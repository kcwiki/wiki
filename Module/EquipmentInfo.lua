local EquipmentCardKai = false
local EquipmentCategoriesKai = false
local EquipmentGraphicKai = false
local EquipmentInfoKai = false
local EnemyEquipmentInfoKai = false
local getArgs = require('Module:GetArgs')

local EquipmentInfo = {}

function EquipmentInfo.Infobox(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEquipmentInfoKai()
	return EquipmentInfoKai:Infobox(args)
end

function _prepareEquipmentInfoKai()
	if not EquipmentInfoKai then
		EquipmentInfoKai = require('Module:EquipmentInfoKai')
	end
end

function EquipmentInfo.Card(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEquipmentCardKai()
	return EquipmentCardKai:Asset(args)
end

function _prepareEquipmentCardKai()
	if not EquipmentCardKai then
		EquipmentCardKai = require('Module:EquipmentCardKai')
	end
end

function EquipmentInfo.Graphic(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEquipmentGraphicKai()
	return EquipmentGraphicKai:Asset(args)
end

function _prepareEquipmentGraphicKai()
	if not EquipmentGraphicKai then
		EquipmentGraphicKai = require('Module:EquipmentGraphicKai')
	end
end

function EquipmentInfo.Categories(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEquipmentCategoriesKai()
	return EquipmentCategoriesKai:Categories(args)
end

function _prepareEquipmentCategoriesKai()
	if not EquipmentCategoriesKai then
		EquipmentCategoriesKai = require('Module:EquipmentCategoriesKai')
	end
end

function EquipmentInfo.EnemyInfobox(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEnemyEquipmentInfoKai()
	return EnemyEquipmentInfoKai:Infobox(args)
end

function _prepareEnemyEquipmentInfoKai()
	if not EnemyEquipmentInfoKai then
		EnemyEquipmentInfoKai = require('Module:EnemyEquipmentInfoKai')
	end
end

return EquipmentInfo