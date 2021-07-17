local EquipmentAsset = require('Module:EquipmentAsset')
local Formatting = require('Module:Formatting')

local EquipmentCardKai = EquipmentAsset()

function EquipmentCardKai:get_source(equip, as_item)
	return equip:card(as_item)
end

function EquipmentCardKai:get(equip, args, link)
	if not args then
		args = equip
		equip = args.equipment or args.equip
		link = args.link
	end
	if args.icon then
        args[1] = equip:icon(args.item)
    else
        args[1] = self:get_source(equip, args.item)
    end
	args.link = link
	return Formatting:format_image(args)
end

return EquipmentCardKai