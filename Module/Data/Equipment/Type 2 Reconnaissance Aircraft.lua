--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Type 2 Reconnaissance Aircraft",
	_page = false,
	_id = 61,
	_japanese_name = "二式艦上偵察機",
	_reading = "にしきかんじょうていさつき",
	_type = 9,
	_icon = 9,
	_rarity = 1,
	_back = 2,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = 1,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 3,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = 7,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = 6,
	_flight_range = 5,
	_special = false,
	_scrap_fuel = 3,
	_scrap_ammo = 1,
	_scrap_steel = false,
	_scrap_bauxite = 13,
	_info = "名機「彗星艦爆」の艦上偵察機型です。<br/>偵察用カメラと増加燃料タンクを搭載して、艦隊の目として活躍可能です。ぜひ、彩雲と共に機動部隊で運用してね！",
	_buildable = true,
	_improvements = {
		_fuel = 120,
		_ammo = 40,
		_steel = 20,
		_bauxite = 300,
		_products = {
			[false] = {
				_ships = {
					["Souryuu/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Souryuu/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Souryuu/Kai Ni"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 3,
					_improvement_material_x = 4,
					_equipment = {["Suisei"] = 2},
				},
				[6] = {
					_development_material = 8,
					_development_material_x = 10,
					_improvement_material = 5,
					_improvement_material_x = 7,
					_equipment = {["Type 2 Reconnaissance Aircraft"] = 1},
				},
			},
		},
	},
}