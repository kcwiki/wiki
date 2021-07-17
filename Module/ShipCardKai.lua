local Formatting = require('Module:Formatting')
local ShipAsset = require('Module:ShipAsset')

local split = require("Module:Core").split

local ShipCardKai = ShipAsset{
	_card_size = "218x300px",
	_card_size_hd = "327x450px",
	_card_layers = {
		status_expedition = {image = "Card Status Expedition.png", style = {top = "229px", left = "133px"}},
		status_repair = {image = "Card Status Repair.png", style = {top = "228px", left = "133px"}},
		status_light_damage = {image = "Card Status Light Damage.png", style = {top = "228px", left = "133px"}},
		status_medium_damage = {image = "Card Status Medium Damage.png", style = {top = "228px", left = "133px"}},
		status_heavy_damage = {image = "Card Status Heavy Damage.png", style = {top = "228px", left = "133px"}},
		status_sunk = {image = "Card Status Sunk.png", style = {top = "228px", left = "133px"}},
		ring = {image = "Card Marriage Ring.png", style = {top = "260px", left = "180px"}},
		ring_glow = {image = "Card Marriage Ring Glow.png", style = {top = "254px", left = "170px", opacity = "0.7"}},
	},
}

function ShipCardKai:get_source(ship, args)
	return args.damaged and ship:card_damaged(args.hd) or ship:card(args.hd)
end

function ShipCardKai:get(ship, args, link)
	if not args then
		args = ship
		ship = args.ship
		link = args.link
	end
	args[1] = self:get_source(ship, args)
	if not args.size then
		args.size = args.hd and self._card_size_hd or self._card_size
	end
	args.link = link
	local image = Formatting:format_image(args)
	if args.layers or args.grayscale then
		local stack = self:_create_stack(image, args.grayscale)
		if args.layers then
			for _, layer in ipairs(split(args.layers)) do
				if self._card_layers[layer] then
					self:_add_layer(stack, self._card_layers[layer], ship, args, link)
				end
			end
		end
		image = tostring(stack)
	end
	return image
end

return ShipCardKai