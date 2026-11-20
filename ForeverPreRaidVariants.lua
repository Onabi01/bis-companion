-- WoW Forever 2.5.2: extra Pre-Raid gear builds for a single talent specialization.
-- A built-in set is NOT a custom list; it is read-only and never saved to SavedVariables.
-- Shockadin 23/0/28 reference: MythicSim Forever (November 2026), provisional.
-- Item IDs crosschecked against the WoW Forever item database; some loot unconfirmed.
-- Faction-dependent pieces reflect the Alliance reference; Horde alternatives need review.
-- Default Paladin_Retribution remains the existing Unsealed Wrath/hybrid pre-raid list.
if not BiSCompanionForever or not BiSCompanionForeverGearReady then return end

local shockadin = {
    { slot = "Head", name = "Stalwart Helm", source = "Blacksmithing / Crafted", id = "250599" },
    { slot = "Neck", name = "Nacreous Shell Necklace", source = "Cannon Master Willey / Stratholme (drop unconfirmed)", id = "22403", icon = "inv_jewelry_necklace_10" },
    { slot = "Shoulders", name = "Soulforge Spaulders", source = "Anthion's Parting Words / Quest (Alliance)", id = "22093", icon = "inv_shoulder_10" },
    { slot = "Back", name = "Arcanoweave Cloak", source = "Pix Xizzix / Stranglethorn Vale", id = "272411", icon = "inv_misc_cape_05" },
    { slot = "Chest", name = "Dawn Armor", source = "Leatherworking / Crafted", id = "252483", icon = "inv_chest_leather_08" },
    { slot = "Wrists", name = "Battleborn Armbraces", source = "Warchief Rend Blackhand / Blackrock Spire: Upper", id = "12936", icon = "inv_bracer_17" },
    { slot = "Hands", name = "Soulforge Gauntlets", source = "Just Compensation / Quest (Alliance)", id = "22090" },
    { slot = "Waist", name = "Soulforge Belt", source = "Just Compensation / Quest (Alliance)", id = "22086", icon = "inv_belt_11" },
    { slot = "Legs", name = "Sentinel's Lamellar Legguards", source = "Silverwing Sentinels / Warsong Gulch (Alliance)", id = "22753" },
    { slot = "Feet", name = "Soulforge Boots", source = "Anthion's Parting Words / Quest (Alliance)", id = "22087" },
    { slot = "Ring 1", name = "Don Julio's Band", source = "Stormpike Guard / Frostwolf Clan - Exalted", id = "19325", icon = "inv_jewelry_ring_35" },
    { slot = "Ring 2", name = "Songstone of Ironforge", source = "The Princess's Surprise / Quest (Alliance)", id = "12543", icon = "inv_jewelry_ring_05" },
    { slot = "Trinket 1", name = "Draconic Infused Emblem", source = "General Drakkisath / Blackrock Spire: Upper", id = "22268", icon = "inv_jewelry_talisman_09" },
    { slot = "Trinket 2", name = "Briarwood Reed", source = "Jed Runewatcher / Blackrock Spire: Upper", id = "12930", icon = "inv_misc_root_02" },
    { slot = "Weapon", name = "Blade of Hanna", source = "World drop (unconfirmed in Forever)", id = "2801" },
    { slot = "Ranged", name = "Libram of Law", source = "Pix Xizzix / Stranglethorn Vale", id = "272435", displaySlot = "Relic", icon = "inv_misc_book_04" },
}

-- Do not expose an incomplete or malformed reference set.
local expectedSlots = { Head=true, Neck=true, Shoulders=true, Back=true, Chest=true,
    Wrists=true, Hands=true, Waist=true, Legs=true, Feet=true,
    ["Ring 1"]=true, ["Ring 2"]=true, ["Trinket 1"]=true, ["Trinket 2"]=true,
    Weapon=true, Ranged=true }
if #shockadin ~= 16 then return end
local seen = {}
for _, item in ipairs(shockadin) do
    if not expectedSlots[item.slot] or seen[item.slot] or not tonumber(item.id)
       or tonumber(item.id) <= 0 or type(item.name) ~= "string" or item.name == "" then
        return
    end
    seen[item.slot] = true
end

-- Internal keys cannot conflict with normal list labels; custom lists are separate.
BiSCompanionForeverGearVariants = {
    ["Paladin_Retribution"] = {
        ["__preraid_shockadin"] = shockadin,
    },
}
BiSCompanionForeverGearVariantLabels = {
    ["Paladin_Retribution"] = {
        Default = "Pre-Raid BiS - Unsealed Wrath",
        ["__preraid_shockadin"] = "Pre-Raid BiS - Shockadin",
    },
}
