--Categories:
--[[Category:Equipment modules]]

return {
    _name = "46cm Triple Gun Mount Kai",
    _id = 276,
    _japanese_name = "46cm三連装砲改",
    _reading = "46せんちさんれんそうほうかい",
    _type = 3, -- 1,1,3,3,0
    _icon = 3,
    _rarity = 4,
    _firepower = 27,
    _bombing = false,
    _torpedo = false,
    _aa = 6,
    _armor = 2,
    _asw = false,
    _shelling_accuracy = 2,
    _torpedo_accuracy = false,
    _evasion = false,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 4,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 25,
    _scrap_steel = 26,
    _scrap_bauxite = 2,
    _buildable = false,
    _info = "呉海軍工廠砲熕部が極秘開発した世界最大最強級の戦艦主砲、その改良改修型です。<br/>敵主力戦艦に対してアウトレンジが可能な「大和」型戦艦搭載用主砲を、各種戦訓を採り入れて改修強化しました。「大和」「武蔵」への装備、さらに「15.5cm三連装副砲改」との複合装備によって、本兵装はその真価を発揮します。",
	_improvements = {
		_fuel = 50,
		_ammo = 490,
		_steel = 860,
		_bauxite = 80,
		_products = {
			[false] = {
				_ships = {
					["Yamato/Kai"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = false, Friday = false, Saturday = false},
					["Musashi/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Musashi/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 9,
					_improvement_material = 5,
					_improvement_material_x = 6,
					_equipment = {["25mm Triple Autocannon Mount"] = 3},
				},
				[6] = {
					_development_material = 9,
					_development_material_x = 16,
					_improvement_material = 8,
					_improvement_material_x = 9,
					_equipment = {["46cm Triple Gun Mount"] = 3},
				},
				_stars = false,
			},
		},
	},
}