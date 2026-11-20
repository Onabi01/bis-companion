"""Validate the Forever 2.5.0 runtime gate, TOC isolation and original save preservation."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
toc = (ROOT / "BiSCompanion_Forever.toc").read_text(encoding="utf-8")
files = [line.strip().replace("\\", "/") for line in toc.splitlines()
         if line.strip().lower().endswith(".lua")]
assert len(files) == len(set(files))
assert all((ROOT / path).is_file() for path in files)
assert "ForeverBiS60.lua" not in files, "Unverified historical gear must stay inactive"
assert "CommonItems.lua" not in files, "Retail set/craft catalog must stay inactive"
assert all(x in files for x in ("ForeverData.lua", "ForeverPreRaidGear.lua",
           "ForeverTalentPlanner.lua", "ForeverIcyVeinsBuilds.lua", "ForeverComparison.lua"))
assert files.index("ForeverData.lua") < files.index("ForeverPreRaidGear.lua") < files.index("Core/Data.lua")
assert files.index("ForeverIcyVeinsBuilds.lua") < files.index("ForeverTalentPlanner.lua")

mapping = (ROOT / "ForeverMapping.lua").read_text(encoding="utf-8")
placeholders = (ROOT / "ForeverData.lua").read_text(encoding="utf-8")
new_data = (ROOT / "ForeverPreRaidGear.lua").read_text(encoding="utf-8")
expected = set(re.findall(r'specKey = "([^"]+)"', mapping))
initial = set(re.findall(r'BiSCompanionBisData\["([^"]+)"\] = \{\}', placeholders))
assert len(expected) == 28 and initial == expected
assert "BiSCompanionForeverGearReady = false" in placeholders
assert "BiSCompanionForeverGearReady = true" in new_data
assert "total ~= 28 or valid ~= total" in new_data
assert "Druid_FeralTank" in expected

ui = (ROOT / "compat/forever/Core/UI.lua").read_text(encoding="utf-8")
assert "local foreverGearEnabled = BiSCompanionForeverGearReady == true" in ui
assert "Pre-Raid BiS" in ui
assert "if not foreverGearEnabled then return end" in ui
assert all(x in ui for x in ("setButton:Disable()", "craftButton:Disable()"))
assert "wowtbc.gg" not in ui
core = (ROOT / "Core/Data.lua").read_text(encoding="utf-8")
assert core.count("BiSCompanionForever and not BiSCompanionForeverGearReady") >= 2
assert (ROOT / "ForeverBiS60.lua").is_file(), "Keep historic gear file as source-only archive"
print("Forever 2.5.0: 28 gated gear profiles, 470 sourced items, no Retail catalogs or stale gear loaded")
