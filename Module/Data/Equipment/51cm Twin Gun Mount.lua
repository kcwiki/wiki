--Categories:
--[[Category:Equipment modules]]

return {
    _name = "51cm Twin Gun Mount",
    _id = 281,
    _japanese_name = "51cm連装砲",
    _reading = "51センチれんそうほう",
    _type = 38, -- 1,1,3,3,0
    _icon = 3,
    _rarity = 5,
    _firepower = 32,
    _bombing = false,
    _torpedo = false,
    _aa = 5,
    _armor = 2,
    _asw = false,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = -1,
    _los = false,
    _speed = false,
    _luck = false,
    _range = 4,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = 30,
    _scrap_steel = 28,
    _scrap_bauxite = false,
    _buildable = false,
    _info = "大和型戦艦の発展強化型への搭載が検討されていた大口径大型用戦艦主砲、その完成版です。最大最強の艦艇搭載用砲熕兵装となる本砲は、改装強化された大和型等で運用可能です。<br>実戦配備されることのなかった本砲で、海原で一斉射を！",
	_improvements = {
		_fuel = 100,
		_ammo = 700,
		_steel = 950,
		_bauxite = 200,
		_products = {
			[false] = {
				_ships = {
					["Musashi/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 20,
					_development_material_x = 25,
					_improvement_material = 7,
					_improvement_material_x = 8,
					_equipment = {["41cm Twin Gun Mount"] = 4},
				},
				[6] = {
					_development_material = 25,
					_development_material_x = 50,
					_improvement_material = 10,
					_improvement_material_x = 13,
					_equipment = {["46cm Triple Gun Mount"] = 4},
				},
			},
		},
	},
}