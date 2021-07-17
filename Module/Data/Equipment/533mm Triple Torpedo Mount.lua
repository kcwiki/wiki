--Categories:
--[[Category:Equipment modules]]

return {
    _name = "533mm Triple Torpedo Mount",
    _id = 283,
    _japanese_name = "533mm 三連装魚雷",
    _reading = "533ミリさんれんそうぎょらい",
    _type = 5, -- 2,3,5,5,0
    _icon = 5,
    _rarity = 2,
    _firepower = 1,
    _bombing = false,
    _torpedo = 5,
    _aa = false,
    _armor = false,
    _asw = false,
    _shelling_accuracy = false,
    _torpedo_accuracy = false,
    _evasion = 1,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 1,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 1,
    _scrap_steel = 1,
    _scrap_bauxite = false,
    _buildable = false,
    _info = "北の国の艦艇用魚雷装備です。<br>北の国から来た艦艇にはもちろん、信頼できるあのコにも装備させてあげたいですね。<br>хорошо!",
	_improvements = {
		_fuel = 60,
		_ammo = 90,
		_steel = 70,
		_bauxite = 30,
		_products = {
			[false] = {
				_ships = {
					["Tashkent/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Tashkent/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 4,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["61cm Triple Torpedo Mount"] = 1},
				},
				[6] = {
					_development_material = 6,
					_development_material_x = 8,
					_improvement_material = 3,
					_improvement_material_x = 4,
					_equipment = {["61cm Quadruple (Oxygen) Torpedo Mount"] = 2},
				},
			},
		},
	},
}