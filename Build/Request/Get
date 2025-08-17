local oldHttpGet
oldHttpGet = safeHookFunction(game.HttpGet, "HttpGet", newcclosure(function(self, url, ...)
    createLogEntry("HTTP Get", url)
    return oldHttpGet(self, url, ...)
end))
