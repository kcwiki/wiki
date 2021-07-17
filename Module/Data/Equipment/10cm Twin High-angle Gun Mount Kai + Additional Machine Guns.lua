--Categories:
--[[Category:Equipment modules]]

return {
    _name = "10cm Twin High-angle Gun Mount Kai + Additional Machine Guns",
    _id = 275,
    _japanese_name = "10cm連装高角砲改+増設機銃",
    _reading = "10cmれんそうこうかくほう+ぞうせつきじゅう",
    _type = 4, -- 1,2,4,16,0
    _icon = 16,
    _rarity = 4,
    _firepower = 2,
    _bombing = false,
    _torpedo = false,
    _aa = 9,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = 2,
    _torpedo_accuracy = false,
    _evasion = 1,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 1,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 3,
    _scrap_steel = 4,
    _scrap_bauxite = 2,
    _info = "優れた艦隊防空能力を持つ長10cm高角砲。同砲の大型艦対空装備用の改良兵装です。<br>秋月型防空駆逐艦などに装備された長10cm高角砲の大型艦搭載用改良バージョンに、増設機銃集中配備を組み合わせた対空兵装パッケージです。",
    _wikipedia = "10 cm/65 Type 98 naval gun",
    _buildable = false,
	_improvements = {
		_fuel = 10,
		_ammo = 90,
		_steel = 170,
		_bauxite = 80,
		_products = {
			[false] = {
				_ships = {
					["Ooyodo/"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Ooyodo/Kai"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Musashi/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 7,
					_development_material_x = 8,
					_improvement_material = 4,
					_improvement_material_x = 5,
					_equipment = {["10cm Twin High-angle Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 10,
					_development_material_x = 16,
					_improvement_material = 6,
					_improvement_material_x = 8,
					_equipment = {["25mm Triple Autocannon Mount"] = 2},
				},
			},
		},
	},
}