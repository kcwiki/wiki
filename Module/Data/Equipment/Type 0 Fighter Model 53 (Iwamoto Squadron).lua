--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Type 0 Fighter Model 53 (Iwamoto Squadron)",
	_page = false,
	_id = 157,
	_japanese_name = "零式艦戦53型(岩本隊)",
	_reading = "れいしきかんせん53がた(いわもとたい)",
	_type = 6,
	_icon = 6,
	_rarity = 5,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = 12,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 2,
	_torpedo_accuracy = false,
	_evasion = 4,
	_los = 3,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = 6,
	_flight_range = 6,
	_special = false,
	_scrap_fuel = 1,
	_scrap_ammo = 2,
	_scrap_steel = false,
	_scrap_bauxite = 5,
	_info = "遂に飛行隊を預かることになった「零戦虎徹」岩本隊長率いる、「零式艦上戦闘機53型」装備の艦戦隊です。「52型」のエンジンと生存性を強化した性能向上型である「零戦53型」を駆り、熟練搭乗員を率いて戦いの空に駆け上がります。",
	_wikipedia = "Tetsuzo Iwamoto",
	_buildable = false,
	_improvements = {
		_fuel = 120,
		_ammo = 120,
		_steel = false,
		_bauxite = 280,
		_products = {
			[false] = {
				_ships = {
					["Zuikaku/"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Zuikaku/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Zuikaku/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Zuikaku/Kai Ni A"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 4,
					_development_material_x = 6,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["Type 0 Fighter Model 52"] = 2}
				},
				[6] = {
					_development_material = 5,
					_development_material_x = 9,
					_improvement_material = 4,
					_improvement_material_x = 6,
					_equipment = {["Type 0 Fighter Model 52"] = 3}
				},
				_stars = nil,
			},
		},
	},
}