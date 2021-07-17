local BaseAsset = require('Module:BaseAsset')
local Ship = require('Module:Ship')

local ShipAsset = BaseAsset()

function ShipAsset:create_object(args)
	if args.name then
		return Ship(args.name, args.model)
	else
		return Ship(args[1])
	end
end

return ShipAsset