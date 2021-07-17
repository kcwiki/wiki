--Categories:
--[[Category:Equipment modules]]

return {
    _name = "15.5cm Triple Gun Mount Kai",
    _id = 235,
    _japanese_name = "15.5cm三連装砲改",
    _reading = "15.5センチさんれんそうほうかい",
    _type = 2, -- 1,1,2,2,0
    _icon = 2,
    _rarity = 3,
    _firepower = 7,
    _bombing = false,
    _torpedo = false,
    _aa = 5,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = 3,
    _torpedo_accuracy = false,
    _evasion = 1,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 2,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 3,
    _scrap_steel = 6,
    _scrap_bauxite = 1,
    _info = "条約下で保有制限のあった重巡を火力を増強した強力な軽巡で補うために開発された三連装主砲です。射程・発射速度・運用性等のバランスに優れ、対空戦もある程度可能な傑作砲となりました。後に有名な「大和」型戦艦の副砲としても採用されています。本砲は、大型軽巡などでの運用で熟成・改修を重ねた同改良主砲です。",
    _buildable = false,
	_improvements = {
		_fuel = 15,
		_ammo = 120,
		_steel = 150,
		_bauxite = 30,
		_products = {
			["15.5cm Triple Secondary Gun Mount Kai"] = {
				_ships = {
					["Ooyodo/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 6,
					_development_material_x = 7,
					_improvement_material = 4,
					_improvement_material_x = 5,
					_equipment = {["15.5cm Triple Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 5,
					_improvement_material_x = 7,
					_equipment = {["15.5cm Triple Secondary Gun Mount"] = 2},
				},
				[10] = {
					_development_material = 9,
					_development_material_x = 10,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["15.5cm Triple Secondary Gun Mount"] = 1},
				},
				_stars = 7,
			},
		},
	},
}