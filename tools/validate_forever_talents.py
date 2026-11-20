"""Static safety checks for Forever Icy Veins presets and planner.

Does not replace loading the addon in the WoW Forever client.
"""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
DATA = (ROOT / 'ForeverIcyVeinsBuilds.lua').read_text(encoding='utf-8')
MAPPING = (ROOT / 'ForeverMapping.lua').read_text(encoding='utf-8')
PLANNER = (ROOT / 'ForeverTalentPlanner.lua').read_text(encoding='utf-8')
TOC = (ROOT / 'BiSCompanion_Forever.toc').read_text(encoding='utf-8')
RETAIL = (ROOT / 'BiSCompanion_Standard.toc').read_text(encoding='utf-8')

assert 'ForeverIcyVeinsBuilds.lua' in TOC
assert 'ForeverIcyVeinsBuilds.lua' not in RETAIL
assert TOC.index('ForeverIcyVeinsBuilds.lua') < TOC.index('ForeverTalentPlanner.lua')
assert all(needle in PLANNER for needle in (
    'MAX_POINTS = 51', 'visibleEdges', 'EdgeRequirementsSatisfied',
    'TreePointsBefore', 'IsValidPlan', 'foreverNamedTalentBuilds',
    'UIDropDownMenu_Initialize', 'PlanFromPreset', 'ReadCurrentTree',
))

# Names and allocations, not copied guide prose. Ensure a full build is
# represented as exactly three strings of point ranks and cannot exceed 51.
pattern = re.compile(r'^\s{6}\{ spec = "([^"]+)", name = "([^"]+)", ranks = '
                     r'\{"([0-9]+)", "([0-9]+)", "([0-9]+)"\}, guide = "([^"]+)", '
                     r'calculator = "([^"]+)" \},$', re.M)
parsed = pattern.findall(DATA)
assert len(parsed) == 45, f'Expected 45 sourced Icy Veins builds, found {len(parsed)}'
assert all(sum(int(ch) for ranks in entry[2:5] for ch in ranks) <= 51 for entry in parsed)
assert any(entry[1] == 'Shockadin Talent Build' for entry in parsed)
assert any(entry[1] == 'Unsealed Wrath Talent Build' for entry in parsed)
assert all(entry[5].startswith('https://') is False for entry in parsed), 'Guides should be relative paths'

class_specs = {name.upper(): set() for name in re.findall(r'className = "([^"]+)"', MAPPING)}
for name, spec in re.findall(r'className = "([^"]+)", specID = 0, specName = "([^"]+)"', MAPPING):
    if spec != "Feral Tank":  # additional gear role, not a fourth talent tree\n        class_specs[name.upper()].add(spec)

layouts = {}
current_class, current_tree = None, None
for line in DATA.splitlines():
    if line == '  builds = {':
        break
    match = re.match(r'^    ([A-Z]+) = \{$', line)
    if match:
        current_class = match.group(1)
        layouts[current_class] = []
    elif line.startswith('      { -- '):
        current_tree = []
        layouts[current_class].append(current_tree)
    else:
        match = re.match(r'^        \{\"(?:[^\"]|\\.)+\", (\d+), (\d+), (\d+), (\d+)\},$', line)
        if match and current_tree is not None:
            current_tree.append(tuple(map(int, match.groups())))
assert len(layouts) == 9 and all(len(v) == 3 for v in layouts.values())

preset_specs = {}
current_class = None
in_builds = False
for line in DATA.splitlines():
    if line == '  builds = {':
        in_builds = True
        continue
    if not in_builds:
        continue
    match = re.match(r'^    ([A-Z]+) = \{$', line)
    if match:
        current_class = match.group(1)
    match = pattern.match(line)
    if match:
        assert current_class is not None
        preset_specs.setdefault(current_class, set()).add(match.group(1))
        for ranks, source_tree in zip(match.group(3, 4, 5), layouts[current_class]):
            assert len(ranks) == len(source_tree), (current_class, match.group(2), 'wrong rank length')
            for rank, (_, _, _, max_rank) in zip(ranks, source_tree):
                assert int(rank) <= max_rank, (current_class, match.group(2), 'over max rank')
assert preset_specs == class_specs, (preset_specs, class_specs)

print('Forever talents: 45 Icy Veins build templates, 27 specs / 9 classes; '
      '51-point cap, prerequisites and personal builds present')
