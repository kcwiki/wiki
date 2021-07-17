--Module:ShipList
local EliteShipsKai = false
local ShipBattleCardListKai = false
local ShipListKai = false
local ShipModernizationListKai = false
local ShipRemodelListKai = false

local getArgs = require('Module:GetArgs')
--Module:ShipCardListKai
local CardList = require('Module:CardList')
local Formatting = require('Module:Formatting')
local Ship = require('Module:Ship')
local ShipCardKai = require('Module:ShipCardKai')
 
local ShipCardListKai = CardList{
	_item_class = Ship,
	_blank = "Empty ship slot.png",
	_default_size = "150x206px",
	_column_count = 5,
}
 
function ShipCardListKai:card(ship)
	local value
	if ship == false then
		value = Formatting:format_image{self._blank, size = self._size}
	else
		value = ShipCardKai:get{ship = ship, size = self._size, link = ship:link(), caption = ship:name()}
	end
	return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
end
--Module:ShipList
local ShipList = {}

function ShipList.CardList(frame)
	local args = getArgs{frame = frame:getParent()}
	return ShipCardListKai:Table(args)
end

function ShipList.BattleCardList(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipBattleCardListKai()
	return ShipBattleCardListKai:Table(args)
end

function _prepareShipBattleCardListKai()
	if not ShipBattleCardListKai then
		ShipBattleCardListKai = require('Module:ShipBattleCardListKai')
	end
end

function ShipList.ShipList(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipListKai()
	return ShipListKai:Table(args)
end

function _prepareShipListKai()
	if not ShipListKai then
		ShipListKai = require('Module:ShipListKai')
	end
end

function ShipList.ShipRemodelList(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipRemodelListKai()
	return ShipRemodelListKai:Table(args)
end

function _prepareShipRemodelListKai()
	if not ShipRemodelListKai then
		ShipRemodelListKai = require('Module:ShipRemodelListKai')
	end
end

function ShipList.ShipModernizationList(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipModernizationListKai()
	return ShipModernizationListKai:Table(args)
end

function _prepareShipModernizationListKai()
	if not ShipModernizationListKai then
		ShipModernizationListKai = require('Module:ShipModernizationListKai')
	end
end

function ShipList.EliteShips(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEliteShipsKai()
	return EliteShipsKai:Table(args)
end

function _prepareEliteShipsKai()
	if not EliteShipsKai then
		EliteShipsKai = require('Module:EliteShipsKai')
	end
end

return ShipList