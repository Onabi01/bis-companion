"""Report current gear/talent coverage; this does not claim patch freshness.

Usage: python tools/audit_coverage.py
"""
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
mapping = (ROOT / "ClassSpecMapping.lua").read_text(encoding="utf-8")
toc = (ROOT / "BiSCompanion.toc").read_text(encoding="utf-8")
lua_files = [ROOT / line.strip().replace("\\", "/") for line in toc.splitlines()
             if line.strip().lower().endswith(".lua")]
gear = "\n".join(path.read_text(encoding="utf-8") for path in lua_files)
talents = gear
rows = re.findall(r'specID\s*=\s*(\d+).*?specKey\s*=\s*"([^"]+)"', mapping)
gear_keys = set(re.findall(r'BiSCompanionBisData\["([^"]+)"\]\s*=', gear))
talent_keys = set(re.findall(r'BiSCompanionTalentData\["([^"]+)"\]\s*=', talents))
specs = defaultdict(list)
for spec_id, key in rows:
    specs[spec_id].append(key)

print(f"{len(specs)} Retail specializations; {len(rows)} hero-tree entries")
mapped = {key for _, key in rows}
print(f"{len(gear_keys & mapped)} mapped gear lists; {len(talent_keys & mapped)} mapped talent lists")
for spec_id, keys in sorted(specs.items(), key=lambda item: int(item[0])):
    missing_gear = [key for key in keys if key not in gear_keys]
    missing_talents = [key for key in keys if key not in talent_keys]
    if missing_gear or missing_talents:
        print(f"{spec_id}: gear missing={missing_gear}; talents missing={missing_talents}")
print("Warning: presence does not mean the data is current; verify the source and patch for each list.")
