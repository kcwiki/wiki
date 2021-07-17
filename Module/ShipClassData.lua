local BaseData = require("Module:BaseData")
local ShipClassData = BaseData{
	_class_suffix = "Class",
}

function ShipClassData:base_name()
	return type(self._name) == 'table' and self._name._name or self._name
end

function ShipClassData:base_name_test()
	return self._name
end

function ShipClassData:short_base_name()
	return self._short_name or self:base_name()
end

function ShipClassData:name()
	local result = {}
	if self._prefix then
		table.insert(result, self._prefix)
	end
	table.insert(result, self:base_name())
	if self._suffix then
		table.insert(result, self._suffix)
	end
	return table.concat(result, " ")
end

function ShipClassData:name_override()
	local result = {}
	if self._prefix then
		table.insert(result, self._prefix)
	end
	if self._name_override or self:base_name() then
	    table.insert(result, self._name_override or self:base_name())
	end
	if self._suffix then
		table.insert(result, self._suffix)
	end
	return table.concat(result, " ")
end

function ShipClassData:short_name()
	local result = {}
	if self._prefix then
		table.insert(result, self._prefix)
	end
	table.insert(result, self:short_base_name())
	if self._suffix then
		table.insert(result, self._suffix)
	end
	return table.concat(result, " ")
end

function ShipClassData:is_type()
	return self._is_type
end

function ShipClassData:base_type()
	return self._base_type
end

function ShipClassData:create(class)
	class = class or {}
	if class._class and not class._suffix then
		class._suffix = self._class_suffix
	end
	setmetatable(class, class)
	class.__index = self
	return class
end

ShipClassData.__call = ShipClassData.create

return ShipClassData