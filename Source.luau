local HttpService = game:GetService("HttpService")
local Serializer = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotDSF/leopard/main/rbx/leopard-syn.lua"))();
loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealXORA/Roblox/refs/heads/Main/Scripts%20/Anti-Cheats%20Bypassers%20/Adonis.luau"))()

--@ LoveSkids!
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local fileSupport = writefile and isfile and makefolder and listfiles

--@ SkidSpy Configs
local Config = {
    FileSaving = false,
    Format = false
}

--@ To delete all logs 
local Logs = {} --@ Do NOT delete this...

--@ Writes Folder
if fileSupport then
    pcall(function() 
        if not isfolder("Skid-Spy") then 
            makefolder("Skid-Spy") 
        end
    end)
end

--@ Creating the window
local Window = WindUI:CreateWindow({
    Title = "SkidSpy-V2",
    Icon = 79091632739713,
    Author = "@whoiscookie",
    Folder = "",
})

Window:Tag({
    Title = "BETA",
    Color = Color3.fromHex("#30ff6a")
})

local ATab = Window:Tab({
    Title = "Main",
    Icon = "book-alert",
    Locked = false,
})

local Paragraph = ATab:Paragraph({
    Title = "Information",
    Desc = "Welcome To Skid-Spy v2, a advanced HTTP Spy. We hope you enjoy the script! If you have any question feel free to join our discord and ask them. Also if you encounter any bugs DM @whoiscookie on discord!",
    Color = "Red",
    Image = "book-user",
    ImageSize = 30,
    Buttons = {
        {
            Icon = "link",
            Title = "Copy Discord Link",
            Callback = function() 
                    setclipboard("https://discord.gg/dHaeNgV9ym")
                end,
        }
    }
})

local Section = ATab:Section({ 
    Title = "Skid-Spy Settings",
    TextXAlignment = "Left",
    TextSize = 17,
})

local Toggle = ATab:Toggle({
    Title = "Enable File Saving",
    Desc = "Enable file saving to save all SkidSpy logs into your Executors Folders",
    Icon = "file-json",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        Config.FileSaving = state
    end
})

local ToggleJson = ATab:Toggle({
    Title = "Format JSON Body",
    Desc = "Format request bodies that are valid JSON for readability",
    Icon = "file-code",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        Config.Format = state
    end
})

--@ Tabs
local LogTab = Window:Tab({Title = "Request", Icon = "antenna", Locked = false})

LogTab:Button({
    Title = "Delete ALL Logs",
    Desc = "Clicking this button will delete all Executor logs.",
    Callback = function()
        for _, log in ipairs(Logs) do
            log:Destroy()
        end
        table.clear(Logs)
    end,
})
local Section = LogTab:Section({ 
    Title = "HTTP Reauest",
    Icon = "move-down"
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

--@ Logging Function
local function a(method, url, headers, body)
    local entry = tostring(url)
    local formattedBody = body or ""

    --@ Headers (use serializer if available)
    if headers and next(headers) then
        entry = entry .. "\n\nHeaders = " .. Serializer.Serialize(headers)
    end

    --@ Body 
    if Config.Format and body and body ~= "" then
    local ok, parsed = pcall(function()
        return HttpService:JSONDecode(body)
    end)
    if ok then
        formattedBody = "[JSON]\n" .. HttpService:JSONEncode(parsed, true) ..
                        "\n\n[Lua]\n" .. Serializer.Serialize(parsed)
    else
        formattedBody = Serializer.FormatString(body)
    end
end

    if formattedBody and formattedBody ~= "" then
        entry = entry .. "\n\nBody = " .. formattedBody
    end

    --@ File saving
    if Config.FileSaving and fileSupport then
        local timeStamp = os.date("%Y-%m-%d %H-%M-%S")
        local fn = string.format("Skid-Spy/%s-%s.spy", method, timeStamp)
        local content = string.format("[ SkidSpy Log ]\nTime: %s\nMethod: %s\nURL: %s\n\n", timeStamp, method, tostring(url))

        if headers and next(headers) then
            content = content .. "Headers:\n" .. Serializer.Serialize(headers) .. "\n"
        end

        if body and body ~= "" then
            content = content .. "\nBody:\n" .. formattedBody .. "\n"
        end

        content = content .. "\nJoin Our Discord!\nhttps://discord.gg/dHaeNgV9ym"
        writefile(fn, content)
    end
    
    --@ SigmaMango
    local buttons = {}
    table.insert(buttons, {
        Icon = "files",
        Title = "Copy Data",
        Callback = function()
            local clip = ("%s %s"):format(method, url)
            if headers and next(headers) then
                clip = clip .. "\nHeaders:\n" .. Serializer.Serialize(headers)
            end
            if body and body ~= "" then
                clip = clip .. "\nBody:\n" .. formattedBody
            end
            setclipboard(clip)
        end,
    })

    --@ Log display
    local logEntry
    if (headers and next(headers)) or (body and body ~= "") then
        logEntry = LogTab:Code({
            Title = tostring(method) .. " Request",
            Code = entry,
            Language = "luau",
            Theme = "dark",
            Buttons = buttons,
        })
    else
        logEntry = LogTab:Paragraph({
            Title = tostring(method),
            Desc = tostring(url),
            Color = "Red",
            Image = "link",
            Buttons = buttons,
        })
    end

    table.insert(Logs, logEntry)
end

--@ 
task.delay(math.random(3, 5), function()
    WindUI:Notify({
        Title = "SkidSpy",
        Content = "SkidSpy Is Fully Loaded!",
        Duration = 3,
        Icon = "check",
    })

    local oldHttpPost
    oldHttpPost = hookfunction(game.HttpPost, function(self, url, body, contentType, compress, headers)
        a("POST", url, headers, body)
        return oldHttpPost(self, url, body, contentType, compress, headers)
    end)

    local oldHttpGet
    oldHttpGet = hookfunction(game.HttpGet, function(self, url, ...)
    a("GET", url)
    return oldHttpGet(self, url, ...)
    end)

    local oldHttpRequest
    if request or http_request then
        oldHttpRequest = hookfunction(request or http_request, function(data, ...)
            if typeof(data) == "table" and data.Url then
                a("Request", data.Url, data.Headers, data.Body)
            end
            return oldHttpRequest(data, ...)
        end)
    end

    local oldHttpPostAsync
    oldHttpPostAsync = hookfunction(game.HttpPostAsync, function(self, url, body, contentType, compress, headers)
        a("PostAsync", url, headers, body)
        return oldHttpPostAsync(self, url, body, contentType, compress, headers)
    end)

    local oldHttpRequestAsync
    oldHttpRequestAsync = hookfunction(HttpService.RequestAsync, function(self, data, ...)
        if typeof(data) == "table" and data.Url then
            a("RequestAsync", data.Url, data.Headers, data.Body)
        end
        return oldHttpRequestAsync(self, data, ...)
    end)

    local oldHttpGetAsync
    oldHttpGetAsync = hookfunction(game.HttpGetAsync, function(self, url, ...)
        a("GetAsync", url)
        return oldHttpGetAsync(self, url, ...)
    end)
end)

local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if not checkcaller() and table.find({"Request", "RequestAsync", "Post", "PostAsync", "Get", "GetAsync"}, Method) then
        local data = ...
        if typeof(data) == "table" and data.Url then
         a("Request:", data.Url, data.Headers, data.Body)
        end
    end
        
    if Method == "Shutdown" and Self == game then
        print("[SkidSpy] Blocked game:Shutdown")
        return nil
    end

    if Method == "Kick" and Self == game.Players.LocalPlayer then
        print("[SkidSpy] Blocked LocalPlayer:Kick()")
        return nil
    end
            
    return OldNamecall(Self, ...)
end))

print("Made By @whoiscookie")
warn("Serializer Made By @NotDSF")
