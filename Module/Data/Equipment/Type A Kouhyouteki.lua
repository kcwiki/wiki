-- [[Category:Equipment modules]]

return {
  _name = "Type A Kouhyouteki",
  _id = 41,
  _japanese_name = "甲標的 甲型",
  _reading = "こうひょうてきこうがた",
  _type = 22, -- 2,4,22,5,0
  _icon = 5,
  _rarity = 1,
  _firepower = false,
  _bombing = false,
  _torpedo = 12,
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
  _flight_cost = false,
  _flight_range = false,
  _special = false,
  _scrap_fuel = false,
  _scrap_ammo = 7,
  _scrap_steel = 7,
  _scrap_bauxite = false,
  _buildable = true,
  _info = "独自開発された「特殊潜航艇」です。<br>軽巡洋艦や甲標的母艦に改装した水上機母艦、そして潜水艦が搭載して運用します。<br>二発の魚雷を装備し、敵艦に肉薄して雷撃、艦隊決戦を補助する特殊兵器です。",
  _wikipedia = "Type A Kō-hyōteki-class submarine",
  _improvements = {
		_fuel = 30,
		_ammo = 50,
		_steel = 40,
		_bauxite = 20,
		_products = {
			["Type C Kouhyouteki"] = {
				_ships = {
					["Chiyoda/A"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Nisshin/A"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 3,
					_improvement_material = 1,
					_improvement_material_x = 2,
					_equipment = {[true] = 1},
				},
				[6] = {
					_development_material = 3,
					_development_material_x = 6,
					_improvement_material = 2,
					_improvement_material_x = 4,
					_equipment = {[true] = 1},
				},
				[10] = {
					_development_material = 9,
					_development_material_x = 18,
					_improvement_material = 4,
					_improvement_material_x = 8,
					_equipment = {
					    [true] = 1,
					    ["Action Report"] = 1,
					    ["New Model Armament Material"] = 2
					},
				},
			},
		},
	},
}