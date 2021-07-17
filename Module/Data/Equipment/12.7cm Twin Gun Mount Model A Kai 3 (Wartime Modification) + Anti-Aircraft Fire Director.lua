--Categories:
--[[Category:Equipment modules]]

return {
    _name = "12.7cm Twin Gun Mount Model A Kai 3 (Wartime Modification) + Anti-Aircraft Fire Director",
    _id = 295,
    _japanese_name = "12.7cm連装砲A型改三(戦時改修)+高射装置",
    _reading = nil,
    _type = 1, -- 1,1,1,16,0
    _icon = 16,
    _rarity = 3,
    _firepower = 2,
    _bombing = false,
    _torpedo = false,
    _aa = 8,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = false,
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
    _scrap_bauxite = 2,
    _buildable = false,
    _info = "旧式化したA型砲、その余剰装備を元に全面改修を実施、両用砲に換装した戦時改修if駆逐艦主砲です。最大仰角、装填機構の換装、高射装置との連動も含め、従来のA型砲とは全く別の特型駆逐艦用主砲兵装となっています。両用砲として、ある程度対空戦闘も可能です。",
    _improvements = {
		_fuel = 10,
		_ammo = 70,
		_steel = 160,
		_bauxite = 70,
		_products = {
			[false] = {
				_ships = {
					["Uranami/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 4,
					_improvement_material_x = 5,
					_equipment = {["10cm Twin High-angle Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 9,
					_development_material_x = 10,
					_improvement_material = 6,
					_improvement_material_x = 9,
					_equipment = {["12.7cm Twin Gun Mount Model A Kai 2"] = 1},
				},
				_stars = false,
			}
		}
	},
    _bonus = {
        ["@<span class='explain' title='Fubuki/Ayanami/Akatsuki'>DD</span>-class"] = {
            _firepower = 2,
            _aa = 2,
        },
        ["@<span class='explain' title='Fubuki/Ayanami/Akatsuki'>DD</span>-class <span class='explain' title='Air RADAR'>[[File:Radar.png]]</span>"] = {
            _firepower = 2,
            _aa = 8,
        },
        ["@<span class='explain' title='Fubuki/Ayanami/Akatsuki'>DD</span>-class <span class='explain' title='Surface RADAR'>[[File:Radar.png]]</span>"] = {
            _firepower = 5,
            _torpedo = 1,
            _aa = 2,
            _evasion = 2,
        },
    },
}