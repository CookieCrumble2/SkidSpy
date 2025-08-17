local SaveToFile = false
local fileSupport = (writefile and isfile and makefolder and delfile) ~= nil

if fileSupport then
    pcall(function() makefolder("Skid-Spy") end)
end
