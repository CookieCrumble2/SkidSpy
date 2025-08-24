--[[

Copyright (c) 2025 @whoiscookie & @whoiscookie2

This script is licensed under the MIT License.  
All rights are reserved by the copyright holder.  

Permission is hereby granted, free of charge, to any person obtaining a copy
of this script and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, subject to the following conditions:

The above copyright notice and this permission notice shall be included in  
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]--
--@ LoveSkids!
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
--@ SkidSpys Settings
local Config = {
    fileSaving = false,
    Format = false
}
local Window = WindUI:CreateWindow({
    Title = "Skid-Spy v2",
    Icon = "door-open",
    Author = "by @whoiscookie",
    Folder = "",
    Size = UDim2.fromOffset(520, 460),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
        end,
    },
})

local ATab = Window:Tab({
    Title = "Main",
    Icon = "book-alert",
    Locked = false,
})

local Paragraph = ATab:Paragraph({
    Title = "Information",
    Desc = "Welcome To Skid-Spy v2, a advanced HTTP Spy. We hope you enjoy the script! If you have any question feel free to jkin our discord and ask them. Also if you encounter any bugs DM @whoiscookie on discord!",
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
    TextSize = 17, -- Default Size
})

local Toggle = ATab:Toggle({
    Title = "Enable File Saving",
    Desc = "Enable file saving to save all SkidSpy logs into your Executors Folders",
    Icon = "file-json",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
      -- Later
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
