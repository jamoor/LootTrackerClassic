--------------------------------------
-- Namespace
--------------------------------------
local _, LTC = ...
LTC.BossCell = { }
local BossCell = LTC.BossCell

--------------------------------------
-- Reusable BossCell Functions
--------------------------------------
function BossCell:create(container, initialConfig)
    -- Create container frame for representing a single boss
    local newCell = { frame = CreateFrame("Frame", nil, container) }

    -- Setup metatable to set functions on a bosscell
    self.__index = self
    setmetatable(newCell, self)

    -- Add the starting config
    newCell:update(initialConfig)

    -- Return initialized cell
    return newCell
end

function BossCell:update(config)
    -- Initialize title if it doesn't exist
    if not self.titleLable then
        self.titleLable = self.frame:CreateFontString(nil, "ARTWORK", "GameFontGreen")
        self.titleLable:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
    end

    -- Verify config state
    if config.bossName then
        -- Update text
        self.titleLable:SetText(config.bossName)
    end

    local height = self.titleLable:GetHeight()
    local width = self.titleLable:GetWidth()
    
    -- Update the list under the label if the boss contains loot
    if config.loot then 
        local lootWidth, lootHeight = self:updateLootList(config)
        width = math.max(lootWidth, width)
        height = height + lootHeight
    end

    -- Update the frame size
    self.frame:SetSize(width, height)
end

function BossCell:updateLootList(config)
    local listWidth, listHeight = 0, 0
    for index, lootId in ipairs(config.loot) do
        local item = Item:CreateFromItemID(lootId);
        local link = item:GetItemLink()
        local linkWidth, linkHeight, margin = 0, 0, 10
        if link then
            print("got link: " .. link)
            if not self.linkLabel then
                self.linkLabel = self.frame:CreateFontString(nil, "ARTWORK", "GameFontWhite")
                self.linkLabel:SetPoint("TOPLEFT", self.titleLable, "BOTTOMLEFT", margin, - margin)
            end

            self.linkLabel:SetText(link)

            linkWidth = self.linkLabel:GetWidth() + margin
            linkHeight = self.linkLabel:GetHeight() + margin
        else
            print("link empty for: " .. lootId)
            item:ContinueOnItemLoad(function()
                print("item finished, dispatch another load")
                self:update(config)
            end);
        end

        listWidth = math.max(listWidth, linkWidth)
        listHeight = listHeight + linkHeight
    end
    return listWidth, listHeight
end

function BossCell:hide() 
    if self.frame then
        self.frame:SetSize(0, 0)
    end
    self.isHidden = true
end