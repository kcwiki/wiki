local getArgs = require('Module:GetArgs')
local format = require('Module:Core').format

local NihongoKai = {
    _template = [[<span style="${style}" title="${title}">${content}</span>]],
}

function NihongoKai:Main(args)
    local title = args[2]
    if args[3] then title = title .. "&#010;" .. args[3] end
    return format{self._template, content = args[1], title = title, style = args["style"] or ""}
end

function NihongoKai.Begin(frame)
    local args = getArgs{frame = frame:getParent()}
	return NihongoKai:Main(args)
end

return NihongoKai