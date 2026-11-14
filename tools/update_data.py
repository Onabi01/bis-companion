"""Validate reviewed guide data and generate a Retail overlay one spec at a time.

Usage: python tools/update_data.py path/to/reviewed.json [--apply]
Without --apply, validation and a unified diff are printed only.
"""
import argparse
import difflib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SLOTS = {"Head", "Neck", "Shoulders", "Back", "Chest", "Wrists", "Hands",
         "Waist", "Legs", "Feet", "Ring 1", "Ring 2", "Weapon", "Off Hand",
         "Trinket 1", "Trinket 2"}


def lua_string(value):
    return json.dumps(value, ensure_ascii=False)


def render(data):
    if data.get("game") != "retail" or not re.fullmatch(r"\d+\.\d+(?:\.\d+)?", data.get("patch", "")):
        raise ValueError("game must be retail and patch must be a numeric version")
    if not isinstance(data.get("specs"), dict) or not data["specs"]:
        raise ValueError("specs must be a nonempty object")
    known = set(re.findall(r'specKey = "([^"]+)"', (ROOT / "ClassSpecMapping.lua").read_text(encoding="utf-8")))
    unknown = set(data["specs"]) - known
    if unknown:
        raise ValueError(f"unknown spec keys: {sorted(unknown)}")
    gear = ["BiSCompanionBisData = BiSCompanionBisData or {}", ""]
    talents = ["BiSCompanionTalentData = BiSCompanionTalentData or {}", ""]
    for key, spec in sorted(data["specs"].items()):
        if key not in known:
            raise ValueError(f"unknown spec key: {key}")
        source = spec.get("source")
        if not isinstance(source, str) or not source.startswith(("https://www.icy-veins.com/", "https://www.wowhead.com/")):
            raise ValueError(f"{key}: source must be an Icy Veins or Wowhead URL")
        items = spec.get("items")
        if not isinstance(items, list) or not items:
            raise ValueError(f"{key}: items must be nonempty")
        seen = set()
        gear.extend([f"-- Patch {data['patch']} | {source}", f"BiSCompanionBisData[{lua_string(key)}] = {{"])
        for item in items:
            slot, item_id = item.get("slot"), str(item.get("id", ""))
            if slot not in SLOTS or slot in seen or not re.fullmatch(r"[1-9]\d*", item_id):
                raise ValueError(f"{key}: invalid or duplicate slot/item ID: {slot}/{item_id}")
            seen.add(slot)
            name = item.get("name")
            if not isinstance(name, str) or not name.strip():
                raise ValueError(f"{key}: missing item name")
            origin = item.get("source", "")
            if not isinstance(origin, str):
                raise ValueError(f"{key}: invalid item source")
            gear.append(f"    {{ slot = {lua_string(slot)}, name = {lua_string(name)}, source = {lua_string(origin)}, id = {lua_string(item_id)} }},")
        gear.extend(["}", ""])
        builds = spec.get("talents", [])
        if not isinstance(builds, list):
            raise ValueError(f"{key}: talents must be a list")
        talents.extend([f"-- Patch {data['patch']} | {source}", f"BiSCompanionTalentData[{lua_string(key)}] = {{"])
        for build in builds:
            if not all(isinstance(build.get(field), str) and build[field].strip() for field in ("buildName", "heroTree", "importCode")):
                raise ValueError(f"{key}: incomplete talent build")
            talents.append("    { buildName = %s, heroTree = %s, importCode = %s }," % tuple(lua_string(build[field]) for field in ("buildName", "heroTree", "importCode")))
        talents.extend(["}", ""])
    return {"RetailReviewedGear.lua": "\n".join(gear) + "\n",
            "RetailReviewedTalents.lua": "\n".join(talents) + "\n"}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()
    incoming = json.loads(args.input.read_text(encoding="utf-8"))
    store_path = ROOT / "tools" / "reviewed_data.json"
    if store_path.exists():
        stored = json.loads(store_path.read_text(encoding="utf-8"))
        if (stored.get("game"), stored.get("patch")) != (incoming.get("game"), incoming.get("patch")):
            raise ValueError("stored and incoming game/patch differ; review before replacing the cache")
        stored["specs"].update(incoming.get("specs", {}))
        incoming = stored
    generated = render(incoming)
    if not args.apply:
        print("Validation OK. Use --apply to write files.")
    for name, content in generated.items():
        path = ROOT / name
        previous = path.read_text(encoding="utf-8") if path.exists() else ""
        diff = "".join(difflib.unified_diff(previous.splitlines(True), content.splitlines(True), fromfile=name, tofile=name + " (new)"))
        print(diff[:12000] + ("\n... diff truncated\n" if len(diff) > 12000 else ""))
        if args.apply:
            if path.exists():
                path.with_suffix(path.suffix + ".bak").write_text(previous, encoding="utf-8")
            path.write_text(content, encoding="utf-8")
    if args.apply:
        store_path.write_text(json.dumps(incoming, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        toc_path = ROOT / "BiSCompanion.toc"
        toc = toc_path.read_text(encoding="utf-8")
        for name, anchor in (("RetailReviewedGear.lua", "TalentData.lua"),
                             ("RetailReviewedTalents.lua", "CommonItems.lua")):
            if name not in toc:
                toc = toc.replace(anchor, name + "\n" + anchor, 1)
        toc_path.write_text(toc, encoding="utf-8")


if __name__ == "__main__":
    main()
