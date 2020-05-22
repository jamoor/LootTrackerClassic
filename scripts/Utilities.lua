--------------------------------------
-- Namespace
--------------------------------------
local _, LTC = ...
LTC.Utilities = { }
local Utilities = LTC.Utilities

-- Checks if the input is a non empty string
function Utilities:isNonEmptyString(value)
    return type(value) == "string" and string.len(value) > 0
end