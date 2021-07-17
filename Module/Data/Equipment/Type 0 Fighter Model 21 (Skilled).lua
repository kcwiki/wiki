--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Type 0 Fighter Model 21 (Skilled)",
	_page = false,
	_id = 96,
	_japanese_name = "零式艦戦21型(熟練)",
	_reading = "れいしきかんせん21がた(じゅくれん)",
	_type = 6,
	_icon = 6,
	_rarity = 3,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = 8,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 2,
	_torpedo_accuracy = false,
	_evasion = 2,
	_los = 1,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = 4,
	_flight_range = 7,
	_special = false,
	_scrap_fuel = 1,
	_scrap_ammo = 1,
	_scrap_steel = false,
	_scrap_bauxite = 2,
	_info = "熟練搭乗員で構成された「零式艦上戦闘機」装備の艦戦隊です。7.7mm機銃2門と自慢の20mm機銃2門、優れた格闘戦能力と長大な航続距離。搭乗員達の高い技量もあって、初期段階では圧倒的な力を誇りました。艦隊の上空直援や攻撃隊の護衛で活躍しま。",
	_buildable = false,
	_improvements = {
		_fuel = 100,
		_ammo = 80,
		_steel = false,
		_bauxite = 250,
		_products = {
			["Type 0 Fighter Model 32 (Skilled)"] = {
				_ships = {
					["Akagi/"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
					["Akagi/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
					["Akagi/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
					["Akagi/Kai Ni E"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
					["Kaga/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Kaga/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Kaga/Kai Ni"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Kaga/Kai Ni E"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Kaga/Kai Ni Go"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 2,
					_development_material_x = 4,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["Type 0 Fighter Model 21"] = 2},
				},
				[6] = {
					_development_material = 3,
					_development_material_x = 5,
					_improvement_material = 2,
					_improvement_material_x = 5,
					_equipment = {["Type 0 Fighter Model 21"] = 3},
				},
				[10] = {
					_development_material = 4,
					_development_material_x = 7,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["7.7mm Machine Gun"] = 3},
				},
				_stars = 3,
			},
		},
	},
}