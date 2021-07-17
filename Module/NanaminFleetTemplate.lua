local NanaminFleetTemplate = {}
local NanaminFleet = require('Module:NanaminFleet')
local getArgs = require('Module:GetArgs')
 
function NanaminFleetTemplate.Table(frame)
	local args = getArgs{frame = frame:getParent()}
	return NanaminFleet:Table(args)
end
 
return NanaminFleetTemplate