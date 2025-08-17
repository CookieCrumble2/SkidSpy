local oldHttpPost
oldHttpPost = safeHookFunction(game.HttpPost, "HttpPost", newcclosure(function(self, url, data, contentType, compress)
    createLogEntry("HTTP Post", url, nil, data)
    return oldHttpPost(self, url, data, contentType, compress)
end))
