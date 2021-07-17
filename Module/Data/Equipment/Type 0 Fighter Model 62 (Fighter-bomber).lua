--Categories:
--[[Category:Equipment modules]]

return {
	_name = "Type 0 Fighter Model 62 (Fighter-bomber)",
	_page = false,
	_id = 60,
	_japanese_name = "零式艦戦62型(爆戦)",
	_reading = "れいしきかんせん62がた(ばくせん)",
	_type = 7,
	_icon = 7,
	_rarity = 2,
	_back = 3,
	_firepower = false,
	_bombing = 4,
	_torpedo = false,
	_aa = 4,
	_armor = false,
	_asw = 3,
	_shelling_accuracy = false,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_flight_cost = 5,
	_flight_range = 4,
	_special = false,
	_scrap_fuel = 1,
	_scrap_ammo = 3,
	_scrap_steel = false,
	_scrap_bauxite = 3,
	_info = "零式艦上戦闘機を艦上爆撃機仕様にした、通称「爆戦」です。<br/>52型の胴体下に250㎏爆弾掛吊架を増設しました。戦闘爆撃機型の機体で、爆撃後はとして空戦に参加できるマルチロールファイター。あの攻撃方法は採用しないで通常攻撃です！",
	_buildable = true,
	_improvements = {
		_fuel = 120,
		_ammo = 120,
		_steel = false,
		_bauxite = 280,
		_products = {
			[false] = {
				_ships = {
					["Junyou/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Junyou/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Junyou/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Shoukaku/"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Shoukaku/Kai"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Shoukaku/Kai Ni"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Shoukaku/Kai Ni A"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Suzuya/Carrier Kai Ni"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 4,
					_development_material_x = 6,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["Type 0 Fighter Model 52"] = 2},
				},
				[6] = {
					_development_material = 5,
					_development_material_x = 9,
					_improvement_material = 4,
					_improvement_material_x = 6,
					_equipment = {["Suisei"] = 2},
				},
			},
			["Type 0 Fighter Model 63 (Fighter-bomber)"] = {
				_ships = {
					["Suzuya/Carrier Kai Ni"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
				},
				[10] = {
					_development_material = 16,
					_development_material_x = 22,
					_improvement_material = 6,
					_improvement_material_x = 9,
					_equipment = {["Prototype Reppuu Late Model"] = 1},
				},
				_stars = nil,
			},
		},
	},
}