--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Spitfire Mk.I",
    _id = 250,
    _japanese_name = "Spitfire Mk.I",
    _reading = nil,
    _type = 48, -- 22,39,48,44,29
    _icon = 44,
    _rarity = 3,
    _firepower = 1,
    _bombing = false,
    _torpedo = false,
    _aa = 7,
    _armor = false,
    _asw = false,
    _shelling_accuracy = 2,
    _torpedo_accuracy = false,
    _evasion = 1,
    _los = false,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 5,
    _flight_range = 4,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 2,
    _scrap_steel = false,
    _scrap_bauxite = 4,
    _info = "紅茶の国を代表する主力戦闘機、「Spitfire」。その初期型です。<br />バトル・オブ・ブリテンでは見事な本土防空戦を戦い、その空を守り抜きました。そして、様々な性能向上型が生まれていきます。",
    _wikipedia = "Supermarine Spitfire",
    _buildable = true,
	_improvements = {
		_fuel = 90,
		_ammo = 130,
		_steel = 0,
		_bauxite = 360,
		_products = {
			["Spitfire Mk.V"] = {
				_ships = {
					["Ark Royal/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Ark Royal/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Jervis/"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Jervis/Kai"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Warspite/"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Warspite/Kai"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 5,
					_development_material_x = 6,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["Type 96 Fighter"] = 1},
				},
				[6] = {
					_development_material = 6,
					_development_material_x = 8,
					_improvement_material = 2,
					_improvement_material_x = 4,
					_equipment = {["Type 0 Fighter Model 21"] = 2},
				},
				[10] = {
					_development_material = 9,
					_development_material_x = 16,
					_improvement_material = 5,
					_improvement_material_x = 7,
					_equipment = {
					    ["Type 0 Fighter Model 32"] = 2,
					    ["New Model Aerial Armament Material"] = 1
					},
				},
				_stars = false,
			}
		}
	},
}