local _ = require("Module:Core")
local Equipment = require('Module:Equipment')

function getEquipment(frame)
    local args = _.getTemplateArgs(frame)
    local name = args.explicit[1] or args.implicit.pagename or ""
    return Equipment(name)
end

function wikipediaLink(wikipedia)
    if not wikipedia then
        return
    end
    local parts = _.split(wikipedia, ":")
    if parts[1] and parts[2] then
        return string.format("[[wikipedia:%s:%s|%s]]", parts[1], parts[2], parts[2])
    else
        return string.format("[[wikipedia:%s|%s]]", wikipedia, wikipedia)
    end
end

return {
    info = function(frame)
        return getEquipment(frame):info()
    end,
    wikipedia = function(frame)
        return wikipediaLink(getEquipment(frame):wikipedia())
    end,
    buildable = function(frame)
        return getEquipment(frame):buildable() and "true" or ""
    end,
    improvable = function(frame)
        return getEquipment(frame):improvable() and "true" or ""
    end,
}