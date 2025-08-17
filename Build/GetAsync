local oldHttpGetAsync
oldHttpGetAsync = safeHookFunction(game.HttpGetAsync, "HttpGetAsync", newcclosure(function(self, url, ...)
    createLogEntry("HttpGetAsync", url)
    return oldHttpGetAsync(self, url, ...)
end))
