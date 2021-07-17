--Categories:
--[[Category:Equipment modules]]

return {
    _name = "38cm Quadruple Gun Mount",
    _id = 245,
    _japanese_name = "38cm四連装砲",
    _reading = "38センチよんれんそうほう",
    _type = 3, -- 1,1,3,3,0
    _icon = 3,
    _rarity = 4,
    _firepower = 21,
    _bombing = false,
    _torpedo = false,
    _aa = 1,
    _armor = false,
    _asw = false,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = false,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 3,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 20,
    _scrap_steel = 24,
    _scrap_bauxite = 3,
    _info = "トリコロールの国で開発された戦艦主砲です。<br />大口径38cm砲四門を一つの砲塔に収めたる迫力の四連装砲です。「Richelieu」級戦艦に装備され、大火力を実現します。",
    _buildable = false,
    _improvements = {
		_fuel = 100,
		_ammo = 420,
		_steel = 660,
		_bauxite = 100,
		_products = {
			["38cm Quadruple Gun Mount Kai"] = {
				_ships = {
					["Richelieu/"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Richelieu/Kai"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 12,
					_development_material_x = 14,
					_improvement_material = 6,
					_improvement_material_x = 7,
					_equipment = {["41cm Twin Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 16,
					_development_material_x = 18,
					_improvement_material = 8,
					_improvement_material_x = 9,
					_equipment = {["41cm Twin Gun Mount"] = 4},
				},
				[10] = {
					_development_material = 20,
					_development_material_x = 40,
					_improvement_material = 13,
					_improvement_material_x = 17,
					_equipment = {
					    ["46cm Triple Gun Mount"] = 2,
					    ["New Model Gun Mount Improvement Material"] = 2
					},
				},
				_stars = false,
			}
		}
	},
}