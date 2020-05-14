local function showMessageOnZone(self, event, ...) 
    inInstance = IsInInstance();
    zoneName = GetInstanceInfo();
    print("InInstance: ", inInstance);
    print("ZoneName: ", zoneName);
end

local eventHandler = CreateFrame("FRAME", "ZoneManagerEventHandler");
eventHandler:RegisterEvent("PLAYER_ENTERING_WORLD");
eventHandler:SetScript("OnEvent", showMessageOnZone);