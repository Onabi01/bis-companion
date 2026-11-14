-- Mock client harness for the Forever-only side-by-side comparison module.
local frames = {}
local function CreateMock(parent, name)
    local o = {name=name or "anonymous", parent=parent, scale=1, width=400, height=300,
        visible=true, points={}, scripts={}, hooks={}, text=""}
    function o:GetScale() return self.scale end
    function o:SetScale(v) assert(v > 0, "invalid scale"); self.scale=v end
    function o:GetEffectiveScale() return self.scale * (self.parent and self.parent:GetEffectiveScale() or 1) end
    function o:GetParent() return self.parent end
    function o:GetWidth() return self.width end
    function o:GetHeight() return self.height end
    function o:SetSize(w,h) self.width=w; self.height=h end
    function o:GetNumPoints() return #self.points end
    function o:GetPoint(i)
        local p = self.points[i]; return p[1],p[2],p[3],p[4],p[5]
    end
    function o:SetPoint(...) self.points[#self.points+1]={...} end
    function o:ClearAllPoints() self.points={} end
    function o:SetScript(event,fn) self.scripts[event]=fn end
    function o:HookScript(event,fn)
        self.hooks[event] = self.hooks[event] or {}
        self.hooks[event][#self.hooks[event]+1]=fn
    end
    function o:RegisterEvent(event) self.event=event end
    function o:SetText(v) self.text=v end
    function o:IsShown() return self.visible and (not self.parent or self.parent:IsShown()) end
    function o:Hide()
        self.visible = false
        if self.scripts.OnHide then self.scripts.OnHide(self) end
        for _,fn in ipairs(self.hooks.OnHide or {}) do fn(self) end
    end
    function o:Show() self.visible=true end
    function o:CreateFontString() return CreateMock(self) end
    frames[#frames+1]=o
    return o
end
UIParent = CreateMock(nil, "UIParent")
UIParent:SetSize(1365,768)
local plannerFrame = CreateMock(UIParent, "Planner")
plannerFrame:SetSize(738,570)
plannerFrame:SetScale(1.07)
plannerFrame:SetPoint("CENTER",UIParent,"CENTER",12,20)
local game=CreateMock(UIParent,"PlayerSpellsFrame")
game:SetSize(1012,666)
game:SetScale(1.23)
game:SetPoint("CENTER",UIParent,"CENTER",-5,-14)
game.TalentsFrame=CreateMock(game,"TalentsFrame")
PlayerSpellsFrame=game
local messages={}
DEFAULT_CHAT_FRAME={AddMessage=function(_,s) messages[#messages+1]=s end}
GameTooltip={SetOwner=function() end,SetText=function() end,AddLine=function() end,Show=function() end,Hide=function() end}
local button
CreateFrame=function(_,name,parent)
    local f=CreateMock(parent)
    if name=="BiSCompanionForeverCompareButton" then button=f end
    if name then _G[name]=f end
    return f
end
GetLocale=function() return "frFR" end
local combat=false
InCombatLockdown=function() return combat end
local toggles=0
PlayerSpellsUtil={TogglePlayerSpellsFrame=function(tab)
    assert(tab==2)
    toggles=toggles+1
    game:Show()
    game.TalentsFrame:Show()
end}
BiSCompanionForever=true
local addon={Core={Talents={frame=plannerFrame}}}
local dir = (arg and arg[0] or ""):match("^(.*)[/\\]tools[/\\]test_forever_comparison.lua$") or "."
assert(loadfile(dir .. "/ForeverComparison.lua"))("BiSCompanion",addon)
assert(button and button.scripts.OnClick)
local planner=addon.Core.Talents
local function click() button.scripts.OnClick(button) end
local function equalPoints(frame, original)
    assert(frame:GetNumPoints()==#original)
    for i=1,#original do
        local a,b,c,d,e=frame:GetPoint(i)
        local p=original[i]
        assert(a==p[1] and b==p[2] and c==p[3] and d==p[4] and e==p[5], "points mismatch")
    end
end
local gpoints={{game:GetPoint(1)}}
local ppoints={{plannerFrame:GetPoint(1)}}
click()
assert(planner.IsComparingTalents(),"should compare")
assert(game:GetScale()<1 and plannerFrame:GetScale()<1,"should shrink both")
assert(game:GetPoint(1)=="TOPLEFT" and plannerFrame:GetPoint(1)=="TOPLEFT","should use left/right anchors")
assert(button.text=="Quitter comparaison")
click()
assert(not planner.IsComparingTalents())
assert(game:GetScale()==1.23 and plannerFrame:GetScale()==1.07,"original scale restored")
equalPoints(game,gpoints)
equalPoints(plannerFrame,ppoints)
assert(button.text=="Mode comparaison")

-- The click opens the game's Talents tab only when the window was closed.
game:Hide()
click()
assert(toggles==1 and planner.IsComparingTalents())
click()

-- Do not reposition the spellbook's tab.
game.TalentsFrame:Hide()
click()
assert(not planner.IsComparingTalents())
assert(game:GetScale()==1.23)
game.TalentsFrame:Show()

-- Combat safety on start.
combat=true
click()
assert(not planner.IsComparingTalents())
combat=false

-- Closing either panel restores both windows.
click()
assert(planner.IsComparingTalents())
plannerFrame:Hide()
assert(not planner.IsComparingTalents() and game:GetScale()==1.23 and plannerFrame:GetScale()==1.07)
plannerFrame:Show()
click()
game:Hide()
assert(not planner.IsComparingTalents())
game:Show()

-- Switching game tabs also restores the original layout.
click()
game.TalentsFrame:Hide()
assert(not planner.IsComparingTalents())
game.TalentsFrame:Show()

-- Restore must wait if the player enters combat while comparison is active.
click()
combat=true
click()
assert(planner.IsComparingTalents())
combat=false
local event
for _,f in ipairs(frames) do if f.event=="PLAYER_REGEN_ENABLED" then event=f end end
assert(event and event.scripts.OnEvent)
event.scripts.OnEvent(event,"PLAYER_REGEN_ENABLED")
assert(not planner.IsComparingTalents())
assert(game:GetScale()==1.23 and plannerFrame:GetScale()==1.07)

-- Do not squeeze to illegible scale on a small screen.
UIParent:SetSize(760,600)
click()
assert(not planner.IsComparingTalents())
assert(game:GetScale()==1.23 and plannerFrame:GetScale()==1.07)
assert(#messages>=3)
print("PASS: compare, restore, automatic open, talents-only, combat, OnHide, tab switch, small screens")
