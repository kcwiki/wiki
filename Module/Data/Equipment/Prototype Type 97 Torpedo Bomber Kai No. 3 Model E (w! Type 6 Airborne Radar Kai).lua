-- [[Category:Equipment modules]]

return {
  _name = "Prototype Type 97 Torpedo Bomber Kai No. 3 Model E (w/ Type 6 Airborne Radar Kai)",
  _asset_name = "Prototype Type 97 Torpedo Bomber Kai No. 3 Model E (w Type 6 Airborne Radar Kai)",
  _id = 344,
  _japanese_name = "九七式艦攻改 試製三号戊型(空六号電探改装備機)",
  _reading = nil,
  _type = 8, -- 3,5,8,46,33
  _icon = 46,
  _rarity = 3,
  _firepower = false,
  _bombing = false,
  _torpedo = 7,
  _aa = false,
  _armor = false,
  _asw = 6,
  _shelling_accuracy = 1,
  _torpedo_accuracy = false,
  _evasion = false,
  _los = 4,
  _speed = false,
  _luck = false,
  _range = false,
  _flight_cost = 6,
  _flight_range = 4,
  _special = false,
  _scrap_fuel = 2,
  _scrap_ammo = 4,
  _scrap_steel = false,
  _scrap_bauxite = 5,
  _buildable = false,
  _info = "初期機動部隊の航空打撃力の中核となった名艦上攻撃機、通称「九七艦攻」。旧式化した同機を強化改修、改良調整を施した機上電探空六号改及び夜間作戦装備を搭載したif改修夜間艦上攻撃機、試製三号艦攻戊型、通称「九七式艦攻改」です。国産の実用夜間攻撃機、その最初の翼をぜひ提督の艦隊に！",
  _improvements = {
		_fuel = 270,
		_ammo = 390,
		_steel = false,
		_bauxite = 470,
		_products = {
			["Tenzan Model 12A Kai (w/ Type 6 Airborne Radar Kai)"] = {
				_ships = {
					["Ryuuhou/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
					["Zuihou/Kai Ni B"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 7,
					_development_material_x = 8,
					_improvement_material = 3,
					_improvement_material_x = 4,
					_equipment = {["Type 97 Torpedo Bomber"] = 2},
				},
				[6] = {
					_development_material = 9,
					_development_material_x = 15,
					_improvement_material = 5,
					_improvement_material_x = 6,
					_equipment = {["Tenzan"] = 2},
				},
				[10] = {
					_development_material = 40,
					_development_material_x = 80,
					_improvement_material = 11,
					_improvement_material_x = 22,
					_equipment = {
					    ["Tenzan Model 12A"] = 1,
					    ["New Model Aerial Armament Material"] = 2,
					    ["Skilled Crew Member"] = 2
					},
				},
			},
		},
	},
}