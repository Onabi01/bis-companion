"""Check the reviewed Midnight gear overlays before packaging the addon."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FILES = ["Retail1215.lua", "Retail1215More.lua",
         "Retail1215MonkPaladinPriest.lua", "Retail1215RogueShamanEvoker.lua"]
mapping = (ROOT / "ClassSpecMapping.lua").read_text(encoding="utf-8")
expected = set(re.findall(r'specKey = "([^"]+)"', mapping))
found = set()
groups = 0
items = 0
for filename in FILES:
    content = (ROOT / filename).read_text(encoding="utf-8")
    for match in re.finditer(r'local (\w+) = \{\n(.*?)\n\}', content, re.S):
        groups += 1
        rows = match.group(2).splitlines()
        slots = []
        for row in rows:
            item = re.fullmatch(
                r'\s*\{ slot = "([^"]+)", name = "(?:[^"\\]|\\.)+", '
                r'source = "Icy Veins", id = "([1-9]\d*)" \},', row)
            assert item, f"{filename}: malformed item: {row}"
            slots.append(item.group(1))
            items += 1
        assert 15 <= len(slots) <= 16, f"{filename}: {match.group(1)} has {len(slots)} slots"
        assert len(slots) == len(set(slots)), f"{filename}: duplicate slot in {match.group(1)}"
    found.update(re.findall(r'BiSCompanionBisData\["([^"]+)"\] =', content))
direct = set(re.findall(r'BiSCompanionBisData\["([^"]+)"\] =',
                        (ROOT / "BisData.lua").read_text(encoding="utf-8")))
assert expected <= found | direct and found <= expected, (
    f"missing={sorted(expected-(found|direct))}, unexpected={sorted(found-expected)}")
assert groups == 33, f"expected 33 gear groups, got {groups}"
print(f"Midnight gear: {groups} checked groups, {len(found)} hero entries, {items} item rows")
