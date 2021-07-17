--Categories:
--[[Category:Equipment modules]]

return {
    _name = "12.7cm Twin Gun Mount Model B Kai 4 (Wartime Modification) + Anti-Aircraft Fire Director",
    _id = 296,
    _japanese_name = "12.7cm連装砲B型改四(戦時改修)+高射装置",
    _reading = "12.7せんちれんそうほうBがたかいよん（せんじかいしゅう）+こうしゃそうち",
    _type = 1, -- 1,1,1,16,0
    _icon = 16,
    _rarity = 3,
    _firepower = 3,
    _bombing = false,
    _torpedo = false,
    _aa = 9,
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
    _scrap_ammo = 3,
    _scrap_steel = 2,
    _scrap_bauxite = 2,
    _buildable = false,
    _info = "やや旧式化したB型砲の余剰装備に全面改修を実施、両用砲に換装した戦時改修if駆逐艦主砲です。現実的な対空戦闘に対応するため、最大仰角、装填機構の換装、高射装置との連動等、従来のB型砲とは全く別の駆逐艦用兵装に昇華しています。特II型以降、初春型、白露型などでの装備運用を想定して改修され、両用砲として対空戦闘も可能です。",
    _improvements = {
		_fuel = 30,
		_ammo = 90,
		_steel = 130,
		_bauxite = 50,
		_products = {
			[false] = {
				_ships = {
					["Shikinami/Kai Ni"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 10,
					_development_material_x = 12,
					_improvement_material = 6,
					_improvement_material_x = 6,
					_equipment = {["12.7cm Twin Gun Mount Model B Kai 2"] = 2},
				},
				[6] = {
					_development_material = 15,
					_development_material_x = 30,
					_improvement_material = 7,
					_improvement_material_x = 9,
					_equipment = {["Type 94 Anti-Aircraft Fire Director"] = 1},
				},
			},
		},
	},
}