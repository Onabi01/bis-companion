"""Validate the level 60 Forever gear lists and TOC references."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
toc = (ROOT / "BiSCompanion_Forever.toc").read_text(encoding="utf-8")
paths = [ROOT / line.strip().replace("\\", "/") for line in toc.splitlines()
         if line.strip().lower().endswith(".lua")]
assert all(path.exists() for path in paths), "TOC references a missing Lua file"
mapping = (ROOT / "ForeverMapping.lua").read_text(encoding="utf-8")
data = (ROOT / "ForeverBiS60.lua").read_text(encoding="utf-8")
expected = set(re.findall(r'specKey = "([^"]+)"', mapping))
groups = re.findall(r'BiSCompanionBisData\["([^"]+)"\] = \{\n(.*?)\n\}', data, re.S)
assert {key for key, _ in groups} == expected, "Forever spec coverage mismatch"
count = 0
for key, content in groups:
    rows = content.splitlines()
    assert 14 <= len(rows) <= 17, f"{key}: unexpected slot count"
    slots = []
    ids = []
    for row in rows:
        item = re.fullmatch(
            r'\s*\{ slot = "([^"]+)", name = "(?:[^"\\]|\\.)+", '
            r'source = "wow-forever.gg, level 60", id = "([1-9]\d*)" \},', row)
        assert item, f"{key}: malformed row: {row}"
        slots.append(item.group(1))
        ids.append(item.group(2))
        count += 1
    assert len(slots) == len(set(slots)), f"{key}: duplicate slot"
    assert len(ids) == len(set(ids)), f"{key}: duplicate item ID"
print(f"Forever: {len(groups)} level 60 lists, {count} item rows, {len(paths)} Lua files in TOC")
