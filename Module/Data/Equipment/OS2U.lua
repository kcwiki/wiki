--Categories:
--[[Category:Equipment modules]]

return {
	_name = "OS2U",
	_page = false,
	_id = 171,
	_japanese_name = "OS2U",
	_reading = false,
	_type = 10,
	_icon = 10,
	_rarity = 3,
	_firepower = false,
	_bombing = 1,
	_torpedo = false,
	_aa = 1,
	_armor = false,
	_asw = 1,
	_shelling_accuracy = 2,
	_torpedo_accuracy = false,
	_evasion = 1,
	_los = 6,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = 6,
	_flight_range = 3,
	_special = false,
	_scrap_fuel = 2,
	_scrap_ammo = 1,
	_scrap_steel = false,
	_scrap_bauxite = 2,
	_info = "Vought社が開発した艦載観測機です。水上機タイプの本機は、米海軍の水上艦に搭載され、Iowa級をはじめ、戦艦や巡洋艦等の目として索敵等に運用されました。",
	_wikipedia = "Vought OS2U Kingfisher",
	_buildable = false,
	_improvements = {
		_fuel = 80,
		_ammo = 30,
		_steel = false,
		_bauxite = 320,
		_products = {
			[false] = {
				_ships = {
					["Colorado/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Iowa/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Houston/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 5,
					_development_material_x = 6,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["Type 0 Reconnaissance Seaplane"] = 1},
				},
			
				[6] = {
					_development_material = 6,
					_development_material_x = 9,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["Type 0 Reconnaissance Seaplane"] = 2},
				},
			},
		},
	},
}