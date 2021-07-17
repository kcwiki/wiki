local EquipmentAsset = require('Module:EquipmentAsset')
local Formatting = require('Module:Formatting')

local EquipmentGraphicKai = EquipmentAsset()

function EquipmentGraphicKai:get_source(equip, args)
	return args.fairy and (args.fairy == "only" and equip:fairy() or equip:cg_fairy()) or (args.flying and equip:cg_flying() or equip:cg())
end

function EquipmentGraphicKai:get(equip, args, link)
	if not args then
		args = equip
		equip = args.equip
		link = args.link
	end
	args[1] = self:get_source(equip, args)
	args.link = link
	return Formatting:format_image(args)
end

return EquipmentGraphicKai