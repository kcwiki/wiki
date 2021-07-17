-- [[Category:Equipment modules]]

return {
	_name = "O Type Observation Autogyro Kai",
	_id = 324,
	_japanese_name = "オ号観測機改",
	_reading = "オごうかんそくきかい",
	_type = 25, -- 3,15,25,21,0
	_icon = 21,
	_rarity = 4,
	_firepower = 1,
	_bombing = false,
	_torpedo = false,
	_aa = false,
	_armor = false,
	_asw = 10,
	_shelling_accuracy = 1,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = false,
	_flight_range = false,
	_special = false,
	_scrap_fuel = 1,
	_scrap_ammo = 2,
	_scrap_steel = false,
	_scrap_bauxite = 4,
	_buildable = false,
	_info = "陸軍で開発、運用されていたオートジャイロ。その対潜戦闘力を強化したif強化型改修機です。<br>現代の艦載ヘリコプターの先祖ともいえる、回転翼の艦載対潜哨戒機、全通甲板を持つ強襲揚陸艦や軽空母、改装航空戦艦、航空甲板を持つ航空巡洋艦などで運用可能です。",
	_improvements = {
		_fuel = 60,
		_ammo = 60,
		_steel = 30,
		_bauxite = 160,
		_products = {
			["O Type Observation Autogyro Kai Ni"] = {
				_ships = {
					["Hyuuga/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 6,
					_development_material_x = 7,
					_improvement_material = 3,
					_improvement_material_x = 4,
					_equipment = false,
				},
				[6] = {
					_development_material = 7,
					_development_material_x = 8,
					_improvement_material = 4,
					_improvement_material_x = 5,
					_equipment = {["Type 96 Fighter"] = 1},
				},
				[10] = {
					_development_material = 16,
					_development_material_x = 30,
					_improvement_material = 7,
					_improvement_material_x = 14,
					_equipment = {
					    ["Ka Type Observation Autogyro"] = 1,
					    ["New Model Aerial Armament Material"] = 1
					},
				},
			},
		},
	},
}