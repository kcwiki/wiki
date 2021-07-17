--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Spitfire Mk.V",
    _id = 251,
    _japanese_name = "Spitfire Mk.V",
    _reading = nil,
    _type = 48, -- 22,39,48,44,29
    _icon = 44,
    _rarity = 4,
    _firepower = 1,
    _bombing = false,
    _torpedo = false,
    _aa = 9,
    _armor = false,
    _asw = false,
    _shelling_accuracy = 3,
    _torpedo_accuracy = false,
    _evasion = 2,
    _los = false,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 5,
    _flight_range = 5,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 2,
    _scrap_steel = false,
    _scrap_bauxite = 6,
    _info = "紅茶の国を代表する主力戦闘機、「Spitfire」。<br>バトル・オブ・ブリテンでは見事な本土防空戦を戦い、その空を守り抜いた名機の性能向上量産型です。様々な性能向上型が生まれ、やがて艦上戦闘機型の「Seafire」も誕生します。",
    _wikipedia = "Supermarine Spitfire",
    _buildable = false,
    _improvements = {
    	_fuel = 120,
    	_ammo = 160,
    	_steel = false,
    	_bauxite = 380,
    	_products = {
    		["Seafire Mk.III Kai"] = {
    			_ships = {
    			    ["Ark Royal/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
    			    ["Nelson/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
    			},
    			[0] = {
    				_development_material = 6,
    				_development_material_x = 7,
    				_improvement_material = 3,
    				_improvement_material_x = 4,
    				_equipment = {["Spitfire Mk.I"] = 1},
    			},
    			[6] = {
    				_development_material = 8,
    				_development_material_x = 10,
    				_improvement_material = 4,
    				_improvement_material_x = 6,
    				_equipment = {["Spitfire Mk.I"] = 1},
    			},
    			[10] = {
    				_development_material = 12,
    				_development_material_x = 24,
    				_improvement_material = 7,
    				_improvement_material_x = 9,
    				_equipment = {
    				    ["Fulmar"] = 2,
    				    ["New Model Aerial Armament Material"] = 1,
    				},
    			},
    		},
        },
    },
}