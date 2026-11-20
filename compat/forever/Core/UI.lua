-- Core/UI.lua
-- Gère l'interface utilisateur principale de BiSCompanion

local addonName, addon = ...
addon.Core.UI = addon.Core.UI or {}

addon.Core.UI.currentOptionFrame = nil -- Variable pour suivre l'optionFrame actuel

-- Créer la fenêtre principale
addon.Core.UI.frame = CreateFrame("Frame", "BiSCompanionFrame", UIParent, "BasicFrameTemplateWithInset")
addon.Core.UI.frame:SetSize(270, 420)
addon.Core.UI.frame:SetPoint("TOPLEFT", CharacterFrame or UIParent, "TOPRIGHT", 0, 0)
addon.Core.UI.frame:Hide()
-- === Drag support for the main BiSCompanion frame ===
addon.Core.UI.frame:SetMovable(true)
addon.Core.UI.frame:EnableMouse(true)
addon.Core.UI.frame:SetClampedToScreen(true)
if not addon.Core.UI.frame._dragHooked then
    addon.Core.UI.frame:RegisterForDrag("LeftButton")
    addon.Core.UI.frame:SetScript("OnDragStart", function(self)
        if not self.isMoving then
            self:StartMoving()
            self.isMoving = true
        end
    end)
    addon.Core.UI.frame:SetScript("OnDragStop", function(self)
        if self.isMoving then
            self:StopMovingOrSizing()
            self.isMoving = false
        end
    end)
    addon.Core.UI.frame._dragHooked = true
end
-- === /Drag support ===


-- Ajouter un titre
addon.Core.UI.frame.title = addon.Core.UI.frame:CreateFontString(nil, "OVERLAY")
addon.Core.UI.frame.title:SetFontObject("GameFontHighlight")
addon.Core.UI.frame.title:SetPoint("TOP", addon.Core.UI.frame, "TOP", 0, -5)
addon.Core.UI.frame.title:SetText("BiS Equipment")

-- On Forever, no gear data is yet trustworthy. The talent planner stays enabled.
local foreverGearEnabled = BiSCompanionForeverGearReady == true
local function VisibleGearListName(name, specKey)
    local labels = BiSCompanionForeverGearVariantLabels
    local perSpec = labels and labels[specKey]
    if perSpec and perSpec[name] then return perSpec[name] end
    return name == "Default" and "Pre-Raid BiS" or name
end
local gearNoticeTitle = addon.Core.UI.frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
gearNoticeTitle:SetPoint("TOP", addon.Core.UI.frame, "TOP", 0, -144)
gearNoticeTitle:SetWidth(225)
gearNoticeTitle:SetJustifyH("CENTER")
local gearNoticeBody = addon.Core.UI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
gearNoticeBody:SetPoint("TOP", gearNoticeTitle, "BOTTOM", 0, -14)
gearNoticeBody:SetWidth(225)
gearNoticeBody:SetJustifyH("CENTER")
if GetLocale and GetLocale() == "frFR" then
    gearNoticeTitle:SetText("BiS en préparation")
    gearNoticeBody:SetText("Les listes BiS et l'édition de l'équipement sont temporairement désactivées sur Forever.\n\nLe planificateur de talents reste disponible.")
else
    gearNoticeTitle:SetText("Forever BiS coming soon")
    gearNoticeBody:SetText("Gear lists and equipment editing are temporarily disabled on Forever.\n\nThe talent planner is still available.")
end
gearNoticeTitle:Hide()
gearNoticeBody:Hide()

-- Ajouter une texture de fond
addon.Core.UI.frame.background = addon.Core.UI.frame:CreateTexture(nil, "BACKGROUND")
addon.Core.UI.frame.background:SetAllPoints(addon.Core.UI.frame)
addon.Core.UI.frame.background:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble")
addon.Core.UI.frame.background:SetAlpha(0.7)

-- Créer un ScrollFrame pour défiler la liste BiS
local scrollFrame = CreateFrame("ScrollFrame", "BiSCompanionScrollFrame", addon.Core.UI.frame, "InsetFrameTemplate3")
scrollFrame:SetPoint("TOPLEFT", addon.Core.UI.frame, "TOPLEFT", 8, -100)
scrollFrame:SetPoint("BOTTOMRIGHT", addon.Core.UI.frame, "BOTTOMRIGHT", -10, 8)

-- Conteneur pour les icônes BiS
local scrollChild = CreateFrame("Frame", "BiSCompanionScrollChild", scrollFrame)
scrollChild:SetSize(260, 1)
scrollFrame:SetScrollChild(scrollChild)

-- Créer les menus déroulants
local classDropdown = CreateFrame("Frame", "BiSCompanionClassDropdown", addon.Core.UI.frame, "UIDropDownMenuTemplate")
classDropdown:SetPoint("TOPLEFT", addon.Core.UI.frame, "TOPLEFT", -7, -25) -- Remonté de 5 pixels
UIDropDownMenu_SetWidth(classDropdown, 90)

local specDropdown = CreateFrame("Frame", "BiSCompanionSpecDropdown", addon.Core.UI.frame, "UIDropDownMenuTemplate")
specDropdown:SetPoint("TOPLEFT", classDropdown, "TOPRIGHT", -30, 0)
UIDropDownMenu_SetWidth(specDropdown, 120)

local listDropdown = CreateFrame("Frame", "BiSCompanionListDropdown", addon.Core.UI.frame, "UIDropDownMenuTemplate")
listDropdown:SetPoint("TOPLEFT", addon.Core.UI.frame, "TOPLEFT", -7, -50) -- Remonté de 5 pixels
UIDropDownMenu_SetWidth(listDropdown, 200)
UIDropDownMenu_SetText(listDropdown, "Select a BiS List")

-- Fenêtre pour nommer une liste
local nameFrame = CreateFrame("Frame", "BiSCompanionNameFrame", UIParent, "BasicFrameTemplateWithInset")
nameFrame:SetSize(300, 150)
nameFrame:SetPoint("CENTER")
nameFrame:SetMovable(true)
nameFrame:EnableMouse(true)
nameFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
nameFrame:SetScript("OnMouseUp", function(self)
    self:StopMovingOrSizing()
end)
nameFrame:Hide()

nameFrame.title = nameFrame:CreateFontString(nil, "OVERLAY")
nameFrame.title:SetFontObject("GameFontHighlight")
nameFrame.title:SetPoint("TOP", nameFrame, "TOP", 0, -5)
nameFrame.title:SetText("Name Your BiS List")

local nameEditBox = CreateFrame("EditBox", nil, nameFrame, "InputBoxTemplate")
nameEditBox:SetSize(280, 20)
nameEditBox:SetPoint("TOP", nameFrame, "TOP", 0, -30)
nameEditBox:SetAutoFocus(true)

local nameInstruction = nameFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
nameInstruction:SetPoint("TOP", nameEditBox, "BOTTOM", 0, -5)
nameInstruction:SetText("Enter a name for this BiS list")

local nameSaveButton = CreateFrame("Button", nil, nameFrame, "UIPanelButtonTemplate")
nameSaveButton:SetSize(80, 22)
nameSaveButton:SetPoint("BOTTOM", nameFrame, "BOTTOM", 0, 10)
nameSaveButton:SetText("Save")
nameSaveButton:SetScript("OnClick", function()
    local name = nameEditBox:GetText():trim()
    if name == "" then return end

    -- Never overwrite a personal list or shadow the built-in Pre-Raid BiS.
    local specKey = nameFrame.pendingSpecKey
    local builtinNames = BiSCompanionForeverGearVariantLabels and BiSCompanionForeverGearVariantLabels[specKey]
    local reserved = name == "Default" or name == "Pre-Raid BiS"
        or (addon.Core.Data.IsBuiltInList and addon.Core.Data.IsBuiltInList(specKey, name))
    if builtinNames then
        for _, label in pairs(builtinNames) do
            if name == label then reserved = true end
        end
    end
    if reserved then
        print("BiSCompanion: This list name is reserved. Choose another name.")
        return
    end
    local custom = addon.Core.Data and addon.Core.Data.customBisListsInMemory
    if specKey and custom and custom[specKey] and custom[specKey][name] then
        print("BiSCompanion: A list with this name already exists for this spec.")
        return
    end

    if nameFrame.importCallback then
        nameFrame.importCallback(name)
    end
    nameFrame.pendingSpecKey = nil
    nameFrame:Hide()
end)

-- Bouton "Duplicate"
local duplicateButton = CreateFrame("Button", nil, addon.Core.UI.frame, "UIPanelButtonTemplate")
duplicateButton:SetSize(68, 22)
duplicateButton:SetPoint("TOPLEFT", addon.Core.UI.frame, "TOPLEFT", 10, -78)
duplicateButton:SetText("Duplicate")

-- Bouton pour créer une liste BiS personnalisée
local createButton = CreateFrame("Button", nil, addon.Core.UI.frame, "UIPanelButtonTemplate")
createButton:SetSize(60, 22)
createButton:SetPoint("LEFT", duplicateButton, "RIGHT", 5, 0)
createButton:SetText("Create")

-- Bouton pour supprimer une liste BiS personnalisée
local deleteButton = CreateFrame("Button", nil, addon.Core.UI.frame, "UIPanelButtonTemplate")
deleteButton:SetSize(60, 22)
deleteButton:SetPoint("LEFT", createButton, "RIGHT", 5, 0)
deleteButton:SetText("Delete")

-- Ajouter une case à cocher pour définir le set comme "par défaut"
local setAsDefaultCheckbox = CreateFrame("CheckButton", "BiSCompanionSetAsDefaultCheckbox", scrollChild, "UICheckButtonTemplate")
setAsDefaultCheckbox:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 65, -5) -- Position en haut du cadre
setAsDefaultCheckbox:SetSize(26, 26)
setAsDefaultCheckbox.text = setAsDefaultCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
setAsDefaultCheckbox.text:SetPoint("LEFT", setAsDefaultCheckbox, "RIGHT", 5, 0)
setAsDefaultCheckbox.text:SetText("Use as Default BiS")
setAsDefaultCheckbox:Hide() -- Cacher par défaut, on l'affichera dans DisplayItems

-- Helper: savoir quelle liste doit être affichée pour une spé
local function GetPreferredListNameForSpec(specKey)
    local names = addon.Core.Data.GetListNamesForSpec(specKey)
    return addon.Core.Data.GetPreferredListName(specKey, names) or "Default"
end

-- Helper: appliquer la sélection correcte dans listDropdown et afficher
local function SelectPreferredListForSpec(specKey)
    if not foreverGearEnabled or not specKey then return end
    local toSelect = GetPreferredListNameForSpec(specKey)

    UIDropDownMenu_SetSelectedValue(listDropdown, toSelect)
    UIDropDownMenu_SetText(listDropdown, VisibleGearListName(toSelect, specKey))
    addon.Core.UI.DisplayItems(specKey, toSelect)
end

-- Fonction pour créer un bouton d’objet
function addon.Core.UI.CreateItemButton(parent, item, x, y, index, section)
    local itemID = item.id and item.id ~= "" and tonumber(item.id)
    local isEmpty = not itemID

    local button = CreateFrame("Button", nil, parent)
    button:SetSize(36, 36)
    button:SetPoint("TOPLEFT", x, y)

    local texture = button:CreateTexture(nil, "ARTWORK")
    texture:SetAllPoints(button)
    if isEmpty then
        texture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    else
        local _, _, _, _, _, _, _, _, _, itemTexture = addon.Core.Data.GetItemInfo(itemID)
        local cachedIcon = GetItemIcon and GetItemIcon(itemID)
        local offlineIcon = item.icon and ("Interface\\Icons\\" .. item.icon)
        texture:SetTexture(itemTexture or cachedIcon or offlineIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
        if not itemTexture then
            C_Timer.After(0.5, function()
                local _, _, _, _, _, _, _, _, _, newTexture = addon.Core.Data.GetItemInfo(itemID)
                if newTexture then
                    texture:SetTexture(newTexture)
                end
            end)
        end
    end

    local slotsToCheck = {}
    if item.slot == "Head" then
        slotsToCheck = {INVSLOT_HEAD}
    elseif item.slot == "Neck" then
        slotsToCheck = {INVSLOT_NECK}
    elseif item.slot == "Shoulders" then
        slotsToCheck = {INVSLOT_SHOULDER}
    elseif item.slot == "Back" then
        slotsToCheck = {INVSLOT_BACK}
    elseif item.slot == "Chest" then
        slotsToCheck = {INVSLOT_CHEST}
    elseif item.slot == "Wrists" then
        slotsToCheck = {INVSLOT_WRIST}
    elseif item.slot == "Hands" then
        slotsToCheck = {INVSLOT_HAND}
    elseif item.slot == "Waist" then
        slotsToCheck = {INVSLOT_WAIST}
    elseif item.slot == "Legs" then
        slotsToCheck = {INVSLOT_LEGS}
    elseif item.slot == "Feet" then
        slotsToCheck = {INVSLOT_FEET}
    elseif item.slot == "Ring 1" or item.slot == "Ring 2" then
        slotsToCheck = {INVSLOT_FINGER1, INVSLOT_FINGER2}
    elseif item.slot == "Trinket 1" or item.slot == "Trinket 2" then
        slotsToCheck = {INVSLOT_TRINKET1, INVSLOT_TRINKET2}
    elseif item.slot == "Weapon" or item.slot == "Off Hand" then
        slotsToCheck = {INVSLOT_MAINHAND, INVSLOT_OFFHAND}
    elseif item.slot == "Ranged" then
        slotsToCheck = {INVSLOT_RANGED}
    end

    local isEquipped = false
    if not isEmpty and slotsToCheck[1] then
        for _, slotID in ipairs(slotsToCheck) do
            local equippedItemID = GetInventoryItemID("player", slotID)
            if equippedItemID == itemID then
                isEquipped = true
                break
            end
        end

        local borderColor = isEquipped and {0, 1, 0} or {1, 0, 0}
        local borderWidth = 1

        local borderTop = button:CreateTexture(nil, "OVERLAY")
        borderTop:SetSize(36, borderWidth)
        borderTop:SetPoint("TOPLEFT", button, "TOPLEFT")
        borderTop:SetTexture("Interface\\Buttons\\WHITE8X8")
        borderTop:SetVertexColor(unpack(borderColor))
        borderTop:SetAlpha(0.7)

        local borderBottom = button:CreateTexture(nil, "OVERLAY")
        borderBottom:SetSize(36, borderWidth)
        borderBottom:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT")
        borderBottom:SetTexture("Interface\\Buttons\\WHITE8X8")
        borderBottom:SetVertexColor(unpack(borderColor))
        borderBottom:SetAlpha(0.7)

        local borderLeft = button:CreateTexture(nil, "OVERLAY")
        borderLeft:SetSize(borderWidth, 36)
        borderLeft:SetPoint("TOPLEFT", button, "TOPLEFT")
        borderLeft:SetTexture("Interface\\Buttons\\WHITE8X8")
        borderLeft:SetVertexColor(unpack(borderColor))
        borderLeft:SetAlpha(0.7)

        local borderRight = button:CreateTexture(nil, "OVERLAY")
        borderRight:SetSize(borderWidth, 36)
        borderRight:SetPoint("TOPRIGHT", button, "TOPRIGHT")
        borderRight:SetTexture("Interface\\Buttons\\WHITE8X8")
        borderRight:SetVertexColor(unpack(borderColor))
        borderRight:SetAlpha(0.7)
    end

    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if isEmpty then
            GameTooltip:SetText(item.slot .. ": <Empty>")
            GameTooltip:AddLine("Click to add an item", 0, 1, 0)
        else
            GameTooltip:SetItemByID(itemID)
            GameTooltip:AddLine("Source: " .. (item.source or "Unknown"), 1, 1, 0)
            if item.gems then
                GameTooltip:AddLine("Gems: " .. table.concat(item.gems, ", "), 0, 1, 1)
            end
            if item.alternates then
                for _, alt in ipairs(item.alternates) do
                    GameTooltip:AddLine("Alt: " .. alt.name .. " (" .. alt.source .. ")", 0.5, 0.5, 1)
                end
            end
            local listName = UIDropDownMenu_GetSelectedValue(listDropdown)
            local specKey = UIDropDownMenu_GetSelectedValue(specDropdown)
            if listName and not addon.Core.Data.IsBuiltInList(specKey, listName) then
                GameTooltip:AddLine("Left-click to edit this item", 0, 1, 0)
            end
        end
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Gestion du clic pour éditer l'item (seulement pour les listes non par défaut)
    button:SetScript("OnClick", function(self, mouseButton)
        if mouseButton == "LeftButton" then
            local specKey = UIDropDownMenu_GetSelectedValue(specDropdown)
            local listName = UIDropDownMenu_GetSelectedValue(listDropdown)
            if not specKey or not listName then
                print("BiSCompanion: Veuillez sélectionner une spécialisation et une liste.")
                return
            end
            if addon.Core.Data.IsBuiltInList(specKey, listName) then
                print("BiSCompanion: Built-in BiS sets cannot be edited; duplicate one to customize it.")
                return
            end

            -- Enregistrer l'état de l'édition
            addon.Core.Data.editingSlot = item.slot
            addon.Core.Data.editingSpecKey = specKey
            addon.Core.Data.editingListName = listName

            -- Fermer l'optionFrame existant s'il y en a un
            if addon.Core.UI.currentOptionFrame then
                addon.Core.UI.currentOptionFrame:Hide()
                addon.Core.UI.currentOptionFrame = nil
            end

            -- Créer une fenêtre avec les options de sélection
            local optionFrame = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset")
            optionFrame:SetSize(200, 160)
            optionFrame:SetPoint("CENTER")
            optionFrame:SetMovable(true)
            optionFrame:EnableMouse(true)
            optionFrame:SetScript("OnMouseDown", function(self, button)
                if button == "LeftButton" then
                    self:StartMoving()
                end
            end)
            optionFrame:SetScript("OnMouseUp", function(self)
                self:StopMovingOrSizing()
            end)

            -- Assigner l'optionFrame à currentOptionFrame pour le suivi
            addon.Core.UI.currentOptionFrame = optionFrame

            local title = optionFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            title:SetPoint("TOP", optionFrame, "TOP", 0, -5)
            title:SetText("Add Item to Slot")

            -- Option 1 : Raid/Dungeon
            local raidButton = CreateFrame("Button", nil, optionFrame, "UIPanelButtonTemplate")
            raidButton:SetSize(160, 22)
            raidButton:SetPoint("TOP", optionFrame, "TOP", 0, -30)
            raidButton:SetText("Raid/Dungeon")
            raidButton:SetScript("OnClick", function()
                optionFrame:Hide()
                addon.Core.UI.currentOptionFrame = nil -- Réinitialiser après fermeture
                addon.Core.EncounterJournal.OpenDungeonTab()
            end)

            -- Option 2 : Set Item
            local setButton = CreateFrame("Button", nil, optionFrame, "UIPanelButtonTemplate")
            setButton:SetSize(160, 22)
            setButton:SetPoint("TOP", raidButton, "BOTTOM", 0, -5)
            setButton:SetText("Sets (not available)")
            setButton:Disable() -- Retail-only catalog is never loaded by Forever.
            setButton:SetScript("OnClick", function()
                optionFrame:Hide()
                addon.Core.UI.currentOptionFrame = nil -- Réinitialiser après fermeture
                -- Afficher une fenêtre avec la liste des items de set sous forme d'icônes
                local setFrame = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset")
                setFrame:SetSize(300, 200)
                setFrame:SetPoint("CENTER")
                setFrame:SetMovable(true)
                setFrame:EnableMouse(true)
                setFrame:SetScript("OnMouseDown", function(self, button)
                    if button == "LeftButton" then
                        self:StartMoving()
                    end
                end)
                setFrame:SetScript("OnMouseUp", function(self)
                    self:StopMovingOrSizing()
                end)

                local setTitle = setFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                setTitle:SetPoint("TOP", setFrame, "TOP", 0, -5)
                setTitle:SetText("Select Set Item")

                local setScrollFrame = CreateFrame("ScrollFrame", nil, setFrame, "UIPanelScrollFrameTemplate")
                setScrollFrame:SetPoint("TOPLEFT", setFrame, "TOPLEFT", 10, -30)
                setScrollFrame:SetPoint("BOTTOMRIGHT", setFrame, "BOTTOMRIGHT", -30, 10)

                local setScrollChild = CreateFrame("Frame", nil, setScrollFrame)
                setScrollChild:SetSize(260, 1)
                setScrollFrame:SetScrollChild(setScrollChild)

                local yOffset = -10
                local xOffset = 10
                local maxHeight = 0
                local itemsPerRow = 5 -- Nombre d'icônes par ligne
                local playerClass = addon.Core.Character.GetClassFromSpecKey(specKey)

                for i, setItem in ipairs(addon.Core.CommonItems.SetItems) do
                    if setItem.class == playerClass and setItem.slot == addon.Core.Data.editingSlot then
                        local setItemButton = CreateFrame("Button", nil, setScrollChild)
                        setItemButton:SetSize(36, 36)
                        setItemButton:SetPoint("TOPLEFT", xOffset, yOffset)

                        local itemID = setItem.itemID
                        local texture = setItemButton:CreateTexture(nil, "ARTWORK")
                        texture:SetAllPoints(setItemButton)
                        local _, _, _, _, _, _, _, _, _, itemTexture = addon.Core.Data.GetItemInfo(itemID)
                        texture:SetTexture(itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
                        if not itemTexture then
                            C_Timer.After(0.5, function()
                                local _, _, _, _, _, _, _, _, _, newTexture = addon.Core.Data.GetItemInfo(itemID)
                                if newTexture then
                                    texture:SetTexture(newTexture)
                                end
                            end)
                        end

                        setItemButton:SetScript("OnEnter", function(self)
                            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                            GameTooltip:SetItemByID(itemID)
                            GameTooltip:AddLine("Source: Set Item (Catalyst)", 1, 1, 0)
                            GameTooltip:Show()
                        end)
                        setItemButton:SetScript("OnLeave", function()
                            GameTooltip:Hide()
                        end)
                        setItemButton:SetScript("OnClick", function()
                            local items = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items
                            local newItems = {}
                            for _, oldItem in ipairs(items) do
                                if oldItem.slot == addon.Core.Data.editingSlot then
                                    table.insert(newItems, {
                                        slot = addon.Core.Data.editingSlot,
                                        name = setItem.name,
                                        source = "Set Item (Catalyst)",
                                        id = tostring(setItem.itemID)
                                    })
                                else
                                    table.insert(newItems, oldItem)
                                end
                            end
                            addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items = newItems
                            addon.Core.Data.BiSCompanionCustomData.customBisLists[addon.Core.Data.editingSpecKey] = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey]
                            BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
                            addon.Core.UI.DisplayItems(addon.Core.Data.editingSpecKey, addon.Core.Data.editingListName)
                            if addon.Core.Data.BiSCompanionCustomData.defaultBisList and
                               addon.Core.Data.BiSCompanionCustomData.defaultBisList[addon.Core.Data.editingSpecKey] == addon.Core.Data.editingListName then
                                addon.Core.Data.UpdateBisTable()
                            end
                            addon.Core.Data.editingSlot = nil
                            addon.Core.Data.editingSpecKey = nil
                            addon.Core.Data.editingListName = nil
                            setFrame:Hide()
                        end)

                        xOffset = xOffset + 40
                        if i % itemsPerRow == 0 then
                            yOffset = yOffset - 40
                            xOffset = 10
                        end
                        maxHeight = math.max(maxHeight, -yOffset + 40)
                    end
                end

                setScrollChild:SetHeight(maxHeight)
            end)

            -- Option 3 : Crafted Item
            local craftButton = CreateFrame("Button", nil, optionFrame, "UIPanelButtonTemplate")
            craftButton:SetSize(160, 22)
            craftButton:SetPoint("TOP", setButton, "BOTTOM", 0, -5)
            craftButton:SetText("Crafts (not available)")
            craftButton:Disable() -- Avoid referencing the absent Retail CommonItems data.
            craftButton:SetScript("OnClick", function()
                optionFrame:Hide()
                addon.Core.UI.currentOptionFrame = nil -- Réinitialiser après fermeture
                -- Afficher une fenêtre avec la liste des items craftés sous forme d'icônes
                local craftFrame = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset")
                craftFrame:SetSize(300, 200)
                craftFrame:SetPoint("CENTER")
                craftFrame:SetMovable(true)
                craftFrame:EnableMouse(true)
                craftFrame:SetScript("OnMouseDown", function(self, button)
                    if button == "LeftButton" then
                        self:StartMoving()
                    end
                end)
                craftFrame:SetScript("OnMouseUp", function(self)
                    self:StopMovingOrSizing()
                end)

                local craftTitle = craftFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                craftTitle:SetPoint("TOP", craftFrame, "TOP", 0, -5)
                craftTitle:SetText("Select Crafted Item")

                local craftScrollFrame = CreateFrame("ScrollFrame", nil, craftFrame, "UIPanelScrollFrameTemplate")
                craftScrollFrame:SetPoint("TOPLEFT", craftFrame, "TOPLEFT", 10, -30)
                craftScrollFrame:SetPoint("BOTTOMRIGHT", craftFrame, "BOTTOMRIGHT", -30, 10)

                local craftScrollChild = CreateFrame("Frame", nil, craftScrollFrame)
                craftScrollChild:SetSize(260, 1)
                craftScrollFrame:SetScrollChild(craftScrollChild)

                local yOffset = -10
                local xOffset = 10
                local maxHeight = 0
                local itemsPerRow = 5 -- Nombre d'icônes par ligne
                local playerClass = addon.Core.Character.GetClassFromSpecKey(specKey)
                local armorType
                if playerClass == "DK" or playerClass == "Warrior" or playerClass == "Paladin" then
                    armorType = "Plate"
                elseif playerClass == "Hunter" or playerClass == "Shaman" then
                    armorType = "Mail"
                elseif playerClass == "Druid" or playerClass == "Rogue" or playerClass == "Monk" or playerClass == "DH" then
                    armorType = "Leather"
                else
                    armorType = "Cloth"
                end

                local i = 0
                for _, craftItem in ipairs(addon.Core.CommonItems.CraftedItems) do
                    if (craftItem.slot == addon.Core.Data.editingSlot) and
                       ((craftItem.type == armorType) or (craftItem.type == "All" or not craftItem.type)) then
                        i = i + 1
                        local craftItemButton = CreateFrame("Button", nil, craftScrollChild)
                        craftItemButton:SetSize(36, 36)
                        craftItemButton:SetPoint("TOPLEFT", xOffset, yOffset)

                        local itemID = craftItem.itemID
                        local texture = craftItemButton:CreateTexture(nil, "ARTWORK")
                        texture:SetAllPoints(craftItemButton)
                        local _, _, _, _, _, _, _, _, _, itemTexture = addon.Core.Data.GetItemInfo(itemID)
                        texture:SetTexture(itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
                        if not itemTexture then
                            C_Timer.After(0.5, function()
                                local _, _, _, _, _, _, _, _, _, newTexture = addon.Core.Data.GetItemInfo(itemID)
                                if newTexture then
                                    texture:SetTexture(newTexture)
                                end
                            end)
                        end

                        craftItemButton:SetScript("OnEnter", function(self)
                            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                            GameTooltip:SetItemByID(itemID)
                            GameTooltip:AddLine("Source: Crafted", 1, 1, 0)
                            GameTooltip:Show()
                        end)
                        craftItemButton:SetScript("OnLeave", function()
                            GameTooltip:Hide()
                        end)
                        craftItemButton:SetScript("OnClick", function()
                            local items = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items
                            local newItems = {}
                            for _, oldItem in ipairs(items) do
                                if oldItem.slot == addon.Core.Data.editingSlot then
                                    table.insert(newItems, {
                                        slot = addon.Core.Data.editingSlot,
                                        name = craftItem.name,
                                        source = "Crafted",
                                        id = tostring(craftItem.itemID)
                                    })
                                else
                                    table.insert(newItems, oldItem)
                                end
                            end
                            addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items = newItems
                            addon.Core.Data.BiSCompanionCustomData.customBisLists[addon.Core.Data.editingSpecKey] = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey]
                            BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
                            addon.Core.UI.DisplayItems(addon.Core.Data.editingSpecKey, addon.Core.Data.editingListName)
                            if addon.Core.Data.BiSCompanionCustomData.defaultBisList and
                               addon.Core.Data.BiSCompanionCustomData.defaultBisList[addon.Core.Data.editingSpecKey] == addon.Core.Data.editingListName then
                                addon.Core.Data.UpdateBisTable()
                            end
                            addon.Core.Data.editingSlot = nil
                            addon.Core.Data.editingSpecKey = nil
                            addon.Core.Data.editingListName = nil
                            craftFrame:Hide()
                        end)

                        xOffset = xOffset + 40
                        if i % itemsPerRow == 0 then
                            yOffset = yOffset - 40
                            xOffset = 10
                        end
                        maxHeight = math.max(maxHeight, -yOffset + 40)
                    end
                end

                craftScrollChild:SetHeight(maxHeight)
            end)

            -- Option 4 : Specific Item ID
            local idButton = CreateFrame("Button", nil, optionFrame, "UIPanelButtonTemplate")
            idButton:SetSize(160, 22)
            idButton:SetPoint("TOP", craftButton, "BOTTOM", 0, -5)
            idButton:SetText("Specific Item ID")
            idButton:SetScript("OnClick", function()
                optionFrame:Hide()
                addon.Core.UI.currentOptionFrame = nil -- Réinitialiser après fermeture
                -- Afficher une fenêtre pour entrer un item ID
                local idFrame = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset")
                idFrame:SetSize(300, 100)
                idFrame:SetPoint("CENTER")
                idFrame:SetMovable(true)
                idFrame:EnableMouse(true)
                idFrame:SetScript("OnMouseDown", function(self, button)
                    if button == "LeftButton" then
                        self:StartMoving()
                    end
                end)
                idFrame:SetScript("OnMouseUp", function(self)
                    self:StopMovingOrSizing()
                end)

                local idTitle = idFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                idTitle:SetPoint("TOP", idFrame, "TOP", 0, -5)
                idTitle:SetText("Enter Item ID")

                local idEditBox = CreateFrame("EditBox", nil, idFrame, "InputBoxTemplate")
                idEditBox:SetSize(280, 20)
                idEditBox:SetPoint("TOP", idFrame, "TOP", 0, -30)
                idEditBox:SetAutoFocus(true)

                local idSaveButton = CreateFrame("Button", nil, idFrame, "UIPanelButtonTemplate")
                idSaveButton:SetSize(80, 22)
                idSaveButton:SetPoint("BOTTOM", idFrame, "BOTTOM", 0, 10)
                idSaveButton:SetText("Save")
                idSaveButton:SetScript("OnClick", function()
                    local itemID = idEditBox:GetText():trim()
                    if itemID == "" or not tonumber(itemID) then
                        print("BiSCompanion: Veuillez entrer un ID d'item valide.")
                        return
                    end
                    itemID = tonumber(itemID)
                    local name = addon.Core.Data.GetItemInfo(itemID)
                    if not name then
                        print("BiSCompanion: Item not loaded (itemID=" .. itemID .. "). Try again.")
                        return
                    end

                    local items = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items
                    local newItems = {}
                    for _, oldItem in ipairs(items) do
                        if oldItem.slot == addon.Core.Data.editingSlot then
                            table.insert(newItems, {
                                slot = addon.Core.Data.editingSlot,
                                name = name,
                                source = "Custom ID",
                                id = tostring(itemID)
                            })
                        else
                            table.insert(newItems, oldItem)
                        end
                    end
                    addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey][addon.Core.Data.editingListName].items = newItems
                    addon.Core.Data.BiSCompanionCustomData.customBisLists[addon.Core.Data.editingSpecKey] = addon.Core.Data.customBisListsInMemory[addon.Core.Data.editingSpecKey]
                    BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
                    addon.Core.UI.DisplayItems(addon.Core.Data.editingSpecKey, addon.Core.Data.editingListName)
                    if addon.Core.Data.BiSCompanionCustomData.defaultBisList and
                       addon.Core.Data.BiSCompanionCustomData.defaultBisList[addon.Core.Data.editingSpecKey] == addon.Core.Data.editingListName then
                        addon.Core.Data.UpdateBisTable()
                    end
                    addon.Core.Data.editingSlot = nil
                    addon.Core.Data.editingSpecKey = nil
                    addon.Core.Data.editingListName = nil
                    idFrame:Hide()
                end)
            end)
        end
    end)

    return button
end

-- Fonction pour afficher les icônes et mettre à jour le fond
local function RenderItems(specKey, listName)
    if not foreverGearEnabled then return end
    if scrollChild.itemButtons then
        for _, button in ipairs(scrollChild.itemButtons) do
            button:Hide()
        end
    end
    scrollChild.itemButtons = {}

    if not specKey then
        return
    end

    local items = addon.Core.Data.GetItemsForList(specKey, listName)

    if not items or #items == 0 then
        setAsDefaultCheckbox:Hide()
        local message = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        message:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 10, -20)
        message:SetWidth(235)
        message:SetJustifyH("LEFT")
        message:SetText("No BiS items loaded for " .. tostring(specKey) .. ". Check that all addon files are installed.")
        table.insert(scrollChild.itemButtons, message)
        return
    end

    local classKey = addon.Core.Character.GetClassFromSpecKey(specKey)
    local backgroundTexture = addon.Core.Character.classBackgrounds[classKey] or addon.Core.Character.classBackgrounds["Default"]
    addon.Core.UI.frame.background:SetTexture(backgroundTexture)

    local tailleIcone = 36
    local maxHeight = 0

    local itemBySlot = {}
    for _, item in ipairs(items) do
        if type(item) == "table" and item.slot then
            itemBySlot[item.slot] = item
        end
    end

    local leftX, leftY = 10, -15
    for i, slot in ipairs(addon.Core.Character.slotOrder.left) do
        local item = itemBySlot[slot]
        if item then
            local button = addon.Core.UI.CreateItemButton(scrollChild, item, leftX, leftY - (i-1) * (tailleIcone + 5), i, "Left")
            if button then
                table.insert(scrollChild.itemButtons, button)
                maxHeight = math.max(maxHeight, (i-1) * (tailleIcone + 5) + tailleIcone + 5)
            end
            local slotText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            slotText:SetPoint("LEFT", button, "RIGHT", 5, 0)
            slotText:SetText(item.slot)
            slotText:SetTextColor(1, 1, 1)
        end
    end

    local rightX, rightY = 205, -15
    for i, slot in ipairs(addon.Core.Character.slotOrder.right) do
        local item = itemBySlot[slot]
        if item then
            local button = addon.Core.UI.CreateItemButton(scrollChild, item, rightX, rightY - (i-1) * (tailleIcone + 5), i, "Right")
            if button then
                table.insert(scrollChild.itemButtons, button)
                maxHeight = math.max(maxHeight, (i-1) * (tailleIcone + 5) + tailleIcone + 5)
            end
            local slotText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            slotText:SetPoint("RIGHT", button, "LEFT", -5, 0)
            slotText:SetText(item.slot)
            slotText:SetTextColor(1, 1, 1)
        end
    end

    -- Gérer la case à cocher "Use as Default BiS"
    if listName ~= "Default" and specKey then
        setAsDefaultCheckbox:Show()
        local isDefault = addon.Core.Data.BiSCompanionCustomData.defaultBisList and
                          addon.Core.Data.BiSCompanionCustomData.defaultBisList[specKey] == listName
        setAsDefaultCheckbox:SetChecked(isDefault)
        setAsDefaultCheckbox:SetScript("OnClick", function(self)
            local isChecked = self:GetChecked()
            addon.Core.Data.BiSCompanionCustomData.defaultBisList = addon.Core.Data.BiSCompanionCustomData.defaultBisList or {}
            if isChecked then
                addon.Core.Data.BiSCompanionCustomData.defaultBisList[specKey] = listName
            else
                if addon.Core.Data.BiSCompanionCustomData.defaultBisList[specKey] == listName then
                    addon.Core.Data.BiSCompanionCustomData.defaultBisList[specKey] = nil
                end
                if next(addon.Core.Data.BiSCompanionCustomData.defaultBisList) == nil then
                    addon.Core.Data.BiSCompanionCustomData.defaultBisList = nil
                end
            end
            BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
            -- Mettre à jour la sélection visuelle immédiatement selon la préférence
            SelectPreferredListForSpec(specKey)
            addon.Core.Data.UpdateBisTable()
        end)
    else
        setAsDefaultCheckbox:Hide()
    end

    local bottomX, bottomY = 10, -maxHeight - 15
    local extraGap = 42
    for i, slot in ipairs(addon.Core.Character.slotOrder.bottom) do
        local item = itemBySlot[slot]
        if item then
            local offsetX
            if i >= 5 then
                offsetX = bottomX
            elseif i <= 2 then
                offsetX = bottomX + (i-1) * (tailleIcone + 15)
            else
                offsetX = bottomX + (i-3) * (tailleIcone + 15) + 2 * (tailleIcone + 15) + extraGap
            end
            local itemY = i >= 5 and bottomY - tailleIcone - 20 or bottomY
            local button = addon.Core.UI.CreateItemButton(scrollChild, item, offsetX, itemY, i, "Bottom")
            if button then
                table.insert(scrollChild.itemButtons, button)
                maxHeight = math.max(maxHeight, -itemY + tailleIcone + 15)
            end
            local slotText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            slotText:SetPoint("BOTTOM", button, "BOTTOM", 0, -12)
            slotText:SetText(item.displaySlot or item.slot)
            slotText:SetTextColor(1, 1, 1)
        end
    end

    scrollChild:SetHeight(maxHeight)
    -- NOTE: on n'ouvre plus automatiquement les talents
    -- addon.Core.Talents.DisplayTalents(specKey)
end

function addon.Core.UI.DisplayItems(specKey, listName)
    if not foreverGearEnabled then return end
    local ok, err = pcall(RenderItems, specKey, listName)
    if ok then return end

    local errorText = tostring(err)
    print("BiSCompanion display error: " .. errorText)
    local message = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    message:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 10, -20)
    message:SetWidth(235)
    message:SetJustifyH("LEFT")
    message:SetText("BiS display error: " .. errorText)
    scrollChild.itemButtons = scrollChild.itemButtons or {}
    table.insert(scrollChild.itemButtons, message)
    scrollChild:SetHeight(100)
end

-- Initialiser la première liste déroulante (classes)
UIDropDownMenu_Initialize(classDropdown, function(self)
    if not BiSCompanionBisData then
        return
    end

    local classList = {}
    for specKey, _ in pairs(BiSCompanionBisData) do
        local class = addon.Core.Character.GetClassFromSpecKey(specKey)
        classList[class] = true
    end

    local sortedClasses = {}
    for class, _ in pairs(classList) do
        table.insert(sortedClasses, class)
    end
    table.sort(sortedClasses)

    for _, class in ipairs(sortedClasses) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = class
        info.value = class
        info.func = function(self)
            UIDropDownMenu_SetSelectedValue(classDropdown, self.value)
            UIDropDownMenu_SetText(classDropdown, self.value)
            UIDropDownMenu_EnableDropDown(specDropdown)
            UIDropDownMenu_Initialize(specDropdown, specDropdown.initialize)
            UIDropDownMenu_SetSelectedValue(specDropdown, nil)
            UIDropDownMenu_SetText(specDropdown, "Select a spec")
            UIDropDownMenu_SetSelectedValue(listDropdown, nil)
            UIDropDownMenu_SetText(listDropdown, "Select a BiS List")
            UIDropDownMenu_DisableDropDown(listDropdown)
            addon.Core.UI.DisplayItems(nil)
        end
        UIDropDownMenu_AddButton(info)
    end
end)

-- Initialiser la deuxième liste déroulante (spécialisations)
UIDropDownMenu_Initialize(specDropdown, function(self)
    local selectedClass = UIDropDownMenu_GetSelectedValue(classDropdown)
    if not selectedClass then
        return
    end

    local specList = {}
    local index = 1
    -- Ajouter les spécialisations par défaut depuis BiSCompanionBisData
    if BiSCompanionBisData then
        for specKey, _ in pairs(BiSCompanionBisData) do
            local classFromSpec = addon.Core.Character.GetClassFromSpecKey(specKey)
            if classFromSpec == selectedClass then
                local specName = addon.Core.Character.GetSpecName(specKey) or specKey
                specList[index] = { text = specName, value = specKey }
                index = index + 1
            end
        end
    end

    -- Ajouter les spécialisations personnalisées (si absentes)
    if addon.Core.Data.customBisListsInMemory then
        for specKey, _ in pairs(addon.Core.Data.customBisListsInMemory) do
            local classFromSpec = addon.Core.Character.GetClassFromSpecKey(specKey)
            if classFromSpec == selectedClass or (selectedClass == "DEATHKNIGHT" and specKey:find("^DK_")) then
                local alreadyAdded = false
                for _, spec in ipairs(specList) do
                    if spec.value == specKey then
                        alreadyAdded = true
                        break
                    end
                end
                if not alreadyAdded then
                    local specName = addon.Core.Character.GetSpecName(specKey) or specKey
                    specList[index] = { text = specName, value = specKey }
                    index = index + 1
                end
            end
        end
    end

    if #specList == 0 then
        return
    end

    table.sort(specList, function(a, b)
        local specA = a.value:match("^[^_]+_([^_]+)") or a.value
        local specB = b.value:match("^[^_]+_([^_]+)") or b.value
        if specA == specB then
            return a.text < b.text
        else
            return specA < specB
        end
    end)

    for _, spec in ipairs(specList) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = spec.text
        info.value = spec.value
        info.func = function(selfBtn)
            -- Blizzard reuses drop-down buttons when another menu is initialized.
            -- Capture the chosen specialization BEFORE rebuilding the lists:
            -- selfBtn.value may become "Default" during that operation.
            local selectedSpecKey = selfBtn.value
            local selectedSpecLabel = selfBtn.text
            UIDropDownMenu_SetSelectedValue(specDropdown, selectedSpecKey)
            UIDropDownMenu_SetText(specDropdown, selectedSpecLabel)
            addon.Core.Character.RememberForeverGearSpec(selectedSpecKey)
            UIDropDownMenu_Refresh(specDropdown)
            UIDropDownMenu_EnableDropDown(listDropdown)

            -- (re)construire le menu des listes pour cette spé
            UIDropDownMenu_Initialize(listDropdown, listDropdown.initialize)
            -- Sélectionner et afficher la bonne liste (custom par défaut si définie)
            SelectPreferredListForSpec(selectedSpecKey)
            -- Mettre à jour bisTable (tooltip)
            addon.Core.Data.UpdateBisTable()
        end
        UIDropDownMenu_AddButton(info)
    end
end)

-- Initialiser la liste déroulante des BiS lists
UIDropDownMenu_Initialize(listDropdown, function(self)
    local specKey = UIDropDownMenu_GetSelectedValue(specDropdown)
    if not specKey then
        return
    end

    -- Déterminer la liste préférée (custom par défaut si dispo, sinon "Default")
    local preferred = GetPreferredListNameForSpec(specKey)

    -- Construire un ordre: [preferred], ["Default" si pas déjà], autres customs triées
    local added = {}

    local function addListEntry(name)
        local info = UIDropDownMenu_CreateInfo()
        info.text = VisibleGearListName(name, specKey)
        info.value = name
        info.func = function(btn)
            UIDropDownMenu_SetSelectedValue(listDropdown, btn.value)
            UIDropDownMenu_SetText(listDropdown, btn.text)
            addon.Core.UI.DisplayItems(specKey, btn.value)
            UIDropDownMenu_Refresh(listDropdown)
        end
        UIDropDownMenu_AddButton(info)
        added[name] = true
    end

    -- 1) préférée
    addListEntry(preferred)

    -- 2) Default (si pas déjà)
    if not added["Default"] and BiSCompanionBisData[specKey] then
        addListEntry("Default")
    end

    -- 3) autres variantes Pre-Raid integrees, en lecture seule.
    local perSpecBuiltins = BiSCompanionForeverGearVariants and BiSCompanionForeverGearVariants[specKey]
    if perSpecBuiltins then
        local keys = {}
        for name in pairs(perSpecBuiltins) do
            if not added[name] then table.insert(keys, name) end
        end
        table.sort(keys, function(a, b)
            return VisibleGearListName(a, specKey) < VisibleGearListName(b, specKey)
        end)
        for _, name in ipairs(keys) do addListEntry(name) end
    end

    -- 4) autres customs
    if addon.Core.Data.customBisListsInMemory and addon.Core.Data.customBisListsInMemory[specKey] then
        local names = {}
        for name, _ in pairs(addon.Core.Data.customBisListsInMemory[specKey]) do
            if type(name) == "string" and not added[name] then
                table.insert(names, name)
            end
        end
        table.sort(names)
        for _, name in ipairs(names) do
            addListEntry(name)
        end
    end
end)

-- Copy all gear metadata, including the Relic label and offline icon.
local function CopyBisItem(value)
    if type(value) ~= "table" then return value end
    local copy = {}
    for key, child in pairs(value) do
        copy[key] = CopyBisItem(child)
    end
    return copy
end

-- Logique pour le bouton "Duplicate"
duplicateButton:SetScript("OnClick", function()
    local specKey = UIDropDownMenu_GetSelectedValue(specDropdown)
    local listName = UIDropDownMenu_GetSelectedValue(listDropdown)
    if not specKey or not listName then
        return
    end

    local items = addon.Core.Data.GetItemsForList(specKey, listName)

    if not items then
        return
    end

    nameFrame.pendingSpecKey = specKey
    nameFrame:Show()
    nameEditBox:SetText("")
    nameFrame.importCallback = function(newListName)
        -- Créer une nouvelle liste avec les items copiés
        addon.Core.Data.customBisListsInMemory[specKey] = addon.Core.Data.customBisListsInMemory[specKey] or {}
        addon.Core.Data.customBisListsInMemory[specKey][newListName] = {
            items = {},
            created = time()
        }
        for _, item in ipairs(items) do
            table.insert(addon.Core.Data.customBisListsInMemory[specKey][newListName].items,
                CopyBisItem(item))
        end
        addon.Core.Data.BiSCompanionCustomData.customBisLists[specKey] = addon.Core.Data.customBisListsInMemory[specKey]
        BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
        UIDropDownMenu_Initialize(listDropdown, listDropdown.initialize)
        UIDropDownMenu_SetSelectedValue(listDropdown, newListName)
        UIDropDownMenu_SetText(listDropdown, newListName)
        addon.Core.UI.DisplayItems(specKey, newListName)
    end
end)

-- Logique pour le bouton "Create"
createButton:SetScript("OnClick", function()
    local specKey = UIDropDownMenu_GetSelectedValue(specDropdown)
    if not specKey then
        return
    end

    nameFrame.pendingSpecKey = specKey
    nameFrame:Show()
    nameEditBox:SetText("")
    nameFrame.importCallback = function(listName)
        addon.Core.Data.CreateEmptyBiSList(specKey, listName)
        UIDropDownMenu_Initialize(listDropdown, listDropdown.initialize)
        UIDropDownMenu_SetSelectedValue(listDropdown, listName)
        UIDropDownMenu_SetText(listDropdown, listName)
        addon.Core.UI.DisplayItems(specKey, listName)
    end
end)

-- Logique pour le bouton "Delete"
deleteButton:SetScript("OnClick", function()
    local specKey = UIDropDownMenu_GetSelectedValue(specDropdown)
    local listName = UIDropDownMenu_GetSelectedValue(listDropdown)
    if not specKey or not listName then
        return
    end

    if addon.Core.Data.IsBuiltInList(specKey, listName) then
        print("BiSCompanion: Built-in BiS sets cannot be deleted")
        return
    end

    if addon.Core.Data.customBisListsInMemory[specKey] then
        addon.Core.Data.customBisListsInMemory[specKey][listName] = nil
        if addon.Core.Data.BiSCompanionCustomData.defaultBisList and
           addon.Core.Data.BiSCompanionCustomData.defaultBisList[specKey] == listName then
            addon.Core.Data.BiSCompanionCustomData.defaultBisList[specKey] = nil
            if next(addon.Core.Data.BiSCompanionCustomData.defaultBisList) == nil then
                addon.Core.Data.BiSCompanionCustomData.defaultBisList = nil
            end
        end
        if next(addon.Core.Data.customBisListsInMemory[specKey]) == nil then
            addon.Core.Data.customBisListsInMemory[specKey] = nil
        end
        addon.Core.Data.BiSCompanionCustomData.customBisLists = addon.Core.Data.customBisListsInMemory
        BiSCompanionCustomData = addon.Core.Data.BiSCompanionCustomData
        UIDropDownMenu_Initialize(listDropdown, listDropdown.initialize)
        -- Revenir à la meilleure sélection dispo après suppression
        SelectPreferredListForSpec(specKey)
        addon.Core.Data.UpdateBisTable()
    end
end)

-- === Talents toggle button (vertical) ===
if not _G["BiSCompanionTalentsVerticalButton"] then
    local vbtn = CreateFrame("Button", "BiSCompanionTalentsVerticalButton", addon.Core.UI.frame, "UIPanelButtonTemplate")
    vbtn:SetSize(22, 110)  -- étroit et haut
    vbtn:SetPoint("TOPRIGHT", addon.Core.UI.frame, "TOPRIGHT", -2, -70)

    vbtn:SetText("T\na\nl\ne\nn\nt\ns")
    local fs = vbtn:GetFontString()
    if fs then
        fs:ClearAllPoints()
        fs:SetAllPoints(vbtn)
        fs:SetJustifyH("CENTER")
        fs:SetJustifyV("MIDDLE")
    end

    vbtn:SetFrameStrata("DIALOG")
    vbtn:SetFrameLevel(addon.Core.UI.frame:GetFrameLevel() + 100)

    vbtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("Toggle Talent Builds")
        GameTooltip:AddLine("Open/close the talents panel.", 1, 1, 1)
        GameTooltip:Show()
    end)
    vbtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    vbtn:SetScript("OnClick", function()
        if addon.Core and addon.Core.Talents and addon.Core.Talents.Toggle then
            addon.Core.Talents.Toggle()
        end
    end)
end
-- === /Talents toggle button (vertical) ===

-- Retirer toutes les commandes d'équipement sur Forever en attendant des données fiables.
-- Ne pas toucher à SavedVariables : les listes personnelles restent stockées.
if not foreverGearEnabled then
    scrollFrame:Hide()
    listDropdown:Hide()
    duplicateButton:Hide()
    createButton:Hide()
    deleteButton:Hide()
    setAsDefaultCheckbox:Hide()
    nameFrame:Hide()
    gearNoticeTitle:Show()
    gearNoticeBody:Show()
end

-- Quand la frame principale s'ouvre, appliquer la sélection préférée pour la spé courante
addon.Core.UI.frame:HookScript("OnShow", function()
    local specKey = UIDropDownMenu_GetSelectedValue(specDropdown)
    if specKey then
        -- reconstruire le menu pour s'assurer que la liste existe
        UIDropDownMenu_Initialize(listDropdown, listDropdown.initialize)
        SelectPreferredListForSpec(specKey)
    end
end)
