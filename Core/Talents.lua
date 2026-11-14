-- Core/Talents.lua
-- Gère la frame des talents et l'affichage pour BiSCompanion (texte cliquable, pas de boutons)
-- Fenêtre cachée par défaut ; ouverture seulement via appel explicite (ex: addon.Core.Talents.Show())

local addonName, addon = ...
addon.Core = addon.Core or {}
addon.Core.Talents = addon.Core.Talents or {}
addon.Core.UI = addon.Core.UI or {}
addon.Core.Data = addon.Core.Data or {}

-- Flag d'affichage : caché par défaut
if addon.Core.Data.showTalents == nil then
    addon.Core.Data.showTalents = false
end

-- Petite utilitaire pour récupérer la spé courante si rien n'est passé
local function getCurrentSpecKey(specKey)
    if specKey then return specKey end
    if type(UIDropDownMenu_GetSelectedValue) == "function" and _G["BiSCompanionSpecDropdown"] then
        local k = UIDropDownMenu_GetSelectedValue(_G["BiSCompanionSpecDropdown"])
        if k then return k end
    end
    if addon.Core and addon.Core.Character and addon.Core.Character.GetPlayerClassAndSpec then
        local _, k = addon.Core.Character.GetPlayerClassAndSpec()
        return k
    end
end

-- Création de la frame Talents (cachée par défaut)
local anchorFrame = (addon.Core.UI and addon.Core.UI.frame) or UIParent
local talentsFrame = CreateFrame("Frame", "BiSCompanionTalentsFrame", UIParent, "BasicFrameTemplateWithInset")
addon.Core.Talents.frame = talentsFrame
talentsFrame:SetSize(290, 160)
talentsFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 5, 0)
talentsFrame:Hide()

-- Rend la fenêtre "Talent Builds" déplaçable
talentsFrame:SetMovable(true)
talentsFrame:EnableMouse(true)
talentsFrame:RegisterForDrag("LeftButton")
talentsFrame:SetClampedToScreen(true)
talentsFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
talentsFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

-- Titre
talentsFrame.title = talentsFrame:CreateFontString(nil, "OVERLAY")
talentsFrame.title:SetFontObject("GameFontHighlight")
talentsFrame.title:SetPoint("TOP", talentsFrame, "TOP", 0, -5)
talentsFrame.title:SetText("Talent Builds")

-- Fond
talentsFrame.background = talentsFrame:CreateTexture(nil, "BACKGROUND")
talentsFrame.background:SetAllPoints(talentsFrame)
talentsFrame.background:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble")
talentsFrame.background:SetAlpha(0.7)

-- Scroll
local talentScrollFrame = CreateFrame("ScrollFrame", "BiSCompanionTalentScrollFrame", talentsFrame, "UIPanelScrollFrameTemplate")
talentScrollFrame:SetPoint("TOPLEFT", talentsFrame, "TOPLEFT", 10, -30)
talentScrollFrame:SetPoint("BOTTOMRIGHT", talentsFrame, "BOTTOMRIGHT", -30, 10)

local talentScrollChild = CreateFrame("Frame", "BiSCompanionTalentScrollChild", talentScrollFrame)
talentScrollChild:SetSize(260, 1)
talentScrollFrame:SetScrollChild(talentScrollChild)

-- Nettoyage des anciennes lignes
local function ClearTalentRows()
    if talentScrollChild.talentRows then
        for _, row in ipairs(talentScrollChild.talentRows) do
            row:Hide()
        end
    end
    talentScrollChild.talentRows = {}
end

-- Fenêtre de copie (utilitaire)
local function ShowCopyFrame(importCode)
    local copyFrame = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplateWithInset")
    copyFrame:SetSize(320, 110)
    copyFrame:SetPoint("CENTER")
    copyFrame:SetMovable(true)
    copyFrame:EnableMouse(true)
    copyFrame:SetScript("OnMouseDown", function(self, mouseButton)
        if mouseButton == "LeftButton" then
            self:StartMoving()
        end
    end)
    copyFrame:SetScript("OnMouseUp", function(self)
        self:StopMovingOrSizing()
    end)

    local title = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOP", copyFrame, "TOP", 0, -6)
    title:SetText("Copy Talent's code")

    local editBox = CreateFrame("EditBox", nil, copyFrame, "InputBoxTemplate")
    editBox:SetSize(300, 22)
    editBox:SetPoint("TOP", copyFrame, "TOP", 0, -34)
    editBox:SetAutoFocus(true)
    editBox:SetText(importCode or "")
    editBox:HighlightText()
    editBox:SetScript("OnEscapePressed", function(self) copyFrame:Hide() end)
    editBox:SetScript("OnEnterPressed", function(self) copyFrame:Hide() end)

    local instruction = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    instruction:SetPoint("BOTTOM", copyFrame, "BOTTOM", 0, 10)
    instruction:SetText("Ctrl+C to copy, then Enter or Escape to close")
end

-- Affichage des talents : crée des LIGNES DE TEXTE cliquables (pas de bouton visuel)
function addon.Core.Talents.DisplayTalents(specKey)
    ClearTalentRows()

    if not BiSCompanionTalentData then
        talentScrollChild:SetHeight(20)
        return
    end

    local key = getCurrentSpecKey(specKey)
    if not key then
        talentScrollChild:SetHeight(20)
        return
    end

    local talents = BiSCompanionTalentData[key]
    if not talents or #talents == 0 then
        local noTalentsText = talentScrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noTalentsText:SetPoint("TOPLEFT", 0, -5)
        noTalentsText:SetWidth(260)
        noTalentsText:SetJustifyH("LEFT")
        noTalentsText:SetText("No talent defined for this spec.")
        talentScrollChild.talentRows = { noTalentsText }
        talentScrollChild:SetHeight(20)
        return
    end

    local y = -2
    local lineHeight = 18
    local totalHeight = 0
    talentScrollChild.talentRows = {}

    for i, t in ipairs(talents) do
        local row = CreateFrame("Frame", nil, talentScrollChild)
        row:SetSize(260, lineHeight)
        row:SetPoint("TOPLEFT", 0, y)
        row:EnableMouse(true)

        local fs = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("LEFT", row, "LEFT", 0, 0)
        fs:SetWidth(260)
        fs:SetJustifyH("LEFT")
        fs:SetText((t.buildName or "Build") .. (t.heroTree and (" (" .. t.heroTree .. ")") or ""))

        -- survol : léger highlight
        row:SetScript("OnEnter", function()
            fs:SetTextColor(1, 0.82, 0) -- doré
            GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
            GameTooltip:SetText("Click to copy the import code", 1, 1, 1)
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function()
            fs:SetTextColor(1, 1, 1)
            GameTooltip:Hide()
        end)

        -- clic : fenêtre de copie
        row:SetScript("OnMouseUp", function(_, btn)
            if btn == "LeftButton" then
                ShowCopyFrame(t.importCode or "")
            end
        end)

        table.insert(talentScrollChild.talentRows, row)
        y = y - lineHeight
        totalHeight = totalHeight + lineHeight
    end

    talentScrollChild:SetHeight(math.max(20, totalHeight + 4))
end

-- Hooks pour forcer caché par défaut si un :Show() sauvage se produit
talentsFrame:HookScript("OnShow", function(frame)
    if not addon.Core.Data.showTalents then
        frame:Hide()
    end
end)
talentsFrame:HookScript("OnHide", function()
    addon.Core.Data.showTalents = false
end)

-- Fermer automatiquement quand la fenêtre de perso / ou la frame principale de l'addon se ferme
local function hookCloseWith(frame)
    if frame and not frame.__BiSCompanionTalentsHooked then
        frame.__BiSCompanionTalentsHooked = true
        frame:HookScript("OnHide", function() addon.Core.Talents.Hide() end)
    end
end
-- Hook après création (CharacterFrame peut ne pas être dispo immédiatement)
if CharacterFrame then
    hookCloseWith(CharacterFrame)
else
    C_Timer.After(0, function() hookCloseWith(CharacterFrame) end)
end
hookCloseWith(addon.Core.UI and addon.Core.UI.frame)

-- API publique (ouvrir/fermer)
function addon.Core.Talents.Show(specKey)
    addon.Core.Data.showTalents = true
    addon.Core.Talents.DisplayTalents(specKey)
    talentsFrame:Show()
end

function addon.Core.Talents.Hide()
    addon.Core.Data.showTalents = false
    talentsFrame:Hide()
end

function addon.Core.Talents.Toggle(specKey)
    if addon.Core.Data.showTalents then
        addon.Core.Talents.Hide()
    else
        addon.Core.Talents.Show(specKey)
    end
end
