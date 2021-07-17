--Categories:
--[[Category:Equipment modules]]

return {
	_name = "61cm Quintuple (Oxygen) Torpedo Mount",
	_page = false,
	_id = 58,
	_japanese_name = "61cm五連装(酸素)魚雷",
	_reading = "61せんちごれんそう(さんそ)ぎょらい",
	_type = 5,
	_icon = 5,
	_rarity = 2,
	_back = 3,
	_firepower = false,
	_bombing = false,
	_torpedo = 12,
	_aa = false,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 1,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = 1,
	_special = false,
	_scrap_fuel = 2,
	_scrap_ammo = 3,
	_scrap_steel = 2,
	_scrap_bauxite = false,
	_info = "大威力長射程を誇る、秘密兵器「九三式酸素魚雷」。<br/>その必殺の酸素魚雷を、五連装にしてしまった水雷兵装のファイナルウェポンが、この五連装【酸素魚雷】発射管です。高速重雷装駆逐艦の「島風」に搭載されていました。大井さんやスーパー北上さまも、こっちを見ています！",
	_wikipedia = "Type 93 torpedo",
	_buildable = false,
	_improvements = {
		_fuel = 100,
		_ammo = 150,
		_steel = 90,
		_bauxite = 30,
		_products = {
			[false] = {
				_ships = {
					["Shimakaze/"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Shimakaze/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 4,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = false,
				},
				[6] = {
					_development_material = 5,
					_development_material_x = 9,
					_improvement_material = 3,
					_improvement_material_x = 7,
					_equipment = {[true] = 1},
				},
			},
		},
	},
}