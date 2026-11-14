-- Core/Data.lua
-- Gère les données globales pour BiSCompanion (persistance fiable, alias créé APRÈS chargement des SV)

local addonName, addon = ...
addon.Core = addon.Core or {}
addon.Core.Data = addon.Core.Data or {}

-- Ajouter LibDeflate
addon.Core.Data.LibDeflate = LibDeflate or (LibStub and LibStub:GetLibrary("LibDeflate", true))

------------------------------------------------------------
-- Utils
------------------------------------------------------------
local function tIndexOf(t, v)
    if type(t) ~= "table" then return nil end
    for i, x in ipairs(t) do if x == v then return i end end
end

------------------------------------------------------------
-- État / Tables (pas d'alias ici ! il sera créé à ADDON_LOADED)
------------------------------------------------------------
addon.Core.Data.BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData or nil
addon.Core.Data.customBisListsInMemory = addon.Core.Data.customBisListsInMemory or {} -- placeholder avant alias
addon.Core.Data.bisTable = addon.Core.Data.bisTable or {}

function addon.Core.Data.GetItemInfo(itemID)
    local getInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
    if getInfo then return getInfo(itemID) end
end

------------------------------------------------------------
-- API "Default" / Listes (robustes si appelé tôt)
------------------------------------------------------------
function addon.Core.Data.GetListNamesForSpec(specKey)
    local names = {}
    if specKey and BiSCompanionBisData and BiSCompanionBisData[specKey] then
        table.insert(names, "Default")
    end
    local mem = addon.Core.Data.customBisListsInMemory[specKey]
    if type(mem) == "table" then
        for listName, _ in pairs(mem) do
            table.insert(names, listName)
        end
    end
    table.sort(names, function(a,b) return tostring(a) < tostring(b) end)
    return names
end

function addon.Core.Data.GetDefaultList(specKey)
    if not specKey then return nil end
    local sv = addon.Core.Data.BiSCompanionCustomData
    local m = sv and sv.defaultBisList
    return type(m) == "table" and m[specKey] or nil
end

function addon.Core.Data.SetDefaultList(specKey, listName)
    if not specKey or not listName or listName == "" then return end
    local sv = addon.Core.Data.BiSCompanionCustomData
    if not sv then return end -- attendra ADDON_LOADED
    if type(sv.defaultBisList) ~= "table" then sv.defaultBisList = {} end
    sv.defaultBisList[specKey] = listName
    addon.Core.Data.UpdateBisTable()
end

function addon.Core.Data.GetPreferredListName(specKey, listNames)
    local mapped = addon.Core.Data.GetDefaultList(specKey)
    if mapped and mapped ~= "" then
        if type(listNames) == "table" then
            if tIndexOf(listNames, mapped) then return mapped end
        else
            return mapped
        end
    end
    if type(listNames) == "table" and tIndexOf(listNames, "Default") then
        return "Default"
    end
    if type(listNames) == "table" then
        return listNames[1]
    end
    return "Default"
end

function addon.Core.Data.SortListNamesWithDefaultFirst(specKey, listNames)
    if type(listNames) ~= "table" then return listNames end
    local preferred = addon.Core.Data.GetPreferredListName(specKey, listNames)
    table.sort(listNames, function(a, b)
        if a == preferred and b ~= preferred then return true end
        if b == preferred and a ~= preferred then return false end
        if preferred ~= "Default" then
            if a == "Default" and b ~= "Default" then return false end
            if b == "Default" and a ~= "Default" then return true end
        end
        return tostring(a) < tostring(b)
    end)
    return listNames
end

------------------------------------------------------------
-- bisTable = items du set courant (pour tooltips)
------------------------------------------------------------
function addon.Core.Data.UpdateBisTable()
    addon.Core.Data.bisTable = {}

    local _, specKey = addon.Core.Character.GetPlayerClassAndSpec()
    if not specKey then return end

    local listNames = addon.Core.Data.GetListNamesForSpec(specKey)
    local bisListName = addon.Core.Data.GetPreferredListName(specKey, listNames)

    local bisItems
    if bisListName == "Default" then
        bisItems = BiSCompanionBisData and BiSCompanionBisData[specKey]
    else
        local mem = addon.Core.Data.customBisListsInMemory[specKey]
        if mem and mem[bisListName] then
            bisItems = mem[bisListName].items
        else
            bisItems = BiSCompanionBisData and BiSCompanionBisData[specKey]
        end
    end
    if not bisItems then return end

    for _, item in ipairs(bisItems) do
        if item.id and item.id ~= "" then
            table.insert(addon.Core.Data.bisTable, {
                id = tonumber(item.id),
                name = item.name,
                slot = item.slot
            })
        end
    end
end

------------------------------------------------------------
-- Création : écrit dans l'alias (qui pointe vers la SV après ADDON_LOADED)
------------------------------------------------------------
function addon.Core.Data.CreateEmptyBiSList(specKey, listName)
    if not specKey or not listName or listName == "" then return end
    local slots = {
        "Head", "Neck", "Shoulders", "Back", "Chest", "Wrists",
        "Hands", "Waist", "Legs", "Feet", "Ring 1", "Ring 2",
        "Weapon", "Off Hand", "Trinket 1", "Trinket 2"
    }
    local emptyList = { items = {}, created = time() }
    for _, slot in ipairs(slots) do
        table.insert(emptyList.items, { slot = slot, name = "<Empty>", source = "", id = "" })
    end

    addon.Core.Data.customBisListsInMemory[specKey] = addon.Core.Data.customBisListsInMemory[specKey] or {}
    addon.Core.Data.customBisListsInMemory[specKey][listName] = emptyList

    -- si les SV sont prêtes, assure la racine
    if addon.Core.Data.BiSCompanionCustomData then
        BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
    end
end

------------------------------------------------------------
-- Great Vault + Preload d’icônes
------------------------------------------------------------
addon.Core.Data.greatVaultItems = addon.Core.Data.greatVaultItems or {}

function addon.Core.Data.PreloadGreatVaultItems()
    addon.Core.Data.greatVaultItems = {}
    if not C_WeeklyRewards or not C_WeeklyRewards.GetActivities or not C_WeeklyRewards.GetExampleRewardItemHyperlinks then return end
    local activities = C_WeeklyRewards.GetActivities()
    if activities then
        for _, activity in ipairs(activities) do
            local link = C_WeeklyRewards.GetExampleRewardItemHyperlinks(activity.id)
            if link then
                local itemID = tonumber(link:match("item:(%d+)"))
                if itemID then addon.Core.Data.greatVaultItems[itemID] = true end
            end
        end
    end
end

function addon.Core.Data.PreloadItemIcons()
    if BiSCompanionBisData then
        for _, items in pairs(BiSCompanionBisData) do
            for _, item in ipairs(items) do
                local itemID = tonumber(item.id)
                if itemID then addon.Core.Data.GetItemInfo(itemID) end
            end
        end
    end
    for _, lists in pairs(addon.Core.Data.customBisListsInMemory) do
        for _, list in pairs(lists) do
            for _, item in ipairs(list.items or {}) do
                local itemID = tonumber(item.id)
                if itemID then addon.Core.Data.GetItemInfo(itemID) end
            end
        end
    end
end

------------------------------------------------------------
-- Événements : on crée l'ALIAS APRÈS le chargement des SV
------------------------------------------------------------
local function OnAddonLoaded()
    -- SV garanties chargées ici
    if type(BiSCompanionCustomData) ~= "table" then BiSCompanionCustomData = {} end
    if type(BiSCompanionCustomData.customBisLists) ~= "table" then BiSCompanionCustomData.customBisLists = {} end
    if type(BiSCompanionCustomData.defaultBisList) ~= "table" then BiSCompanionCustomData.defaultBisList = {} end

    -- alias uniquement maintenant (évite le cas où l'alias pointe une table temporaire)
    addon.Core.Data.BiSCompanionCustomData = BiSCompanionCustomData
    addon.Core.Data.customBisListsInMemory = BiSCompanionCustomData.customBisLists
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PLAYER_LOGOUT")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        OnAddonLoaded()
        -- pas de Unregister : si l'addon est rechargé, on veut repasser ici
    elseif event == "PLAYER_LOGIN" then
        addon.Core.Data.UpdateBisTable()
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player" then
        addon.Core.Data.UpdateBisTable()
    elseif event == "PLAYER_LOGOUT" then
        -- SV déjà à jour (alias). On renforce l'assignation racine.
        if addon.Core.Data.BiSCompanionCustomData then
            BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
        end
    end
end)

------------------------------------------------------------
-- État d’édition
------------------------------------------------------------
addon.Core.Data.editingSlot = addon.Core.Data.editingSlot or nil
addon.Core.Data.editingSpecKey = addon.Core.Data.editingSpecKey or nil
addon.Core.Data.editingListName = addon.Core.Data.editingListName or nil
