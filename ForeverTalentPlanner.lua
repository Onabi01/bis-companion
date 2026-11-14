-- BiSCompanion: read-only Forever talent planner.
-- Uses the live C_Traits layout and edges; never purchases/refunds a talent.
-- Icy Veins recommendations are immutable templates, not SavedVariables.
local addonName, addon = ...
addon.Core = addon.Core or {}
addon.Core.Talents = addon.Core.Talents or {}
local planner = addon.Core.Talents
local MAX_POINTS = 51
local RECOMMENDATIONS = BiSCompanionForeverIcyVeins or {talents = {}, builds = {}}

local function T(fr, en)
    return GetLocale and GetLocale() == "frFR" and fr or en
end
local frame = CreateFrame("Frame", "BiSCompanionForeverTalentPlanner", UIParent, "BasicFrameTemplateWithInset")
planner.frame = frame
frame:SetSize(738, 570)
frame:SetPoint("CENTER", UIParent, "CENTER")
frame:SetMovable(true)
frame:SetClampedToScreen(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
frame:Hide()

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("TOP", frame, "TOP", 0, -7)
title:SetText(T("Planificateur de talents Forever", "Forever Talent Planner"))

local buildDropdown = CreateFrame("Frame", "BiSCompanionForeverBuildDropdown", frame, "UIDropDownMenuTemplate")
buildDropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -29)
UIDropDownMenu_SetWidth(buildDropdown, 436)
UIDropDownMenu_SetText(buildDropdown, T("Choisir un build Icy Veins ou personnel", "Choose an Icy Veins or saved build"))

local countLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
countLabel:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -22, -38)
countLabel:SetText("0 / 51")

local instructions = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
instructions:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -79)
instructions:SetWidth(690)
instructions:SetJustifyH("LEFT")
instructions:SetText(T("Clic gauche : +1 · Clic droit : -1 · 51 points maximum · Les talents du personnage ne sont pas modifiés.",
    "Left-click: +1 · Right-click: -1 · Max 51 points · Your character's talents are never changed."))

local canvas = CreateFrame("Frame", nil, frame, "InsetFrameTemplate3")
canvas:SetPoint("TOPLEFT", frame, "TOPLEFT", 16, -103)
canvas:SetSize(706, 352)
local message = canvas:CreateFontString(nil, "OVERLAY", "GameFontNormal")
message:SetPoint("CENTER", canvas, "CENTER")
message:SetWidth(670)
message:SetText("")

local treeLabels = {}
for i = 1, 3 do
    local label = canvas:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", canvas, "TOPLEFT", 117 + (i - 1) * 232, -9)
    treeLabels[i] = label
end
for i = 1, 2 do
    local separator = canvas:CreateTexture(nil, "BACKGROUND")
    separator:SetColorTexture(0.6, 0.46, 0.19, 0.55)
    separator:SetSize(1, 301)
    separator:SetPoint("TOPLEFT", canvas, "TOPLEFT", i * 232 + 2, -38)
end

local status = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
status:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 18, 68)
status:SetWidth(696)
status:SetJustifyH("LEFT")
status:SetText("")

local function NewButton(text, x, width)
    local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    button:SetSize(width, 25)
    button:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", x, 21)
    button:SetText(text)
    return button
end
local newButton = NewButton(T("Nouveau", "New"), 19, 108)
local saveButton = NewButton(T("Sauvegarder", "Save build"), 135, 125)
local deleteButton = NewButton(T("Supprimer", "Delete"), 268, 107)
local refreshButton = NewButton(T("Actualiser", "Refresh"), 592, 128)

local saveDialog = CreateFrame("Frame", "BiSCompanionForeverSaveBuildDialog", UIParent, "BasicFrameTemplateWithInset")
saveDialog:SetSize(342, 150)
saveDialog:SetPoint("CENTER")
saveDialog:SetFrameStrata("DIALOG")
saveDialog:Hide()
local saveTitle = saveDialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
saveTitle:SetPoint("TOP", saveDialog, "TOP", 0, -18)
saveTitle:SetText(T("Nom du build personnel", "Name your personal build"))
local saveName = CreateFrame("EditBox", nil, saveDialog, "InputBoxTemplate")
saveName:SetSize(270, 25)
saveName:SetPoint("TOP", saveDialog, "TOP", 0, -54)
saveName:SetAutoFocus(false)
local confirmSave = CreateFrame("Button", nil, saveDialog, "UIPanelButtonTemplate")
confirmSave:SetSize(120, 24)
confirmSave:SetPoint("BOTTOMLEFT", saveDialog, "BOTTOMLEFT", 32, 18)
confirmSave:SetText(T("Enregistrer", "Save"))
local cancelSave = CreateFrame("Button", nil, saveDialog, "UIPanelButtonTemplate")
cancelSave:SetSize(120, 24)
cancelSave:SetPoint("BOTTOMRIGHT", saveDialog, "BOTTOMRIGHT", -32, 18)
cancelSave:SetText(T("Annuler", "Cancel"))
cancelSave:SetScript("OnClick", function() saveDialog:Hide() end)
saveName:SetScript("OnEscapePressed", function() saveDialog:Hide() end)

-- SavedVariables: the historic live plan is kept intact, and named copies use
-- a separate key so upgrading doesn't destroy pre-existing draft points.
local function DB()
    if type(BiSCompanionCustomData) ~= "table" then BiSCompanionCustomData = {} end
    local db = BiSCompanionCustomData
    if type(db.foreverTalentPlans) ~= "table" then db.foreverTalentPlans = {} end
    if type(db.foreverNamedTalentBuilds) ~= "table" then db.foreverNamedTalentBuilds = {} end
    if type(db.foreverTalentPlannerState) ~= "table" then db.foreverTalentPlannerState = {} end
    return db
end
local function CopyPoints(points)
    local copy = {}
    if type(points) == "table" then
        for id, rank in pairs(points) do
            id = tonumber(id)
            rank = tonumber(rank)
            if id and rank and rank > 0 and rank <= MAX_POINTS then copy[id] = math.floor(rank) end
        end
    end
    return copy
end

local currentClassID, currentClass, currentPlan, currentNodes, currentByID
local currentPreset, currentPersonal, currentSpec
local nodeButtons, edgeLines, nodePool, linePool = {}, {}, {}, {}
local currentSourceLabel = ""

local function Announce(text)
    status:SetText(text or "")
end
local function TotalPoints(plan)
    local count = 0
    for _, points in pairs(plan or {}) do count = count + (tonumber(points) or 0) end
    return count
end
local function TreePointsBefore(plan, treeIndex, row)
    local count = 0
    for _, n in ipairs(currentNodes or {}) do
        if n.tree == treeIndex and n.row < row then
            count = count + (tonumber(plan[n.id]) or 0)
        end
    end
    return count
end
local function EdgeRequirementsSatisfied(plan, node)
    local anySufficient = false
    local hasSufficient = false
    for _, edge in ipairs(node.incoming or {}) do
        local source = currentByID[edge.parent]
        local maxed = source and (tonumber(plan[source.id]) or 0) >= source.max
        if edge.kind == 3 and not maxed then return false end
        if edge.kind == 2 then
            hasSufficient = true
            if maxed then anySufficient = true end
        end
    end
    return not hasSufficient or anySufficient
end
local function IsValidPlan(plan)
    if TotalPoints(plan) > MAX_POINTS then return false, T("Limite de 51 points", "51-point limit") end
    for id, rank in pairs(plan) do
        local n = currentByID and currentByID[tonumber(id)]
        if not n or type(rank) ~= "number" or rank < 0 or rank > n.max then
            return false, T("Talent incompatible", "Incompatible talent")
        end
        if rank > 0 then
            if TreePointsBefore(plan, n.tree, n.row) < 5 * (n.row - 1) then
                return false, T("Niveau de talent verrouillé", "Talent tier is locked")
            end
            if not EdgeRequirementsSatisfied(plan, n) then
                return false, T("Prérequis manquant", "Missing prerequisite")
            end
        end
    end
    return true
end

local function NormalizedAxis(values)
    table.sort(values)
    local result, seen = {}, nil
    for _, v in ipairs(values) do
        if not seen or math.abs(v - seen) > 100 then
            result[#result + 1] = v
            seen = v
        end
    end
    return result
end
local function AxisIndex(axis, value)
    local idx, distance
    for i, n in ipairs(axis) do
        local d = math.abs(value - n)
        if not distance or d < distance then idx, distance = i, d end
    end
    return idx
end

local function GetTalentDisplay(configID, info)
    local entryID = info.activeEntry and info.activeEntry.entryID
    if not entryID then entryID = info.entryIDs and info.entryIDs[1] end
    local entry = entryID and C_Traits.GetEntryInfo(configID, entryID)
    local def = entry and entry.definitionID and C_Traits.GetDefinitionInfo(entry.definitionID)
    local spellID = def and def.spellID
    local spell = spellID and C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(spellID)
    return (def and def.overrideName) or (spell and spell.name) or T("Talent", "Talent"),
        (def and def.overrideIcon) or (spell and spell.iconID) or "Interface\\Icons\\INV_Misc_QuestionMark",
        spellID
end

-- Forever's classic three panes may be represented by ONE C_Traits tree.
-- Discover its two physical gutters instead of assuming #treeIDs == 3.
local function ReadCurrentTree()
    if not (C_ClassTalents and C_ClassTalents.GetActiveConfigID and C_Traits and
            C_Traits.GetConfigInfo and C_Traits.GetTreeNodes and C_Traits.GetNodeInfo) then
        return nil, T("API des talents indisponible", "Talent API unavailable")
    end
    local configID = C_ClassTalents.GetActiveConfigID()
    local config = configID and C_Traits.GetConfigInfo(configID)
    if not config or not config.treeIDs or #config.treeIDs == 0 then
        return nil, T("Ouvre l'arbre des talents du jeu puis réessaie.", "Open the game's Talents panel and try again.")
    end
    local nodes = {}
    for treeIndex, treeID in ipairs(config.treeIDs) do
        for _, id in ipairs(C_Traits.GetTreeNodes(treeID) or {}) do
            local info = C_Traits.GetNodeInfo(configID, id)
            if info and info.ID and info.ID ~= 0 and info.posX and info.posY
                and info.entryIDs and #info.entryIDs > 0 then
                local name, icon, spellID = GetTalentDisplay(configID, info)
                nodes[#nodes + 1] = {
                    id = id, info = info, name = name, icon = icon, spellID = spellID,
                    x = info.posX, y = info.posY, tree = treeIndex,
                    max = math.max(1, tonumber(info.maxRanks) or 1), incoming = {}
                }
            end
        end
    end
    if #nodes == 0 then return nil, T("Aucun talent détecté", "No talents detected") end
    if #config.treeIDs == 1 then
        local xs, gaps = {}, {}
        for _, node in ipairs(nodes) do xs[#xs + 1] = node.x end
        xs = NormalizedAxis(xs)
        for i = 1, #xs - 1 do gaps[#gaps + 1] = {index = i, amount = xs[i + 1] - xs[i]} end
        table.sort(gaps, function(a, b) return a.amount > b.amount end)
        if #gaps < 3 or gaps[2].amount <= gaps[3].amount * 1.5 then
            return nil, T("Disposition des 3 arbres inconnue : aucun point modifié.",
                "Unknown three-tree layout: no points were changed.")
        end
        local i1, i2 = gaps[1].index, gaps[2].index
        if i1 > i2 then i1, i2 = i2, i1 end
        local split1, split2 = (xs[i1] + xs[i1 + 1]) / 2, (xs[i2] + xs[i2 + 1]) / 2
        for _, n in ipairs(nodes) do n.tree = n.x < split1 and 1 or (n.x < split2 and 2 or 3) end
    elseif #config.treeIDs ~= 3 then
        return nil, T("Disposition des talents non reconnue", "Unrecognized talent-tree layout")
    end
    local byID, byPosition = {}, {}
    for _, n in ipairs(nodes) do byID[n.id] = n end
    for tree = 1, 3 do
        local xs, ys = {}, {}
        for _, n in ipairs(nodes) do
            if n.tree == tree then
                xs[#xs + 1] = n.x
                ys[#ys + 1] = n.y
            end
        end
        xs, ys = NormalizedAxis(xs), NormalizedAxis(ys)
        if #xs < 3 or #xs > 4 or #ys ~= 7 then
            return nil, T("Arbre Forever différent des données prévues", "Forever layout differs from recorded talent data")
        end
        for _, n in ipairs(nodes) do
            if n.tree == tree then
                n.col, n.row = AxisIndex(xs, n.x), AxisIndex(ys, n.y)
                local key = tree .. ":" .. n.row .. ":" .. n.col
                if byPosition[key] then return nil, T("Positions de talents ambiguës", "Ambiguous talent positions") end
                byPosition[key] = n
            end
        end
    end
    for _, n in ipairs(nodes) do
        for _, edge in ipairs(n.info.visibleEdges or {}) do
            local target = byID[edge.targetNode]
            if target then
                target.incoming[#target.incoming + 1] = {parent = n.id, kind = edge.type}
            end
        end
    end
    return nodes, byID, byPosition
end

local function UpdateVisuals()
    local total = TotalPoints(currentPlan)
    countLabel:SetText(total .. " / " .. MAX_POINTS)
    for _, n in ipairs(currentNodes or {}) do
        local button = nodeButtons[n.id]
        if button then
            local rank = tonumber(currentPlan[n.id]) or 0
            button.rank:SetText(rank .. "/" .. n.max)
            button.icon:SetDesaturated(rank == 0)
            local gate = TreePointsBefore(currentPlan, n.tree, n.row) >= (n.row - 1) * 5
            local edge = EdgeRequirementsSatisfied(currentPlan, n)
            if rank > 0 then button.border:SetVertexColor(1, 0.81, 0.1)
            elseif gate and edge and total < MAX_POINTS then button.border:SetVertexColor(0.25, 0.85, 0.35)
            else button.border:SetVertexColor(0.35, 0.35, 0.35) end
        end
    end
    for _, item in ipairs(edgeLines) do
        local parent = currentByID[item.parent]
        if parent and (tonumber(currentPlan[parent.id]) or 0) >= parent.max then
            item.line:SetColorTexture(0.93, 0.72, 0.2, 0.88)
        else
            item.line:SetColorTexture(0.34, 0.34, 0.34, 0.8)
        end
    end
end

local function SelectPlan(points, name, spec, personal)
    local proposal = CopyPoints(points)
    local valid, errorMessage = IsValidPlan(proposal)
    if not valid then
        Announce(T("Build incompatible avec les talents du client : ", "Build incompatible with client talents: ") .. (errorMessage or ""))
        return false
    end
    wipe(currentPlan)
    for id, rank in pairs(proposal) do currentPlan[id] = rank end
    currentSourceLabel = name or ""
    currentSpec = spec
    currentPersonal = personal
    UpdateVisuals()
    UIDropDownMenu_SetText(buildDropdown, currentSourceLabel)
    Announce(T("Build chargé (copie modifiable) : ", "Loaded editable copy: ") .. currentSourceLabel)
    return true
end

local function PlanFromPreset(build)
    local layout = RECOMMENDATIONS.talents[currentClass]
    if not layout or not currentNodes then return nil, "No layout available" end
    local lookup = {}
    for _, n in ipairs(currentNodes) do lookup[n.tree .. ":" .. n.row .. ":" .. n.col] = n end
    local result, checked, matched = {}, 0, 0
    for treeIndex, sourceTree in ipairs(layout) do
        local encoded = build.ranks[treeIndex]
        if type(encoded) ~= "string" or #encoded ~= #sourceTree then return nil, "Tree size changed" end
        for i, source in ipairs(sourceTree) do
            local rank = tonumber(encoded:sub(i, i))
            if not rank then return nil, "Malformed source ranks" end
            local n = lookup[treeIndex .. ":" .. source[3] .. ":" .. source[4]]
            if not n or n.max ~= source[5] then return nil, "Node positions or maximum ranks changed" end
            if source[2] > 0 and n.spellID then
                checked = checked + 1
                if n.spellID == source[2] then matched = matched + 1 end
            end
            if rank > 0 then result[n.id] = rank end
        end
    end
    -- Also reject a layout with extra game nodes. The source has 467 nodes over
    -- 9 classes; a future Forever tree change must not silently misapply ranks.
    local expected = 0
    for _, tree in ipairs(layout) do expected = expected + #tree end
    if expected ~= #currentNodes then return nil, "The number of talents changed" end
    if checked >= 8 and matched / checked < 0.7 then return nil, "Talent spell IDs changed" end
    return result
end

local function SavedForClass()
    local db = DB()
    local key = tostring(currentClassID)
    db.foreverNamedTalentBuilds[key] = db.foreverNamedTalentBuilds[key] or {}
    return db.foreverNamedTalentBuilds[key]
end
local function UpdateMenu()
    UIDropDownMenu_Initialize(buildDropdown, function()
        if not currentClassID then return end
        local titleInfo = UIDropDownMenu_CreateInfo()
        titleInfo.text = "Icy Veins"
        titleInfo.isTitle = true
        titleInfo.notCheckable = true
        UIDropDownMenu_AddButton(titleInfo)
        for _, build in ipairs((RECOMMENDATIONS.builds or {})[currentClass] or {}) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = "[" .. build.spec .. "] " .. build.name
            info.notCheckable = true
            info.func = function()
                local plan, reason = PlanFromPreset(build)
                if not plan then
                    Announce(T("Modèle incompatible : ", "Preset not applied: ") .. (reason or ""))
                    return
                end
                if SelectPlan(plan, "Icy Veins: " .. build.name, build.spec, nil) then
                    currentPreset = build
                end
            end
            UIDropDownMenu_AddButton(info)
        end
        local saved = SavedForClass()
        local names = {}
        for name in pairs(saved) do names[#names + 1] = name end
        table.sort(names)
        if #names > 0 then
            local sep = UIDropDownMenu_CreateInfo()
            sep.text = T("Mes builds", "My saved builds")
            sep.isTitle = true
            sep.notCheckable = true
            UIDropDownMenu_AddButton(sep)
            for _, name in ipairs(names) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = name
                info.notCheckable = true
                info.func = function()
                    local entry = SavedForClass()[name]
                    if entry and SelectPlan(entry.points, name, entry.spec, name) then currentPreset = nil end
                end
                UIDropDownMenu_AddButton(info)
            end
        end
    end)
end

local function ClearBoard()
    for _, button in ipairs(nodePool) do button:Hide() end
    for _, line in ipairs(linePool) do line:Hide() end
    wipe(nodeButtons)
    wipe(edgeLines)
    for _, label in ipairs(treeLabels) do label:SetText("") end
end

local function NewNodeButton(index)
    if nodePool[index] then return nodePool[index] end
    local button = CreateFrame("Button", nil, canvas)
    button:SetSize(30, 30)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetAllPoints()
    button.border = button:CreateTexture(nil, "OVERLAY")
    button.border:SetTexture("Interface\\Buttons\\WHITE8X8")
    button.border:SetPoint("TOPLEFT", -2, 2)
    button.border:SetPoint("BOTTOMRIGHT", 2, -2)
    button.border:SetDrawLayer("BORDER")
    button.rank = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    button.rank:SetPoint("BOTTOMRIGHT", 5, -4)
    nodePool[index] = button
    return button
end
local function RenderTree()
    ClearBoard()
    message:SetText("")
    local names = {}
    for _, mapping in ipairs(BiSCompanionClassSpecMapping or {}) do
        if mapping.classID == currentClassID then names[#names + 1] = mapping.specName end
    end
    for i = 1, 3 do treeLabels[i]:SetText(names[i] or (T("Arbre ", "Tree ") .. i)) end
    for i, n in ipairs(currentNodes) do
        local button = NewNodeButton(i)
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", canvas, "TOPLEFT", 25 + (n.tree - 1) * 232 + (n.col - 1) * 47, -38 - (n.row - 1) * 45)
        button.icon:SetTexture(n.icon)
        button:SetScript("OnClick", function(_, mouseButton)
            local before = tonumber(currentPlan[n.id]) or 0
            local nextRank = before + (mouseButton == "RightButton" and -1 or 1)
            if nextRank < 0 or nextRank > n.max then return end
            local newPlan = CopyPoints(currentPlan)
            newPlan[n.id] = nextRank > 0 and nextRank or nil
            local valid, problem = IsValidPlan(newPlan)
            if not valid then Announce(problem); return end
            currentPlan[n.id] = nextRank > 0 and nextRank or nil
            currentPersonal = nil  -- source entry stays immutable; working copy changed
            currentPreset = nil
            UpdateVisuals()
            Announce(T("Build modifié : sauvegarde-le pour le conserver sous un nom.",
                "Build edited: save a named copy to keep it."))
        end)
        button:SetScript("OnEnter", function(self)
            local rank = tonumber(currentPlan[n.id]) or 0
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(n.name)
            GameTooltip:AddLine(T("Prévu : ", "Planned: ") .. rank .. "/" .. n.max, 1, 0.82, 0)
            GameTooltip:AddLine(T("En jeu : ", "In game: ") .. tostring(n.info.currentRank or 0) .. "/" .. n.max, 0.4, 0.85, 0.4)
            if n.row > 1 then
                GameTooltip:AddLine(T("Déblocage : ", "Requires: ") .. ((n.row - 1) * 5) ..
                    T(" points dans les rangées précédentes", " points in earlier tiers"), 0.85, 0.85, 0.85)
            end
            if #n.incoming > 0 then
                for _, edge in ipairs(n.incoming) do
                    if edge.kind == 2 or edge.kind == 3 then
                        local p = currentByID[edge.parent]
                        if p then GameTooltip:AddLine(T("Prérequis : ", "Prerequisite: ") .. p.name .. " (" .. p.max .. "/" .. p.max .. ")", 0.95, 0.8, 0.35) end
                    end
                end
            end
            GameTooltip:AddLine(T("Planification uniquement : aucun talent acheté en jeu.",
                "Planner only: does not purchase in-game talents."), 0.68, 0.68, 0.68)
            GameTooltip:Show()
        end)
        button:SetScript("OnLeave", function() GameTooltip:Hide() end)
        button:Show()
        nodeButtons[n.id] = button
    end
    -- Draw actual TraitOutEdgeInfo connections. If this Forever build has no
    -- CreateLine API, the tier/prerequisite rules still work without arrows.
    if canvas.CreateLine then
        local index = 0
        for _, parent in ipairs(currentNodes) do
            for _, edge in ipairs(parent.info.visibleEdges or {}) do
                local target = currentByID[edge.targetNode]
                if target and nodeButtons[parent.id] and nodeButtons[target.id] then
                    index = index + 1
                    local line = linePool[index]
                    if not line then
                        line = canvas:CreateLine(nil, "BORDER")
                        line:SetThickness(2)
                        linePool[index] = line
                    end
                    line:SetStartPoint("CENTER", nodeButtons[parent.id], 0, 0)
                    line:SetEndPoint("CENTER", nodeButtons[target.id], 0, 0)
                    line:Show()
                    edgeLines[#edgeLines + 1] = {line = line, parent = parent.id}
                end
            end
        end
    end
    UpdateVisuals()
end

local function ChooseSuggestedSpec()
    local dropdown = _G["BiSCompanionSpecDropdown"]
    local selected = dropdown and UIDropDownMenu_GetSelectedValue and UIDropDownMenu_GetSelectedValue(dropdown)
    if selected then
        for _, m in ipairs(BiSCompanionClassSpecMapping or {}) do
            if m.specKey == selected and m.classID == currentClassID then return m.specName end
        end
    end
end
function planner.DisplayTalents()
    ClearBoard()
    currentClass, currentClassID = select(2, UnitClass("player")), select(3, UnitClass("player"))
    currentNodes, currentByID = nil, nil
    if not currentClassID then message:SetText(T("Classe indisponible", "Class unavailable")); return end
    local nodes, byID, byPosition = ReadCurrentTree()
    if not nodes then
        message:SetText(byID or T("Arbre indisponible", "Talent tree unavailable"))
        Announce(T("Aucune donnée enregistrée n'a été modifiée.", "No saved data has been modified."))
        return
    end
    currentNodes, currentByID = nodes, byID
    local db = DB()
    local key = tostring(currentClassID)
    db.foreverTalentPlans[key] = db.foreverTalentPlans[key] or {}
    currentPlan = db.foreverTalentPlans[key]
    currentPersonal = nil
    currentPreset = nil
    RenderTree()
    UpdateMenu()
    if db.foreverTalentPlannerState[key] then
        UIDropDownMenu_SetText(buildDropdown, db.foreverTalentPlannerState[key])
    elseif next(currentPlan) then
        UIDropDownMenu_SetText(buildDropdown, T("Plan précédent", "Previous plan"))
    else
        -- A relevant Icy Veins build is the first suggested default for a
        -- newly used class, not a destructive migration of an existing plan.
        local choice, selectedSpec = nil, ChooseSuggestedSpec()
        for _, build in ipairs((RECOMMENDATIONS.builds or {})[currentClass] or {}) do
            if build.spec == selectedSpec then choice = build; break end
        end
        if choice then
            local points = PlanFromPreset(choice)
            if points and SelectPlan(points, "Icy Veins: " .. choice.name, choice.spec, nil) then
                currentPreset = choice
            end
        end
    end
    UpdateVisuals()
end

newButton:SetScript("OnClick", function()
    if not currentPlan then return end
    SelectPlan({}, T("Nouveau build", "New build"), nil, nil)
    currentPreset = nil
end)
saveButton:SetScript("OnClick", function()
    if not currentPlan then return end
    saveName:SetText(currentPersonal or "")
    saveDialog:Show()
    saveName:SetFocus()
end)
confirmSave:SetScript("OnClick", function()
    if not currentClassID or not currentPlan then return end
    local name = (saveName:GetText() or ""):match("^%s*(.-)%s*$")
    if name == "" or #name > 64 then
        Announce(T("Donne un nom de 1 à 64 caractères.", "Use a name of 1-64 characters."))
        return
    end
    local valid, problem = IsValidPlan(currentPlan)
    if not valid then Announce(problem); return end
    local stored = SavedForClass()
    stored[name] = {points = CopyPoints(currentPlan), spec = currentSpec}
    currentPersonal, currentPreset, currentSourceLabel = name, nil, name
    DB().foreverTalentPlannerState[tostring(currentClassID)] = name
    UIDropDownMenu_SetText(buildDropdown, name)
    saveDialog:Hide()
    UpdateMenu()
    Announce(T("Build sauvegardé : ", "Saved build: ") .. name)
end)
saveName:SetScript("OnEnterPressed", function() confirmSave:Click() end)
deleteButton:SetScript("OnClick", function()
    if not currentPersonal then
        Announce(T("Sélectionne un build personnel à supprimer (pas un modèle Icy Veins).",
            "Select a saved personal build to delete (not an Icy Veins preset)."))
        return
    end
    SavedForClass()[currentPersonal] = nil
    DB().foreverTalentPlannerState[tostring(currentClassID)] = nil
    Announce(T("Build personnel supprimé : ", "Deleted personal build: ") .. currentPersonal)
    currentPersonal = nil
    UpdateMenu()
    UIDropDownMenu_SetText(buildDropdown, T("Plan actuel non enregistré", "Unsaved current plan"))
end)
refreshButton:SetScript("OnClick", function() planner.DisplayTalents() end)

function planner.Show()
    frame:Show()
    planner.DisplayTalents()
end
function planner.Hide() frame:Hide() end
function planner.Toggle()
    if frame:IsShown() then planner.Hide() else planner.Show() end
end
