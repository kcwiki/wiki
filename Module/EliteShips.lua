local EliteShips = {}
local EliteShipsKai = false
local EliteShipsKaiSortable = false
local getArgs = require('Module:GetArgs')

function EliteShips.Table(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEliteShipsKai()
	return EliteShipsKai:Table(args)
end

function _prepareEliteShipsKai()
	if not EliteShipsKai then
		EliteShipsKai = require('Module:EliteShipsKai')
	end
end

function EliteShips.SortableTable(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEliteShipsKaiSortable()
	return EliteShipsKaiSortable:Table(args)
end

function _prepareEliteShipsKaiSortable()
	if not EliteShipsKaiSortable then
		EliteShipsKaiSortable = require('Module:EliteShipsKaiSortable')
	end
end

return EliteShips