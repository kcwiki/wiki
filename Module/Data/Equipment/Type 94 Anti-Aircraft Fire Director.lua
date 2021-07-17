--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Type 94 Anti-Aircraft Fire Director",
	_page = false,
	_id = 121,
	_japanese_name = "94式高射装置",
	_reading = "94しきこうしゃそうち",
	_type = 36,
	_icon = 30,
	_rarity = 2,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = 3,
	_armor = false,
	_asw = false,
	_shelling_accuracy = false,
	_torpedo_accuracy = false,
	_evasion = 1,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 1,
	_scrap_steel = false,
	_scrap_bauxite = 2,
	_info = "比較的新しい高角砲対空射撃用の高射装置です。<br>本高射機は測距儀がパッケージされており、高角砲の有効な対空射撃をサポートします。新造大型艦や、防空駆逐艦 「秋月」 型に搭載されました。",
	_buildable = false,
	_improvements = {
		_fuel = false,
		_ammo = false,
		_steel = 80,
		_bauxite = 70,
		_products = {
			["10cm Twin High-angle Gun Mount + Anti-Aircraft Fire Director"] = {
				_ships = {
					["Akizuki/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Akizuki/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Teruzuki/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Teruzuki/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Hatsuzuki/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Hatsuzuki/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Suzutsuki/"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Suzutsuki/Kai"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Fubuki/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 4,
					_development_material_x = 5,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = false,
				},
				[6] = {
					_development_material = 3,
					_development_material_x = 5,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["10cm Twin High-angle Gun Mount"] = 1},
				},
				[10] = {
					_development_material = 8,
					_development_material_x = 10,
					_improvement_material = 5,
					_improvement_material_x = 10,
					_equipment = {["10cm Twin High-angle Gun Mount"] = 2},
				},
			},
			["12.7cm High-angle Gun + Anti-Aircraft Fire Director"] = {
				_ships = {
					["Maya/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 4,
					_development_material_x = 5,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = false,
				},
				[6] = {
					_development_material = 3,
					_development_material_x = 5,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["12.7cm Twin High-angle Gun Mount"] = 1},
				},
				[10] = {
					_development_material = 7,
					_development_material_x = 9,
					_improvement_material = 5,
					_improvement_material_x = 9,
					_equipment = {["12.7cm Twin High-angle Gun Mount"] = 2},
				},
			},
		},
	},
}