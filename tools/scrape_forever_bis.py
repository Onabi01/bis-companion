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
CACHE_BASE = "https://raw.githubusercontent.com/Napalmsteak/WoW-Classic-Item-Caches/" + CACHE_COMMIT + "/"
CACHE_URL = CACHE_BASE + "Forever%20Cache.json"
ERA_CACHE_URL = CACHE_BASE + "Classic%20Era%20Cache.json"

# Ten post-cache Forever items independently verified against their WoW Forever
# item pages (wowhead.com/forever/item=<ID>) on 20 November 2026.
# They were not in the pinned November snapshot because several drops were
# initially hidden by the Forever client or introduced via patch 1.60.1.
EXTRA_VERIFIED_IDS = {
    "Horn of Ve'han": 275736,
    "Behemoth Bones": 280065,
    "Flamebreak Talisman": 280071,
    "Tooth of the Matriarch": 280021,
    "Robes of Dark Summons": 280057,
    "Obsidian Bauble": 18316,
    "Wit's Edge": 276632,
    "Warpwood Bracers": 270124,
    "High Clerist's Seal": 284079,
    "Lucky Shovelnose Tuft": 280060,
}

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
    indexes, counts = {}, {}
    for label, url in (("forever", CACHE_URL), ("era", ERA_CACHE_URL)):
        data = json.loads(fetch(url))
        result = {}
        for item in data:
            name, item_id = item.get("name"), item.get("itemId")
            if isinstance(item_id, int) and item_id > 0 and isinstance(name, str):
                result.setdefault(normalized(name), []).append(item)
        indexes[label] = result
        counts[label] = len(data)
    return indexes, counts


def tooltip_text(item):
    return html.unescape(re.sub(r"<[^>]+>", " ", item.get("tooltipHtml") or ""))


def level(item):
    match = re.search(r"Item Level\s+(\d+)", tooltip_text(item))
    return int(match.group(1)) if match else 0


def source_matches(item, source_kind):
    types = [str(t).lower() for t in item.get("sourceTypes") or []]
    k = source_kind.lower()
    if 'quest' in k:
        return 'quest' in types
    if 'crafted' in k:
        return 'craft' in types or 'profession' in types
    if k == 'reputation':
        return 'vendor' in types or 'reputation' in types
    return 'drop' in types


def resolve_id(name, source_kind, class_name, index):
    key = normalized(name)
    forever = index['forever'].get(key, [])
    era = index['era'].get(key, [])
    if len(forever) == 1:
        return forever[0]['itemId'], 'forever-unique', None
    if len(forever) > 1:
        matched = [x for x in forever if source_matches(x, source_kind)]
        if len(matched) == 1:
            return matched[0]['itemId'], 'forever-source', None
        if len(matched) > 1:
            forever = matched
        # Variants of the same reputation equipment at levels 30/40/50/60:
        # the guide is for level 60, so use the highest known item level.
        levels = [level(x) for x in forever]
        if levels and max(levels) > 0 and levels.count(max(levels)) == 1:
            x = forever[levels.index(max(levels))]
            return x['itemId'], 'forever-highest-level', None
        # If the Forever data is ambiguous but the Classic quest has an ID
        # matching one variant and source is a quest, it is an exact crosscheck.
        if len(era) == 1 and 'quest' in source_kind.lower():
            if any(x['itemId'] == era[0]['itemId'] for x in forever):
                return era[0]['itemId'], 'quest-era-confirmed', None
        return None, 'ambiguous-forever', [x['itemId'] for x in forever]
    if len(era) == 1:
        return era[0]['itemId'], 'classic-era-unique', None
    if len(era) > 1:
        # Eldre'Thalas trinkets share one name but are class-locked.
        class_matched = [x for x in era if re.search(
            r'Classes:\s*' + re.escape(class_name) + r'(?:\s|$)', tooltip_text(x))]
        if len(class_matched) == 1:
            return class_matched[0]['itemId'], 'classic-era-class-locked', None
        return None, 'ambiguous-classic-era', [x['itemId'] for x in era]
    extra = {normalized(k): v for k, v in EXTRA_VERIFIED_IDS.items()}
    if key in extra:
        return extra[key], 'verified-wowhead-forever', None
    return None, 'not-in-caches', None


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
    index, cache_counts = get_item_ids()
    builds = {}
    unknown, ambiguous = [], []
    for key, slug in SPECS.items():
        url = SOURCE + slug + "/"
        gear = extract_page(fetch(url), url)
        for item in gear:
            item_id, method, candidates = resolve_id(item['name'], item['source_kind'], key.split('_')[0], index)
            item['id'] = item_id
            item['id_evidence'] = method
            if not item_id and not candidates:
                unknown.append([key, item["slot"], item["name"]])
            elif not item_id:
                ambiguous.append([key, item["slot"], item["name"], candidates])
        builds[key] = gear
        print("SCRAPED", key, len(gear), "matched", sum(i["id"] is not None for i in gear), file=sys.stderr)
        time.sleep(0.16)
    snapshot = {
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "source_site": SOURCE,
        "cache_commit": CACHE_COMMIT,
        "cache_item_count": cache_counts,
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
