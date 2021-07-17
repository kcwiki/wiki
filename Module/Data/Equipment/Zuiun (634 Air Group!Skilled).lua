--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Zuiun (634 Air Group/Skilled)",
    _asset_name = "Zuiun (634 Air Group Skilled)",
    _id = 237,
    _japanese_name = "瑞雲(六三四空/熟練)",
    _reading = nil,
    _type = 11, -- 5,43,11,10,2
    _icon = 10,
    _rarity = 5,
    _firepower = false,
    _bombing = 9,
    _torpedo = false,
    _aa = 4,
    _armor = false,
    _asw = 6,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = 1,
    _los = 7,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 7,
    _flight_range = 5,
    _special = false,
    _scrap_fuel = 2,
    _scrap_ammo = 3,
    _scrap_steel = false,
    _scrap_bauxite = 5,
    _info = "急降下爆撃も可能な高性能多用途水上偵察機「瑞雲」。<br/>航空戦艦「伊勢」「日向」等での海上での艦隊運用を前提に編成され、錬成を重ねた六三四航空隊所属の「瑞雲」飛行隊。<br/>実際に航空戦艦での艦隊運用は叶いませんでしたが、<br/>その精鋭「瑞雲」隊は、今ここに。",
    _wikipedia = "634th Naval Air Group",
    _buildable = false,
	_improvements = {
		_fuel = 190,
		_ammo = 190,
		_steel = false,
		_bauxite = 490,
		_products = {
			[false] = {
				_ships = {
					["Hyuuga/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Hyuuga/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = false},
				},
				[0] = {
					_development_material = 8,
					_development_material_x = 10,
					_improvement_material = 6,
					_improvement_material_x = 7,
					_equipment = {["Zuiun"] = 2},
				},
				[6] = {
					_development_material = 10,
					_development_material_x = 16,
					_improvement_material = 7,
					_improvement_material_x = 9,
					_equipment = {["Zuiun"] = 3},
				},
			},
		},
	},
}