--Categories:
--[[Category:Equipment modules]]

return {
    _name = "130mm B-13 Twin Gun Mount",
    _id = 282,
    _japanese_name = "130mm B-13連装砲",
    _reading = nil,
    _type = 1, -- 1,1,1,1,0
    _icon = 1,
    _rarity = 3,
    _firepower = 4,
    _bombing = false,
    _torpedo = false,
    _aa = 1,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = false,
    _torpedo_accuracy = false,
    _evasion = false,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 1,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 2,
    _scrap_steel = 3,
    _scrap_bauxite = false,
    _buildable = false,
    _info = "北の国の小型艦艇用の主砲です。<br>優れた火力を持つ本砲は大型の嚮導駆逐艦などにも装備され、対陸上砲撃などでも成果を上げました。<br>урааааааа!",
	_improvements = {
		_fuel = 40,
		_ammo = 90,
		_steel = 190,
		_bauxite = 50,
		_products = {
			[false] = {
				_ships = {
					["Tashkent/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Tashkent/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 5,
					_improvement_material_x = 6,
					_equipment = {["12.7cm Twin Gun Mount"] = 3},
				},
				[6] = {
					_development_material = 9,
					_development_material_x = 13,
					_improvement_material = 7,
					_improvement_material_x = 9,
					_equipment = {["14cm Single Gun Mount"] = 4},
				},
			},
		},
	},
}