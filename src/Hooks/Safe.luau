local function safeHookFunction(targetFunction, hookName, hookImplementation)
    local success, originalFunction = pcall(function()
        return hookfunction(targetFunction, hookImplementation)
    end)
    if success then
        return originalFunction
    else
        warn("[Skid-Spy] Failed to hook: " .. hookName)
        return nil
    end
end
