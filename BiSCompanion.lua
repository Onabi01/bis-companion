-- BiSCompanion.lua
-- Point d'entrée principal de l'addon BiSCompanion

-- Charger les autres modules
local addonName, addon = ...
addon.Core = addon.Core or {}

-- Enregistrer les événements globaux
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:RegisterEvent("WEEKLY_REWARDS_UPDATE")

-- Fonction pour synchroniser avec CharacterFrame
local function SyncWithCharacterFrame()
    if CharacterFrame and CharacterFrame:IsShown() then
        if addon.Core.UI and addon.Core.UI.frame then
            addon.Core.UI.frame:Show()
        end
        if addon.Core.Talents and addon.Core.Talents.talentFrame then
            addon.Core.Talents.talentFrame:Show()
        end
        if addon.Core.Character then
            addon.Core.Character.PreselectPlayerClassAndSpec()
        end
    else
        if addon.Core.UI and addon.Core.UI.frame then
            addon.Core.UI.frame:Hide()
        end
        if addon.Core.Talents and addon.Core.Talents.talentFrame then
            addon.Core.Talents.talentFrame:Hide()
        end
    end
end

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_LOGIN" or (event == "ADDON_LOADED" and arg1 == "BiSCompanion") then
        -- Vérifier que addon.Core.Data est initialisé
        if not addon.Core.Data or not addon.Core.Data.BiSCompanionCustomData then
           -- print("BiSCompanion: Erreur - Données non initialisées.")
            return
        end

        -- Désactiver temporairement le nettoyage pour diagnostic
        -- Nettoyer les clés numériques dans customBisLists
        -- for specKey, lists in pairs(addon.Core.Data.BiSCompanionCustomData.customBisLists) do
        --     for key, _ in pairs(lists) do
        --         if type(key) ~= "string" then
        --             print("BiSCompanion: Suppression de clé non-string (" .. tostring(key) .. ") pour specKey=" .. specKey)
        --             addon.Core.Data.BiSCompanionCustomData.customBisLists[specKey][key] = nil
        --         end
        --     end
        --     if next(addon.Core.Data.BiSCompanionCustomData.customBisLists[specKey]) == nil then
        --         print("BiSCompanion: Suppression de specKey vide : " .. specKey)
        --         addon.Core.Data.BiSCompanionCustomData.customBisLists[specKey] = nil
        --     end
        -- end

        --print("BiSCompanion: Après PLAYER_LOGIN - État de customBisLists :")
        if addon.Core.Data.BiSCompanionCustomData.customBisLists then
            for specKey, lists in pairs(addon.Core.Data.BiSCompanionCustomData.customBisLists) do
                --print("BiSCompanion: customBisLists - specKey=" .. specKey .. " a " .. table.getn(lists) .. " listes")
                for listName, listData in pairs(lists) do
                    --print("BiSCompanion: Liste " .. listName .. " pour specKey=" .. specKey)
                end
            end
        else
            --print("BiSCompanion: customBisLists est nil après PLAYER_LOGIN")
        end

        --print("BiSCompanion: Addon chargé, interface prête")
        C_Timer.After(1, SyncWithCharacterFrame)
        if addon.Core.Data then
            C_Timer.After(2, addon.Core.Data.PreloadItemIcons)
        end
        if addon.Core.Tooltip then
            addon.Core.Tooltip.InitTooltips()
        end
    elseif event == "ADDON_LOADED" and arg1 == "Blizzard_EncounterJournal" then
        if addon.Core.EncounterJournal then
            addon.Core.EncounterJournal.HookLootButtons()
        end
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player" then
        C_Timer.After(2, function()
            if addon.Core.Character then
                addon.Core.Character.PreselectPlayerClassAndSpec()
            end
            if CharacterFrame and CharacterFrame:IsShown() then
                SyncWithCharacterFrame()
            end
        end)
    elseif event == "PLAYER_TALENT_UPDATE" then
        C_Timer.After(2, function()
            if addon.Core.Character then
                addon.Core.Character.PreselectPlayerClassAndSpec()
            end
            if CharacterFrame and CharacterFrame:IsShown() then
                SyncWithCharacterFrame()
            end
        end)
    elseif event == "WEEKLY_REWARDS_UPDATE" then
        if addon.Core.Data then
            C_Timer.After(1, addon.Core.Data.PreloadGreatVaultItems)
        end
    end
end)

-- Crochets pour CharacterFrame
if CharacterFrame then
CharacterFrame:HookScript("OnShow", function()
    if addon.Core.UI and addon.Core.UI.frame then
        addon.Core.UI.frame:Show()
    end
    if addon.Core.Talents and addon.Core.Talents.talentFrame then
        addon.Core.Talents.talentFrame:Show()
    end
    if addon.Core.Character then
        addon.Core.Character.PreselectPlayerClassAndSpec()
    end
end)

CharacterFrame:HookScript("OnHide", function()
    if addon.Core.UI and addon.Core.UI.frame then
        addon.Core.UI.frame:Hide()
    end
    if addon.Core.Talents and addon.Core.Talents.talentFrame then
        addon.Core.Talents.talentFrame:Hide()
    end
end)
end

if WeeklyRewardsFrame then
    WeeklyRewardsFrame:HookScript("OnShow", function()
        if addon.Core.Data then
            C_Timer.After(1, addon.Core.Data.PreloadGreatVaultItems)
        end
    end)
end
