    if SaveToFile and fileSupport then
    local TimeStamp = os.date("%Y-%m-%d %H-%M-%S")
    local fileName = string.format("Skid-Spy/%s-%s.txt", method, TimeStamp)

    local content = string.format("[ SkidSpy Log ]\nTime: %s\nMethod: %s\nURL: %s\n\n", TimeStamp, method, tostring(url))

    if headers and next(headers) then
        content = content .. "Headers:\n"
        for k,v in pairs(headers) do
            content = content .. string.format("    %s: %s\n", tostring(k), tostring(v))
        end
    end

    if body and body ~= "" then
        content = content .. "\nBody = { \n" .. prettyPrintJson(body) .. "\n }"
    end

    content = content .. "\nJoin Our Discord If You havent Already!\n https://discord.gg/dHaeNgV9ym"
    pcall(function()
        writefile(fileName, content)
        end)
    end
end
