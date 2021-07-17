-- [[Category:Equipment modules]]

return {
  _name = "Zuiun Kai Ni (634 Air Group)",
  _id = 322,
  _japanese_name = "瑞雲改二(六三四空)",
  _reading = "ずいうんかいに（ろくさんよんくう）",
  _type = 11, -- 5,43,11,10,32
  _icon = 10,
  _rarity = 6,
  _firepower = 2,
  _bombing = 10,
  _torpedo = false,
  _aa = 4,
  _armor = false,
  _asw = 6,
  _shelling_accuracy = 2,
  _torpedo_accuracy = false,
  _evasion = 1,
  _los = 7,
  _speed = false,
  _luck = false,
  _range = false,
  _flight_cost = 8,
  _flight_range = 5,
  _special = false,
  _scrap_fuel = 2,
  _scrap_ammo = 3,
  _scrap_steel = false,
  _scrap_bauxite = 5,
  _buildable = false,
  _info = "急降下爆撃も可能な高性能多用途水上偵察機「瑞雲」。<br>航空戦艦「伊勢」「日向」に搭載し、海上の艦隊運用を前提に編成され、錬成を重ねた六三四航空隊所属の「瑞雲」飛行隊。<br>同12型をさらにチューンナップ、最後まで粘り強く戦い抜いた傑作多用途水上偵察機の最終強化型です。",
  _improvements = {
    _fuel = 240,
    _ammo = 280,
    _steel = false,
    _bauxite = 630,
 	_products = {
 	    [false] = {
 	        _ships = {
				["Hyuuga/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
			},
			[0] = {
				_development_material = 10,
				_development_material_x = 12,
				_improvement_material = 8,
				_improvement_material_x = 8,
				_equipment = {
				    ["Zuiun"] = 2
				},
			},
			[6] = {
				_development_material = 15,
				_development_material_x = 30,
				_improvement_material = 9,
				_improvement_material_x = 12,
				_equipment = {
				    ["Shiden Kai 2"] = 2
				},
			},
		},
	},
  },
}