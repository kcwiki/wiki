local EliteShipsKai = false
local ShipBattleCardListKai = false
local ShipCardListKai = false
local ShipListKai = false
local ShipModernizationListKai = false
local ShipRemodelListKai = false

local getArgs = require('Module:GetArgs')

local ShipList = {}

function ShipList.CardList(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipCardListKai()
	return ShipCardListKai:Table(args)
end

function _prepareShipCardListKai()
	if not ShipCardListKai then
		ShipCardListKai = require('Module:ShipCardListKai')
	end
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