--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Type 95 Depth Charge",
    _id = 226,
    _japanese_name = "九五式爆雷",
    _reading = nil,
    _type = 15,
    _icon = 17,
    _rarity = 1,
    _firepower = false,
    _bombing = false,
    _torpedo = false,
    _aa = false,
    _armor = false,
    _asw = 4,
    _shelling_accuracy = false,
    _torpedo_accuracy = false,
    _evasion = false,
    _los = false,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 2,
    _scrap_steel = false,
    _scrap_bauxite = 1,
    _info = "対潜水艦に使用する増加爆雷装備です。<br />駆逐艦や海防艦などに爆雷投射機やソナー類などの対潜装備ともに装備することで、対潜能力の向上が図れます。",
    _buildable = true,
    _asw_damage_type = 'DCR',
	_improvements = {
		_fuel = 10,
		_ammo = 90,
		_steel = 10,
		_bauxite = 60,
		_products = {
			["Type 2 Depth_Charge"] = {
				_ships = {
					["Shimushu/"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Shimushu/Kai"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Etorofu/"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Etorofu/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Kamikaze/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
					["Kamikaze/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
					["Naka/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 4,
					_improvement_material = 1,
					_improvement_material_x = 1,
					_equipment = false,
				},
				[6] = {
					_development_material = 4,
					_development_material_x = 5,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {[true] = 1},
				},
				[10] = {
					_development_material = 5,
					_development_material_x = 9,
					_improvement_material = 3,
					_improvement_material_x = 6,
					_equipment = {[true] = 2},
				},
				_stars = false,
			},
		},
	},
}