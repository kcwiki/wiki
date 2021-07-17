local BaseData = require('Module:BaseData')

local Tabber = BaseData{
	_separator = '\n|-|\n'
}

function Tabber:create(data)
	data = data or {}
	data._tabs = {}
	data.__tostring = self._tostring
	return self.__index.create(self, data)
end

function Tabber:add_tab(tab_name, tab_contents)
	table.insert(self._tabs, tab_name .. '=' .. tab_contents)
end

function Tabber:_tostring()
	return mw.getCurrentFrame():preprocess('<tabber>' .. table.concat(self._tabs, self._separator) .. '</tabber>')
end

return Tabber