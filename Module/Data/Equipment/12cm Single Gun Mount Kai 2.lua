--Categories:
--[[Category:Equipment modules]]

return {
    _name = "12cm Single Gun Mount Kai 2",
    _id = 293,
    _japanese_name = "12cm単装砲改二",
    _reading = nil,
    _type = 1, -- 1,1,1,1,0
    _icon = 1,
    _rarity = 2,
    _firepower = 1,
    _bombing = false,
    _torpedo = false,
    _aa = false,
    _armor = 1,
    _asw = false,
    _shelling_accuracy = 1,
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
    _scrap_ammo = 1,
    _scrap_steel = 1,
    _scrap_bauxite = false,
    _buildable = false,
    _info = "旧型駆逐艦に標準的主砲として搭載された小口径主砲の改良型です。装填・操砲も人力ですが、シンプルな構造で経済性も高く、駆逐艦や海防艦等の主砲として、長く使われました本兵装を戦訓を取り入れて改良、実戦時の運用性を大きく向上させています。残念ながら対空射撃には不向きです。",
    _improvements = {
		_fuel = 10,
		_ammo = 30,
		_steel = 50,
		_bauxite = 10,
		_products = {
			[false] = {
				_ships = {
					["Mutsuki/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = false},
					["Kisaragi/Kai Ni"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 4,
					_improvement_material = 2,
					_improvement_material_x = 2,
					_equipment = {["12cm Single Gun Mount"] = 2},
				},  
				[6] = {
					_development_material = 4,
					_development_material_x = 5,
					_improvement_material = 2,
					_improvement_material_x = 4,
					_equipment = {["Type 22 Surface Radar"] = 1},
				},
			},
		},
	},
}