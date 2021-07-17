--Categories:
--[[Category:Equipment modules]]

return {
    _name = "SK Radar",
    _id = 278,
    _japanese_name = "SK レーダー",
    _reading = nil,
    _type = 13, -- 5,8,13,11,0
    _icon = 11,
    _rarity = 3,
    _firepower = false,
    _bombing = false,
    _torpedo = false,
    _aa = 8,
    _armor = false,
    _asw = false,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = 2,
    _los = 10,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = false,
    _flight_range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = false,
    _scrap_steel = 21,
    _scrap_bauxite = 25,
    _buildable = false,
    _info = "米国で開発・運営された対空早期監視レーダーです。探知距離も大きく優れた能力を持っています。本レーダーと迎撃戦闘機隊の連携、そしてエセックス級などの新型かつ強力な航空母艦の投入は、圧倒的な艦隊防空網を発揮します。",
    _improvements = {
		_fuel = 10,
		_ammo = false,
		_steel = 270,
		_bauxite = 200,
		_products = {
			["SK + SG Radar"] = {
				_ships = {
					["Gambier Bay/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 20,
					_development_material_x = 24,
					_improvement_material = 5,
					_improvement_material_x = 6,
					_equipment = {["Type 21 Air Radar"] = 1},
				},
				[6] = {
					_development_material = 28,
					_development_material_x = 36,
					_improvement_material = 7,
					_improvement_material_x = 9,
					_equipment = {["Type 13 Air Radar Kai"] = 1},
				},
				[10] = {
					_development_material = 50,
					_development_material_x = 100,
					_improvement_material = 18,
					_improvement_material_x = 30,
					_equipment = {
						["SG Radar (Initial Model)"] = 1,
					},
				},
			},
		},
	},
}