--------------------------------------
-- Namespace
--------------------------------------
local _, LTC = ...
LTC.Utilities = { }
local Utilities = LTC.Utilities

--------------------------------------
-- Functions
--------------------------------------
function Utilities:isNonEmptyString(value)
    return type(value) == "string" and string.len(value) > 0
end