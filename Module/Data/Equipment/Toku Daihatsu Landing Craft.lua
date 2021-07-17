--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Toku Daihatsu Landing Craft",
	_page = false,
	_id = 193,
	_japanese_name = "特大発動艇",
	_reading = "とくだいはつどうてい",
	_type = 24,
	_icon = 20,
	_rarity = 2,
	_back = -1,
	_stars = 2,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = false,
	_armor = false,
	_asw = false,
	_shelling_accuracy = false,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_special = "Increases resource gains from expeditions",
	_scrap_fuel = 2,
	_scrap_ammo = 2,
	_scrap_steel = false,
	_scrap_bauxite = 1,
	_buildable = false,
	_info = "特大発動艇、略して「特大発」。<br/>輸送船からの揚陸作業や上陸戦に用いる数多く量産された上陸用舟艇、「大発」。この海上のトラック「大発」を新型中戦車搭載等に対応するためより大型化、搭載力が向上しています。",
	_wikipedia = "Toku Daihatsu-class landing craft",
	_improvements = {
		_fuel =70,
		_ammo = 80,
		_steel = 120,
		_bauxite = 30,
		_products = {
			[false] = {
				_ships = {
					["Akitsu Maru/"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Akitsu Maru/Kai"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Kinu/Kai Ni"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 5,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["Drum Canister (Transport Use)"] = 2},
				},
				[6] = {
					_development_material = 4,
					_development_material_x = 8,
					_improvement_material = 4,
					_improvement_material_x = 6,
					_equipment = {["Daihatsu Landing Craft"] = 1},
				},
			},
		},
	},
}