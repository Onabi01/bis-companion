-- Créer une fenêtre simple avec un ScrollFrame pour BiS
local frame = CreateFrame("Frame", "BiSCompanionFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(325, 475)
frame:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT", 0, 0)
frame:Hide()

-- Ajouter un titre
frame.title = frame:CreateFontString(nil, "OVERLAY")
frame.title:SetFontObject("GameFontHighlight")
frame.title:SetPoint("TOP", frame, "TOP", 0, -5)
frame.title:SetText("BiS Equipment")

-- Ajouter une texture de fond
frame.background = frame:CreateTexture(nil, "BACKGROUND")
frame.background:SetAllPoints(frame)
frame.background:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble")
frame.background:SetAlpha(0.7)

-- Créer un ScrollFrame pour défiler la liste BiS
local scrollFrame = CreateFrame("ScrollFrame", "BiSCompanionScrollFrame", frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -70)
scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 10)

-- Conteneur pour les icônes BiS
local scrollChild = CreateFrame("Frame", "BiSCompanionScrollChild", scrollFrame)
scrollChild:SetSize(310, 1)
scrollFrame:SetScrollChild(scrollChild)

-- Créer deux menus déroulants : un pour les classes, un pour les spécialisations
local classDropdown = CreateFrame("Frame", "BiSCompanionClassDropdown", frame, "UIDropDownMenuTemplate")
classDropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
UIDropDownMenu_SetWidth(classDropdown, 100)

local specDropdown = CreateFrame("Frame", "BiSCompanionSpecDropdown", frame, "UIDropDownMenuTemplate")
specDropdown:SetPoint("TOPLEFT", classDropdown, "TOPRIGHT", -10, 0)
UIDropDownMenu_SetWidth(specDropdown, 100)

-- Table des textures de fond par classe
local classBackgrounds = {
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
local slotOrder = {
    left = {"Head", "Neck", "Shoulders", "Back", "Chest", "Wrists"},
    right = {"Hands", "Waist", "Legs", "Feet", "Ring 1", "Ring 2"},
    bottom = {"Weapon", "Off Hand", "Trinket 1", "Trinket 2"}
}

-- Créer une frame latérale pour les talents
local talentFrame = CreateFrame("Frame", "BiSCompanionTalentFrame", UIParent, "BasicFrameTemplateWithInset")
talentFrame:SetSize(325, 475)
talentFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 5, 0)
talentFrame:Hide()

-- Ajouter un titre à la frame des talents
talentFrame.title = talentFrame:CreateFontString(nil, "OVERLAY")
talentFrame.title:SetFontObject("GameFontHighlight")
talentFrame.title:SetPoint("TOP", talentFrame, "TOP", 0, -5)
talentFrame.title:SetText("Talent Builds")

-- Ajouter une texture de fond à la frame des talents
talentFrame.background = talentFrame:CreateTexture(nil, "BACKGROUND")
talentFrame.background:SetAllPoints(talentFrame)
talentFrame.background:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble")
talentFrame.background:SetAlpha(0.7)

-- Créer un ScrollFrame pour défiler la liste des talents
local talentScrollFrame = CreateFrame("ScrollFrame", "BiSCompanionTalentScrollFrame", talentFrame, "UIPanelScrollFrameTemplate")
talentScrollFrame:SetPoint("TOPLEFT", talentFrame, "TOPLEFT", 10, -30)
talentScrollFrame:SetPoint("BOTTOMRIGHT", talentFrame, "BOTTOMRIGHT", -30, 10)

-- Conteneur pour les talents
local talentScrollChild = CreateFrame("Frame", "BiSCompanionTalentScrollChild", talentScrollFrame)
talentScrollChild:SetSize(310, 1)
talentScrollFrame:SetScrollChild(talentScrollChild)

-- Créer une fenêtre popup pour copier le code (déplaçable)
local copyFrame = CreateFrame("Frame", "BiSCompanionCopyFrame", UIParent, "BasicFrameTemplateWithInset")
copyFrame:SetSize(300, 100)
copyFrame:SetPoint("CENTER")
copyFrame:SetMovable(true)
copyFrame:EnableMouse(true)
copyFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)
copyFrame:SetScript("OnMouseUp", function(self)
    self:StopMovingOrSizing()
end)
copyFrame:Hide()

copyFrame.title = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
copyFrame.title:SetPoint("TOP", copyFrame, "TOP", 0, -5)
copyFrame.title:SetText("Copy Talent's code")

local copyEditBox = CreateFrame("EditBox", nil, copyFrame, "InputBoxTemplate")
copyEditBox:SetSize(280, 20)
copyEditBox:SetPoint("TOP", copyFrame, "TOP", 0, -30)
copyEditBox:SetAutoFocus(true)
copyEditBox:SetScript("OnEscapePressed", function(self) copyFrame:Hide() end)
copyEditBox:SetScript("OnEnterPressed", function(self) copyFrame:Hide() end)

local copyInstruction = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
copyInstruction:SetPoint("BOTTOM", copyFrame, "BOTTOM", 0, 10)
copyInstruction:SetText("Ctrl+C to copy, then Enter or Escape to close")

-- Fonction pour extraire la classe à partir de la clé de spécialisation
local function GetClassFromSpecKey(specKey)
    local classPrefix = specKey:match("^([^_]+)")
    -- Retourner en "Title Case" ou conserver les abréviations spécifiques (DK, DH)
    if classPrefix then
        if classPrefix:upper() == "DK" or classPrefix:upper() == "DH" then
            return classPrefix:upper() -- Garder "DK" et "DH" en majuscules
        else
            return classPrefix:sub(1, 1):upper() .. classPrefix:sub(2):lower()
        end
    end
    return "Default"
end

-- Fonction pour obtenir le nom de la spécialisation sans la classe
local function GetSpecName(specKey)
    local specPart = specKey:match("_(.+)$") or specKey
    return specPart:gsub("_", " ")
end

local function GetPlayerClassAndSpec()
    local className, classFile, classID = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then
        return nil, nil
    end

    local specID = GetSpecializationInfo(specIndex)
    if not specID then
        return nil, nil
    end

    if not BiSCompanionClassSpecMapping then
        return nil, nil
    end

    -- Mapper classFile au préfixe correct utilisé dans BiSCompanionBisData
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

    local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
    local matchingSpecKey = nil
    if heroSpecID then
        for _, mapping in ipairs(BiSCompanionClassSpecMapping) do
            if mapping.classID == classID and mapping.specID == specID and mapping.heroID == heroSpecID then
                matchingSpecKey = mapping.specKey
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
                [577] = "DH_Havoc_Aldrachi Reaver",
                [581] = "DH_Vengeance_Fel-Scarred"
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
                [268] = "Monk_Brewmaster_Master of Harmony",
                [270] = "Monk_Mistweaver_Conduit of the Celestials",
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
            return playerClass, specKey
        else
            return playerClass, nil
        end
    end
end

-- Fonction pour créer un bouton d’objet
local function CreateItemButton(parent, item, x, y, index, section)
    local itemID = tonumber(item.id)
    if not itemID then
        return nil
    end

    local button = CreateFrame("Button", "BiSCompanionItem" .. section .. index, parent)
    button:SetSize(36, 36)
    button:SetPoint("TOPLEFT", x, y)

    local texture = button:CreateTexture(nil, "ARTWORK")
    texture:SetAllPoints(button)
    texture:SetTexture(GetItemIcon(itemID))

    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetItemByID(itemID)
        GameTooltip:AddLine("Source: " .. (item.source or "Inconnu"), 1, 1, 0)
        if item.gems then
            GameTooltip:AddLine("Gems: " .. table.concat(item.gems, ", "), 0, 1, 1)
        end
        if item.alternates then
            for _, alt in ipairs(item.alternates) do
                GameTooltip:AddLine("Alt: " .. alt.name .. " (" .. alt.source .. ")", 0.5, 0.5, 1)
            end
        end
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    local slotText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    slotText:SetPoint("BOTTOM", button, "TOP", 0, 2)
    slotText:SetText(item.slot)
    slotText:SetTextColor(1, 1, 1)

    return button
end

-- Fonction pour afficher les talents avec des boutons ouvrant une EditBox
local function DisplayTalents(specKey)
    if talentScrollChild.talentButtons then
        for _, button in ipairs(talentScrollChild.talentButtons) do
            button:Hide()
        end
    end
    talentScrollChild.talentButtons = {}

    if not BiSCompanionTalentData then
        return
    end

    local talents = BiSCompanionTalentData[specKey]
    if not talents then
        local noTalentsText = talentScrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noTalentsText:SetPoint("TOPLEFT", 10, -10)
        noTalentsText:SetWidth(290)
        noTalentsText:SetJustifyH("LEFT")
        noTalentsText:SetText("No talent defined for this spec.")
        talentScrollChild.talentButtons = { noTalentsText }
        talentScrollChild:SetHeight(20)
        return
    end

    local yOffset = -10
    local maxHeight = 0

    for i, talent in ipairs(talents) do
        local button = CreateFrame("Button", "BiSCompanionTalentButton" .. i, talentScrollChild)
        button:SetSize(290, 20)
        button:SetPoint("TOPLEFT", 10, yOffset)

        local text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("LEFT", button, "LEFT", 0, 0)
        text:SetWidth(290)
        text:SetJustifyH("LEFT")
        text:SetText(talent.buildName .. " (" .. talent.heroTree .. ")")

        button:SetScript("OnClick", function()
            copyFrame:Show()
            copyEditBox:SetText(talent.importCode)
            copyEditBox:HighlightText()
        end)
        button:SetScript("OnEnter", function(self)
            self:LockHighlight()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Cliquez pour voir le code des talents")
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function(self)
            self:UnlockHighlight()
            GameTooltip:Hide()
        end)

        button:SetHighlightTexture("Interface\\Buttons\\UI-Listbox-Highlight")
        button:GetHighlightTexture():SetAlpha(0.5)

        table.insert(talentScrollChild.talentButtons, button)
        yOffset = yOffset - 25
        maxHeight = math.max(maxHeight, -yOffset + 25)
    end

    talentScrollChild:SetHeight(maxHeight)
end

-- Fonction pour afficher les icônes et mettre à jour le fond
local function DisplayItems(specKey)
    if scrollChild.itemButtons then
        for _, button in ipairs(scrollChild.itemButtons) do
            button:Hide()
        end
    end
    scrollChild.itemButtons = {}

    if not BiSCompanionBisData or not BiSCompanionBisData[specKey] then
        return
    end

    local classKey = GetClassFromSpecKey(specKey)
    local backgroundTexture = classBackgrounds[classKey] or classBackgrounds["Default"]
    frame.background:SetTexture(backgroundTexture)

    local items = BiSCompanionBisData[specKey]
    local tailleIcone = 36
    local maxHeight = 0

    local itemBySlot = {}
    for _, item in ipairs(items) do
        if type(item) == "table" and item.slot and item.name and item.id then
            itemBySlot[item.slot] = item
        end
    end

    local leftX, leftY = 40, -15
    for i, slot in ipairs(slotOrder.left) do
        local item = itemBySlot[slot]
        if item then
            local button = CreateItemButton(scrollChild, item, leftX, leftY - (i-1) * (tailleIcone + 15), i, "Left")
            if button then
                table.insert(scrollChild.itemButtons, button)
                maxHeight = math.max(maxHeight, (i-1) * (tailleIcone + 15) + tailleIcone + 15)
            end
        end
    end

    local rightX, rightY = 230, -15
    for i, slot in ipairs(slotOrder.right) do
        local item = itemBySlot[slot]
        if item then
            local button = CreateItemButton(scrollChild, item, rightX, rightY - (i-1) * (tailleIcone + 15), i, "Right")
            if button then
                table.insert(scrollChild.itemButtons, button)
                maxHeight = math.max(maxHeight, (i-1) * (tailleIcone + 15) + tailleIcone + 15)
            end
        end
    end

    local bottomX, bottomY = 60, -maxHeight - 10
    local extraGap = 30
    for i, slot in ipairs(slotOrder.bottom) do
        local item = itemBySlot[slot]
        if item then
            local offsetX
            if i <= 2 then
                offsetX = bottomX + (i-1) * (tailleIcone + 10)
            else
                offsetX = bottomX + (i-3) * (tailleIcone + 10) + 2 * (tailleIcone + 10) + extraGap
            end
            local button = CreateItemButton(scrollChild, item, offsetX, bottomY, i, "Bottom")
            if button then
                table.insert(scrollChild.itemButtons, button)
                maxHeight = math.max(maxHeight, -bottomY + tailleIcone + 15)
            end
        end
    end

    scrollChild:SetHeight(maxHeight)
    DisplayTalents(specKey)
end

-- Initialiser la première liste déroulante (classes)
UIDropDownMenu_Initialize(classDropdown, function(self)
    if not BiSCompanionBisData then
        return
    end

    local classList = {}
    for specKey, _ in pairs(BiSCompanionBisData) do
        local class = GetClassFromSpecKey(specKey)
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
            DisplayItems(nil)
        end
        UIDropDownMenu_AddButton(info)
    end
end)

-- Initialiser la deuxième liste déroulante (spécialisations)
UIDropDownMenu_Initialize(specDropdown, function(self)
    if not BiSCompanionBisData then
        return
    end

    local selectedClass = UIDropDownMenu_GetSelectedValue(classDropdown)
    if not selectedClass then
        return
    end

    local specList = {}
    for specKey, _ in pairs(BiSCompanionBisData) do
        if GetClassFromSpecKey(specKey) == selectedClass then
            table.insert(specList, { text = GetSpecName(specKey), value = specKey })
        end
    end

    table.sort(specList, function(a, b) return a.text < b.text end)

    for _, spec in ipairs(specList) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = spec.text
        info.value = spec.value
        info.func = function(self)
            UIDropDownMenu_SetSelectedValue(specDropdown, self.value)
            UIDropDownMenu_SetText(specDropdown, self.text) -- Forcer l’affichage du texte
            UIDropDownMenu_Refresh(specDropdown) -- Rafraîchir pour s’assurer que le texte persiste
            DisplayItems(self.value)
        end
        UIDropDownMenu_AddButton(info)
    end
end)

-- Variable globale pour stocker les objets BiS
local bisTable = {}

-- Fonction pour pré-sélectionner la classe et la spécialisation du joueur
local function PreselectPlayerClassAndSpec()
    if not BiSCompanionBisData then
        return
    end

    UIDropDownMenu_SetSelectedValue(classDropdown, nil)
    UIDropDownMenu_SetSelectedValue(specDropdown, nil)
    UIDropDownMenu_SetText(classDropdown, "Select a class")
    UIDropDownMenu_SetText(specDropdown, "Select a spec")
    UIDropDownMenu_DisableDropDown(specDropdown)

    local playerClass, playerSpecKey = GetPlayerClassAndSpec()
    if playerClass then
        UIDropDownMenu_SetSelectedValue(classDropdown, playerClass)
        UIDropDownMenu_SetText(classDropdown, playerClass)
        UIDropDownMenu_EnableDropDown(specDropdown)
        UIDropDownMenu_Initialize(specDropdown, specDropdown.initialize)

        if playerSpecKey then
            UIDropDownMenu_SetSelectedValue(specDropdown, playerSpecKey)
            UIDropDownMenu_SetText(specDropdown, GetSpecName(playerSpecKey))
            DisplayItems(playerSpecKey)

            -- Étape 2 & 3 : Récupérer et stocker la liste des objets BiS
            local bisItems = BiSCompanionBisData[playerSpecKey]
            if bisItems then
                bisTable = {}
                for _, item in ipairs(bisItems) do
                    if type(item) == "table" and item.id and item.name and item.slot then
                        table.insert(bisTable, {
                            id = tonumber(item.id),
                            name = item.name,
                            slot = item.slot
                        })
                    end
                end
            else
                bisTable = {}
            end
        else
            bisTable = {}
        end
    else
        bisTable = {}
    end
end

-- Synchroniser avec CharacterFrame et pré-sélectionner
local function SyncWithCharacterFrame()
    if CharacterFrame:IsShown() then
        frame:Show()
        talentFrame:Show()
        PreselectPlayerClassAndSpec()
    else
        frame:Hide()
        talentFrame:Hide()
    end
end

-- Ajouter un tooltip générique uniquement pour les objets BiS
local function AddGenericTooltip(tooltip)
    if not tooltip:IsForbidden() then
        local _, itemLink = tooltip:GetItem()
        if itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                for _, bisItem in ipairs(bisTable) do
                    if bisItem.id == itemID then
                        local numLines = tooltip:NumLines()
                        local alreadyAdded = false
                        for i = 1, numLines do
                            local line = _G[tooltip:GetName() .. "TextLeft" .. i]
                            if line and line:GetText() == "!!! BiS Item for your spec !!!" then
                                alreadyAdded = true
                                break
                            end
                        end
                        if not alreadyAdded then
                            tooltip:AddLine("!!! BiS Item for your spec !!!", 0, 1, 1)
                        end
                        return
                    end
                end
            end
        end
    end
end

-- Événements
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")

-- Intégration dans ton gestionnaire d'événements
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_LOGIN" or (event == "ADDON_LOADED" and arg1 == "BiSCompanion") then
        C_Timer.After(1, SyncWithCharacterFrame)
        
        -- Ajout des hooks pour les tooltips sur tous les objets
        hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
            local _, itemLink = tooltip:GetItem()
            if itemLink then
                AddGenericTooltip(tooltip)
            end
        end)
        
        hooksecurefunc(GameTooltip, "SetInventoryItem", function(self, unit, slot)
            if unit and slot then
                AddGenericTooltip(self)
            end
        end)
        
        hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
            if bag and slot then
                AddGenericTooltip(self)
            end
        end)
        
        hooksecurefunc(GameTooltip, "SetLootItem", function(self, slot)
            if slot then
                AddGenericTooltip(self)
            end
        end)

        -- Hook pour les fenêtres de choix de butin en raid (Need/Greed)
        hooksecurefunc(GameTooltip, "SetLootRollItem", function(self, rollID)
            if rollID then
                local itemLink = GetLootRollItemLink(rollID)
                if itemLink then
                    local itemID = tonumber(itemLink:match("item:(%d+)"))
                    if itemID then
                        for _, bisItem in ipairs(bisTable) do
                            if bisItem.id == itemID then
                                local numLines = self:NumLines()
                                local alreadyAdded = false
                                for i = 1, numLines do
                                    local line = _G[self:GetName() .. "TextLeft" .. i]
                                    if line and line:GetText() == "!!! BiS Item for your spec !!!" then
                                        alreadyAdded = true
                                        break
                                    end
                                end
                                if not alreadyAdded then
                                    self:AddLine("!!! BiS Item for your spec !!!", 0, 1, 1)
                                end
                                return
                            end
                        end
                    end
                end
            end
        end)

        -- Hook pour les liens dans le chat
        for i = 1, NUM_CHAT_WINDOWS do
            local chatFrame = _G["ChatFrame" .. i]
            chatFrame:HookScript("OnHyperlinkEnter", function(self, link)
                if link and link:match("item:") then
                    local itemID = tonumber(link:match("item:(%d+)"))
                    if itemID then
                        for _, bisItem in ipairs(bisTable) do
                            if bisItem.id == itemID then
                                GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
                                GameTooltip:ClearLines()
                                GameTooltip:SetHyperlink(link)
                                GameTooltip:AddLine("!!! BiS Item for your spec !!!", 0, 1, 1)
                                GameTooltip:Show()
                                return
                            end
                        end
                    end
                end
            end)
            chatFrame:HookScript("OnHyperlinkLeave", function()
                GameTooltip:Hide()
            end)
        end
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player" then
        C_Timer.After(2, function()
            PreselectPlayerClassAndSpec()
            if CharacterFrame:IsShown() then
                SyncWithCharacterFrame()
            end
        end)
    elseif event == "PLAYER_TALENT_UPDATE" then
        C_Timer.After(2, function()
            PreselectPlayerClassAndSpec()
            if CharacterFrame:IsShown() then
                SyncWithCharacterFrame()
            end
        end)
    end
end)

-- Réajouter les hooks sur CharacterFrame
CharacterFrame:HookScript("OnShow", function()
    frame:Show()
    talentFrame:Show()
    PreselectPlayerClassAndSpec()
end)

CharacterFrame:HookScript("OnHide", function()
    frame:Hide()
    talentFrame:Hide()
end)