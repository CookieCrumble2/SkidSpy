local HMM = newcclosure(function(Instance, Method, Function)
    Method = Method:find("^__") and Method:lower() or "__" .. Method:lower()
    local OIMT = getrawmetatable(Instance); setreadonly(OIMT, false)
    local OMM = rawget(OIMT, Method)
    
    rawset(OIMT, Method, newcclosure(Function)); setreadonly(OIMT, true)
    return OMM
end)

local ONC
ONC = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    local method = getnamecallmethod()

    if not checkcaller() and method == "RequestAsync" then
        local data = ...
        if typeof(data) == "table" and data.Url then
            createLogEntry("RequestAsync", data.Url, data.Headers, data.Body)
        end
    end
    return ONC(Self, ...)
end))
