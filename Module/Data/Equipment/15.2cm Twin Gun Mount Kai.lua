--Categories:
--[[Category:Equipment modules]]

local _15_2cm_Twin_Gun_Mount_Kai = {
	_name = "15.2cm Twin Gun Mount Kai",
	_page = false,
	_id = 139,
	_japanese_name = "15.2cm連装砲改",
	_reading = "15.2せんちれんそうほうかい",
	_type = 2,
	_icon = 2,
	_rarity = 3,
	_firepower = 6,
	_bombing = false,
	_torpedo = false,
	_aa = 3,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 4,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = 2,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 2,
	_scrap_steel = 3,
	_scrap_bauxite = 1,
	_info = "阿賀野型軽巡シリーズの主兵装として開発された両用砲の改良改修型です。<br>対巡洋艦戦闘に重きをおいた新設計の軽巡主砲で、限定的ですが対空戦闘も可能です。改修により精度が若干向上しました。軽巡にフィットした新型の主砲兵装です。",
	_buildable = false,
	_improvements = {
		_fuel = 20,
		_ammo = 80,
		_steel = 100,
		_bauxite = 30,
		_products = {
			[false] = {
				_ships = {
					["Sakawa/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = true},
					["Sakawa/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = true},
					["Yahagi/"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Yahagi/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 4,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["15.2cm Twin Gun Mount"] = 1},
				},
				[6] = {
					_development_material = 4,
					_development_material_x = 6,
					_improvement_material = 3,
					_improvement_material_x = 6,
					_equipment = {["15.2cm Twin Gun Mount"] = 1},
				},
				_stars = false,
			},
		},
	},
}

return _15_2cm_Twin_Gun_Mount_Kai