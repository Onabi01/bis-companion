"""Check that optional Forever Pre-Raid gear builds are complete and isolated."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]

def read(name):
    return (ROOT / name).read_text(encoding="utf-8")

forever = read("BiSCompanion_Forever.toc")
retail = read("BiSCompanion_Standard.toc")
default = read("BiSCompanion.toc")
core = read("Core/Data.lua")
ui = read("compat/forever/Core/UI.lua")
source = read("ForeverPreRaidVariants.lua")
base = read("ForeverPreRaidLot1.lua")
assert "ForeverPreRaidVariants.lua" in forever
assert "ForeverPreRaidVariants.lua" not in retail and "ForeverPreRaidVariants.lua" not in default
assert forever.index("ForeverPreRaidGear.lua") < forever.index("ForeverPreRaidVariants.lua") < forever.index("Core\\Data.lua")
assert "BiSCompanionForeverGearReady" in source
assert "BiSCompanionForeverGearVariants" in source
assert 'Default = "Pre-Raid BiS - Unsealed Wrath"' in source
assert '["__preraid_shockadin"] = "Pre-Raid BiS - Shockadin"' in source
assert 'local shockadin = {' in source
reg = source.split('local shockadin = {',1)[1].split('\n}',1)[0]
items = re.findall(r'\{ slot = "([^"]+)", name = "([^"]+)", source = "([^"]+)", id = "(\d+)"',reg)
assert len(items) == 16, items
assert len(set(x[0] for x in items)) == 16
assert all(int(x[3]) > 0 for x in items)
assert len(set(x[3] for x in items)) == 16
expected = {"Head": "250599", "Neck": "22403", "Shoulders": "22093", "Back": "272411",
    "Chest": "252483", "Wrists": "12936", "Hands": "22090", "Waist": "22086",
    "Legs": "22753", "Feet": "22087", "Ring 1": "19325", "Ring 2": "12543",
    "Trinket 1": "22268", "Trinket 2": "12930", "Weapon": "2801", "Ranged": "272435"}
assert {x[0]:x[3] for x in items} == expected
assert 'displaySlot = "Relic"' in reg
assert 'name = "Blackblade of Shahram"' in base
assert 'name = "Blade of Hanna"' in source
assert "function addon.Core.Data.IsBuiltInList" in core
assert "function addon.Core.Data.GetItemsForList" in core
assert "BiSCompanionForeverGearVariants[specKey]" in core
assert "GetItemsForList(specKey, bisListName)" in core
assert "GetItemsForList(specKey, listName)" in ui
assert "local perSpecBuiltins" in ui
assert "addon.Core.Data.IsBuiltInList(specKey, listName)" in ui
assert "VisibleGearListName(toSelect, specKey)" in ui
assert 'name == "Pre-Raid BiS"' in ui
assert all("## Version: 2.5.2" in read(x) for x in ["BiSCompanion.toc", "BiSCompanion_Standard.toc", "BiSCompanion_Forever.toc"])
print("WoW Forever optional gear builds OK: 2 Retribution variants, 16 Shockadin gear slots, Retail isolated")
