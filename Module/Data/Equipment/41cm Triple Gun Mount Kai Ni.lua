--Categories:
--[[Category:Equipment modules]]

return {
    _name = "41cm Triple Gun Mount Kai Ni",
    _id = 290,
    _japanese_name = "41cm三連装砲改二",
    _reading = "41センチさんれんそうほうかいに",
    _type = 3, -- 1,1,3,3,0
    _icon = 3,
    _rarity = 5,
    _firepower = 23,
    _bombing = false,
    _torpedo = false,
    _aa = 6,
    _armor = false,
    _asw = false,
    _shelling_accuracy = 5,
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
    _scrap_steel = 22,
    _scrap_bauxite = 6,
    _buildable = false,
    _info = "呉海軍工廠砲熕部で開発された純国産戦艦用三連装主砲、その改修改良型です。if兵装ではありますが、軽量化及び射撃装置を熟成改良した同改良砲を、航空戦艦への装備、特に伊勢型航空戦艦に最適化改修した戦艦主砲兵装です。特に大規模改装後の伊勢型改二では、その潜在能力を遺憾なく発揮します。",
	_improvements = {
		_fuel = 45,
		_ammo = 460,
		_steel = 720,
		_bauxite = 50,
		_products = {
			[false] = {
				_ships = {
					["Ise/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 10,
					_improvement_material = 7,
					_improvement_material_x = 7,
					_equipment = {["41cm Twin Gun Mount"] = 3},
				},
				[6] = {
					_development_material = 14,
					_development_material_x = 41,
					_improvement_material = 10,
					_improvement_material_x = 13,
					_equipment = {["Prototype 41cm Triple Gun Mount"] = 1},
				},
			},
		},
	},
}