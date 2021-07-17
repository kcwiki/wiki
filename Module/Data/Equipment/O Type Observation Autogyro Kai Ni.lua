-- [[Category:Equipment modules]]

return {
  _name = "O Type Observation Autogyro Kai Ni",
  _id = 325,
  _japanese_name = "オ号観測機改二",
  _reading = "オごうかんそくきかいに",
  _type = 25, -- 3,15,25,21,0
  _icon = 21,
  _rarity = 5,
  _firepower = 1,
  _bombing = false,
  _torpedo = false,
  _aa = false,
  _armor = false,
  _asw = 11,
  _shelling_accuracy = 1,
  _torpedo_accuracy = false,
  _evasion = false,
  _los = 1,
  _speed = false,
  _luck = false,
  _range = false,
  _flight_cost = false,
  _flight_range = false,
  _special = false,
  _scrap_fuel = 1,
  _scrap_ammo = 3,
  _scrap_steel = false,
  _scrap_bauxite = 4,
  _buildable = false,
  _info = "陸軍で開発、運用されていたオートジャイロ。その対潜戦闘力及びエンジンを強化したif強化型改修最終型です。<br>現代の哨戒ヘリコプターの先祖ともいえる、回転翼の艦載対潜哨戒機、回転翼機運用能力の高い全通甲板を持つ改装航空戦艦などで強力なASWを展開可能です。",
  _improvements = {
		_fuel = 80,
		_ammo = 70,
		_steel = 60,
		_bauxite = 190,
		_products = {
			["S-51J"] = {
				_ships = {
					["Hyuuga/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = false},
				},
			    [0] = {
					_development_material = 7,
					_development_material_x = 8,
					_improvement_material = 4,
					_improvement_material_x = 5,
					_equipment = { ["Type 0 Reconnaissance Seaplane"] = 1 },
				},
				[6] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 5,
					_improvement_material_x = 6,
					_equipment = { ["Type 99 Dive Bomber"] = 2 },
				},
				[10] = {
					_development_material = 50,
					_development_material_x = 80,
					_improvement_material = 10,
					_improvement_material_x = 20,
					_equipment = {
					    [true] = 1,
					    ["New Model Aerial Armament Material"] = 3
					},
				},
			},
		},
	},
}