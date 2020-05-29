--------------------------------------
-- Namespace
--------------------------------------
local _, LTC = ...
LTC.ZoneManager = { }
local ZoneManager = LTC.ZoneManager

--------------------------------------
-- Module Imports
--------------------------------------
local ListTracker = LTC.ListTracker

--------------------------------------
-- ZoneManager Config and Handlers
--------------------------------------
function ZoneManager:start()
    if (not ZoneManager.eventHandler) then
        ZoneManager.eventHandler = CreateFrame("FRAME", "ZoneManagerEventHandler")
        ZoneManager.eventHandler:RegisterEvent("PLAYER_ENTERING_WORLD");
        ZoneManager.eventHandler:SetScript("OnEvent", ZoneManager.toggleListTracker);
    end
end

function ZoneManager:toggleListTracker(event, ...) 
    local inInstance = IsInInstance()
    local zoneName = GetInstanceInfo()
    if inInstance then
        ListTracker:initializeTracker(zoneName, { 
            { bossName = "Not In An Instance",
              loot = { 24282 } }, 
            { bossName = "Hakkar",
              loot = { 24102 } },
            { bossName = zoneName },
        })
    else 
        ListTracker:initializeTracker(zoneName, { 
            { bossName = "Your Mom" }, 
            { bossName = zoneName },
        })
    end
end

--[[
local item = Item:CreateFromItemID(24102); 
item:ContinueOnItemLoad(function()
print(item:GetItemLink()) end);

local frame = CreateFrame("FRAME", "TestFrameName", UIParent, "BasicFrameTemplateWithInset")
local texture = frame:CreateTexture(nil, "BACKGROUND")
local fontString = frame:CreateFontString(nil, "BACKGROUND")

Layers are similar to Photoshop layers, and for an item to appear it needs to be 
assigned to a layer. Below are lowest to highest, with highest being displayed on
top of lower layers.
Layers:
- Background
- Border
- Artwork
- Overlay
- Highlight
--]]