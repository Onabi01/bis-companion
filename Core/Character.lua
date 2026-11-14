-- Core/Character.lua
-- Gère la logique des classes et spécialisations pour BiSCompanion

local addonName, addon = ...
addon.Core.Character = addon.Core.Character or {}

-- Table des textures de fond par classe
addon.Core.Character.classBackgrounds = {
    ["DK"] = "Interface\\TALENTFRAME\\DK-Blood-Top",
    ["DH"] = "Interface\\TALENTFRAME\\DH-Havoc-Top",
    ["Druid"] = "Interface\\TALENTFRAME\\Druid-Balance-Top",
    ["Hunter"] = "Interface\\TALENTFRAME\\Hunter-BeastMastery-Top",
    ["Mage"] = "Interface\\TALENTFRAME\\Mage-Arcane-Top",
    ["Monk"] = "Interface\\TALENTFRAME\\Monk-Brewmaster-Top",
    ["Paladin"] = "Interface\\TALENTFRAME\\Paladin-Holy-Top",
    ["Priest"] = "Interface\\TALENTFRAME\\Priest-Discipline-Top",
    ["Rogue"] = "Interface\\TALENTFRAME\\Rogue-Assassination-Top",
    ["Shaman"] = "Interface\\TALENTFRAME\\Shaman-Elemental-Top",
    ["Warlock"] = "Interface\\TALENTFRAME\\Warlock-Affliction-Top",
    ["Warrior"] = "Interface\\TALENTFRAME\\Warrior-Arms-Top",
    ["Evoker"] = "Interface\\TALENTFRAME\\Warrior-Arms-Top",
    ["Default"] = "Interface\\FrameGeneral\\UI-Background-Marble"
}

-- Ordre des slots pour imiter l’équipement
addon.Core.Character.slotOrder = {
    left = {"Head", "Neck", "Shoulders", "Back", "Chest", "Wrists"},
    right = {"Hands", "Waist", "Legs", "Feet", "Ring 1", "Ring 2"},
    bottom = {"Weapon", "Off Hand", "Trinket 1", "Trinket 2", "Ranged"}
}

-- Table pour associer les slots aux types d'objets du Guide de l'Aventurier
addon.Core.Character.slotToEJType = {
    ["Head"] = "INVTYPE_HEAD",
    ["Neck"] = "INVTYPE_NECK",
    ["Shoulders"] = "INVTYPE_SHOULDER",
    ["Back"] = "INVTYPE_CLOAK",
    ["Chest"] = "INVTYPE_CHEST",
    ["Wrists"] = "INVTYPE_WRIST",
    ["Hands"] = "INVTYPE_HAND",
    ["Waist"] = "INVTYPE_WAIST",
    ["Legs"] = "INVTYPE_LEGS",
    ["Feet"] = "INVTYPE_FEET",
    ["Ring 1"] = "INVTYPE_FINGER",
    ["Ring 2"] = "INVTYPE_FINGER",
    ["Trinket 1"] = "INVTYPE_TRINKET",
    ["Trinket 2"] = "INVTYPE_TRINKET",
    ["Weapon"] = "INVTYPE_WEAPON", -- Inclut aussi "Two-Hand"
    ["Off Hand"] = "INVTYPE_WEAPONOFFHAND",
    ["Ranged"] = "INVTYPE_RANGED"
}

-- Table simplifiée pour les tokens de set (exemple pour The War Within)
addon.Core.Character.setTokenData = {
    [225718] = { class = "DEATHKNIGHT", slot = "Head" },
    [225719] = { class = "DEATHKNIGHT", slot = "Chest" },
    -- Ajouter d'autres tokens selon les besoins
}

-- Fonction pour extraire la classe à partir de la clé de spécialisation
function addon.Core.Character.GetClassFromSpecKey(specKey)
    local classPrefix = specKey:match("^([^_]+)")
    if classPrefix then
        if classPrefix:upper() == "DK" or classPrefix:upper() == "DH" then
            return classPrefix:upper()
        else
            return classPrefix:sub(1, 1):upper() .. classPrefix:sub(2):lower()
        end
    end
    return "Default"
end

-- Fonction pour obtenir le nom de la spécialisation sans la classe
function addon.Core.Character.GetSpecName(specKey)
    local specPart = specKey:match("_(.+)$") or specKey
    return specPart:gsub("_", " ")
end

function addon.Core.Character.GetPlayerClassAndSpec()
    local className, classFile, classID = UnitClass("player")
    local foreverClass = BiSCompanionForever and ({
        WARRIOR = "Warrior", PALADIN = "Paladin", HUNTER = "Hunter",
        ROGUE = "Rogue", PRIEST = "Priest", SHAMAN = "Shaman",
        MAGE = "Mage", WARLOCK = "Warlock", DRUID = "Druid"
    })[classFile]
    if BiSCompanionForever then
        return foreverClass, nil
    end
    local specIndex = GetSpecialization and GetSpecialization()
    if not specIndex then
        return nil, nil
    end

    local specID = GetSpecializationInfo and GetSpecializationInfo(specIndex)
    if not specID then
        return nil, nil
    end

    if not BiSCompanionClassSpecMapping then
        return nil, nil
    end

    local classPrefixMap = {
        ["DEATHKNIGHT"] = "DK",
        ["DEMONHUNTER"] = "DH",
        ["DRUID"] = "Druid",
        ["HUNTER"] = "Hunter",
        ["MAGE"] = "Mage",
        ["MONK"] = "Monk",
        ["PALADIN"] = "Paladin",
        ["PRIEST"] = "Priest",
        ["ROGUE"] = "Rogue",
        ["SHAMAN"] = "Shaman",
        ["WARLOCK"] = "Warlock",
        ["WARRIOR"] = "Warrior",
        ["EVOKER"] = "Evoker"
    }
    local playerClass = classPrefixMap[classFile] or classFile

    local heroSpecID = C_ClassTalents and C_ClassTalents.GetActiveHeroTalentSpec
        and C_ClassTalents.GetActiveHeroTalentSpec()
    --print("BiSCompanion: GetPlayerClassAndSpec - classID=" .. tostring(classID) .. ", specID=" .. tostring(specID) .. ", heroID=" .. tostring(heroSpecID))
    local matchingSpecKey = nil
    if heroSpecID then
        for _, mapping in ipairs(BiSCompanionClassSpecMapping) do
            if mapping.classID == classID and mapping.specID == specID and mapping.heroID == heroSpecID then
                matchingSpecKey = mapping.specKey
                --print("BiSCompanion: Correspondance trouvée dans BiSCompanionClassSpecMapping - specKey=" .. matchingSpecKey)
                break
            end
        end
    end

    if matchingSpecKey then
        return playerClass, matchingSpecKey
    else
        local specFallback = {
            ["DK"] = {
                [250] = "DK_Blood_San'layn",
                [251] = "DK_Frost_Deathbringer",
                [252] = "DK_Unholy_Rider of the Apocalypse"
            },
            ["DH"] = {
                [1480] = "DH_Devourer_Annihilator",
                [577] = "DH_Havoc_Aldrachi Reaver",
                [581] = "DH_Vengeance_Annihilator"
            },
            ["Druid"] = {
                [102] = "Druid_Balance_Keeper of the Grove",
                [103] = "Druid_Feral_Wildstalker",
                [104] = "Druid_Guardian_Druid of the Claw",
                [105] = "Druid_Resto_Keeper of the Grove"
            },
            ["Hunter"] = {
                [253] = "Hunter_BM_Pack Leader",
                [254] = "Hunter_Marks_Sentinel",
                [255] = "Hunter_Survival_Sentinel"
            },
            ["Mage"] = {
                [62] = "Mage_Arcane_Spellslinger",
                [63] = "Mage_Fire_Sunfury",
                [64] = "Mage_Frost_Frostfire"
            },
            ["Monk"] = {
                [268] = "Monk_BM_Master of Harmony",
                [270] = "Monk_MW_Conduit of the Celestials",
                [269] = "Monk_WW_Conduit of the Celestials"
            },
            ["Paladin"] = {
                [65] = "Paladin_Holy_Lightsmith",
                [66] = "Paladin_Prot_Templar",
                [70] = "Paladin_Ret_Templar"
            },
            ["Priest"] = {
                [256] = "Priest_Disc_Voidweaver",
                [257] = "Priest_Holy_Archon",
                [258] = "Priest_Shadow_Archon"
            },
            ["Rogue"] = {
                [259] = "Rogue_Assassination_Deathstalker",
                [260] = "Rogue_Outlaw_Fatebound",
                [261] = "Rogue_Subtlety_Deathstalker"
            },
            ["Shaman"] = {
                [262] = "Shaman_Ele_Farseer",
                [263] = "Shaman_Enh_Stormbringer",
                [264] = "Shaman_Resto_Totemic"
            },
            ["Warlock"] = {
                [265] = "Warlock_Aff_Hellcaller",
                [266] = "Warlock_Demo_Soul Harvester",
                [267] = "Warlock_Destro_Hellcaller"
            },
            ["Warrior"] = {
                [71] = "Warrior_Arms_Slayer",
                [72] = "Warrior_Fury_Slayer",
                [73] = "Warrior_Prot_Mountain Thane"
            },
            ["Evoker"] = {
                [1467] = "Evoker_Devastation_Flameshaper",
                [1468] = "Evoker_Preservation_Chronowarden",
                [1473] = "Evoker_Augmentation_Chronowarden"
            }
        }

        local specKey = specFallback[playerClass] and specFallback[playerClass][specID]
        if specKey then
            --print("BiSCompanion: Utilisation du fallback - specKey=" .. specKey)
            return playerClass, specKey
        else
            --print("BiSCompanion: Aucun mapping trouvé pour class=" .. playerClass .. ", specID=" .. specID)
            return playerClass, nil
        end
    end
end

function addon.Core.Character.PreselectPlayerClassAndSpec()
    if not BiSCompanionBisData then
        return
    end

    local classDropdown = _G["BiSCompanionClassDropdown"]
    local specDropdown = _G["BiSCompanionSpecDropdown"]
    local listDropdown = _G["BiSCompanionListDropdown"]

    UIDropDownMenu_SetSelectedValue(classDropdown, nil)
    UIDropDownMenu_SetSelectedValue(specDropdown, nil)
    UIDropDownMenu_SetSelectedValue(listDropdown, nil)
    UIDropDownMenu_SetText(classDropdown, "Select a class")
    UIDropDownMenu_SetText(specDropdown, "Select a spec")
    UIDropDownMenu_SetText(listDropdown, "Select a BiS List")
    UIDropDownMenu_DisableDropDown(specDropdown)
    UIDropDownMenu_DisableDropDown(listDropdown)

    local playerClass, playerSpecKey = addon.Core.Character.GetPlayerClassAndSpec()
    if playerClass then
        UIDropDownMenu_SetSelectedValue(classDropdown, playerClass)
        UIDropDownMenu_SetText(classDropdown, playerClass)
        UIDropDownMenu_EnableDropDown(specDropdown)
        UIDropDownMenu_Initialize(specDropdown, specDropdown.initialize)

        if playerSpecKey then
            UIDropDownMenu_SetSelectedValue(specDropdown, playerSpecKey)
            UIDropDownMenu_SetText(specDropdown, addon.Core.Character.GetSpecName(playerSpecKey))
            UIDropDownMenu_EnableDropDown(listDropdown)
            UIDropDownMenu_Initialize(listDropdown, listDropdown.initialize)
            UIDropDownMenu_SetSelectedValue(listDropdown, "Default")
            UIDropDownMenu_SetText(listDropdown, "Default")
            if BiSCompanionBisData[playerSpecKey] then
                addon.Core.UI.DisplayItems(playerSpecKey, "Default")
            end

            -- Mettre à jour bisTable en fonction de defaultBisList
            addon.Core.Data.UpdateBisTable()
        else
            addon.Core.Data.bisTable = {}
        end
    else
        addon.Core.Data.bisTable = {}
    end
end
