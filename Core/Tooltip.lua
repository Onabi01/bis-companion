-- Core/Tooltip.lua
-- Gère les tooltips pour BiSCompanion

local addonName, addon = ...
addon.Core.Tooltip = addon.Core.Tooltip or {}

-- Ajouter un tooltip générique uniquement pour les objets BiS
function addon.Core.Tooltip.AddGenericTooltip(tooltip)
    if not tooltip:IsForbidden() then
        local _, itemLink = tooltip:GetItem()
        if itemLink then
            local itemID = tonumber(itemLink:match("item:(%d+)"))
            if itemID then
                for _, bisItem in ipairs(addon.Core.Data.bisTable) do
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

function addon.Core.Tooltip.InitTooltips()
    hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
        local _, itemLink = tooltip:GetItem()
        if itemLink then
            addon.Core.Tooltip.AddGenericTooltip(tooltip)
        end
    end)
    hooksecurefunc(GameTooltip, "SetInventoryItem", function(self, unit, slot)
        if unit and slot then
            addon.Core.Tooltip.AddGenericTooltip(self)
        end
    end)
    hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
        if bag and slot then
            addon.Core.Tooltip.AddGenericTooltip(self)
        end
    end)
    hooksecurefunc(GameTooltip, "SetLootItem", function(self, slot)
        if slot then
            addon.Core.Tooltip.AddGenericTooltip(self)
        end
    end)
    hooksecurefunc(GameTooltip, "SetHyperlink", function(self, link)
        if link and link:match("item:") then
            local itemID = tonumber(link:match("item:(%d+)"))
            if itemID then
                for _, bisItem in ipairs(addon.Core.Data.bisTable) do
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
    end)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(self, link)
        if link and link:match("item:") then
            local itemID = tonumber(link:match("item:(%d+)"))
            if itemID then
                for _, bisItem in ipairs(addon.Core.Data.bisTable) do
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
    end)
    hooksecurefunc(GameTooltip, "SetItemByID", function(self, itemID)
        if itemID then
            for _, bisItem in ipairs(addon.Core.Data.bisTable) do
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
    end)
    hooksecurefunc(GameTooltip, "SetLootRollItem", function(self, rollID)
        if rollID then
            local itemLink = GetLootRollItemLink(rollID)
            if itemLink then
                local itemID = tonumber(itemLink:match("item:(%d+)"))
                if itemID then
                    for _, bisItem in ipairs(addon.Core.Data.bisTable) do
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
    for i = 1, NUM_CHAT_WINDOWS do
        local chatFrame = _G["ChatFrame" .. i]
        chatFrame:HookScript("OnHyperlinkEnter", function(self, link)
            if link and link:match("item:") then
                local itemID = tonumber(link:match("item:(%d+)"))
                if itemID then
                    for _, bisItem in ipairs(addon.Core.Data.bisTable) do
                        if bisItem.id == itemID then
                            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
                            GameTooltip:ClearLines()
                            GameTooltip:SetHyperlink(link)
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
    if TooltipDataProcessor then
        local function AttachTooltip(self, ttdata)
            self.BiSProcessed = nil
            if ttdata and ttdata.type == Enum.TooltipDataType.Item then
                local _, itemLink, itemID = TooltipUtil.GetDisplayedItem(self)
                if itemLink then
                    itemID = tonumber(itemLink:match("item:(%d+)"))
                    if itemID then
                        for _, bisItem in ipairs(addon.Core.Data.bisTable) do
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
                                    self.BiSProcessed = true
                                end
                                return
                            end
                        end
                    end
                end
            end
        end
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, AttachTooltip)
    end
end