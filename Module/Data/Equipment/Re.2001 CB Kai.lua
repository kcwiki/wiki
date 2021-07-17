-- [[Category:Equipment modules]]

return {
  _name = "Re.2001 CB Kai",
  _id = 316,
  _japanese_name = "Re.2001 CB改",
  _reading = nil,
  _type = 7, -- 3,5,7,7,14
  _icon = 7,
  _rarity = 4,
  _firepower = 3,
  _bombing = 6,
  _torpedo = false,
  _aa = 4,
  _armor = false,
  _asw = 3,
  _shelling_accuracy = 1,
  _torpedo_accuracy = false,
  _evasion = 2,
  _los = false,
  _speed = false,
  _luck = false,
  _range = false,
  _flight_cost = 6,
  _flight_range = 3,
  _special = false,
  _scrap_fuel = 1,
  _scrap_ammo = 4,
  _scrap_steel = false,
  _scrap_bauxite = 6,
  _buildable = false,
  _info = "パスタの国で開発/配備された液冷エンジン装備の戦闘機、<br>その戦闘爆撃機タイプです。<br>比較的大きな打撃力を持ち、爆弾投下後は制空戦闘で活躍……することもできるかも。艦爆と艦戦の中間的な機体です。あの空母にぜひ載せてあげたいですね！",
  _improvements = {
    	_fuel = 170,
    	_ammo = 220,
    	_steel = false,
    	_bauxite = 380,
    	_products = {
    		["Re.2005 Kai"] = {
    			_ships = {
    			    ["Aquila/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
    			    ["Aquila/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
    			},
    			[0] = {
    				_development_material = 7,
    				_development_material_x = 9,
    				_improvement_material = 3,
    				_improvement_material_x = 4,
    				_equipment = {["Suisei"] = 1},
    			},
    			[6] = {
    				_development_material = 8,
    				_development_material_x = 10,
    				_improvement_material = 4,
    				_improvement_material_x = 7,
    				_equipment = {["Suisei Model 12A"] = 1},
    			},
    			[10] = {
    				_development_material = 30,
    				_development_material_x = 50,
    				_improvement_material = 9,
    				_improvement_material_x = 17,
    				_equipment = {
    				["Spitfire Mk.V"] = 1,
    				["New Model Aerial Armament Material"] = 3,
    				["Skilled Crew Member"] = 1
					},
    			},
    		},
        },
    },
}