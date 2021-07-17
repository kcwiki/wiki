--Categories:
--[[Category:Equipment modules]]
 
return {
	_name = "Type 3 Fighter Hien",
	_localized_name = "Type 3 Fighter Flying Swallow",
	_page = false,
	_id = 176,
	_japanese_name = "三式戦 飛燕",
	_reading = "さんしきせん ひえん",
	_type = 48,
	_icon = 44,
	_rarity = 3,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = 8,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 1,
	_torpedo_accuracy = false,
	_evasion = 3,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = 7,
	_flight_range = 3,
	_special = false,
	_scrap_fuel = 1,
	_scrap_ammo = 2,
	_scrap_steel = false,
	_scrap_bauxite = 6,
	_info = "かの国で開発された液冷エンジンを参考に開発された、液冷エンジンを装備した陸軍戦闘機、三式戦「飛燕」です。残念ながら信頼性に難があり、その実力を十分に発揮できませんでしたが、万全な状態であれば高い潜在力を持っています。",
	_wikipedia = "Kawasaki Ki-61",
	_buildable = false,
	_improvements = {
		_fuel = 100,
		_ammo = 150,
		_steel = 0,
		_bauxite = 330,
		_products = {
			["Type 3 Fighter Hien Model 1D"] = {
				_ships = {
					["Akitsu Maru/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Akitsu Maru/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Kasuga Maru/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Taiyou/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Taiyou/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Taiyou/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 6,
					_development_material_x = 7,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["Type 0 Fighter Model 21"] = 1},
				},
				[6] = {
					_development_material = 8,
					_development_material_x = 10,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["Type 0 Fighter Model 32"] = 1},
				},
				[10] = {
					_development_material = 12,
					_development_material_x = 20,
					_improvement_material = 6,
					_improvement_material_x = 10,
					_equipment = {
					    ["Type 0 Fighter Model 52"] = 3,
					    ["New Model Aerial Armament Material"] = 1
					},
				},
				_stars = false,
			}
		}
	},
}