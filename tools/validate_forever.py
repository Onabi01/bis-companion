"""Validate paused Forever gear: no placeholder gear or editing is loaded."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
toc = (ROOT / "BiSCompanion_Forever.toc").read_text(encoding="utf-8")
files = {line.strip().replace("\\", "/") for line in toc.splitlines()
         if line.strip().lower().endswith(".lua")}
assert all((ROOT / path).is_file() for path in files), "Forever TOC has missing modules"
assert "ForeverBiS60.lua" not in files, "Unverified gear must not be loaded"
assert "CommonItems.lua" not in files, "Retail sets/crafts must not be loaded by Forever"
assert "ForeverData.lua" in files
assert "ForeverTalentPlanner.lua" in files

mapping = (ROOT / "ForeverMapping.lua").read_text(encoding="utf-8")
data = (ROOT / "ForeverData.lua").read_text(encoding="utf-8")
expected = set(re.findall(r'specKey = "([^"]+)"', mapping))
empty = set(re.findall(r'BiSCompanionBisData\["([^"]+)"\] = \{\}', data))
assert len(expected) == 27 and empty == expected, "Forever needs 27 empty specialization placeholders"
assert "BiSCompanionForeverGearReady = false" in data, "Forever gear must be explicitly gated"

ui = (ROOT / "compat/forever/Core/UI.lua").read_text(encoding="utf-8")
assert "if not foreverGearEnabled then return end" in ui, "Gear rendering not disabled"
assert "gearNoticeTitle:Show()" in ui and "gearNoticeBody:Show()" in ui
assert all(f"{name}:Hide()" in ui for name in
           ("scrollFrame", "listDropdown", "duplicateButton", "createButton", "deleteButton", "setAsDefaultCheckbox"))

core = (ROOT / "Core/Data.lua").read_text(encoding="utf-8")
assert core.count("BiSCompanionForever and not BiSCompanionForeverGearReady") >= 2, (
    "Forever should not preload or highlight unverified gear")

# The historical unverified gear file remains in the repo for later review,
# not in the installable archive.
assert (ROOT / "ForeverBiS60.lua").is_file(), "Historical data must remain available"
print(f"Forever gear paused: {len(empty)} empty specializations, 0 active BiS items; "
      "gear editing off, talent planner on")
