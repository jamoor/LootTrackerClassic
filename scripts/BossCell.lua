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
        self.titleLable = self.frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        self.titleLable:SetPoint("CENTER", self.frame, "CENTER", 0, 0)
    end

    -- Update text
    -- self.titleLable:SetText(config.bossName)
    self.titleLable:SetText(config)

    -- Update the frame size
    self.frame:SetSize(self.titleLable:GetWidth(), self.titleLable:GetHeight())
end

function BossCell:hide() 
    if self.frame then
        self.frame:SetSize(0, 0)
    end
    self.isHidden = true
end