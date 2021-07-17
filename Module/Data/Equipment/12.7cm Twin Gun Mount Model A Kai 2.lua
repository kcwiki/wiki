--Categories:
--[[Category:Equipment modules]]

return {
    _name = "12.7cm Twin Gun Mount Model A Kai 2",
    _id = 294,
    _japanese_name = "12.7cm連装砲A型改二",
    _reading = "12.7センチれんそうほうAがたかいに",
    _type = 1, -- 1,1,1,1,0
    _icon = 1,
    _rarity = 2,
    _firepower = 2,
    _bombing = false,
    _torpedo = false,
    _aa = 1,
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
    _scrap_ammo = 1,
    _scrap_steel = 2,
    _scrap_bauxite = false,
    _buildable = false,
    _info = "特I型駆逐艦に採用された駆逐艦主砲、その改良型です。防盾で全周を遮蔽、弾片や荒天対策を施しており、動力操砲も採用した近代的駆逐艦用主砲の先駆けである本兵装を改良、特I型での運用性と精度を向上させています。ただし、本質的には平射砲であるため、対空戦闘には不向きです。",
	_improvements = {
		_fuel = 10,
		_ammo = 40,
		_steel = 70,
		_bauxite = false,
		_products = {
			[false] = {
				_ships = {
					["Fubuki/Kai Ni"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 2,
					_development_material_x = 3,
					_improvement_material = 2,
					_improvement_material_x = 2,
					_equipment = {["12.7cm Twin Gun Mount Model A"] = 2},
				},
				[6] = {
					_development_material = 3,
					_development_material_x = 4,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["10cm Twin High-angle Gun Mount"] = 2},
				},
				_stars = false,
			}
		}
	},
}