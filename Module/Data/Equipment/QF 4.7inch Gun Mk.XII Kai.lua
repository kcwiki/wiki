--Categories:
--[[Category:Equipment modules]]

return {
    _name = "QF 4.7inch Gun Mk.XII Kai",
    _id = 280,
    _japanese_name = "QF 4.7inch砲 Mk.XII改",
    _reading = "QF 4.7インチほう マークトゥエルヴかい",
    _type = 1, -- 1,1,1,1,0
    _icon = 1,
    _rarity = 3,
    _firepower = 3,
    _bombing = false,
    _torpedo = false,
    _aa = 3,
    _armor = false,
    _asw = 1,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = 1,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 1,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 2,
    _scrap_steel = 2,
    _scrap_bauxite = 1,
    _buildable = false,
    _info = "紅茶の国の駆逐艦に搭載された主砲兵装、その改良版です。<br>可愛い駆逐艦用主砲、実戦で鍛え上げられた、優れた対潜戦闘力を誇る紅茶の国の駆逐艦達に、ASDICと共にぜひ搭載したいですね！",
	_improvements = {
		_fuel = 20,
		_ammo = 60,
		_steel = 80,
		_bauxite = 20,
		_products = {
			[false] = {
				_ships = {
					["Jervis/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Jervis/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 6,
					_development_material_x = 7,
					_improvement_material = 4,
					_improvement_material_x = 5,
					_equipment = {["12.7cm Twin Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 7,
					_development_material_x = 8,
					_improvement_material = 6,
					_improvement_material_x = 7,
					_equipment = {["12.7cm Twin Gun Mount Model B Kai 2"] = 2},
				},
			},
		},
	},
}