-- Offline Lua 5.1 test of the extra Forever gear registry and runtime gating.
BiSCompanionForever = false
BiSCompanionForeverGearReady = true
BiSCompanionForeverGearVariants = { Paladin_Retribution = { __preraid_shockadin = { 'preserved' } } }
BiSCompanionForeverGearVariantLabels = { Paladin_Retribution = { __preraid_shockadin = 'Shockadin' } }
dofile('ForeverPreRaidAdditionalBuilds.lua')
assert(BiSCompanionForeverGearVariants.Hunter_Survival == nil)
BiSCompanionForever = true
BiSCompanionForeverGearReady = false
dofile('ForeverPreRaidAdditionalBuilds.lua')
assert(BiSCompanionForeverGearVariants.Hunter_Survival == nil)
BiSCompanionForeverGearReady = true
dofile('ForeverPreRaidAdditionalBuilds.lua')
local expected = {
    Hunter_Survival={__preraid_survival_melee=17,__preraid_survival_weaving=16},
    Rogue_Combat={__preraid_combat_daggers=17},
    Mage_Arcane={__preraid_arcane_fire=16},
    Mage_Fire={__preraid_frostfire=16},
    Priest_Discipline={__preraid_smite=16},
    Warlock_Demonology={__preraid_shadow_brand=16},
    Warlock_Affliction={__preraid_sm_ruin=16},
    Paladin_Protection={__preraid_holy_prot_alliance=17,__preraid_holy_prot_horde=17},
}
local count, items=0,0
for spec, names in pairs(expected) do
    for name, size in pairs(names) do
        local set=assert(BiSCompanionForeverGearVariants[spec][name],spec..'/'..name)
        assert(#set==size,spec..'/'..name)
        assert(BiSCompanionForeverGearVariantLabels[spec][name]:match('^Pre%-Raid BiS'))
        local slots, ids = {}, {}
        for _, item in ipairs(set) do
            assert(not slots[item.slot] and not ids[item.id],spec..'/'..name)
            slots[item.slot],ids[item.id]=true,true
            assert(item.name and item.source and tonumber(item.id) and tonumber(item.id)>0)
            if spec == 'Paladin_Protection' and item.slot=='Ranged' then assert(item.displaySlot=='Relic') end
        end
        count=count+1
        items=items+#set
    end
end
assert(count==10 and items==164,count..' sets '..items..' items')
assert(BiSCompanionForeverGearVariants.Paladin_Retribution.__preraid_shockadin[1]=='preserved')
local a=BiSCompanionForeverGearVariants.Paladin_Protection.__preraid_holy_prot_alliance
local h=BiSCompanionForeverGearVariants.Paladin_Protection.__preraid_holy_prot_horde
assert(a[12].id=='12543' and h[12].id=='12545')
dofile('ForeverPreRaidAdditionalBuilds.lua')
assert(BiSCompanionForeverGearVariants.Paladin_Retribution.__preraid_shockadin[1]=='preserved')
print('Forever extra gear variants: '..count..' sets, '..items..' items OK')
