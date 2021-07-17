local ShipData = require("Module:ShipData")
local EnemyShipData = ShipData{
	_enemy = true,
    _constructor_module = "Module:EnemyShip",
}

EnemyShipData.hp_leveled = EnemyShipData.hp
EnemyShipData.firepower_leveled = EnemyShipData.firepower
EnemyShipData.torpedo_leveled = EnemyShipData.torpedo
EnemyShipData.aa_leveled = EnemyShipData.aa
EnemyShipData.armor_leveled = EnemyShipData.armor
EnemyShipData.asw_leveled = EnemyShipData.asw
EnemyShipData.evasion_leveled = EnemyShipData.evasion
EnemyShipData.los_leveled = EnemyShipData.los
EnemyShipData.luck_leveled = EnemyShipData.luck

function EnemyShipData:can_debuff()
	return self._can_debuff
end

EnemyShipData.__call = EnemyShipData.create
 
return EnemyShipData