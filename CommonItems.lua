-- CommonItems.lua
-- Liste des items de set, craftés, et de quête pour BiSCompanion

local addonName, addon = ...
addon.Core = addon.Core or {} -- Ajout pour garantir que addon.Core existe
addon.Core.CommonItems = addon.Core.CommonItems or {}

-- Items de set (pièces spécifiques, pas les tokens)
addon.Core.CommonItems.SetItems = {
    -- DK
    { itemID = 237628, name = "Hollow Sentinel's Stonemask", class = "DK", slot = "Head" },
    { itemID = 237626, name = "Hollow Sentinel's Perches", class = "DK", slot = "Shoulders" },
    { itemID = 237631, name = "Hollow Sentinel's Breastplate", class = "DK", slot = "Chest" },
    { itemID = 237629, name = "Hollow Sentinel's Gauntlets", class = "DK", slot = "Hands" },
    { itemID = 237627, name = "Hollow Sentinel's Stonekilt", class = "DK", slot = "Legs" },
    { itemID = 237630, name = "Hollow Sentinel's Greatboots", class = "DK", slot = "Feet" },
    { itemID = 237625, name = "Hollow Sentinel's Greatbelt", class = "DK", slot = "Waist" },
    { itemID = 237623, name = "Hollow Sentinel's Wingdrape", class = "DK", slot = "Back" },
    { itemID = 237624, name = "Hollow Sentinel's Stonecuffs", class = "DK", slot = "Wrists" },
    -- DH
    { itemID = 237691, name = "Charhound's Vicious Scalp", class = "DH", slot = "Head" },
    { itemID = 237689, name = "Charhound's Vicious Hornguards", class = "DH", slot = "Shoulders" },
    { itemID = 237694, name = "Charhound's Vicious Bindings", class = "DH", slot = "Chest" },
    { itemID = 237692, name = "Charhound's Vicious Felclaws", class = "DH", slot = "Hands" },
    { itemID = 237688, name = "Charhound's Vicious Huntbelt", class = "DH", slot = "Waist" },
    { itemID = 237688, name = "Charhound's Vicious Huntbelt", class = "DH", slot = "Legs" },
    { itemID = 237693, name = "Charhound's Vicious Flametabi", class = "DH", slot = "Feet" },
    { itemID = 237686, name = "Charhound's Vicious Felcover", class = "DH", slot = "Back" },
    { itemID = 237687, name = "Charhound's Vicious Restraints", class = "DH", slot = "Wrists" },
    -- Druid
    { itemID = 237682, name = "Skymane of the Mother Eagle", class = "Druid", slot = "Head" },
    { itemID = 237680, name = "Ritual Pauldrons of the Mother Eagle", class = "Druid", slot = "Shoulders" },
    { itemID = 237685, name = "Vest of the Mother Eagle", class = "Druid", slot = "Chest" },
    { itemID = 237683, name = "Wings of the Mother Eagle", class = "Druid", slot = "Hands" },
    { itemID = 237681, name = "Breeches of the Mother Eagle", class = "Druid", slot = "Legs" },
    { itemID = 237684, name = "Feathered Boots of the Mother Eagle", class = "Druid", slot = "Feet" },
    { itemID = 237678, name = "Bands of the Mother Eagle", class = "Druid", slot = "Wrists" },
    { itemID = 237677, name = "Plumage of the Mother Eagle", class = "Druid", slot = "Back" },
    { itemID = 237679, name = "Dreamsash of the Mother Eagle", class = "Druid", slot = "Waist" },
    -- Hunter
    { itemID = 237646, name = "Midnight Herald's Cowl", class = "Hunter", slot = "Head" },
    { itemID = 237644, name = "Midnight Herald's Shadowguards", class = "Hunter", slot = "Shoulders" },
    { itemID = 237649, name = "Midnight Herald's Hauberk", class = "Hunter", slot = "Chest" },
    { itemID = 237647, name = "Midnight Herald's Gloves", class = "Hunter", slot = "Hands" },
    { itemID = 237645, name = "Midnight Herald's Petticoat", class = "Hunter", slot = "Legs" },
    { itemID = 237643, name = "Midnight Herald's Clasp", class = "Hunter", slot = "Waist" },
    { itemID = 237648, name = "Midnight Herald's Jackboots", class = "Hunter", slot = "Feet" },
    { itemID = 237642, name = "Midnight Herald's Wristguards", class = "Hunter", slot = "Wrists" },
    { itemID = 237641, name = "Midnight Herald's Shroud", class = "Hunter", slot = "Back" },
    -- Warrior
    { itemID = 237610, name = "Living Weapon's Faceshield", class = "Warrior", slot = "Head" },
    { itemID = 237608, name = "Living Weapon's Ramparts", class = "Warrior", slot = "Shoulders" },
    { itemID = 237613, name = "Living Weapon's Bulwark", class = "Warrior", slot = "Chest" },
    { itemID = 237611, name = "Living Weapon's Crushers", class = "Warrior", slot = "Hands" },
    { itemID = 237607, name = "Living Weapon's Chain", class = "Warrior", slot = "Waist" },
    { itemID = 237609, name = "Living Weapon's Legguards", class = "Warrior", slot = "Legs" },
    { itemID = 237605, name = "Living Weapon's Cape", class = "Warrior", slot = "Back" },
    { itemID = 237612, name = "Living Weapon's Sabatons", class = "Warrior", slot = "Feet" },
    { itemID = 237606, name = "Living Weapon's Manacles", class = "Warrior", slot = "Wrists" },
    -- Evoker
    { itemID = 237655, name = "Spellweaver's Immaculate", class = "Evoker", slot = "Head" },
    { itemID = 237653, name = "Spellweaver's Immaculate Pauldrons", class = "Evoker", slot = "Shoulders" },
    { itemID = 237658, name = "Spellweaver's Immaculate Crestward", class = "Evoker", slot = "Chest" },
    { itemID = 237656, name = "Spellweaver's Immaculate Scaleguards", class = "Evoker", slot = "Hands" },
    { itemID = 237654, name = "Spellweaver's Immaculate Runeslacks", class = "Evoker", slot = "Legs" },
    { itemID = 237652, name = "Spellweaver's Immaculate Crystal Cord", class = "Evoker", slot = "Waist" },
    { itemID = 237650, name = "Spellweaver's Immaculate Runecloak", class = "Evoker", slot = "Back" },
    { itemID = 237657, name = "Spellweaver's Immaculate Talons", class = "Evoker", slot = "Feet" },
    { itemID = 237651, name = "Spellweaver's Immaculate Cuffs", class = "Evoker", slot = "Wrists" },
    -- Warlock
    { itemID = 237700, name = "Inquisitor's Portal to Madness", class = "Warlock", slot = "Head" },
    { itemID = 237698, name = "Inquisitor's Gaze of Madness", class = "Warlock", slot = "Shoulders" },
    { itemID = 237703, name = "Inquisitor's Robes of Madness", class = "Warlock", slot = "Chest" },
    { itemID = 237701, name = "Inquisitor's Clutches of Madness", class = "Warlock", slot = "Hands" },
    { itemID = 237699, name = "Inquisitor's Leggings of Madness", class = "Warlock", slot = "Legs" },
    { itemID = 237697, name = "Inquisitor's Tome of Madness", class = "Warlock", slot = "Waist" },
    { itemID = 237702, name = "Inquisitor's Treads of Madness", class = "Warlock", slot = "Feet" },
    { itemID = 237695, name = "Inquisitor's All-Seeing Madness", class = "Warlock", slot = "Back" },
    { itemID = 237696, name = "Inquisitor's Bracelets of Madness", class = "Warlock", slot = "Wrists" },
    -- Shaman
    { itemID = 237637, name = "Channeled Fury", class = "Shaman", slot = "Head" },
	{ itemID = 237635, name = "Fangs of Channeled Fury", class = "Shaman", slot = "Shoulders" },
    { itemID = 237640, name = "Furs of Channeled Fury", class = "Shaman", slot = "Chest" },
	{ itemID = 237638, name = "Claws of Channeled Fury", class = "Shaman", slot = "Hands" },
    { itemID = 237636, name = "Tassets of Channeled Fury", class = "Shaman", slot = "Legs" },
    { itemID = 237639, name = "Boots of Channeled Fury", class = "Shaman", slot = "Feet" },
    { itemID = 237634, name = "Fauld of Channeled Fury", class = "Shaman", slot = "Waist" },
    { itemID = 237632, name = "Shawl of Channeled Fury", class = "Shaman", slot = "Back" },
    { itemID = 237633, name = "Bracers of Channeled Fury", class = "Shaman", slot = "Wrists" },
    -- Mage
    { itemID = 237718, name = "Augur's Ephemeral Wide-Brim", class = "Mage", slot = "Head" },
    { itemID = 237716, name = "Augur's Ephemeral Orbs of Power", class = "Mage", slot = "Shoulders" },
    { itemID = 237721, name = "Augur's Ephemeral Habiliments", class = "Mage", slot = "Chest" },
    { itemID = 237717, name = "Augur's Ephemeral Trousers", class = "Mage", slot = "Legs" },
    { itemID = 237719, name = "Augur's Ephemeral Mitts", class = "Mage", slot = "Hands" },
    { itemID = 237720, name = "Augur's Ephemeral Slippers", class = "Mage", slot = "Feet" },
    { itemID = 237715, name = "Augur's Ephemeral Quillsash", class = "Mage", slot = "Waist" },
    { itemID = 237713, name = "Augur's Ephemeral Brilliance", class = "Mage", slot = "Back" },
    { itemID = 237714, name = "Augur's Ephemeral Bindings", class = "Mage", slot = "Wrists" },
    -- Monk
    { itemID = 237673, name = "Half-Mask of Fallen Storms", class = "Monk", slot = "Head" },
    { itemID = 237671, name = "Glyphs of Fallen Storm", class = "Monk", slot = "Shoulders" },
    { itemID = 237676, name = "Gi of Fallen Storms", class = "Monk", slot = "Chest" },
    { itemID = 237674, name = "Grasp of Fallen Storms", class = "Monk", slot = "Hands" },
    { itemID = 237672, name = "Legwraps of Fallen Storms", class = "Monk", slot = "Legs" },
    { itemID = 237675, name = "Footpads of Fallen Storms", class = "Monk", slot = "Feet" },
    { itemID = 237670, name = "Thunderbund of Fallen Storms", class = "Monk", slot =	 "Waist" },
    { itemID = 237668, name = "Breeze of Fallen Storms", class = "Monk", slot = "Back" },
    { itemID = 237669, name = "Demigaunts of Fallen Storms", class = "Monk", slot = "Wrists" },
    -- Paladin
    { itemID = 237619, name = "Lightmane of the Lucent Battalion", class = "Paladin", slot = "Head" },
    { itemID = 237617, name = "Chargers of the Lucent Battalion", class = "Paladin", slot = "Shoulders" },
    { itemID = 237622, name = "Cuirass of the Lucent Battalion", class = "Paladin", slot = "Chest" },
    { itemID = 237620, name = "Protectors of the Lucent Battalion", class = "Paladin", slot = "Hands" },
    { itemID = 237618, name = "Cuisses of the Lucent Battalion", class = "Paladin", slot = "Legs" },
    { itemID = 237621, name = "Stompers of the Lucent Battalion", class = "Paladin", slot = "Feet" },
    { itemID = 237616, name = "Seal of the Lucent Battalion", class = "Paladin", slot = "Waist" },
    { itemID = 237614, name = "Gilded Cloak of the Lucent Battalion", class = "Paladin", slot = "Back" },
    { itemID = 237615, name = "Vambraces of the Lucent Battalion", class = "Paladin", slot = "Wrists" },
    -- Priest
    { itemID = 237709, name = "Dying Star's Veil", class = "Priest", slot = "Head" },
    { itemID = 237707, name = "Dying Star's Pyrelights", class = "Priest", slot = "Shoulders" },
    { itemID = 237712, name = "Dying Star's Cassock", class = "Priest", slot = "Chest" },
    { itemID = 237710, name = "Dying Star's Caress", class = "Priest", slot = "Hands" },
    { itemID = 237708, name = "Dying Star's Leggings", class = "Priest", slot = "Legs" },
    { itemID = 237711, name = "Dying Star's Soles", class = "Priest", slot = "Feet" },
    { itemID = 237706, name = "Dying Star's Waistlight", class = "Priest", slot = "Waist" },
    { itemID = 237705, name = "Dying Star's Bangles", class = "Priest", slot = "Wrists" },
    { itemID = 237704, name = "Dying Star's Memory", class = "Priest", slot = "Back" },
    -- Rogue
    { itemID = 237664, name = "Hood of the Sudden Eclipse", class = "Rogue", slot = "Head" },
    { itemID = 237662, name = "Smokemantle of the Sudden Eclipse", class = "Rogue", slot = "Shoulders" },
    { itemID = 237667, name = "Tactical Vest of the Sudden Eclipse", class = "Rogue", slot = "Chest" },
    { itemID = 237665, name = "Deathgrips of the Sudden Eclipse", class = "Rogue", slot = "Hands" },
    { itemID = 237663, name = "Pants of the Sudden Eclipse", class = "Rogue", slot = "Legs" },
    { itemID = 237659, name = "Cape of the Sudden Eclipse", class = "Rogue", slot = "Back" },
    { itemID = 237666, name = "Bladed Boots of the Sudden Eclipse", class = "Rogue", slot = "Feet" },
    { itemID = 237661, name = "Strap of the Sudden Eclipse", class = "Rogue", slot = "Waist" },
    { itemID = 237660, name = "Armbands of the Sudden Eclipse", class = "Rogue", slot = "Wrists" },
}

-- Items craftés (par type d'armure)
addon.Core.CommonItems.CraftedItems = {
    -- Tissu
    { itemID = 222817, name = "Consecrated Cloak", slot = "Back" },
    { itemID = 222814, name = "Consecrated Slippers", type = "Cloth", slot = "Feet" },
    { itemID = 222815, name = "Consecrated Cuffs", type = "Cloth", slot = "Wrists" },
    -- Cuir
    { itemID = 219334, name = "Rune-Branded Armbands", type = "Leather", slot = "Wrists" },
    { itemID = 219331, name = "Rune-Branded Waistband", type = "Leather", slot = "Waist" },
    { itemID = 219333, name = "Rune-Branded Grasps", type = "Leather", slot = "Hands" },
    { itemID = 219327, name = "Rune-Branded Kickers", type = "Leather", slot = "Feet" },
    { itemID = 219502, name = "Adrenal Surge Clasp", type = "Leather", slot = "Waist" },
    -- Maille
    { itemID = 219339, name = "Glyph-Etched Binding", type = "Mail", slot = "Waist" },
    { itemID = 219342, name = "Glyph-Etched Vambraces", type = "Mail", slot = "Wrists" },
    { itemID = 219335, name = "Glyph-Etched Stompers", type = "Mail", slot = "Feet" },
    -- Plaque
    { itemID = 222435, name = "Everforged Vambraces", type = "Plate", slot = "Wrists" },
    { itemID = 222431, name = "Everforged Greatblet", type = "Plate", slot = "Waist" },
    -- Armes
    { itemID = 222566, name = "Vagabond's Torch", slot = "Off Hand" }, -- OffHand Caster
    { itemID = 222432, name = "Everforged Defender", slot = "Off Hand" }, -- Shield
    { itemID = 221969, name = "P.0.W. x2", slot = "Weapon" }, -- Gun
    { itemID = 222447, name = "Charged Claymore", slot = "Weapon" }, -- Sword 2H
    { itemID = 222448, name = "Charged Halberd", slot = "Weapon" }, -- Halberd 2H
    { itemID = 222446, name = "Charged Facesmasher", slot = "Weapon" }, -- Fist 1H
    { itemID = 222446, name = "Charged Facesmasher", slot = "Off Hand" }, -- Fist 1H
    { itemID = 222441, name = "Everforged Warglaive", slot = "Weapon" }, -- Warglaive 1H
    { itemID = 222441, name = "Everforged Warglaive", slot = "Off Hand" }, -- Warglaive 1H
    { itemID = 222438, name = "Everforged Stabber", slot = "Weapon" }, -- Dagger 1H
    { itemID = 222438, name = "Everforged Stabber", slot = "Off Hand" }, -- Dagger 1H
    { itemID = 222440, name = "Everforged Longsword", slot = "Weapon" }, -- Sword 1H
    { itemID = 222440, name = "Everforged Longsword", slot = "Off Hand" }, -- Sword 1H
    { itemID = 222443, name = "Everforged Greataxe", slot = "Weapon" }, -- Axe 2H
    { itemID = 222451, name = "Charged Slicer", slot = "Weapon" }, -- Axe 1H
    { itemID = 222451, name = "Charged Slicer", slot = "Off Hand" }, -- Axe 1H
    { itemID = 222450, name = "Charged Invoker", slot = "Weapon" }, -- Hammer 2H
    { itemID = 222568, name = "Vagabond's Bounding Baton", slot = "Weapon" }, -- Staff 2H
    -- Accessoires
    { itemID = 215133, name = "Binding of Binding", slot = "Ring 1" },
    { itemID = 215133, name = "Binding of Binding", slot = "Ring 2" },
    { itemID = 215135, name = "Ring of Earthen Craftsmanship", slot = "Ring 1" },
    { itemID = 215135, name = "Ring of Earthen Craftsmanship", slot = "Ring 2" },
    { itemID = 215136, name = "Amulet of Earthen Craftsmanship", slot = "Neck" },
	{ itemID = 228411, name = "Cyrce's Circlet", class = "All", slot = "Ring 1", source = "Siren Isle"},
    { itemID = 228411, name = "Cyrce's Circlet", class = "All", slot = "Ring 2", source = "Siren Isle"},
    -- Autres
    { itemID = 221802, name = "Overclocked Idea Generator", type = "All", slot = "Head" },
}