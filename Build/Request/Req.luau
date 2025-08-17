local oldHttpRequest
oldHttpRequest = safeHookFunction(request, "Request", newcclosure(function(self, data, ...)
    if typeof(data) == "table" and data.Url then
        createLogEntry("Request", data.Url, data.Headers, data.Body)
    end
    return oldHttpRequest(self, data, ...)
end))
