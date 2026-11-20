"""Build an offline, auditable snapshot of public WoW Forever pre-raid gear.

This developer-only script requires Internet access; the installed addon does not.
It extracts the first visible recommended item per slot from WoWTBC.GG's
WoW Forever pages, and matches IDs against a pinned public Forever item cache.

Never guess item IDs: missing or ambiguous matches retain a null item ID.
"""

import argparse
from datetime import datetime, timezone
import html
from html.parser import HTMLParser
import json
import re
import sys
import time
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen
import unicodedata

SOURCE = "https://wowtbc.gg/warcraftforever/bis-list/"
CACHE_COMMIT = "eff4560809de2e852e9164183e3edf5a795edd20"
CACHE_URL = (
    "https://raw.githubusercontent.com/Napalmsteak/WoW-Classic-Item-Caches/"
    + CACHE_COMMIT + "/Forever%20Cache.json"
)

SPECS = {
    "Warrior_Arms": "arms-warrior",
    "Warrior_Fury": "fury-warrior",
    "Warrior_Protection": "protection-warrior",
    "Paladin_Holy": "holy-paladin",
    "Paladin_Protection": "protection-paladin",
    "Paladin_Retribution": "retribution-paladin",
    "Hunter_BeastMastery": "beast-mastery-hunter",
    "Hunter_Marksmanship": "marksmanship-hunter",
    "Hunter_Survival": "survival-hunter",
    "Rogue_Assassination": "assassination-rogue",
    "Rogue_Combat": "combat-rogue",
    "Rogue_Subtlety": "subtlety-rogue",
    "Priest_Discipline": "discipline-priest",
    "Priest_Holy": "holy-priest",
    "Priest_Shadow": "shadow-priest",
    "Shaman_Elemental": "elemental-shaman",
    "Shaman_Enhancement": "enhancement-shaman",
    "Shaman_Restoration": "restoration-shaman",
    "Mage_Arcane": "arcane-mage",
    "Mage_Fire": "fire-mage",
    "Mage_Frost": "frost-mage",
    "Warlock_Affliction": "affliction-warlock",
    "Warlock_Demonology": "demonology-warlock",
    "Warlock_Destruction": "destruction-warlock",
    "Druid_Balance": "balance-druid",
    "Druid_Feral": "feral-dps-druid",
    "Druid_FeralTank": "feral-tank-druid",
    "Druid_Restoration": "restoration-druid",
}

SLOTS = {
    "head": "Head", "neck": "Neck", "shoulder": "Shoulders", "shoulders": "Shoulders",
    "back": "Back", "chest": "Chest", "wrist": "Wrists", "wrists": "Wrists",
    "hands": "Hands", "hand": "Hands", "waist": "Waist", "legs": "Legs",
    "feet": "Feet", "finger1": "Ring 1", "finger2": "Ring 2",
    "finger-1": "Ring 1", "finger-2": "Ring 2", "trinket1": "Trinket 1",
    "trinket2": "Trinket 2", "trinket-1": "Trinket 1", "trinket-2": "Trinket 2",
    "weapon": "Weapon", "offhand": "Off Hand", "off-hand": "Off Hand",
    "ranged": "Ranged", "relic": "Relic",
}

class CardParser(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.current_card = None
        self.depth = 0
        self.capture = None
        self.capture_depth = 0
        self.parts = []
        self.entries = []

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        classes = (a.get("class") or "").split()
        if tag == "div" and "bis__card" in classes and self.current_card is None:
            self.current_card = {"raw_slot": a.get("id"), "items": []}
            self.entries.append(self.current_card)
            self.depth = 1
            return
        if self.current_card is None:
            return
        if tag == "div":
            self.depth += 1
            if "item" in classes and "item__" not in (a.get("class") or ""):
                self.current_card["items"].append({"name": "", "instance": "", "boss": ""})
            for cls, field in (("item__name", "name"), ("item__instance", "instance"), ("item__boss", "boss")):
                if cls in classes and self.current_card["items"]:
                    self.capture, self.capture_depth, self.parts = field, self.depth, []
        elif self.capture:
            self.parts.append(" ")

    def handle_endtag(self, tag):
        if self.current_card is None:
            return
        if tag == "div":
            if self.capture and self.capture_depth == self.depth:
                if self.current_card["items"]:
                    self.current_card["items"][-1][self.capture] = " ".join("".join(self.parts).split())
                self.capture, self.parts = None, []
            self.depth -= 1
            if self.depth == 0:
                self.current_card = None

    def handle_data(self, data):
        if self.capture:
            self.parts.append(data)


def fetch(url, tries=3):
    req = Request(url, headers={"User-Agent": "Mozilla/5.0 (compatible; BiSCompanion offline data audit)"})
    for attempt in range(tries):
        try:
            with urlopen(req, timeout=30) as f:
                return f.read().decode("utf-8", "replace")
        except (HTTPError, URLError, TimeoutError):
            if attempt + 1 == tries:
                raise
            time.sleep(1 + attempt)


def normalized(text):
    text = unicodedata.normalize("NFKC", str(text))
    text = text.replace("\u2019", "'").replace("\u2018", "'")
    text = text.replace("\u2014", "-").replace("\u2013", "-")
    return " ".join(text.casefold().strip().split())


def get_item_ids():
    data = json.loads(fetch(CACHE_URL))
    result = {}
    for item in data:
        name, item_id = item.get("name"), item.get("itemId")
        if not isinstance(item_id, int) or item_id < 1 or not isinstance(name, str):
            continue
        result.setdefault(normalized(name), set()).add(item_id)
    return result, len(data)


def extract_page(markup, url):
    if 'bis__cards' not in markup or 'WoW Forever' not in markup:
        raise ValueError("Not a Forever pre-raid list: " + url)
    parser = CardParser()
    parser.feed(markup)
    gear = []
    for card in parser.entries:
        slot = SLOTS.get((card["raw_slot"] or "").replace("_", "").replace("-", ""))
        if slot is None:
            raise ValueError("Unknown equipment slot %r at %s" % (card["raw_slot"], url))
        valid_items = [i for i in card["items"] if i["name"]]
        if not valid_items:
            continue
        entry = valid_items[0]  # the main item; alternatives are optional dropdown UI
        name = html.unescape(entry["name"])
        if ("TBD" in name.upper() or name.startswith("Trinket #") or
            "TO BE TESTED" in entry["instance"].upper()):
            continue
        gear.append({
            "slot": slot, "name": name,
            "source": " / ".join(filter(None, [entry["instance"], entry["boss"]])),
            "source_kind": entry["boss"],
        })
    seen = [i["slot"] for i in gear]
    if len(seen) != len(set(seen)):
        raise ValueError("Duplicate equipment slots at " + url + " " + repr(seen))
    if len(gear) < 12 or len(gear) > 18:
        raise ValueError("Unexpected count of gear slots at %s: %d %s" % (url, len(gear), repr(seen)))
    return gear


def main():
    args = argparse.ArgumentParser()
    args.add_argument("--out", default="tools/data/forever_preraid_snapshot.json")
    opts = args.parse_args()
    index, cache_count = get_item_ids()
    builds = {}
    unknown, ambiguous = [], []
    for key, slug in SPECS.items():
        url = SOURCE + slug + "/"
        gear = extract_page(fetch(url), url)
        for item in gear:
            candidates = sorted(index.get(normalized(item["name"]), []))
            item["id"] = candidates[0] if len(candidates) == 1 else None
            if not candidates:
                unknown.append([key, item["slot"], item["name"]])
            elif len(candidates) > 1:
                ambiguous.append([key, item["slot"], item["name"], candidates])
        builds[key] = gear
        print("SCRAPED", key, len(gear), "matched", sum(i["id"] is not None for i in gear), file=sys.stderr)
        time.sleep(0.16)
    snapshot = {
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "source_site": SOURCE,
        "cache_commit": CACHE_COMMIT,
        "cache_item_count": cache_count,
        "builds": builds,
        "unmatched": unknown,
        "ambiguous": ambiguous,
    }
    from pathlib import Path
    path = Path(opts.out)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(snapshot, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print("SNAPSHOT", len(builds), "builds", sum(map(len, builds.values())), "gear picks", "missing", len(unknown), "ambiguous", len(ambiguous), file=sys.stderr)
    print("WROTE", path, file=sys.stderr)


if __name__ == "__main__":
    main()
