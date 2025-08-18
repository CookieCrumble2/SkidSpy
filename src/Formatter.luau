--@ JSON FORMATTER
local function prettyPrintJson(jsonString)
    local success, decoded = pcall(function()
        return HttpService:JSONDecode(jsonString)
    end)
    if not success then return jsonString end

    local function isArray(tbl)
        local i = 0
        for k in pairs(tbl) do
            i += 1
            if tbl[i] == nil then
                return false
            end
        end
        return true
    end

    local function encodePretty(tbl, indent)
        indent = indent or 0
        local spacing = string.rep("  ", indent)
        local nextSpacing = string.rep("  ", indent + 1)

        if typeof(tbl) ~= "table" then
            if typeof(tbl) == "string" then
                return "\"" .. tbl .. "\""
            else
                return tostring(tbl)
            end
        end

        local array = isArray(tbl)
        local parts = { array and "[\n" or "{\n" }

        for k, v in pairs(tbl) do
            local formattedValue = encodePretty(v, indent + 1)
            local line
            if array then
                line = nextSpacing .. formattedValue
            else
                local key = "\"" .. tostring(k) .. "\""
                line = string.format("%s%s: %s", nextSpacing, key, formattedValue)
            end
            table.insert(parts, line .. ",\n")
        end

        if #parts > 1 then
            parts[#parts] = parts[#parts]:gsub(",\n$", "\n")
        end

        table.insert(parts, spacing .. (array and "]" or "}"))
        return table.concat(parts)
    end

    return encodePretty(decoded)
end
