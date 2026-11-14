-- Read-only talent planner for Forever. It never purchases or refunds game talents.
local addonName, addon = ...
addon.Core = addon.Core or {}
addon.Core.Talents = addon.Core.Talents or {}

local planner = addon.Core.Talents
local frame = CreateFrame("Frame", "BiSCompanionForeverTalentPlanner", UIParent, "BasicFrameTemplateWithInset")
planner.frame = frame
frame:SetSize(710, 500)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
frame:SetMovable(true)
frame:SetClampedToScreen(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
frame:Hide()

frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.title:SetPoint("TOP", 0, -6)
frame.title:SetText("Forever Talent Planner")

local instructions = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
instructions:SetPoint("TOPLEFT", 16, -30)
instructions:SetWidth(670)
instructions:SetJustifyH("LEFT")
instructions:SetText("Left-click: add a planned rank. Right-click: remove one. Copy the gold numbers into the real talent tree.")

local canvas = CreateFrame("Frame", nil, frame, "InsetFrameTemplate3")
canvas:SetPoint("TOPLEFT", 16, -58)
canvas:SetSize(676, 370)

local message = canvas:CreateFontString(nil, "OVERLAY", "GameFontNormal")
message:SetPoint("CENTER", canvas, "CENTER")
message:SetWidth(610)
message:SetText("")

local treeLabels = {}
for i = 1, 3 do
    local label = canvas:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", canvas, "TOPLEFT", 113 + (i - 1) * 225, -8)
    treeLabels[i] = label
end
for i = 1, 2 do
    local divider = canvas:CreateTexture(nil, "ARTWORK")
    divider:SetColorTexture(0.55, 0.4, 0.15, 0.55)
    divider:SetSize(1, 320)
    divider:SetPoint("TOPLEFT", canvas, "TOPLEFT", 225 * i, -40)
end

local buttons = {}
local currentClassID

local function GetSavedPlan(classID)
    if type(BiSCompanionCustomData) ~= "table" then BiSCompanionCustomData = {} end
    if type(BiSCompanionCustomData.foreverTalentPlans) ~= "table" then
        BiSCompanionCustomData.foreverTalentPlans = {}
    end
    local key = tostring(classID)
    local plans = BiSCompanionCustomData.foreverTalentPlans
    if type(plans[key]) ~= "table" then plans[key] = {} end
    return plans[key]
end

local function GetTalentDisplay(configID, nodeInfo)
    local entryID = nodeInfo.activeEntry and nodeInfo.activeEntry.entryID
    if not entryID then entryID = nodeInfo.entryIDs and nodeInfo.entryIDs[1] end
    local entry = entryID and C_Traits.GetEntryInfo(configID, entryID)
    local definition = entry and entry.definitionID and C_Traits.GetDefinitionInfo(entry.definitionID)
    local spellID = definition and definition.spellID
    local spell = spellID and C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(spellID)
    return (definition and definition.overrideName) or (spell and spell.name) or "Talent", 
        (definition and definition.overrideIcon) or (spell and spell.iconID) or "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function ClearButtons()
    for _, button in ipairs(buttons) do button:Hide() end
    wipe(buttons)
end

local function UpdateButton(button, rank, maxRanks)
    button.rank:SetText(rank .. "/" .. maxRanks)
    button.icon:SetDesaturated(rank == 0)
    button.border:SetVertexColor(rank > 0 and 1 or 0.3, rank > 0 and 0.8 or 0.3, 0)
end

function planner.DisplayTalents()
    ClearButtons()
    message:SetText("")
    for _, label in ipairs(treeLabels) do label:SetText("") end

    if not (C_ClassTalents and C_ClassTalents.GetActiveConfigID and C_Traits) then
        message:SetText("Forever talent data is not available in this client.")
        return
    end
    local configID = C_ClassTalents.GetActiveConfigID()
    local config = configID and C_Traits.GetConfigInfo(configID)
    if not config or not config.treeIDs then
        message:SetText("Open the game's Talents panel, then reopen this planner.")
        return
    end

    local classID = select(3, UnitClass("player"))
    if not classID then
        message:SetText("Could not identify the player's class.")
        return
    end
    currentClassID = classID
    local plan = GetSavedPlan(classID)
    local names = {}
    for _, mapping in ipairs(BiSCompanionClassSpecMapping or {}) do
        if mapping.classID == classID then table.insert(names, mapping.specName) end
    end
    for i, label in ipairs(treeLabels) do label:SetText(names[i] or "") end

    local nodes = {}
    local minX, maxX, minY, maxY
    local separateTrees = #config.treeIDs == 3
    local bounds = {}
    for treeIndex, treeID in ipairs(config.treeIDs) do
        for _, nodeID in ipairs(C_Traits.GetTreeNodes(treeID) or {}) do
            local info = C_Traits.GetNodeInfo(configID, nodeID)
            if info and info.ID and info.ID ~= 0 and info.posX and info.posY and
                    info.entryIDs and #info.entryIDs > 0 then
                table.insert(nodes, { id = nodeID, info = info, treeIndex = treeIndex })
                minX = minX and math.min(minX, info.posX) or info.posX
                maxX = maxX and math.max(maxX, info.posX) or info.posX
                minY = minY and math.min(minY, info.posY) or info.posY
                maxY = maxY and math.max(maxY, info.posY) or info.posY
                local bound = bounds[treeIndex] or { minX = info.posX, maxX = info.posX }
                bound.minX = math.min(bound.minX, info.posX)
                bound.maxX = math.max(bound.maxX, info.posX)
                bounds[treeIndex] = bound
            end
        end
    end
    if #nodes == 0 then
        message:SetText("No talent nodes were returned by the game.")
        return
    end

    local xSpan = math.max(1, maxX - minX)
    local ySpan = math.max(1, maxY - minY)
    for _, node in ipairs(nodes) do
        local nodeID = node.id
        local info = node.info
        local x = 15 + (info.posX - minX) / xSpan * 625
        if separateTrees then
            local bound = bounds[node.treeIndex]
            x = 15 + (node.treeIndex - 1) * 225 +
                (info.posX - bound.minX) / math.max(1, bound.maxX - bound.minX) * 175
        end
        local button = CreateFrame("Button", nil, canvas)
        button:SetSize(30, 30)
        button:SetPoint("TOPLEFT", canvas, "TOPLEFT",
            x,
            -42 - (info.posY - minY) / ySpan * 280)
        button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        button.icon = button:CreateTexture(nil, "ARTWORK")
        button.icon:SetAllPoints()
        local talentName, talentIcon = GetTalentDisplay(configID, info)
        button.icon:SetTexture(talentIcon)
        button.border = button:CreateTexture(nil, "OVERLAY")
        button.border:SetTexture("Interface\\Buttons\\WHITE8X8")
        button.border:SetPoint("TOPLEFT", -2, 2)
        button.border:SetPoint("BOTTOMRIGHT", 2, -2)
        button.border:SetDrawLayer("BORDER")
        button.rank = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        button.rank:SetPoint("BOTTOMRIGHT", 5, -4)
        local maxRanks = math.max(1, info.maxRanks or 1)
        local planned = math.min(maxRanks, tonumber(plan[nodeID]) or 0)
        UpdateButton(button, planned, maxRanks)
        button:SetScript("OnClick", function(self, mouseButton)
            local nextRank = tonumber(plan[nodeID]) or 0
            if mouseButton == "RightButton" then
                nextRank = math.max(0, nextRank - 1)
            else
                nextRank = math.min(maxRanks, nextRank + 1)
            end
            plan[nodeID] = nextRank > 0 and nextRank or nil
            UpdateButton(self, nextRank, maxRanks)
        end)
        button:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(talentName)
            GameTooltip:AddLine("Planned: " .. (tonumber(plan[nodeID]) or 0) .. "/" .. maxRanks, 1, 0.82, 0)
            GameTooltip:AddLine("In game: " .. (info.currentRank or 0) .. "/" .. maxRanks, 0.6, 1, 0.6)
            GameTooltip:AddLine("This planner does not change your real talents.", 0.8, 0.8, 0.8)
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function() GameTooltip:Hide() end)
        table.insert(buttons, button)
    end
end

local clear = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
clear:SetSize(110, 24)
clear:SetPoint("BOTTOMLEFT", 16, 15)
clear:SetText("Clear plan")
clear:SetScript("OnClick", function()
    if not currentClassID then return end
    local plan = GetSavedPlan(currentClassID)
    wipe(plan)
    planner.DisplayTalents()
end)

local refresh = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
refresh:SetSize(110, 24)
refresh:SetPoint("BOTTOMRIGHT", -16, 15)
refresh:SetText("Refresh")
refresh:SetScript("OnClick", function() planner.DisplayTalents() end)

function planner.Show()
    planner.DisplayTalents()
    frame:Show()
end
function planner.Hide() frame:Hide() end
function planner.Toggle()
    if frame:IsShown() then planner.Hide() else planner.Show() end
end
