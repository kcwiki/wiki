local EquipmentList = {}
local EquipmentCardListKai = false
local EquipmentComparisonKai = false
local EquipmentListKai = false
local EnemyEquipmentListKai = false
local ImprovementTableKai = false
local getArgs = require('Module:GetArgs')

function EquipmentList.CardList(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEquipmentCardListKai()
	return EquipmentCardListKai:Table(args)
end

function _prepareEquipmentCardListKai()
	if not EquipmentCardListKai then
		EquipmentCardListKai = require('Module:EquipmentCardListKai')
	end
end

function EquipmentList.Table(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEquipmentListKai()
	return EquipmentListKai:Table(args)
end

function _prepareEquipmentListKai()
	if not EquipmentListKai then
		EquipmentListKai = require('Module:EquipmentListKai')
	end
end

function EquipmentList.EnemyTable(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEnemyEquipmentListKai()
	return EnemyEquipmentListKai:Table(args)
end

function _prepareEnemyEquipmentListKai()
	if not EnemyEquipmentListKai then
		EnemyEquipmentListKai = require('Module:EnemyEquipmentListKai')
	end
end

function EquipmentList.ComparisonTable(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareEquipmentComparisonKai()
	return EquipmentComparisonKai:Table(args)
end	

function _prepareEquipmentComparisonKai()
	if not EquipmentComparisonKai then
		EquipmentComparisonKai = require('Module:EquipmentComparisonKai')
	end
end

function EquipmentList.ImprovementTable(frame)
	local args = getArgs{frame = frame:getParent()}
	_prepareImprovementTableKai()
	return ImprovementTableKai:Table(args)
end	

function _prepareImprovementTableKai()
	if not ImprovementTableKai then
		ImprovementTableKai = require('Module:ImprovementTableKai')
	end
end

return EquipmentList