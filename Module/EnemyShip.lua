local Ship = require('Module:Ship')

local EnemyShip = Ship:extend{
	_enemy = true,
	_ships = {}, --maintain a separate cache from Ship
	_data_class = false,
}
 
function EnemyShip:_prepareShipData()
	self._data_class = self._data_class or require('Module:EnemyShipData')
end

return EnemyShip