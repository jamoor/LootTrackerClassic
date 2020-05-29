--------------------------------------
-- Namespace
--------------------------------------
local _, LTC = ...
LTC.ListTracker = { }
local ListTracker = LTC.ListTracker

--------------------------------------
-- Module Imports
--------------------------------------
local Utilities = LTC.Utilities
local BossCell = LTC.BossCell

--------------------------------------
-- ListTracker Functions
--------------------------------------
function ListTracker:initializeTracker(zoneName, listData)
    -- check malformed params
    if not Utilities:isNonEmptyString(zoneName) or not listData then
        return
    end

    -- reuse or initialize frame holding the list
    ListTracker.trackerFrame = ListTracker.trackerFrame or CreateFrame("Frame", "BossList", UIParent)
    local tracker = ListTracker.trackerFrame
    tracker:SetPoint("CENTER", UIParent, "CENTER", 200, 100)

    -- reuse or initialize list of bosses
    tracker.bossesList = tracker.bossesList or {}
    local bossesList = tracker.bossesList
    local width, height, margin = 0, 0, 50
    for index, config in ipairs(listData) do
        local bossCell = bossesList[index] or BossCell:create(tracker, config)

        -- Update Cell for latest config if its re-used
        bossCell:update(config)

        -- Anchor the cells to each other or the parent frame if its the first item in the list
        if bossesList[index - 1] then
            bossCell.frame:SetPoint("TOPLEFT", bossesList[index - 1].frame, "BOTTOMLEFT", 0, - margin)
        else
            bossCell.frame:SetPoint("TOPLEFT", tracker, "TOPLEFT", 0, 0)
        end
        
        -- Caculate the width and height of the container list
        -- Max width of any cell
        -- Sum of all cell heights plus their margins
        width = math.max(width, bossCell.frame:GetWidth())
        height = height + bossCell.frame:GetHeight() + margin

        -- Store the Cell to be re-useable
        bossesList[index] = bossCell
    end

    -- After finished configuring the list, hide any remaining cached
    -- cells as we have no data to insert
    for index = table.getn(listData) + 1, table.getn(bossesList), 1 do
        bossesList[index]:hide()
    end

    -- Remove the extra margin at the end of the frame
    height = height - margin

    tracker:SetSize(width, height)
end