--Categories:
--[[Category:Equipment modules]]

return {
    _name = "F6F-5",
    _id = 206,
    _japanese_name = "F6F-5",
    _reading = nil,
    _type = 6, -- 3,5,6,6,21
    _icon = 6,
    _rarity = 5,
    _firepower = 1,
    _bombing = false,
    _torpedo = false,
    _aa = 10,
    _armor = false,
    _asw = false,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = 3,
    _los = 1,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 8,
    _flight_range = 5,
    _special = false,
    _scrap_fuel = 2,
    _scrap_ammo = 4,
    _scrap_steel = false,
    _scrap_bauxite = 5,
    _info = "大戦初期の太平洋上で零戦としのぎを削った艦上戦闘機F4Fシリーズの後継機、F6Fシリーズの後期改良型量産機です。<br>大出力エンジンと強力な火力を装備、さらに防御面も強化した本機は、強力な量産型艦上戦闘機として、戦場の空で零戦を圧倒していきます。",
    _buildable = false,
    _improvements = {
		_fuel = 250,
		_ammo = 250,
		_steel = false,
		_bauxite = 450,
		_products = {
			[false] = {
				_ships = {
					["Saratoga/Mk.II"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Saratoga/Mk.II Mod.2"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 6,
					_improvement_material_x = 7,
					_equipment = {["Shiden Kai 2"] = 2},
				},
				[6] = {
					_development_material = 12,
					_development_material_x = 16,
					_improvement_material = 8,
					_improvement_material_x = 12,
					_equipment = {["Prototype Reppuu Late Model"] = 1},
				},
			},
		},
	},
}