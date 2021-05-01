local U = require('Module:Core')
local EquipmentData = require('Module:EquipmentData')
local EquipmentCollection = require('Module:Collection/Equipment')

local Equipment = {}

local equipments = {}

function Equipment:create(name)
	if not name then
		return EquipmentData()
	end
	if equipments[name] then
		return equipments[name]
	end
	local success, equipment_table = U.requireModule(name)
	if not success then
		local eq = U.find(EquipmentCollection, name, '_name')
		local success2, equipment_table2
		if eq and (eq._module or eq._dev) then
			success2, equipment_table2 = U.requireModule(eq._module or eq._dev and name .. '/Dev')
		end
		equipment_table = success2 and equipment_table2 or eq or { _name = name }
		if eq and eq._module then
			equipment_table._module = eq._module
		end
		if eq and eq._dev then
			equipment_table._dev = eq._dev
		end
	end
	local equipment = EquipmentData(equipment_table)
	equipments[name] = equipment
	return equipment
end

function Equipment:get(stat, name)
	return self:create(name)[stat]()
end

function Equipment:get_module(name)
	return name and mw.ustring.format(
	    'Module:%s',
	    equipments[name] and (equipments[name]._module or equipments[name]._dev and name .. '/Dev') or name
    ) or nil
end

function Equipment:extend(data)
	data = data or {}
	setmetatable(data, data)
	data.__index = self
	data.__call = self.__call
	return data
end

Equipment.__call = Equipment.create
setmetatable(Equipment, Equipment)

return Equipment