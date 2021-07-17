local Formatting = require('Module:Formatting')
local ShipAsset = require('Module:ShipAsset')

local ShipGraphicKai = ShipAsset{}

function ShipGraphicKai:get_source(ship, args)
    local hd = args.hd
    if (ship._api_id or 0) > 1500 and not ship._can_debuff then
        hd = true
    end
    if args.damaged then
        return ship:cg_damaged(hd)
    else
        return ship:cg(hd)
    end
end

function ShipGraphicKai:get(ship, args, link)
	if not args then
		args = ship
		ship = args.ship
	end
	args[1] = self:get_source(ship, args)
	args.link = link
	if args.damaged then
	    args.nsfw = ship._nsfw_damaged
	else
	    args.nsfw = ship._nsfw
	end
	return Formatting:format_image(args)
end

return ShipGraphicKai