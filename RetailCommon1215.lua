-- Midnight Season 2 (12.1.5) items for the manual item picker.
-- Tier IDs are the five class-set slots in the current BiS guides.
local addonName, addon = ...
addon.Core = addon.Core or {}
addon.Core.CommonItems = addon.Core.CommonItems or {}

local tierSlots = { Head = true, Shoulders = true, Chest = true, Hands = true, Legs = true }
local tierByClassAndID = {}

for specKey, items in pairs(BiSCompanionBisData or {}) do
    local class = specKey:match("^([^_]+)_")
    if class and type(items) == "table" then
        tierByClassAndID[class] = tierByClassAndID[class] or {}
        for _, item in ipairs(items) do
            local id = tonumber(item.id)
            if id and id >= 271454 and id <= 271567 and tierSlots[item.slot] then
                tierByClassAndID[class][id] = {
                    itemID = id, name = item.name, class = class, slot = item.slot,
                }
            end
        end
    end
end

-- The Warlock helm is the only tier slot absent from its Overall BiS lists.
tierByClassAndID.Warlock = tierByClassAndID.Warlock or {}
tierByClassAndID.Warlock[271546] = {
    itemID = 271546, name = "Skull of the Damned Necrolyte", class = "Warlock", slot = "Head",
}

addon.Core.CommonItems.SetItems = {}
for _, byID in pairs(tierByClassAndID) do
    for _, item in pairs(byID) do
        table.insert(addon.Core.CommonItems.SetItems, item)
    end
end
table.sort(addon.Core.CommonItems.SetItems, function(a, b)
    if a.class ~= b.class then return a.class < b.class end
    return a.itemID < b.itemID
end)

-- Current Midnight profession items with checked item IDs.
addon.Core.CommonItems.CraftedItems = {
    { itemID = 239648, name = "Martyr's Bindings", type = "Cloth", slot = "Wrists", source = "Crafted" },
    { itemID = 239649, name = "Martyr's Waistwrap", type = "Cloth", slot = "Waist", source = "Crafted" },
    { itemID = 244576, name = "Silvermoon Agent's Deflectors", type = "Leather", slot = "Wrists", source = "Crafted" },
    { itemID = 244569, name = "Silvermoon Agent's Sneakers", type = "Leather", slot = "Feet", source = "Crafted" },
    { itemID = 244584, name = "Farstrider's Plated Bracers", type = "Mail", slot = "Wrists", source = "Crafted" },
    { itemID = 237834, name = "Spellbreaker's Bracers", type = "Plate", slot = "Wrists", source = "Crafted" },
    { itemID = 240949, name = "Masterwork Sin'dorei Band", type = "All", slot = "Ring 1", source = "Crafted" },
    { itemID = 240949, name = "Masterwork Sin'dorei Band", type = "All", slot = "Ring 2", source = "Crafted" },
    { itemID = 240950, name = "Masterwork Sin'dorei Amulet", type = "All", slot = "Neck", source = "Crafted" },
    { itemID = 245769, name = "Aln'hara Lantern", type = "All", slot = "Off Hand", source = "Crafted" },
}
