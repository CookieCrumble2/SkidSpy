local oldHttpRequest
oldHttpRequest = safeHookFunction(HttpService.RequestAsync, "RequestAsync", newcclosure(function(self, data, ...)
    if typeof(data) == "table" and data.Url then
        createLogEntry("RequestAsync", data.Url, data.Headers, data.Body)
    end
    return oldHttpRequest(self, data, ...)
end))
