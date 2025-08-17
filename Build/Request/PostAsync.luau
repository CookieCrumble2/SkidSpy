local oldHttpPostAsync
oldHttpPostAsync = safeHookFunction(game.HttpPostAsync, "HttpPostAsync", newcclosure(function(self, url, data, contentType, compress)
    createLogEntry("HttpPostAsync", url, nil, data)
    return oldHttpPostAsync(self, url, data, contentType, compress)
end))
