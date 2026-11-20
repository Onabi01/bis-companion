-- Regression: Blizzard reuses dropdown button frames when rebuilding a menu.
-- Test the actual specialization-click callback extracted from the Forever UI,
-- not a second implementation of the selection logic.
local file = assert(io.open("compat/forever/Core/UI.lua", "rb"))
local source = file:read("*a")
file:close()

local startMark = "        info.func = function(selfBtn)\n"
local endMark = "\n        end\n        UIDropDownMenu_AddButton(info)"
local start = assert(source:find(startMark, 1, true), "Missing Forever spec click callback")
local finish = assert(source:find(endMark, start + #startMark, true), "Missing spec callback terminator")
local body = source:sub(start + #startMark, finish - 1)

local specDropdown = { selectedValue = nil }
local listDropdown = { initialize = function() end }
local selectionButton = {}
local lastPreferred, remembered, updates

local env = {
    specDropdown = specDropdown,
    listDropdown = listDropdown,
    addon = {
        Core = {
            Character = { RememberForeverGearSpec = function(value) remembered = value end },
            Data = { UpdateBisTable = function() updates = updates + 1 end },
        },
    },
    UIDropDownMenu_SetSelectedValue = function(menu, value) menu.selectedValue = value end,
    UIDropDownMenu_SetText = function(menu, text) menu.text = text end,
    UIDropDownMenu_Refresh = function() end,
    UIDropDownMenu_EnableDropDown = function() end,
    UIDropDownMenu_Initialize = function(menu)
        if menu == listDropdown then
            -- A new menu reassigns the same WoW button to its first entry.
            selectionButton.value = "Default"
            selectionButton.text = "Pre-Raid BiS"
        end
    end,
    SelectPreferredListForSpec = function(value) lastPreferred = value end,
}
setmetatable(env, { __index = _G })
local code = "return function(selfBtn)\n" .. body .. "\nend"
local compiled
if setfenv and loadstring then
    compiled = assert(loadstring(code)) -- WoW / Lua 5.1
    setfenv(compiled, env)
else
    compiled = assert(load(code, "spec-click callback", "t", env)) -- Lua 5.2+ local check
end
local onClick = compiled()

local firstSpecs = {
    "Warrior_Arms", "Paladin_Holy", "Hunter_BeastMastery",
    "Rogue_Assassination", "Priest_Discipline", "Shaman_Elemental",
    "Mage_Arcane", "Warlock_Affliction", "Druid_Balance",
}
for _, specKey in ipairs(firstSpecs) do
    selectionButton.value = specKey
    selectionButton.text = "First spec"
    specDropdown.selectedValue = nil
    lastPreferred, remembered, updates = nil, nil, 0
    onClick(selectionButton)
    assert(selectionButton.value == "Default", "Test did not simulate button reuse")
    assert(specDropdown.selectedValue == specKey, "Spec dropdown changed unexpectedly: " .. specKey)
    assert(remembered == specKey, "Wrong character specialization saved: " .. specKey)
    assert(lastPreferred == specKey, "Gear displayed for stale dropdown button instead of " .. specKey)
    assert(updates == 1, "BiS tooltip refresh not triggered")
end

print("Forever first-spec menu callback: " .. #firstSpecs .. " class selections OK even when dropdown buttons are recycled")
