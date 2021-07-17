--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Ka Type Observation Autogyro",
	_page = false,
	_id = 69,
	_japanese_name = "カ号観測機",
	_reading = "かごうかんそくき",
	_type = 25,
	_icon = 21,
	_rarity = 3,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = false,
	_armor = false,
	_asw = 9,
	_shelling_accuracy = 1,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_special = false,
	_scrap_fuel = 1,
	_scrap_ammo = 1,
	_scrap_steel = false,
	_scrap_bauxite = 4,
	_info = "陸軍で開発、運用されていたオートジャイロ「カ号観測機」。<br/>現代の艦載ヘリコプターの先祖ともいえる、回転翼の艦載対潜哨戒機です。全通甲板を持つ強襲揚陸艦や軽空母、航空甲板を持つ航空巡洋艦などで運用可能です。",
	_wikipedia = "Kayaba Ka-1",
	_buildable = false,
	_improvements = {
		_fuel = 50,
		_ammo = 20,
		_steel = 30,
		_bauxite = 150,
		_products = {
			["O Type Observation Autogyro Kai"] = {
				_ships = {
					["Ise/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 5,
					_development_material_x = 6,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = false,
				},
				[6] = {
					_development_material = 6,
					_development_material_x = 7,
					_improvement_material = 3,
					_improvement_material_x = 4,
					_equipment = {
					    ["Type 0 Reconnaissance Seaplane"] = 1
					},
				},
				[10] = {
					_development_material = 12,
					_development_material_x = 20,
					_improvement_material = 5,
					_improvement_material_x = 10,
					_equipment = {
					    ["Ka Type Observation Autogyro"] = 1,
					    ["New Model Aerial Armament Material"] = 1
					},
				},
			},
		},
	},
}