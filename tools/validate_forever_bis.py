"""Offline integrity checks for the Forever 2.5.0 pre-raid gear snapshot."""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
snapshot = json.loads((ROOT / 'tools/data/forever_preraid_snapshot.json').read_text(encoding='utf-8'))
gear = (ROOT / 'ForeverPreRaidGear.lua').read_text(encoding='utf-8')
map_txt = (ROOT / 'ForeverMapping.lua').read_text(encoding='utf-8')
forever_toc = (ROOT / 'BiSCompanion_Forever.toc').read_text(encoding='utf-8')
retail_toc = (ROOT / 'BiSCompanion_Standard.toc').read_text(encoding='utf-8')

mapped = re.findall(r'specKey = "([^"]+)"', map_txt)
assert len(mapped) == 28 and len(set(mapped)) == 28
assert set(snapshot['builds']) == set(mapped)
assert 'Druid_Feral' in mapped and 'Druid_FeralTank' in mapped
assert 'ForeverPreRaidGear.lua' in forever_toc and 'ForeverPreRaidGear.lua' not in retail_toc
assert forever_toc.index('ForeverData.lua') < forever_toc.index('ForeverPreRaidGear.lua') < forever_toc.index('Core\\Data.lua')
assert not snapshot['unmatched'] and not snapshot['ambiguous']
assert 'BiSCompanionForeverGearReady = true' in gear
assert 'Pre-Raid BiS' in gear
assert 'wowtbc.gg' not in gear and 'WOWTBC' not in gear

# Exact per-build serialisation against JSON source, including names, IDs,
# acquisition notes, and the relic-to-ranged mapping used by the game's UI.
count = 0
for spec, items in snapshot['builds'].items():
    assert 12 <= len(items) <= 18
    assert len({x['slot'] for x in items}) == len(items)
    assert all(type(x['id']) is int and x['id'] > 0 and x['name'] and x['slot'] for x in items)
    head = '    ["' + spec + '"] = {'
    assert gear.count(head) == 1, spec
    region = gear.split(head, 1)[1].split('    },', 1)[0]
    assert region.count('{ slot = ') == len(items), spec
    for obj in items:
        import json as _json
        esc = lambda value: _json.dumps(str(value), ensure_ascii=False)
        slot = 'Ranged' if obj['slot'] == 'Relic' else obj['slot']
        required = ('{ slot = ' + esc(slot) + ', name = ' + esc(obj['name']) +
                    ', source = ' + esc(obj['source'] or 'Source not specified') +
                    ', id = ' + esc(obj['id']))
        assert required in region, (spec, obj['slot'], obj['name'])
        if obj['slot'] == 'Relic':
            assert 'displaySlot = "Relic"' in region
        count += 1
assert count == 470
assert gear.count('{ slot = ') == count

ui = (ROOT / 'compat/forever/Core/UI.lua').read_text(encoding='utf-8')
assert 'VisibleGearListName' in ui and 'Pre-Raid BiS' in ui
assert 'RememberForeverGearSpec' in ui
assert 'offlineIcon = item.icon' in ui
character = (ROOT / 'Core/Character.lua').read_text(encoding='utf-8')
assert 'foreverGearSpecByCharacter' in character
assert 'Druid_FeralTank' in character and 'Feral DPS' in character
print(f'Forever pre-raid gear OK: {len(mapped)} gear profiles, {count} verified item IDs, 2 Feral roles, Retail manifest clean')
