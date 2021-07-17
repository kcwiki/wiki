local ShipInfo = {}

local EnemyShipCategoriesKai = false
local EnemyShipInfoKai = false
local ShipBattleCardKai = false
local ShipCardKai = false
local ShipCardComboKai = false
local ShipCategoriesKai = false
local ShipGraphicKai = false
local ShipInfoKai = false
local ShipMetaKai = false
local getArgs = require('Module:GetArgs')

function ShipInfo.Infobox(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipInfoKai()
	return ShipInfoKai:Infobox(args)
end

function _prepareShipInfoKai()
	if not ShipInfoKai then
		ShipInfoKai = require('Module:ShipInfoKai')
	end
end

function ShipInfo.Meta(frame)
	local args = getArgs{frame = frame, wrappers = {"Template:ShipMetaKai"}}
	_prepareShipMetaKai()
	return ShipMetaKai:Infobox(args)
end

function _prepareShipMetaKai()
	if not ShipMetaKai then
		ShipMetaKai = require('Module:ShipMetaKai')
	end
end

function ShipInfo.Card(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipCardKai()
	return ShipCardKai:Asset(args)
end

function _prepareShipCardKai()
	if not ShipCardKai then
		ShipCardKai = require('Module:ShipCardKai')
	end
end

function ShipInfo.BattleCard(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipBattleCardKai()
	return ShipBattleCardKai:Asset(args)
end

function _prepareShipBattleCardKai()
	if not ShipBattleCardKai then
		ShipBattleCardKai = require('Module:ShipBattleCardKai')
	end
end

function ShipInfo.CardCombo(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipCardComboKai()
	return ShipCardComboKai:Asset(args)
end

function _prepareShipCardComboKai()
	if not ShipCardComboKai then
		ShipCardComboKai = require('Module:ShipCardComboKai')
	end
end

function ShipInfo.Graphic(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipGraphicKai()
	return ShipGraphicKai:Asset(args)
end

function _prepareShipGraphicKai()
	if not ShipGraphicKai then
		ShipGraphicKai = require('Module:ShipGraphicKai')
	end
end

function ShipInfo.EnemyInfobox(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEnemyShipInfoKai()
	return EnemyShipInfoKai:Infobox(args)
end

function _prepareEnemyShipInfoKai()
	if not EnemyShipInfoKai then
		EnemyShipInfoKai = require('Module:EnemyShipInfoKai')
	end
end

function ShipInfo.Categories(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareShipCategoriesKai()
	return ShipCategoriesKai:Categories(args)
end

function _prepareShipCategoriesKai()
	if not ShipCategoriesKai then
		ShipCategoriesKai = require('Module:ShipCategoriesKai')
	end
end

function ShipInfo.EnemyCategories(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEnemyShipCategoriesKai()
	return EnemyShipCategoriesKai:Categories(args)
end

function _prepareEnemyShipCategoriesKai()
	if not EnemyShipCategoriesKai then
		EnemyShipCategoriesKai = require('Module:EnemyShipCategoriesKai')
	end
end

return ShipInfo