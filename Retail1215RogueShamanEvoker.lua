-- Midnight 12.1.5 Overall BiS, verified against Icy Veins and Wowhead.
BiSCompanionBisData = BiSCompanionBisData or {}

-- https://www.icy-veins.com/wow/assassination-rogue-pve-dps-gear-best-in-slot
local RogueAssassination1215 = {
    { slot = "Head", name = "Gaze of the Coiled Watcher", source = "Icy Veins", id = "271875" },
    { slot = "Hands", name = "Chosen Bloodslayer's Fanged Grips", source = "Icy Veins", id = "271511" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Sash of the Forlorn Vessel", source = "Icy Veins", id = "268256" },
    { slot = "Shoulders", name = "Chosen Bloodslayer's Voodoo Guards", source = "Icy Veins", id = "271508" },
    { slot = "Legs", name = "Chosen Bloodslayer's Reinforced Pants", source = "Icy Veins", id = "271509" },
    { slot = "Back", name = "Silken Voodoo Drape", source = "Icy Veins", id = "268253" },
    { slot = "Feet", name = "Arctic Explorer's Legwraps", source = "Icy Veins", id = "251153" },
    { slot = "Chest", name = "Chosen Bloodslayer's Banded Poncho", source = "Icy Veins", id = "271513" },
    { slot = "Ring 1", name = "Vile Alchemist's Band", source = "Icy Veins", id = "268249" },
    { slot = "Ring 2", name = "Band of the Swarmcaller", source = "Icy Veins", id = "281029" },
    { slot = "Trinket 1", name = "Twisted Horror's Tendril", source = "Icy Veins", id = "281215" },
    { slot = "Wrists", name = "Silvermoon Agent's Deflectors", source = "Icy Veins", id = "244576" },
    { slot = "Trinket 2", name = "Voracious Heart of Ula'tek", source = "Icy Veins", id = "270175" },
    { slot = "Weapon", name = "Zatha'tek, Breath of Corruption", source = "Icy Veins", id = "271093" },
    { slot = "Off Hand", name = "Farstrider's Mercy", source = "Icy Veins", id = "237837" },
}
BiSCompanionBisData["Rogue_Assassination_Deathstalker"] = RogueAssassination1215
BiSCompanionBisData["Rogue_Assassination_Fatebound"] = RogueAssassination1215

-- https://www.icy-veins.com/wow/outlaw-rogue-pve-dps-gear-best-in-slot
local RogueOutlaw1215 = {
    { slot = "Head", name = "Gaze of the Coiled Watcher", source = "Icy Veins", id = "271875" },
    { slot = "Hands", name = "Chosen Bloodslayer's Fanged Grips", source = "Icy Veins", id = "271511" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Silvermoon Agent's Utility Belt", source = "Icy Veins", id = "244573" },
    { slot = "Shoulders", name = "Chosen Bloodslayer's Voodoo Guards", source = "Icy Veins", id = "271508" },
    { slot = "Legs", name = "Chosen Bloodslayer's Reinforced Pants", source = "Icy Veins", id = "271509" },
    { slot = "Back", name = "Amani Summoning Shawl", source = "Icy Veins", id = "268248" },
    { slot = "Feet", name = "Silvermoon Agent's Sneakers", source = "Icy Veins", id = "244569" },
    { slot = "Chest", name = "Chosen Bloodslayer's Banded Poncho", source = "Icy Veins", id = "271513" },
    { slot = "Ring 1", name = "Alluring Bubbleband", source = "Icy Veins", id = "268266" },
    { slot = "Ring 2", name = "Apex Brute's Claw Ring", source = "Icy Veins", id = "268252" },
    { slot = "Trinket 1", name = "Zul'jin's Guillotine Technique", source = "Icy Veins", id = "270173" },
    { slot = "Wrists", name = "Restless Spirit Shackles", source = "Icy Veins", id = "268240" },
    { slot = "Trinket 2", name = "Voracious Heart of Ula'tek", source = "Icy Veins", id = "270175" },
    { slot = "Weapon", name = "Aman'muso, Warlord's Vengeance", source = "Icy Veins", id = "268209" },
    { slot = "Off Hand", name = "Sharpened Lightwood Slasher", source = "Icy Veins", id = "275070" },
}
BiSCompanionBisData["Rogue_Outlaw_Fatebound"] = RogueOutlaw1215
BiSCompanionBisData["Rogue_Outlaw_Trickster"] = RogueOutlaw1215

-- https://www.icy-veins.com/wow/subtlety-rogue-pve-dps-gear-best-in-slot
local RogueSubtlety1215 = {
    { slot = "Head", name = "Chosen Bloodslayer's Spirit Shroud", source = "Icy Veins", id = "271510" },
    { slot = "Hands", name = "Chosen Bloodslayer's Fanged Grips", source = "Icy Veins", id = "271511" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Sash of the Forlorn Vessel", source = "Icy Veins", id = "268256" },
    { slot = "Shoulders", name = "Chosen Bloodslayer's Voodoo Guards", source = "Icy Veins", id = "271508" },
    { slot = "Legs", name = "Chosen Bloodslayer's Reinforced Pants", source = "Icy Veins", id = "271509" },
    { slot = "Back", name = "Silken Voodoo Drape", source = "Icy Veins", id = "268253" },
    { slot = "Feet", name = "Arctic Explorer's Legwraps", source = "Icy Veins", id = "251153" },
    { slot = "Chest", name = "Chosen Bloodslayer's Banded Poncho", source = "Icy Veins", id = "271513" },
    { slot = "Ring 1", name = "Lightwarden's Bind", source = "Icy Veins", id = "251194" },
    { slot = "Ring 2", name = "Band of the Swarmcaller", source = "Icy Veins", id = "281029" },
    { slot = "Trinket 1", name = "Voracious Heart of Ula'tek", source = "Icy Veins", id = "270175" },
    { slot = "Wrists", name = "Silvermoon Agent's Deflectors", source = "Icy Veins", id = "244576" },
    { slot = "Trinket 2", name = "Zul'jin's Guillotine Technique", source = "Icy Veins", id = "270173" },
    { slot = "Weapon", name = "Zatha'tek, Breath of Corruption", source = "Icy Veins", id = "271093" },
    { slot = "Off Hand", name = "Farstrider's Mercy", source = "Icy Veins", id = "237837" },
}
BiSCompanionBisData["Rogue_Subtlety_Deathstalker"] = RogueSubtlety1215
BiSCompanionBisData["Rogue_Subtlety_Trickster"] = RogueSubtlety1215

-- https://www.icy-veins.com/wow/elemental-shaman-pve-dps-gear-best-in-slot
local ShamanElemental1215 = {
    { slot = "Head", name = "Serpent Crown of the Ophidian Oracle", source = "Icy Veins", id = "271483" },
    { slot = "Hands", name = "Aberrant Commander's Gauntlets", source = "Icy Veins", id = "281238" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Serpentine Mixing Belt", source = "Icy Veins", id = "268254" },
    { slot = "Shoulders", name = "Hissing Mantle of the Ophidian Oracle", source = "Icy Veins", id = "271481" },
    { slot = "Legs", name = "Leggings of the Ophidian Oracle", source = "Icy Veins", id = "271482" },
    { slot = "Back", name = "Silken Voodoo Drape", source = "Icy Veins", id = "268253" },
    { slot = "Feet", name = "Ferocious Scaleboots", source = "Icy Veins", id = "268233" },
    { slot = "Chest", name = "Fanged Raiment of the Ophidian Oracle", source = "Icy Veins", id = "271486" },
    { slot = "Ring 1", name = "Apex Brute's Claw Ring", source = "Icy Veins", id = "268252" },
    { slot = "Ring 2", name = "Band of the Swarmcaller", source = "Icy Veins", id = "281029" },
    { slot = "Trinket 1", name = "Twisted Horror's Tendril", source = "Icy Veins", id = "281215" },
    { slot = "Wrists", name = "Farstrider's Plated Bracers", source = "Icy Veins", id = "244584" },
    { slot = "Trinket 2", name = "Vile Vial of Volatile Venom", source = "Icy Veins", id = "273796" },
    { slot = "Weapon", name = "Jan'thrazet, the Soul Fang", source = "Icy Veins", id = "271092" },
    { slot = "Off Hand", name = "Aln'hara Lantern", source = "Icy Veins", id = "245769" },
}
BiSCompanionBisData["Shaman_Ele_Farseer"] = ShamanElemental1215
BiSCompanionBisData["Shaman_Ele_Stormbringer"] = ShamanElemental1215

-- https://www.icy-veins.com/wow/enhancement-shaman-pve-dps-gear-best-in-slot
local ShamanEnhancement1215 = {
    { slot = "Head", name = "Serpent Crown of the Ophidian Oracle", source = "Icy Veins", id = "271483" },
    { slot = "Hands", name = "Hexing Grips of the Ophidian Oracle", source = "Icy Veins", id = "271484" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Serpentine Mixing Belt", source = "Icy Veins", id = "268254" },
    { slot = "Shoulders", name = "Hissing Mantle of the Ophidian Oracle", source = "Icy Veins", id = "271481" },
    { slot = "Legs", name = "Leggings of the Ophidian Oracle", source = "Icy Veins", id = "271482" },
    { slot = "Back", name = "Silken Voodoo Drape", source = "Icy Veins", id = "268253" },
    { slot = "Feet", name = "Boots of the Reckless Wayfarer", source = "Icy Veins", id = "268258" },
    { slot = "Chest", name = "Fanged Raiment of the Ophidian Oracle", source = "Icy Veins", id = "271486" },
    { slot = "Ring 1", name = "Apex Brute's Claw Ring", source = "Icy Veins", id = "268252" },
    { slot = "Ring 2", name = "Band of the Swarmcaller", source = "Icy Veins", id = "281029" },
    { slot = "Trinket 1", name = "Voracious Heart of Ula'tek", source = "Icy Veins", id = "270175" },
    { slot = "Wrists", name = "Farstrider's Plated Bracers", source = "Icy Veins", id = "244584" },
    { slot = "Trinket 2", name = "Zul'jin's Guillotine Technique", source = "Icy Veins", id = "270173" },
    { slot = "Weapon", name = "Aman'muso, Warlord's Vengeance", source = "Icy Veins", id = "268209" },
    { slot = "Off Hand", name = "Farstrider's Chopper", source = "Icy Veins", id = "237850" },
}
BiSCompanionBisData["Shaman_Enh_Stormbringer"] = ShamanEnhancement1215
BiSCompanionBisData["Shaman_Enh_Totemic"] = ShamanEnhancement1215

-- https://www.icy-veins.com/wow/restoration-shaman-pve-healing-gear-best-in-slot
local ShamanRestoration1215 = {
    { slot = "Head", name = "Serpent Crown of the Ophidian Oracle", source = "Icy Veins", id = "271483" },
    { slot = "Hands", name = "Hexing Grips of the Ophidian Oracle", source = "Icy Veins", id = "271484" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Cursed Reliquary Cincture", source = "Icy Veins", id = "268216" },
    { slot = "Shoulders", name = "Hissing Mantle of the Ophidian Oracle", source = "Icy Veins", id = "271481" },
    { slot = "Legs", name = "Leggings of the Ophidian Oracle", source = "Icy Veins", id = "271482" },
    { slot = "Back", name = "Amani Summoning Shawl", source = "Icy Veins", id = "268248" },
    { slot = "Feet", name = "Farstrider's Razor Talons", source = "Icy Veins", id = "244577" },
    { slot = "Chest", name = "Fanged Raiment of the Ophidian Oracle", source = "Icy Veins", id = "271486" },
    { slot = "Ring 1", name = "Signet of Snarling Servitude", source = "Icy Veins", id = "251136" },
    { slot = "Ring 2", name = "Apex Brute's Claw Ring", source = "Icy Veins", id = "268252" },
    { slot = "Trinket 1", name = "Twisted Horror's Tendril", source = "Icy Veins", id = "281215" },
    { slot = "Wrists", name = "Farstrider's Plated Bracers", source = "Icy Veins", id = "244584" },
    { slot = "Trinket 2", name = "Gebbo's Bottomless Bag", source = "Icy Veins", id = "270164" },
    { slot = "Weapon", name = "Jan'thrazet, the Soul Fang", source = "Icy Veins", id = "271092" },
    { slot = "Off Hand", name = "Teldrassil's Sacrifice", source = "Icy Veins", id = "251196" },
}
BiSCompanionBisData["Shaman_Resto_Farseer"] = ShamanRestoration1215
BiSCompanionBisData["Shaman_Resto_Totemic"] = ShamanRestoration1215

-- https://www.icy-veins.com/wow/devastation-evoker-pve-dps-gear-best-in-slot
local EvokerDevastation1215 = {
    { slot = "Head", name = "Calamitous Echo's Magmashapers", source = "Icy Veins", id = "271501" },
    { slot = "Hands", name = "Calamitous Echo's Ebon Greathorns", source = "Icy Veins", id = "271502" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Serpentine Mixing Belt", source = "Icy Veins", id = "268254" },
    { slot = "Shoulders", name = "Calamitous Echo's Sundered Peaks", source = "Icy Veins", id = "271499" },
    { slot = "Legs", name = "Earthen Pillars of Calamity", source = "Icy Veins", id = "271500" },
    { slot = "Back", name = "Silken Voodoo Drape", source = "Icy Veins", id = "268253" },
    { slot = "Feet", name = "Ferocious Scaleboots", source = "Icy Veins", id = "268233" },
    { slot = "Chest", name = "Searing Caldera of Calamity", source = "Icy Veins", id = "271504" },
    { slot = "Ring 1", name = "Band of the Swarmcaller", source = "Icy Veins", id = "281029" },
    { slot = "Ring 2", name = "Apex Brute's Claw Ring", source = "Icy Veins", id = "268252" },
    { slot = "Trinket 1", name = "Gebbo's Bottomless Bag", source = "Icy Veins", id = "270164" },
    { slot = "Wrists", name = "Farstrider's Plated Bracers", source = "Icy Veins", id = "244584" },
    { slot = "Trinket 2", name = "Twisted Horror's Tendril", source = "Icy Veins", id = "281215" },
    { slot = "Weapon", name = "Jan'thrazet, the Soul Fang", source = "Icy Veins", id = "271092" },
    { slot = "Off Hand", name = "Aln'hara Lantern", source = "Icy Veins", id = "245769" },
}
BiSCompanionBisData["Evoker_Devastation_Flameshaper"] = EvokerDevastation1215
BiSCompanionBisData["Evoker_Devastation_Scalecommander"] = EvokerDevastation1215

-- https://www.icy-veins.com/wow/preservation-evoker-pve-healing-gear-best-in-slot
local EvokerPreservation1215 = {
    { slot = "Head", name = "Calamitous Echo's Magmashapers", source = "Icy Veins", id = "271501" },
    { slot = "Hands", name = "Calamitous Echo's Ebon Greathorns", source = "Icy Veins", id = "271502" },
    { slot = "Neck", name = "Aqirbane Reliquary", source = "Icy Veins", id = "268265" },
    { slot = "Waist", name = "Serpentine Mixing Belt", source = "Icy Veins", id = "268254" },
    { slot = "Shoulders", name = "Calamitous Echo's Sundered Peaks", source = "Icy Veins", id = "271499" },
    { slot = "Legs", name = "Earthen Pillars of Calamity", source = "Icy Veins", id = "271500" },
    { slot = "Back", name = "Silken Voodoo Drape", source = "Icy Veins", id = "268253" },
    { slot = "Feet", name = "Ferocious Scaleboots", source = "Icy Veins", id = "268233" },
    { slot = "Chest", name = "Searing Caldera of Calamity", source = "Icy Veins", id = "271504" },
    { slot = "Ring 1", name = "Band of the Swarmcaller", source = "Icy Veins", id = "281029" },
    { slot = "Ring 2", name = "Vile Alchemist's Band", source = "Icy Veins", id = "268249" },
    { slot = "Trinket 1", name = "Soulcoiler Ritual Vessel", source = "Icy Veins", id = "270162" },
    { slot = "Wrists", name = "Rising Tide Wristguards", source = "Icy Veins", id = "268217" },
    { slot = "Trinket 2", name = "Gebbo's Bottomless Bag", source = "Icy Veins", id = "270164" },
    { slot = "Weapon", name = "Jan'thrazet, the Soul Fang", source = "Icy Veins", id = "271092" },
    { slot = "Off Hand", name = "Luminescent Sprout", source = "Icy Veins", id = "251191" },
}
BiSCompanionBisData["Evoker_Preservation_Chronowarden"] = EvokerPreservation1215
BiSCompanionBisData["Evoker_Preservation_Flameshaper"] = EvokerPreservation1215

-- https://www.icy-veins.com/wow/augmentation-evoker-pve-dps-gear-best-in-slot
local EvokerAugmentation1215 = {
    { slot = "Head", name = "Calamitous Echo's Magmashapers", source = "Icy Veins", id = "271501" },
    { slot = "Hands", name = "Calamitous Echo's Ebon Greathorns", source = "Icy Veins", id = "271502" },
    { slot = "Neck", name = "Amulet of the Twin Fangs", source = "Icy Veins", id = "268251" },
    { slot = "Waist", name = "Farstrider's Trophy Belt", source = "Icy Veins", id = "244581" },
    { slot = "Shoulders", name = "Calamitous Echo's Sundered Peaks", source = "Icy Veins", id = "271499" },
    { slot = "Legs", name = "Earthen Pillars of Calamity", source = "Icy Veins", id = "271500" },
    { slot = "Back", name = "Silken Voodoo Drape", source = "Icy Veins", id = "268253" },
    { slot = "Feet", name = "Ferocious Scaleboots", source = "Icy Veins", id = "268233" },
    { slot = "Chest", name = "Searing Caldera of Calamity", source = "Icy Veins", id = "271504" },
    { slot = "Ring 1", name = "Vile Alchemist's Band", source = "Icy Veins", id = "268249" },
    { slot = "Ring 2", name = "Band of the Swarmcaller", source = "Icy Veins", id = "281029" },
    { slot = "Trinket 1", name = "Twisted Horror's Tendril", source = "Icy Veins", id = "281215" },
    { slot = "Wrists", name = "Farstrider's Plated Bracers", source = "Icy Veins", id = "244584" },
    { slot = "Trinket 2", name = "Font of Venomous Rage", source = "Icy Veins", id = "270168" },
    { slot = "Weapon", name = "Jan'thrazet, the Soul Fang", source = "Icy Veins", id = "271092" },
    { slot = "Off Hand", name = "Spine of the Hissing Abyss", source = "Icy Veins", id = "268197" },
}
BiSCompanionBisData["Evoker_Augmentation_Chronowarden"] = EvokerAugmentation1215
BiSCompanionBisData["Evoker_Augmentation_Scalecommander"] = EvokerAugmentation1215

