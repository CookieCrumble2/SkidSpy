local function createLogEntry(method, url, headers, body)
    local entry = tostring(url)

    if headers and next(headers) then
        entry = entry .. "\n\nHeaders = {\n"
        for k, v in pairs(headers) do
            entry = entry .. string.format('    [%q] = %q,\n', tostring(k), tostring(v))
        end
        entry = entry .. "}"
    end

    if body and body ~= "" then
        local formattedBody = prettyPrintJson(body)
        entry = entry .. "\n\nBody:\n" .. formattedBody
    end

    local buttons = {}
    if headers and next(headers) then
        local headerText = ""
        for k, v in pairs(headers) do
            headerText = headerText .. tostring(k) .. ": " .. tostring(v) .. "\n"
        end
        table.insert(buttons, {
            Icon = "files",
            Title = "Copy Data",
            Callback = function()
                setclipboard(tostring(url) .. "\nHeaders:\n" .. headerText .. "\nBody:\n" .. tostring(body))
            end,
        })
    else
        table.insert(buttons, {
            Icon = "files",
            Title = "Copy URL",
            Callback = function()
                setclipboard(tostring(url))
            end,
        })
    end
            
    local targetTab = BTab
    local methodLower = method:lower()
    if methodLower:find("post") then
        targetTab = CTab
    elseif methodLower:find("request") then
        targetTab = DTab
    end

    local log
if (headers and next(headers)) or (body and body ~= "") then
    log = targetTab:Code({
        Title = tostring(method) .. " Request",
        Code = entry,
        Language = "luau",
        Theme = "dark",
        Buttons = buttons,
    })
else
    log = targetTab:Paragraph({
        Title = tostring(method),
        Desc = tostring(url),
        Color = "Red",
        Image = "link",
        Buttons = buttons,
    })
end

    if methodLower:find("get") then table.insert(GetLogs, log)
    elseif methodLower:find("post") then table.insert(PostLogs, log)
    elseif methodLower:find("request") then table.insert(ExecutorLogs, log) end

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
