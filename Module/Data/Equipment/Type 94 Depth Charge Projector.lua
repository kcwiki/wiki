--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Type 94 Depth Charge Projector",
	_page = false,
	_id = 44,
	_japanese_name = "九四式爆雷投射機",
	_reading = "きゅうよんしきばくらいとうしゃき",
	_type = 15,
	_icon = 17,
	_rarity = 0,
	_back = 1,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = false,
	_armor = false,
	_asw = 5,
	_shelling_accuracy = false,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 2,
	_scrap_steel = 1,
	_scrap_bauxite = 1,
	_info = "対潜兵装です。<br/>最も標準的な爆雷投射機です。駆逐艦・海防艦等の小型艦艇に対潜水艦用火力として装備されました。<br/>若干旧式化しつつありますが、敵潜を発見さえできれば、その威力は十分です。",
	_buildable = true,
	_asw_damage_type = 'DCP',
	_improvements = {
		_fuel = 10,
		_ammo = 60,
		_steel = 20,
		_bauxite = 20,
		_products = {
			["Type 3 Depth Charge Projector"] = {
				_ships = {
					[true] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 1,
					_development_material_x = 2,
					_improvement_material = 1,
					_improvement_material_x = 2,
					_equipment = false,
				},
				[6] = {
					_development_material = 2,
					_development_material_x = 3,
					_improvement_material = 1,
					_improvement_material_x = 3,
					_equipment = {[true] = 1},
				},
				[10] = {
					_development_material = 3,
					_development_material_x = 6,
					_improvement_material = 3,
					_improvement_material_x = 8,
					_equipment = {[true] = 2},
				},
				_stars = 3,
			},
		},
	},
}