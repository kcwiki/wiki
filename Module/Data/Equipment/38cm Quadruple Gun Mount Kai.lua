--Categories:
--[[Category:Equipment modules]]

return {
    _name = "38cm Quadruple Gun Mount Kai",
    _id = 246,
    _japanese_name = "38cm四連装砲改",
    _reading = "38センチよんれんそうほうかい",
    _type = 3, -- 1,1,3,3,0
    _icon = 3,
    _rarity = 5,
    _firepower = 22,
    _bombing = false,
    _torpedo = false,
    _aa = 2,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = 3,
    _torpedo_accuracy = false,
    _evasion = false,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 2,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 21,
    _scrap_steel = 24,
    _scrap_bauxite = 4,
    _info = "トリコロールの国で開発された戦艦主砲です。<br>大口径38cm砲四門から構成される迫力の四連装砲で、「Richelieu」級戦艦に装備されました。同砲を熟成、改修した改良大口径主砲装備です。同クラスとしては圧倒的な火力を実現します。",
    _buildable = false,
    _improvements = {
		_fuel = 180,
		_ammo = 480,
		_steel = 800,
		_bauxite = 180,
		_products = {
			[false] = {
				_ships = {
					["Richelieu/Kai"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 16,
					_development_material_x = 18,
					_improvement_material = 7,
					_improvement_material_x = 8,
					_equipment = {["41cm Twin Gun Mount"] = 3},
				},
				[6] = {
					_development_material = 20,
					_development_material_x = 24,
					_improvement_material = 8,
					_improvement_material_x = 10,
					_equipment = {["Prototype 35.6cm Triple Gun Mount"] = 1},
				},
				_stars = false,
			}
		}
	},
}