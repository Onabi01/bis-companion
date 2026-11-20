-- Forever 2.5.0: activate equipment only after the three audited gear lots load.
-- The 28 class/spec lists never overwrite saved personal lists.
if not BiSCompanionForever or type(BiSCompanionBisData) ~= "table" then return end
local staged = BiSCompanionForeverPreRaidStaging
if type(staged) ~= "table" then return end
local mapped, count = {}, 0
for _, mapping in ipairs(BiSCompanionClassSpecMapping or {}) do
    local key = mapping.specKey
    if mapped[key] then return end
    mapped[key] = true
    count = count + 1
    local items = staged[key]
    if type(items) ~= "table" or #items < 12 or #items > 18 then return end
    local seen = {}
    for _, item in ipairs(items) do
        if type(item) ~= "table" or not tonumber(item.id) or tonumber(item.id) <= 0
            or type(item.name) ~= "string" or item.name == ""
            or type(item.slot) ~= "string" or item.slot == "" or seen[item.slot] then
            return
        end
        seen[item.slot] = true
    end
end
if count ~= 28 then return end
for key in pairs(staged) do if not mapped[key] then return end end
for key, items in pairs(staged) do BiSCompanionBisData[key] = items end
BiSCompanionForeverPreRaidStaging = nil
BiSCompanionForeverGearReady = true
