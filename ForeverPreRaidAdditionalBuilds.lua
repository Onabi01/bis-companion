-- Forever 2.5.4: additional Pre-Raid BiS gear sets for materially different PvE builds.
-- References: wowforeverbislist.com/pre-raid (November 19, 2026), plus Forever item IDs.
-- Some loot, profession, or faction availability is provisional; verify in game.
-- Do not mutate, replace, or copy into personal SavedVariables any of the 28 base lists.
if not BiSCompanionForever or not BiSCompanionForeverGearReady then return end
if type(BiSCompanionForeverGearVariants) ~= "table" then return end
if type(BiSCompanionForeverGearVariantLabels) ~= "table" then return end
local variants = BiSCompanionForeverGearVariants
local labels = BiSCompanionForeverGearVariantLabels
local validSlots = { Head=true, Neck=true, Shoulders=true, Back=true, Chest=true,
    Wrists=true, Hands=true, Waist=true, Legs=true, Feet=true,
    ["Ring 1"]=true, ["Ring 2"]=true, ["Trinket 1"]=true, ["Trinket 2"]=true,
    Weapon=true, ["Off Hand"]=true, Ranged=true }

-- Each set is fail-closed: one unknown slot, duplicate ID, or invalid item cancels that set.
local function addSet(spec, key, label, rows)
    if type(rows) ~= "table" or (#rows ~= 16 and #rows ~= 17) then return end
    if variants[spec] and variants[spec][key] then return end
    local seenSlots, seenIDs, items = {}, {}, {}
    for _, row in ipairs(rows) do
        local slot, name, id, source = row[1], row[2], tonumber(row[3]), row[4]
        if not validSlots[slot] or seenSlots[slot] or type(name) ~= "string"
            or name == "" or not id or id <= 0 or seenIDs[id]
            or type(source) ~= "string" or source == "" then return end
        seenSlots[slot], seenIDs[id] = true, true
        local item = { slot=slot, name=name, id=tostring(id), source=source }
        if slot == "Ranged" and spec:match("^Paladin_") then item.displaySlot="Relic" end
        items[#items + 1] = item
    end
    for _, slot in ipairs({"Head","Neck","Shoulders","Back","Chest","Wrists",
        "Hands","Waist","Legs","Feet","Ring 1","Ring 2",
        "Trinket 1","Trinket 2","Weapon","Ranged"}) do
        if not seenSlots[slot] then return end
    end
    variants[spec] = variants[spec] or {}
    labels[spec] = labels[spec] or {}
    variants[spec][key] = items
    labels[spec][key] = label
end

-- Hunter_Survival / Melee (differs in 11 slots from current default).
addSet("Hunter_Survival", "__preraid_survival_melee", "Pre-Raid BiS - Melee", {
    { "Head", "Black Dragonscale Helm", "252605", "Leatherworking / Crafted" },
    { "Neck", "Mark of Fordring", "15411", "In Dreams / Quest" },
    { "Shoulders", "Bone Golem Shoulders", "18686", "Rattlegore / Scholomance" },
    { "Back", "Cape of the Black Baron", "13340", "Baron Rivendare / Stratholme" },
    { "Chest", "Dawn Armor", "252483", "Leatherworking / Crafted" },
    { "Wrists", "Bracers of the Eclipse", "18375", "Prince Tortheldrin / Dire Maul: West" },
    { "Hands", "Devilsaur Gauntlets", "15063", "Leatherworking / Crafted" },
    { "Waist", "Ranger's Belt", "272397", "Pix Xizzix / Stranglethorn Vale" },
    { "Legs", "Devilsaur Leggings", "15062", "Leatherworking / Crafted" },
    { "Feet", "Windreaver Greaves", "13967", "Kirtonos the Herald / Scholomance" },
    { "Ring 1", "Painweaver Band", "13098", "General Drakkisath / Blackrock Spire: Upper" },
    { "Ring 2", "Cutthroat's Signet", "272408", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 1", "Hand of Justice", "11815", "Emperor Dagran Thaurissan / Blackrock Depths" },
    { "Trinket 2", "Adaptive Combat Assistant", "272437", "Pix Xizzix / Stranglethorn Vale" },
    { "Weapon", "Dal'Rend's Sacred Charge", "12940", "Warchief Rend Blackhand / Blackrock Spire: Upper" },
    { "Off Hand", "Felstriker", "12590", "Warchief Rend Blackhand / Blackrock Spire: Upper" },
    { "Ranged", "Precisely Calibrated Boomstick", "2100", "World drop (source to confirm in Forever)" },
})

-- Hunter_Survival / Melee Weaving (differs in 12 slots from current default).
addSet("Hunter_Survival", "__preraid_survival_weaving", "Pre-Raid BiS - Melee Weaving", {
    { "Head", "Black Dragonscale Helm", "252605", "Leatherworking / Crafted" },
    { "Neck", "Mark of Fordring", "15411", "In Dreams / Quest" },
    { "Shoulders", "Stratholme Militia Shoulderguard", "18742", "Stratholme (drop to confirm)" },
    { "Back", "Cape of the Black Baron", "13340", "Baron Rivendare / Stratholme" },
    { "Chest", "Dawn Armor", "252483", "Leatherworking / Crafted" },
    { "Wrists", "Bracers of the Eclipse", "18375", "Prince Tortheldrin / Dire Maul: West" },
    { "Hands", "Devilsaur Gauntlets", "15063", "Leatherworking / Crafted" },
    { "Waist", "Ranger's Belt", "272397", "Pix Xizzix / Stranglethorn Vale" },
    { "Legs", "Devilsaur Leggings", "15062", "Leatherworking / Crafted" },
    { "Feet", "Beastmaster's Treads", "226881", "Anthion's Parting Words / Quest" },
    { "Ring 1", "Eagle's Head Signet", "260217", "Quest / Forever (source to confirm)" },
    { "Ring 2", "Cutthroat's Signet", "272408", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 1", "Blackhand's Breadth", "13965", "For The Horde! / General Drakkisath's Demise / Quest" },
    { "Trinket 2", "Behemoth Bones", "280065", "Blackmaw Behemoth / Blackmaw Hold" },
    { "Weapon", "Legionite Glaive", "250619", "Blacksmithing / Crafted" },
    { "Ranged", "Eaglehorn Long Bow", "13023", "World drop" },
})

-- Rogue_Combat / Backstab (Daggers) (differs in 9 slots from current default).
addSet("Rogue_Combat", "__preraid_combat_daggers", "Pre-Raid BiS - Backstab (Daggers)", {
    { "Head", "Darkmantle Cap", "22005", "Saving the Best for Last / Quest" },
    { "Neck", "Mark of Fordring", "15411", "In Dreams / Quest" },
    { "Shoulders", "Stormshroud Shoulders", "15058", "Leatherworking / Crafted" },
    { "Back", "Cape of the Black Baron", "13340", "Baron Rivendare / Stratholme" },
    { "Chest", "Dawn Armor", "252483", "Leatherworking / Crafted" },
    { "Wrists", "Bracers of the Eclipse", "18375", "Prince Tortheldrin / Dire Maul: West" },
    { "Hands", "Stormshroud Gloves", "21278", "Leatherworking / Crafted" },
    { "Waist", "Assassin's Waistguard", "272395", "Pix Xizzix / Stranglethorn Vale" },
    { "Legs", "Stormshroud Pants", "15057", "Leatherworking / Crafted" },
    { "Feet", "Darkmantle Footpads", "226831", "Anthion's Parting Words / Quest" },
    { "Ring 1", "Painweaver Band", "13098", "General Drakkisath / Blackrock Spire: Upper" },
    { "Ring 2", "Cutthroat's Signet", "272408", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 1", "Hand of Justice", "11815", "Emperor Dagran Thaurissan / Blackrock Depths" },
    { "Trinket 2", "Behemoth Bones", "280065", "Blackmaw Behemoth / Blackmaw Hold" },
    { "Weapon", "Felstriker", "12590", "Warchief Rend Blackhand / Blackrock Spire: Upper" },
    { "Off Hand", "King Mosh's Tooth", "286613", "King Mosh / Un'Goro (drop to confirm)" },
    { "Ranged", "Precisely Calibrated Boomstick", "2100", "World drop (source to confirm in Forever)" },
})

-- Mage_Arcane / Arcane Fire (differs in 7 slots from current default).
addSet("Mage_Arcane", "__preraid_arcane_fire", "Pre-Raid BiS - Arcane Fire", {
    { "Head", "Sorcerer's Crown", "22065", "Saving the Best for Last / Quest" },
    { "Neck", "Nacreous Shell Necklace", "22403", "Cannon Master Willey / Stratholme" },
    { "Shoulders", "Rugged Mantle of the Timbermaw", "227808", "Meilosh / Timbermaw Hold (Tailoring requirement)" },
    { "Back", "Arcanoweave Cloak", "272411", "Pix Xizzix / Stranglethorn Vale" },
    { "Chest", "Robe of the Archmage", "14152", "Tailoring / Crafted" },
    { "Wrists", "Sublime Wristguards", "18497", "Trash drop / Dire Maul" },
    { "Hands", "Sorcerer's Gauntlets", "226930", "Just Compensation / Quest" },
    { "Waist", "Knowledge of the Timbermaw", "228190", "Meilosh / Timbermaw Hold (availability unconfirmed)" },
    { "Legs", "Skyshroud Leggings", "13170", "Highlord Omokk / Blackrock Spire: Lower" },
    { "Feet", "Sorcerer's Sandals", "226931", "Anthion's Parting Words / Quest" },
    { "Ring 1", "Songstone of Ironforge", "12543", "The Princess's Surprise / Quest (Alliance)" },
    { "Ring 2", "Channeler's Ring", "272406", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 1", "Eye of the Beast", "13968", "For The Horde! / General Drakkisath's Demise / Quest" },
    { "Trinket 2", "Weakness Analyzer", "272438", "Pix Xizzix / Stranglethorn Vale" },
    { "Weapon", "Staff of Sorrow", "280082", "Forever (source to confirm)" },
    { "Ranged", "Bonecreeper Stylus", "13938", "Darkmaster Gandling / Scholomance" },
})

-- Mage_Fire / Frostfire Bolt (differs in 13 slots from current default).
addSet("Mage_Fire", "__preraid_frostfire", "Pre-Raid BiS - Frostfire Bolt", {
    { "Head", "Spellweaver's Turban", "22267", "General Drakkisath / Blackrock Spire: Upper" },
    { "Neck", "Nacreous Shell Necklace", "22403", "Cannon Master Willey / Stratholme" },
    { "Shoulders", "Rugged Mantle of the Timbermaw", "227808", "Meilosh / Timbermaw Hold (Tailoring requirement)" },
    { "Back", "Arcanoweave Cloak", "272411", "Pix Xizzix / Stranglethorn Vale" },
    { "Chest", "Robe of the Archmage", "14152", "Tailoring / Crafted" },
    { "Wrists", "Netherflame Cuffs", "254065", "Tailoring / Crafted (profession requirement)" },
    { "Hands", "Gloves of Spell Mastery", "14146", "Tailoring / Crafted" },
    { "Waist", "Knowledge of the Timbermaw", "228190", "Meilosh / Timbermaw Hold (availability unconfirmed)" },
    { "Legs", "Skyshroud Leggings", "13170", "Highlord Omokk / Blackrock Spire: Lower" },
    { "Feet", "Fire Striders", "13369", "Stratholme (drop to confirm)" },
    { "Ring 1", "Rune Band of Wizardry", "22339", "Lord Valthalak / Blackrock Spire: Upper" },
    { "Ring 2", "Don Mauricio's Band of Domination", "22433", "Darkmaster Gandling / Scholomance" },
    { "Trinket 1", "Eye of the Beast", "13968", "For The Horde! / General Drakkisath's Demise / Quest" },
    { "Trinket 2", "Weakness Analyzer", "272438", "Pix Xizzix / Stranglethorn Vale" },
    { "Weapon", "Elemental Mage Staff", "944", "World drop" },
    { "Ranged", "Pyric Caduceus", "11748", "Pyromancer Loregrain / Blackrock Depths" },
})

-- Priest_Discipline / Smite DPS (differs in 16 slots from current default).
addSet("Priest_Discipline", "__preraid_smite", "Pre-Raid BiS - Smite DPS", {
    { "Head", "Virtuous Cowl", "226957", "Virtuous set / source to confirm" },
    { "Neck", "Orb of the Darkmoon", "19426", "Darkmoon Faire / Ticket Quest" },
    { "Shoulders", "Rugged Mantle of the Timbermaw", "227808", "Meilosh / Timbermaw Hold (Tailoring requirement)" },
    { "Back", "Amplifying Cloak", "18350", "Magister Kalendris / Dire Maul: West" },
    { "Chest", "Virtuous Gown", "226960", "Virtuous set / source to confirm" },
    { "Wrists", "Sublime Wristguards", "18497", "Trash drop / Dire Maul" },
    { "Hands", "Virtuous Hands", "226958", "Virtuous set / source to confirm" },
    { "Waist", "Knowledge of the Timbermaw", "228190", "Meilosh / Timbermaw Hold (availability unconfirmed)" },
    { "Legs", "Spiritshroud Leggings", "12965", "The Beast / Blackrock Spire" },
    { "Feet", "Virtuous Slippers", "226959", "Anthion's Parting Words / Quest" },
    { "Ring 1", "Maiden's Circle", "13001", "Stratholme (drop to confirm)" },
    { "Ring 2", "Jereman's Bauble", "275738", "Return to Jereman / Quest" },
    { "Trinket 1", "Mindtap Talisman", "18371", "Dire Maul (drop)" },
    { "Trinket 2", "Weakness Analyzer", "272438", "Pix Xizzix / Stranglethorn Vale" },
    { "Weapon", "Headmaster's Charge", "13937", "Darkmaster Gandling / Scholomance" },
    { "Ranged", "Bonecreeper Stylus", "13938", "Darkmaster Gandling / Scholomance" },
})

-- Warlock_Demonology / Shadow Brand (differs in 8 slots from current default).
addSet("Warlock_Demonology", "__preraid_shadow_brand", "Pre-Raid BiS - Shadow Brand", {
    { "Head", "Spellweaver's Turban", "22267", "General Drakkisath / Blackrock Spire: Upper" },
    { "Neck", "Orb of the Darkmoon", "19426", "Darkmoon Faire / Ticket Quest" },
    { "Shoulders", "Rugged Mantle of the Timbermaw", "227808", "Meilosh / Timbermaw Hold (Tailoring requirement)" },
    { "Back", "Arcanoweave Cloak", "272411", "Pix Xizzix / Stranglethorn Vale" },
    { "Chest", "Robe of the Void", "14153", "Tailoring / Crafted" },
    { "Wrists", "Sublime Wristguards", "18497", "Trash drop / Dire Maul" },
    { "Hands", "Gloves of Spell Mastery", "14146", "Tailoring / Crafted" },
    { "Waist", "Knowledge of the Timbermaw", "228190", "Meilosh / Timbermaw Hold (availability unconfirmed)" },
    { "Legs", "Skyshroud Leggings", "13170", "Highlord Omokk / Blackrock Spire: Lower" },
    { "Feet", "Omnicast Boots", "11822", "Golem Lord Argelmach / Blackrock Depths" },
    { "Ring 1", "Songstone of Ironforge", "12543", "The Princess's Surprise / Quest (Alliance)" },
    { "Ring 2", "Channeler's Ring", "272406", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 1", "Royal Seal of Eldre'Thalas", "18472", "The Light and How To Swing It / Quest" },
    { "Trinket 2", "Weakness Analyzer", "272438", "Pix Xizzix / Stranglethorn Vale" },
    { "Weapon", "Headmaster's Charge", "13937", "Darkmaster Gandling / Scholomance" },
    { "Ranged", "Bonecreeper Stylus", "13938", "Darkmaster Gandling / Scholomance" },
})

-- Warlock_Affliction / SM/Ruin (differs in 11 slots from current default).
addSet("Warlock_Affliction", "__preraid_sm_ruin", "Pre-Raid BiS - SM/Ruin", {
    { "Head", "Spellweaver's Turban", "22267", "General Drakkisath / Blackrock Spire: Upper" },
    { "Neck", "Orb of the Darkmoon", "19426", "Darkmoon Faire / Ticket Quest" },
    { "Shoulders", "Rugged Mantle of the Timbermaw", "227808", "Meilosh / Timbermaw Hold (Tailoring requirement)" },
    { "Back", "Arcanoweave Cloak", "272411", "Pix Xizzix / Stranglethorn Vale" },
    { "Chest", "Robe of the Void", "14153", "Tailoring / Crafted" },
    { "Wrists", "Sublime Wristguards", "18497", "Trash drop / Dire Maul" },
    { "Hands", "Gloves of Spell Mastery", "14146", "Tailoring / Crafted" },
    { "Waist", "Knowledge of the Timbermaw", "228190", "Meilosh / Timbermaw Hold (availability unconfirmed)" },
    { "Legs", "Leggings of Torment", "22342", "Lord Valthalak / Blackrock Spire: Upper" },
    { "Feet", "Omnicast Boots", "11822", "Golem Lord Argelmach / Blackrock Depths" },
    { "Ring 1", "Rune Band of Wizardry", "22339", "Lord Valthalak / Blackrock Spire: Upper" },
    { "Ring 2", "Channeler's Ring", "272406", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 1", "Royal Seal of Eldre'Thalas", "18472", "The Light and How To Swing It / Quest" },
    { "Trinket 2", "Weakness Analyzer", "272438", "Pix Xizzix / Stranglethorn Vale" },
    { "Weapon", "Rod of the Ogre Magi", "18534", "Dire Maul (drop)" },
    { "Ranged", "Bonecreeper Stylus", "13938", "Darkmaster Gandling / Scholomance" },
})

-- Paladin_Protection / Holy-Protection (Threat) (differs in 17 slots from current default).
addSet("Paladin_Protection", "__preraid_holy_prot_alliance", "Pre-Raid BiS - Holy-Prot (Alliance)", {
    { "Head", "Stalwart Helm", "250599", "Blacksmithing / Crafted" },
    { "Neck", "Mark of Fordring", "15411", "In Dreams / Quest" },
    { "Shoulders", "Truestrike Shoulders", "12927", "Blackrock Spire (drop)" },
    { "Back", "Arcanoweave Cloak", "272411", "Pix Xizzix / Stranglethorn Vale" },
    { "Chest", "Plate of the Shaman King", "13168", "World drop / source to confirm" },
    { "Wrists", "Justicar's Wristguards", "250585", "Blacksmithing / Crafted" },
    { "Hands", "Storm Gauntlets", "12632", "Leatherworking / Crafted" },
    { "Waist", "Vindicator's Belt", "272404", "Pix Xizzix / Stranglethorn Vale" },
    { "Legs", "Champion's Legplates", "250598", "Blacksmithing / Crafted" },
    { "Feet", "Justicar's Sabatons", "250565", "Blacksmithing / Crafted" },
    { "Ring 1", "Blessed Band of Light", "272407", "Pix Xizzix / Stranglethorn Vale" },
    { "Ring 2", "Songstone of Ironforge", "12543", "The Princess's Surprise / Quest (Alliance)" },
    { "Trinket 1", "Adaptive Combat Assistant", "272437", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 2", "Briarwood Reed", "12930", "Jed Runewatcher / Blackrock Spire: Upper" },
    { "Weapon", "Ironfoe", "11684", "Emperor Dagran Thaurissan / Blackrock Depths" },
    { "Off Hand", "Dreadguard's Protector", "18756", "Blackrock Spire (drop)" },
    { "Ranged", "Sentinel's Libram", "272434", "Pix Xizzix / Stranglethorn Vale" },
})

-- Paladin_Protection / Holy-Protection (Horde) (differs in 17 slots from current default).
addSet("Paladin_Protection", "__preraid_holy_prot_horde", "Pre-Raid BiS - Holy-Prot (Horde)", {
    { "Head", "Stalwart Helm", "250599", "Blacksmithing / Crafted" },
    { "Neck", "Mark of Fordring", "15411", "In Dreams / Quest" },
    { "Shoulders", "Truestrike Shoulders", "12927", "Blackrock Spire (drop)" },
    { "Back", "Arcanoweave Cloak", "272411", "Pix Xizzix / Stranglethorn Vale" },
    { "Chest", "Plate of the Shaman King", "13168", "World drop / source to confirm" },
    { "Wrists", "Justicar's Wristguards", "250585", "Blacksmithing / Crafted" },
    { "Hands", "Storm Gauntlets", "12632", "Leatherworking / Crafted" },
    { "Waist", "Vindicator's Belt", "272404", "Pix Xizzix / Stranglethorn Vale" },
    { "Legs", "Champion's Legplates", "250598", "Blacksmithing / Crafted" },
    { "Feet", "Justicar's Sabatons", "250565", "Blacksmithing / Crafted" },
    { "Ring 1", "Blessed Band of Light", "272407", "Pix Xizzix / Stranglethorn Vale" },
    { "Ring 2", "Eye of Orgrimmar", "12545", "The Princess's Surprise / Quest (Horde only)" },
    { "Trinket 1", "Adaptive Combat Assistant", "272437", "Pix Xizzix / Stranglethorn Vale" },
    { "Trinket 2", "Briarwood Reed", "12930", "Jed Runewatcher / Blackrock Spire: Upper" },
    { "Weapon", "Ironfoe", "11684", "Emperor Dagran Thaurissan / Blackrock Depths" },
    { "Off Hand", "Dreadguard's Protector", "18756", "Blackrock Spire (drop)" },
    { "Ranged", "Sentinel's Libram", "272434", "Pix Xizzix / Stranglethorn Vale" },
})
