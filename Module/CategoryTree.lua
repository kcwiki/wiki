local BaseData = require('Module:BaseData')

local format = require('Module:Core').format

local CategoryTree = BaseData{
	_template = '<categorytree mode=${mode} depth=${depth}>${category}</categorytree>',
}

function CategoryTree:create(data)
	data = data or {}
	data.mode = data.mode or "pages"
	data.depth = data.depth or "0"
	data.__tostring = self._tostring
	return self.__index.create(self, data)
end

function CategoryTree:set_mode(mode)
	self._mode = mode
end

function CategoryTree:set_depth(depth)
    self._depth = depth
end

function CategoryTree:_tostring()
	return mw.getCurrentFrame():preprocess(format(self._template, self))
end

return CategoryTree