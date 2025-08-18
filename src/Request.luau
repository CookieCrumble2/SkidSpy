local oldHttpGet
oldHttpGet = safeHookFunction(game.HttpGet, "HttpGet", newcclosure(function(self, url, ...)
    createLogEntry("HTTP Get", url)
    return oldHttpGet(self, url, ...)
end))

local oldHttpPost
oldHttpPost = safeHookFunction(game.HttpPost, "HttpPost", newcclosure(function(self, url, data, contentType, compress)
    createLogEntry("HTTP Post", url, nil, data)
    return oldHttpPost(self, url, data, contentType, compress)
end))

local oldHttpGetAsync
oldHttpGetAsync = safeHookFunction(game.HttpGetAsync, "HttpGetAsync", newcclosure(function(self, url, ...)
    createLogEntry("HttpGetAsync", url)
    return oldHttpGetAsync(self, url, ...)
end))

local oldHttpPostAsync
oldHttpPostAsync = safeHookFunction(game.HttpPostAsync, "HttpPostAsync", newcclosure(function(self, url, data, contentType, compress)
    createLogEntry("HttpPostAsync", url, nil, data)
    return oldHttpPostAsync(self, url, data, contentType, compress)
end))

local oldHttpRequestAsync
oldHttpRequestAsync = safeHookFunction(HttpService.RequestAsync, "RequestAsync", newcclosure(function(self, data, ...)
    if typeof(data) == "table" and data.Url then
        createLogEntry("RequestAsync", data.Url, data.Headers, data.Body)
    end
    return oldHttpRequestAsync(self, data, ...)
end))

local oldHttpRequest
oldHttpRequest = safeHookFunction(request, "Request", newcclosure(function(self, data, ...)
    if typeof(data) == "table" and data.Url then
        createLogEntry("Request", data.Url, data.Headers, data.Body)
    end
    return oldHttpRequest(self, data, ...)
end))
