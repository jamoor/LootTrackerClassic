--------------------------------------
-- Namespace
--------------------------------------
local _, LTC = ...
LTC.ZoneManager = { }
local ZoneManager = LTC.ZoneManager
local Utilities = LTC.Utilities

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
    if inInstance or true then
        ZoneManager:initializeTracker(zoneName)
    end
end

-- likely will move this to its own file

local BossListTracker = ZoneManager

function BossListTracker:initializeTracker(zoneName)
    if not Utilities:isNonEmptyString(zoneName) then
        return
    end

    -- reuse or initialize frame holding the list
    BossListTracker.trackerFrame = BossListTracker.trackerFrame or CreateFrame("Frame", "BossList", UIParent)
    local listTracker = BossListTracker.trackerFrame
    listTracker:SetPoint("CENTER", UIParent, "CENTER", 200, 200)

    -- reuse or initialize list of bosses
    listTracker.bossesList = listTracker.bossesList or {}
    local bossesList = listTracker.bossesList
    local width, height, margin = 0, 0, 50
    for index, bossName in ipairs({ "Hakkar", "Your Mom", zoneName}) do
        local bossLabel = bossesList[index] or listTracker:CreateFontString(nil, "ARTWORK", "GameFontNormal")

        bossLabel:SetText(bossName)
        bossLabel:SetPoint("CENTER", bossesList[index - 1] or listTracker, "CENTER", 0, - margin)

        width = math.max(width, bossLabel:GetWidth())
        height = height + bossLabel:GetHeight() + margin

        bossesList[index] = bossLabel
    end
    listTracker:SetSize(width, height)
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