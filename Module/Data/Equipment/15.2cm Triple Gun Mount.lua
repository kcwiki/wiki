--Categories:
--[[Category:Equipment modules]]

return {
    _name = "15.2cm Triple Gun Mount",
    _id = 247,
    _japanese_name = "15.2cm三連装砲",
    _reading = "15.2センチさんれんそうほう",
    _type = 4, -- 1,2,4,4,0
    _icon = 4,
    _rarity = 3,
    _firepower = 6,
    _bombing = false,
    _torpedo = false,
    _aa = 1,
    _armor = false,
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
    _scrap_ammo = 2,
    _scrap_steel = 5,
    _scrap_bauxite = false,
    _info = "トリコロールの国で開発された副砲です。<br>軽巡クラスに搭載する主砲としても運用されました。ぜひ「Richelieu」級戦艦に搭載して、主砲＋主砲+副砲運用を！",
    _buildable = false,
	_improvements = {
		_fuel = 15,
		_ammo = 150,
		_steel = 150,
		_bauxite = 50,
		_products = {
			[false] = {
				_ships = {
					["Richelieu/"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Richelieu/Kai"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 10,
					_development_material_x = 15,
					_improvement_material = 6,
					_improvement_material_x = 6,
					_equipment = {["15.5cm Triple Secondary Gun Mount"] = 1},
				},
				[6] = {
					_development_material = 10,
					_development_material_x = 15,
					_improvement_material = 7,
					_improvement_material_x = 8,
					_equipment = {["Type 22 Surface Radar"] = 2},
				},
			},
		},
	},
}