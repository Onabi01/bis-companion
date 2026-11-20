"""Offline, per-lot checks for 2.5.0 gear (no WoW client required)."""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
def content(path):
    return (ROOT / path).read_text(encoding="utf-8")

snapshot = json.loads(content("tools/data/forever_preraid_snapshot.json"))
map_txt = content("ForeverMapping.lua")
forever_toc = content("BiSCompanion_Forever.toc")
retail_toc = content("BiSCompanion_Standard.toc")
gate = content("ForeverPreRaidGear.lua")
ui = content("compat/forever/Core/UI.lua")
character = content("Core/Character.lua")

expected = set(re.findall(r'specKey = "([^"]+)"', map_txt))
assert len(expected) == 28 and set(snapshot["builds"]) == expected
assert "Druid_Feral" in expected and "Druid_FeralTank" in expected
assert "BiSCompanionForeverGearReady = true" in gate
assert "Pre-Raid BiS" in ui and "VisibleGearListName" in ui
assert "wowtbc.gg" not in ui.lower()
# Personal-list safeguards and complete metadata duplication (v2.5.1).
assert 'local reserved = name == "Default" or name == "Pre-Raid BiS"' in ui
assert "custom[specKey][name]" in ui
assert ui.count("nameFrame.pendingSpecKey = specKey") == 2
assert "local function CopyBisItem(value)" in ui
assert "CopyBisItem(item)" in ui
assert "local cachedIcon = GetItemIcon and GetItemIcon(itemID)" in ui
assert "RememberForeverGearSpec" in ui and "foreverGearSpecByCharacter" in character
assert "Druid_FeralTank" in character and "Feral DPS" in character
assert not snapshot["unmatched"] and not snapshot["ambiguous"]

lots = [("Warrior", "Paladin", "Hunter"), ("Rogue", "Priest", "Shaman"),
        ("Mage", "Warlock", "Druid")]
expected_counts = [150, 152, 168]
seen = set()
total = 0
for number, (classes, expected_count) in enumerate(zip(lots, expected_counts), 1):
    lua_path = f"ForeverPreRaidLot{number}.lua"
    json_path = f"tools/data/forever_preraid_lot{number}.json"
    assert lua_path in forever_toc and lua_path not in retail_toc
    data = json.loads(content(json_path))
    lua = content(lua_path)
    assert data["batch"] == number and data["classes"] == list(classes)
    assert data["timestamp_utc"] == snapshot["timestamp_utc"]
    assert data["cache_commit"] == snapshot["cache_commit"]
    assert "BiSCompanionForeverPreRaidStaging" in lua
    assert len(data["builds"]) == (10 if number == 3 else 9)
    count = 0
    for spec, items in data["builds"].items():
        assert spec in expected and spec.split("_")[0] in classes
        assert spec not in seen
        seen.add(spec)
        assert items == snapshot["builds"][spec]
        assert 12 <= len(items) <= 18
        assert len({x["slot"] for x in items}) == len(items)
        head = '    ["' + spec + '"] = {'
        assert lua.count(head) == 1, spec
        region = lua.split(head, 1)[1].split('    },', 1)[0]
        assert region.count('{ slot = ') == len(items), spec
        for item in items:
            assert type(item["id"]) is int and item["id"] > 0
            assert item["slot"] and item["name"]
            esc = lambda value: json.dumps(str(value), ensure_ascii=False)
            slot = "Ranged" if item["slot"] == "Relic" else item["slot"]
            required = ('{ slot = ' + esc(slot) + ', name = ' + esc(item["name"])
                        + ', source = ' + esc(item["source"] or "Source not specified")
                        + ', id = ' + esc(item["id"]))
            assert required in region, (spec, item["slot"], item["name"], item["id"])
            if item["slot"] == "Relic":
                assert 'displaySlot = "Relic"' in region
            count += 1
    assert count == expected_count, (number, count)
    assert lua.count('{ slot = ') == count
    total += count
    print(f"Lot {number}: {len(data['builds'])} profiles, {count} gear picks OK")

assert seen == expected and total == 470
assert "ForeverPreRaidGear.lua" in forever_toc and "ForeverPreRaidGear.lua" not in retail_toc
assert forever_toc.index("ForeverData.lua") < forever_toc.index("ForeverPreRaidLot1.lua") < forever_toc.index("ForeverPreRaidLot2.lua") < forever_toc.index("ForeverPreRaidLot3.lua") < forever_toc.index("ForeverPreRaidGear.lua") < forever_toc.index("Core\\Data.lua")
print(f"Forever Pre-Raid BiS: {len(seen)} profiles, {total} cross-referenced gear IDs, 2 Feral roles, Retail isolated")
