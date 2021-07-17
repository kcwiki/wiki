local BaseAsset = require('Module:BaseAsset')
local Equipment = require('Module:Equipment')

local EquipmentAsset = BaseAsset()

function EquipmentAsset:create_object(args)
    if args.id then
        local equipmentMap = mw.loadData('Module:Collection/EquipmentByApiId')
        local apiId = tonumber(args.id)
        return Equipment(equipmentMap[apiId])
    else
	    return Equipment(args[1])
    end
end

return EquipmentAsset