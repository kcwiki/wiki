--Categories:
--[[Category:Equipment modules]]

return {
    _name = "12.7cm Twin Gun Mount Model D Kai 2",
    _id = 267,
    _japanese_name = "12.7cm連装砲D型改二",
    _reading = nil,
    _type = 1, -- 1,1,1,1,0
    _icon = 1,
    _rarity = 3,
    _firepower = 3,
    _bombing = false,
    _torpedo = false,
    _aa = 4,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = 2,
    _torpedo_accuracy = false,
    _evasion = 1,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 1,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 2,
    _scrap_steel = 2,
    _scrap_bauxite = 1,
    _buildable = false,
    _info = "夕雲型駆逐艦などに搭載された駆逐艦主砲のif改修型です。<br>最大仰角を大きく設定しましたが、装填システムの基本構造は従来通りのため対空能力は限定的です。ただし、数々の実戦の戦訓を取り入れた改修により、甲型及び丙型駆逐艦での運用において、優れた砲戦能力を発揮します。",
	_improvements = {
		_fuel = 20,
		_ammo = 70,
		_steel = 90,
		_bauxite = 20,
		_products = {
			[false] = {
				_ships = {
					["Naganami/Kai Ni"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Yuugumo/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Yuugumo/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 6,
					_development_material_x = 7,
					_improvement_material = 5,
					_improvement_material_x = 6,
					_equipment = {["10cm Twin High-angle Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 7,
					_development_material_x = 10,
					_improvement_material = 6,
					_improvement_material_x = 9,
					_equipment = {["12.7cm Twin Gun Mount Model C Kai 2"] = 1},
				},
				_stars = false,
			},
		},
	},
}