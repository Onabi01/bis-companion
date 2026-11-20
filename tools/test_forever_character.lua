-- Simulate only the character/gear-role selection logic, no WoW client required.
local mod = {Core = {}}
BiSCompanionForever = true
BiSCompanionClassSpecMapping = {
    {classID=11, specKey='Druid_Balance'},
    {classID=11, specKey='Druid_Feral'},
    {classID=11, specKey='Druid_FeralTank'},
    {classID=11, specKey='Druid_Restoration'},
    {classID=2, specKey='Paladin_Holy'},
}
BiSCompanionCustomData = {}
function UnitClass() return 'Druid','DRUID',11 end
function UnitName() return 'TestDruid' end
function GetRealmName() return 'Forever' end
local file = assert(loadfile('Core/Character.lua'))
file('BiSCompanion', mod)
local core = mod.Core.Character
assert(core.GetSpecName('Druid_Feral') == 'Feral DPS')
assert(core.GetSpecName('Druid_FeralTank') == 'Feral Tank')
local class, role = core.GetPlayerClassAndSpec()
assert(class == 'Druid' and role == nil)
core.RememberForeverGearSpec('Paladin_Holy')
assert(core.GetPlayerClassAndSpec() == 'Druid' and not BiSCompanionCustomData.foreverGearSpecByCharacter)
core.RememberForeverGearSpec('Druid_FeralTank')
class, role = core.GetPlayerClassAndSpec()
assert(class == 'Druid' and role == 'Druid_FeralTank')
assert(BiSCompanionCustomData.foreverGearSpecByCharacter['TestDruid@Forever']=='Druid_FeralTank')
core.RememberForeverGearSpec('Druid_Feral')
assert(select(2, core.GetPlayerClassAndSpec()) == 'Druid_Feral')
BiSCompanionCustomData.foreverGearSpecByCharacter['TestDruid@Forever'] = 'Paladin_Holy'
assert(select(2, core.GetPlayerClassAndSpec()) == nil)
BiSCompanionForever = false
assert(core.GetSpecName('Druid_Feral') == 'Feral')
print('Forever gear role persistence and Retail isolation: OK')
