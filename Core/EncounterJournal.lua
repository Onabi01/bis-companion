-- Core/EncounterJournal.lua
-- Gère l'intégration avec le Guide de l'Aventurier pour BiSCompanion

local addonName, addon = ...
addon.Core.EncounterJournal = addon.Core.EncounterJournal or {}

local function LoadEncounterJournal()
    if EncounterJournal then
        return true
    end
    if C_AddOns and C_AddOns.LoadAddOn then
        return C_AddOns.LoadAddOn("Blizzard_EncounterJournal")
    end
    if UIParentLoadAddOn then
        return UIParentLoadAddOn("Blizzard_EncounterJournal")
    end
    return false
end

-- Fonction pour ouvrir le Guide de l'Aventurier
function addon.Core.EncounterJournal.OpenDungeonTab()
    if not LoadEncounterJournal() then return end
    if not EncounterJournal or not EncounterJournal:IsShown() then
        ToggleEncounterJournal()
    end
end

-- Fonction utilitaire pour hooker les boutons de butin
local function HookButtons(scrollBox, context)
    scrollBox:ForEachFrame(function(button)
        if button and not button.isHooked then
            button:HookScript("OnEnter", function(self)
                -- Supprimer le log de survol pour réduire le bruit
            end)
            button:HookScript("OnLeave", function()
                GameTooltip:Hide()
            end)
            button:HookScript("OnClick", function(self, mouseButton)
                if mouseButton == "LeftButton" and addon.Core.Data.editingSlot and addon.Core.Data.editingSpecKey and addon.Core.Data.editingListName then
                    local itemID = self.itemID
                    if not itemID then 
                        print("BiSCompanion: Erreur - itemID missing.")
                        return 
                    end

                    local name, _, _, _, _, itemType, _, _, equipSlot = addon.Core.Data.GetItemInfo(itemID)
                    if not name then
                        print("BiSCompanion: Item not loaded (itemID=" .. itemID .. "). Try again.")
                        return
                    end

                    -- Cas 2 : Objet non équipable
                    if itemType == "Miscellaneous" or equipSlot == "" then
                        print("BiSCompanion: Can't Equip this item (Mount, Toy, etc.).")
                        return
                    end

                    -- Normaliser le slot pour la comparaison
                    local targetSlot = addon.Core.Data.editingSlot
                    local validEquipSlots = { [equipSlot] = true }
                    if targetSlot == "Ring 1" or targetSlot == "Ring 2" then
                        targetSlot = "INVTYPE_FINGER"
                    elseif targetSlot == "Trinket 1" or targetSlot == "Trinket 2" then
                        targetSlot = "INVTYPE_TRINKET"
                    elseif targetSlot == "Weapon" then
                        targetSlot = "INVTYPE_WEAPON"
                        validEquipSlots["INVTYPE_2HWEAPON"] = true -- Inclure les armes à deux mains
                    elseif targetSlot == "Off Hand" then
                        targetSlot = "INVTYPE_HOLDABLE" -- Par défaut pour main gauche
                        validEquipSlots = {
                            ["INVTYPE_HOLDABLE"] = true,
                            ["INVTYPE_SHIELD"] = true,
                            ["INVTYPE_WEAPON"] = true, -- Autoriser arme à une main pour certaines classes
                        }
                    end

                    -- Cas 3 : Objet ne correspond pas au slot
                    local ejSlot = addon.Core.Character.slotToEJType[addon.Core.Data.editingSlot] or targetSlot
                    if not validEquipSlots[equipSlot] and not (ejSlot == "INVTYPE_WEAPON" and equipSlot == "INVTYPE_2HWEAPON") then
                        print("BiSCompanion: This item is not in the right slot " .. addon.Core.Data.editingSlot .. " (equipSlot=" .. equipSlot .. ", ejSlot=" .. ejSlot .. ")")
                        return
                    end

                    -- Vérifier si c'est un token
                    local isToken = addon.Core.Character.setTokenData[itemID]
                    if isToken then
                        local playerClass = select(2, UnitClass("player")):upper()
                        if isToken.class == playerClass and isToken.slot == addon.Core.Data.editingSlot then
                            -- Token valide pour la classe et le slot
                            local items = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items
                            local newItems = {}
                            for _, oldItem in ipairs(items) do
                                if oldItem.slot == addon.Core.Data.editingSlot then
                                    table.insert(newItems, {
                                        slot = addon.Core.Data.editingSlot,
                                        name = name,
                                        source = "Token (Adventure Guide)",
                                        id = tostring(itemID)
                                    })
                                else
                                    table.insert(newItems, oldItem)
                                end
                            end
                            addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items = newItems
                            -- Synchroniser avec SavedVariables
                            addon.Core.Data.BiSCompanionCustomData.customBisLists[addon.Core.Data.editingSpecKey] = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey]
                            BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
                            addon.Core.UI.DisplayItems(addon.Core.Data.editingSpecKey, addon.Core.Data.editingListName)
                            -- Mettre à jour bisTable si ce set est le set par défaut
                            if addon.Core.Data.BiSCompanionCustomData.defaultBisList and
                               addon.Core.Data.BiSCompanionCustomData.defaultBisList[addon.Core.Data.editingSpecKey] == addon.Core.Data.editingListName then
                                addon.Core.Data.UpdateBisTable()
                            end
                            addon.Core.Data.editingSlot = nil
                            addon.Core.Data.editingSpecKey = nil
                            addon.Core.Data.editingListName = nil
                            return
                        else
                            print("BiSCompanion: This token is not for your class " .. addon.Core.Data.editingSlot)
                            return
                        end
                    end

                    -- Cas 1 : Objet correspond au slot
                    local source = "Adventure Guide"
                    if EncounterJournal and EncounterJournal.encounterID then
                        local encounterName = EJ_GetEncounterInfo(EncounterJournal.encounterID)
                        local instanceName = EJ_GetInstanceInfo()
                        if instanceName and encounterName then
                            source = instanceName .. " - " .. encounterName
                        elseif instanceName then
                            source = instanceName
                        end
                    end
                    local items = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items
                    local newItems = {}
                    for _, oldItem in ipairs(items) do
                        if oldItem.slot == addon.Core.Data.editingSlot then
                            table.insert(newItems, {
                                slot = addon.Core.Data.editingSlot,
                                name = name,
                                source = source,
                                id = tostring(itemID)
                            })
                        else
                            table.insert(newItems, oldItem)
                        end
                    end
                    addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items = newItems
                    -- Synchroniser avec SavedVariables
                    addon.Core.Data.BiSCompanionCustomData.customBisLists[addon.Core.Data.editingSpecKey] = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey]
                    BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
                    addon.Core.UI.DisplayItems(addon.Core.Data.editingSpecKey, addon.Core.Data.editingListName)
                    -- Mettre à jour bisTable si ce set est le set par défaut
                    if addon.Core.Data.BiSCompanionCustomData.defaultBisList and
                       addon.Core.Data.BiSCompanionCustomData.defaultBisList[addon.Core.Data.editingSpecKey] == addon.Core.Data.editingListName then
                        addon.Core.Data.UpdateBisTable()
                    end
                    addon.Core.Data.editingSlot = nil
                    addon.Core.Data.editingSpecKey = nil
                    addon.Core.Data.editingListName = nil
                end
            end)
            button.isHooked = true
        end
    end)
end

-- Fonction pour attacher des crochets aux boutons de butin
function addon.Core.EncounterJournal.HookLootButtons()
    if not LoadEncounterJournal() then return end
    local function tryHook()
        -- Hook pour les onglets Dungeons/Raids
        if EncounterJournal and 
           EncounterJournal.encounter and 
           EncounterJournal.encounter.info and 
           EncounterJournal.encounter.info.LootContainer and 
           EncounterJournal.encounter.info.LootContainer.ScrollBox then
            HookButtons(EncounterJournal.encounter.info.LootContainer.ScrollBox, "LootContainer")
        else
            C_Timer.After(1, tryHook)
            return
        end

        -- Hook pour l'onglet Item Sets
        if EncounterJournal and EncounterJournal.setsFrame and EncounterJournal.setsFrame.ScrollBox then
            HookButtons(EncounterJournal.setsFrame.ScrollBox, "ItemSets")
        else
            C_Timer.After(1, tryHook)
        end
    end
    tryHook()
end

-- Attacher le crochet à ToggleEncounterJournal et aux mises à jour du Guide
hooksecurefunc("ToggleEncounterJournal", function()
    addon.Core.EncounterJournal.HookLootButtons()
end)
if EncounterJournal then
    hooksecurefunc(EncounterJournal, "DisplayEncounter", function()
        addon.Core.EncounterJournal.HookLootButtons()
    end)
    hooksecurefunc(EncounterJournal, "ShowSets", function()
        addon.Core.EncounterJournal.HookLootButtons()
    end)
end
