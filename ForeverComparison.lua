-- Forever-only side-by-side comparison of the real talent window and the planner.
-- The Blizzard window is never modified permanently; its scale and anchors
-- are restored whenever comparison ends or either window closes.
local addonName, addon = ...
if not BiSCompanionForever then return end
local planner = addon.Core and addon.Core.Talents
if not planner or not planner.frame then return end

local frame = planner.frame
local function T(fr, en)
    return GetLocale and GetLocale() == "frFR" and fr or en
end
local function Notify(text)
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00BiSCompanion:|r " .. text)
    end
end
local function IsInCombat()
    return InCombatLockdown and InCombatLockdown()
end

-- The existing buttons occupy x=19..375 and x=592..720.
local compareButton = CreateFrame("Button", "BiSCompanionForeverCompareButton", frame, "UIPanelButtonTemplate")
compareButton:SetSize(202, 25)
compareButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 382, 21)
local function UpdateButton(active)
    compareButton:SetText(active and T("Quitter comparaison", "Exit comparison")
        or T("Mode comparaison", "Compare side by side"))
end
UpdateButton(false)
compareButton:SetScript("OnEnter", function(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:SetText(T("Comparer les talents", "Compare talents"))
    GameTooltip:AddLine(T("Place les talents du jeu a gauche et le planificateur a droite. Restaure les fenetres a la sortie.",
        "Place game talents on the left and the planner on the right. Restore both windows on exit."), 1, 1, 1, true)
    GameTooltip:Show()
end)
compareButton:SetScript("OnLeave", function()
    if GameTooltip then GameTooltip:Hide() end
end)

local comparison, pendingRestore = nil, false
local hookedGameWindows = {}
local hookedTalentPanes = {}

local function Capture(window)
    local snapshot = {frame = window, scale = window:GetScale(), points = {}}
    for i = 1, window:GetNumPoints() do
        local point, relative, relativePoint, x, y = window:GetPoint(i)
        snapshot.points[#snapshot.points + 1] = {point, relative, relativePoint, x, y}
    end
    return snapshot
end
local function Restore(snapshot)
    local window = snapshot.frame
    window:SetScale(snapshot.scale)
    window:ClearAllPoints()
    for _, p in ipairs(snapshot.points) do
        window:SetPoint(p[1], p[2], p[3], p[4], p[5])
    end
end
local function StopComparison()
    if not comparison then return end
    if IsInCombat() then
        pendingRestore = true
        Notify(T("Restauration des fenetres apres le combat.", "Windows will be restored after combat."))
        return
    end
    local old = comparison
    comparison, pendingRestore = nil, false
    -- Restore even if the first window fails, so the planner is not left tiny.
    local okGame = pcall(Restore, old.game)
    local okPlanner = pcall(Restore, old.planner)
    UpdateButton(false)
    if not okGame or not okPlanner then
        Notify(T("Impossible de restaurer une position : utilise /reload.",
            "A window position could not be restored; use /reload."))
    end
end

-- The game talent UI is load-on-demand and lives inside PlayerSpellsFrame.
-- Don't touch the spellbook if the player has its tab open instead.
local function FindGameTalents()
    local game = _G.PlayerSpellsFrame
    if not game or not game:IsShown() then
        -- Attempt to open the Talents tab, never toggle an already open panel.
        if PlayerSpellsUtil and type(PlayerSpellsUtil.TogglePlayerSpellsFrame) == "function" then
            pcall(PlayerSpellsUtil.TogglePlayerSpellsFrame, 2)
        end
        game = _G.PlayerSpellsFrame
    end
    if not game or not game:IsShown() then
        return nil, T("Ouvre les talents du jeu (N), puis reessaie.",
            "Open the game's Talents window (N) and try again.")
    end
    local pane = game.TalentsFrame
    if not pane or not pane:IsShown() then
        return nil, T("Selectionne l'onglet Talents du jeu, puis reessaie.",
            "Switch the game window to its Talents tab and try again.")
    end
    return game, pane
end

local function StartComparison()
    if comparison then return end
    if IsInCombat() then
        Notify(T("Le mode comparaison est indisponible en combat.",
            "Comparison mode is unavailable in combat."))
        return
    end
    local game, paneOrError = FindGameTalents()
    if not game then Notify(paneOrError); return end
    local talentsPane = paneOrError
    if not UIParent or not UIParent.GetWidth or not UIParent.GetHeight then return end
    local uiWidth, uiHeight = UIParent:GetWidth(), UIParent:GetHeight()
    local gameWidth, gameHeight = game:GetWidth(), game:GetHeight()
    local planWidth, planHeight = frame:GetWidth(), frame:GetHeight()
    if not (uiWidth and uiHeight and gameWidth and gameHeight and planWidth and planHeight)
        or gameWidth <= 0 or gameHeight <= 0 or planWidth <= 0 or planHeight <= 0 then
        Notify(T("Dimensions des fenetres indisponibles.", "Window sizes are unavailable."))
        return
    end
    -- Frame scales are relative to their respective parents. Convert to a
    -- common UIParent coordinate system before fitting them on screen.
    local uiScale = UIParent:GetEffectiveScale()
    local gameParent = game:GetParent()
    local planParent = frame:GetParent()
    local gameParentRatio = gameParent and gameParent:GetEffectiveScale() / uiScale or 1
    local planParentRatio = planParent and planParent:GetEffectiveScale() / uiScale or 1
    local gap, margin = 18, 18
    local scale = math.min(1,
        (uiWidth - 2 * margin - gap) / (gameWidth + planWidth),
        (uiHeight - 2 * margin) / math.max(gameHeight, planHeight))
    if scale < 0.52 then
        Notify(T("Ecran trop etroit pour deux fenetres lisibles : agrandis la resolution.",
            "Screen too small for two readable windows; increase the resolution."))
        return
    end
    local groupWidth = (gameWidth + planWidth) * scale + gap
    local left = (uiWidth - groupWidth) / 2
    local gameTop = (uiHeight - gameHeight * scale) / 2
    local planTop = (uiHeight - planHeight * scale) / 2
    local original = {game = Capture(game), planner = Capture(frame)}

    -- SetPoint offsets use each newly scaled frame's coordinate space.
    local ok = pcall(function()
        game:SetScale(scale / gameParentRatio)
        game:ClearAllPoints()
        game:SetPoint("TOPLEFT", UIParent, "TOPLEFT", left / scale, -gameTop / scale)
        frame:SetScale(scale / planParentRatio)
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT",
            (left + gameWidth * scale + gap) / scale, -planTop / scale)
    end)
    if not ok then
        pcall(Restore, original.game)
        pcall(Restore, original.planner)
        Notify(T("La fenetre des talents refuse le repositionnement.",
            "The game's Talents window could not be repositioned."))
        return
    end
    comparison = original
    UpdateButton(true)

    -- Closing either window or switching away from Talents exits the mode.
    if not hookedGameWindows[game] then
        hookedGameWindows[game] = true
        game:HookScript("OnHide", function(self)
            if comparison and comparison.game.frame == self then StopComparison() end
        end)
    end
    if not hookedTalentPanes[talentsPane] then
        hookedTalentPanes[talentsPane] = true
        talentsPane:HookScript("OnHide", function()
            if comparison then StopComparison() end
        end)
    end
end

compareButton:SetScript("OnClick", function()
    if comparison then StopComparison() else StartComparison() end
end)
frame:HookScript("OnHide", function()
    if comparison then StopComparison() end
end)
local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_ENABLED" and pendingRestore then StopComparison() end
end)

-- Non-invasive API useful for automated tests and future UI integrations.
planner.ExitComparison = StopComparison
planner.IsComparingTalents = function() return comparison ~= nil end
