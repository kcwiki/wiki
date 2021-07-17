-- [[Category:Equipment modules]]

return {
  _name = "16inch Mk.V Twin Gun Mount",
  _id = 331,
  _japanese_name = "16inch Mk.V連装砲",
  _reading = "16インチ マークファイブれんそうほう",
  _type = 3, -- 1,1,3,3,0
  _icon = 3,
  _rarity = 3,
  _firepower = 21,
  _bombing = false,
  _torpedo = false,
  _aa = 2,
  _armor = 2,
  _asw = false,
  _shelling_accuracy = 2,
  _torpedo_accuracy = false,
  _evasion = 1,
  _los = false,
  _speed = false,
  _luck = false,
  _range = 3,
  _flight_cost = false,
  _flight_range = false,
  _special = false,
  _scrap_fuel = false,
  _scrap_ammo = 13,
  _scrap_steel = 21,
  _scrap_bauxite = 2,
  _buildable = false,
  _info = "米国で建造されたビッグセブン、「Colorado」級。その初期の主砲兵装として採用された標準的な16inch連装主砲、その改良強化型です。<br>あの戦いの開戦時オーバーホール中だった「Colorado」級戦艦ネームシップ、そして真珠湾で撃破された妹達も改装を受け、主砲兵装を本砲に順次更新装備していきます。",
  _improvements = {
		_fuel = 30,
		_ammo = 350,
		_steel = 480,
		_bauxite = false,
		_products = {
			["16inch Mk.VIII Twin Gun Mount Kai"] = {
				_ships = {
					["Colorado/"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Colorado/Kai"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 6,
					_development_material_x = 7,
					_improvement_material = 3,
					_improvement_material_x = 4,
					_equipment = {["41cm Twin Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 8,
					_development_material_x = 16,
					_improvement_material = 4,
					_improvement_material_x = 7,
					_equipment = {["41cm Twin Gun Mount"] = 3},
				},
				[10] = {
					_development_material = 17,
					_development_material_x = 27,
					_improvement_material = 7,
					_improvement_material_x = 13,
					_equipment = {
					    ["41cm Twin Gun Mount"] = 4,
					    ["New Model Gun Mount Improvement Material"] = 2,
					    ["New Model Armament Material"] = 2
					},
				},
			},
		},
	},
}