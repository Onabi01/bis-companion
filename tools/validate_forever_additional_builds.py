"""Check WoW Forever multiple Pre-Raid builds and client isolation (offline)."""
from pathlib import Path
import re
root = Path(__file__).resolve().parents[1]
source=(root/'ForeverPreRaidAdditionalBuilds.lua').read_text(encoding='utf-8')
expect={
 'Hunter_Survival': {'__preraid_survival_melee':17, '__preraid_survival_weaving':16},
 'Rogue_Combat': {'__preraid_combat_daggers':17},
 'Mage_Arcane': {'__preraid_arcane_fire':16},
 'Mage_Fire': {'__preraid_frostfire':16},
 'Priest_Discipline': {'__preraid_smite':16},
 'Warlock_Demonology': {'__preraid_shadow_brand':16},
 'Warlock_Affliction': {'__preraid_sm_ruin':16},
 'Paladin_Protection': {'__preraid_holy_prot_alliance':17, '__preraid_holy_prot_horde':17},
}
blocks=list(re.finditer(r'addSet\("([^\"]+)", "([^\"]+)", "([^\"]+)", \{\n(.*?)\n\}\)',source,re.S))
assert len(blocks)==sum(len(v) for v in expect.values()),len(blocks)
assert 'if not BiSCompanionForever or not BiSCompanionForeverGearReady then return end' in source
assert 'if variants[spec] and variants[spec][key] then return end' in source
assert 'not validSlots[slot] or seenSlots[slot]' in source
seen=set(); count=0
for b in blocks:
    spec,key,label,rows=b.groups()
    assert spec in expect and key in expect[spec] and (spec,key) not in seen
    seen.add((spec,key))
    items=re.findall(r'\{ "([^\"]+)", "([^\"]+)", "(\d+)", "([^\"]+)" \}',rows)
    assert len(items)==expect[spec][key],(spec,key,len(items))
    assert len({x[0] for x in items})==len(items)
    assert len({x[2] for x in items})==len(items)
    assert all(int(x[2])>0 for x in items)
    assert {"Head","Neck","Shoulders","Back","Chest","Wrists","Hands","Waist","Legs","Feet","Ring 1","Ring 2","Trinket 1","Trinket 2","Weapon","Ranged"} <= {x[0] for x in items}
    assert label.startswith('Pre-Raid BiS - ')
    count+=len(items)
assert count==164,count
assert '"Paladin_Protection", "__preraid_holy_prot_horde"' in source
assert '"Paladin_Protection", "__preraid_holy_prot_alliance"' in source
assert '"Eye of Orgrimmar", "12545"' in source
assert '"Songstone of Ironforge", "12543"' in source
forever=(root/'BiSCompanion_Forever.toc').read_text()
retail=(root/'BiSCompanion_Standard.toc').read_text()
assert 'ForeverPreRaidAdditionalBuilds.lua' in forever
assert 'ForeverPreRaidAdditionalBuilds.lua' not in retail
assert forever.index('ForeverPreRaidVariants.lua') < forever.index('ForeverPreRaidAdditionalBuilds.lua') < forever.index('Core\\Data.lua')
print('Additional builds: ',len(blocks),'sets /',count,'items across',len(expect),'specs; factions separated and Retail isolated')
