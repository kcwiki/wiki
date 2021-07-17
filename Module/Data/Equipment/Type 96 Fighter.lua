--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Type 96 Fighter",
	_page = false,
	_id = 19,
	_japanese_name = "九六式艦戦",
	_reading = "きゅうろくしきかんせん",
	_type = 6,
	_icon = 6,
	_rarity = 0,
	_back = 1,
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
	_flight_cost = 3,
	_flight_range = 3,
	_special = false,
	_scrap_fuel = 1,
	_scrap_ammo = 1,
	_scrap_steel = false,
	_scrap_bauxite = 1,
	_info = "旧式の艦上戦闘機です。<br/>零戦より前に実戦配備されていた旧型機ですが、優れた格闘戦能力を持っています。<br/>武装や航続力、速度の点で既に二線級ではありますが、防空戦闘には活用可能です。",
	_wikipedia = "Mitsubishi A5M",
	_buildable = true,
	_improvements = {
		_fuel = 70,
		_ammo = 50,
		_steel = false,
		_bauxite = 170,
		_products = {
			["Type 0 Fighter Model 21"] = {
				_ships = {
					["Houshou/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Houshou/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 1,
					_development_material_x = 3,
					_improvement_material = 1,
					_improvement_material_x = 2,
					_equipment = {[true] = 1},
				},
				[6] = {
					_development_material = 2,
					_development_material_x = 4,
					_improvement_material = 1,
					_improvement_material_x = 3,
					_equipment = {["7.7mm Machine Gun"] = 1},
				},
				[10] = {
					_development_material = 3,
					_development_material_x = 6,
					_improvement_material = 2,
					_improvement_material_x = 4,
					_equipment = {[true] = 2},
				},
				_stars = 3,
			},
		},
	},
}