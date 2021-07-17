local NanaminCombinedFleetTemplate = {}
local NanaminCombinedFleet = require('Module:NanaminCombinedFleet')
local getArgs = require('Module:GetArgs')
 
function NanaminCombinedFleetTemplate.Fleetbox(frame)
	local args = getArgs{frame = frame:getParent()}
	return NanaminCombinedFleet:Fleetbox(args)
end
 
return NanaminCombinedFleetTemplate