"""Static check for Forever-only side-by-side Talents comparison mode."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
retail = (ROOT / 'BiSCompanion_Standard.toc').read_text(encoding='utf-8')
forever = (ROOT / 'BiSCompanion_Forever.toc').read_text(encoding='utf-8')
comparison = (ROOT / 'ForeverComparison.lua').read_text(encoding='utf-8')
assert 'ForeverComparison.lua' in forever
assert forever.index('ForeverTalentPlanner.lua') < forever.index('ForeverComparison.lua')
assert 'ForeverComparison.lua' not in retail
assert all(snippet in comparison for snippet in (
    'BiSCompanionForeverCompareButton',
    'PlayerSpellsFrame',
    'TalentsFrame',
    'GetEffectiveScale',
    'GetNumPoints',
    'GetPoint(i)',
    'Restore(snapshot)',
    'InCombatLockdown',
    'PLAYER_REGEN_ENABLED',
    'IsComparingTalents',
    'Mode comparaison',
))
assert 'BiSCompanionCustomData' not in comparison, 'Comparison should not modify SavedVariables'
print('Forever comparison: only Forever TOC loads the module; scale/points/combat/restoration checks present')
