--Categories:
--[[Category:Equipment modules]]

return {
    _name = "41cm Triple Gun Mount Kai",
    _id = 236,
    _japanese_name = "41cm三連装砲改",
    _reading = "41せんちさんれんそうほうかい",
    _type = 3, -- 1,1,3,3,0
    _icon = 3,
    _rarity = 5,
    _firepower = 22,
    _bombing = false,
    _torpedo = false,
    _aa = 6,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = 4,
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
    _scrap_ammo = 18,
    _scrap_steel = 23,
    _scrap_bauxite = 4,
    _info = "呉海軍工廠砲熕部で試作された純国産戦艦主砲の三連装砲、<br>その改修改良型です。if兵装ではありますが、各部及び射撃装置を熟成改良し、砲弾誘爆防止措置も考慮した同砲を装備した改長門型戦艦は、当時世界列強の「ビッグ７」水準を遥かに凌駕した攻防のバランスと高い砲撃精度を実現します。",
    _buildable = false,
	_improvements = {
		_fuel = 45,
		_ammo = 450,
		_steel = 700,
		_bauxite = 45,
		_products = {
			[false] = {
				_ships = {
					["Nagato/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = false, Friday = false, Saturday = false},
					["Mutsu/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 6,
					_development_material_x = 8,
					_improvement_material = 6,
					_improvement_material_x = 7,
					_equipment = {["41cm Twin Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 10,
					_development_material_x = 12,
					_improvement_material = 7,
					_improvement_material_x = 10,
					_equipment = {["46cm Triple Gun Mount"] = 2},
				},
			},
			["41cm Triple Gun Mount Kai Ni"] = {
				_ships = {
					["Nagato/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = false, Friday = false, Saturday = false},
				},
				[10] = {
					_development_material = 30,
					_development_material_x = 48,
					_improvement_material = 14,
					_improvement_material_x = 20,
					_equipment = {
					    ["Prototype 41cm Triple Gun Mount"] = 1,
					    ["New Model Gun Mount Improvement Material"] = 3,
					    ["Action Report"] = 1,
					},
				},
			},
			["41cm Twin Gun Mount Kai Ni"] = {
				_ships = {
					["Mutsu/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[10] = {
					_development_material = 30,
					_development_material_x = 42,
					_improvement_material = 14,
					_improvement_material_x = 19,
					_equipment = {
					    ["Prototype 46cm Twin Gun Mount"] = 1,
					    ["New Model Gun Mount Improvement Material"] = 3,
					    ["Action Report"] = 1,
					},
				},
			},
		},
	},
}