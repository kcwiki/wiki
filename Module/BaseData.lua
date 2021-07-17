local BaseData = {}

function BaseData:create(data)
	data = data or {}
	setmetatable(data, data)
	data.__index = self
	data.__call = self.__call
	return data
end

BaseData.__call = function (table, ...)
	return table:create(...)
end

setmetatable(BaseData, BaseData)

return BaseData