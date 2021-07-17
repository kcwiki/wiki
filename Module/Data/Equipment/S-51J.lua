-- [[Category:Equipment modules]]

return {
	_name = "S-51J",
	_id = 326,
	_japanese_name = "S-51J",
	_reading = nil,
	_type = 25,
	_types = {3, 44, 25, 21, 0},
	_icon = 21,
	_rarity = 6,
	_firepower = 2,
	_bombing = false,
	_torpedo = false,
	_aa = false,
	_armor = false,
	_asw = 12,
	_shelling_accuracy = 2,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = 3,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = false,
	_flight_range = false,
	_special = false,
	_scrap_fuel = 2,
	_scrap_ammo = 3,
	_scrap_steel = false,
	_scrap_bauxite = 5,
	_buildable = false,
	_info = "時代はオートジャイロから、ヘリコプターへ。あの時代に原型機が既に初飛行を実現、哨戒や連絡などを中心に実用化が始まっていた回転翼機、初期のヘリコプターです。戦後、海上自衛隊にも導入された同機のif対潜哨戒型の艦載ヘリです。",
	_improvements = {
		_fuel = 200,
		_ammo = 80,
		_steel = 120,
		_bauxite = 390,
		_products = {
			["S-51J Kai"] = {
				_ships = {
					["Hyuuga/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = true},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 7,
					_improvement_material_x = 7,
					_equipment = {["Zuiun"] = 1},
				},
				[6] = {
					_development_material = 9,
					_development_material_x = 10,
					_improvement_material = 7,
					_improvement_material_x = 9,
					_equipment = {["Saiun"] = 1},
				},
				[10] = {
					_development_material = 50,
					_development_material_x = 80,
					_improvement_material = 10,
					_improvement_material_x = 20,
					_equipment = {
						["Type 95 Depth Charge"] = 2,
						["New Model Aerial Armament Material"] = 1
					},
				},
			},
		},
	},
}