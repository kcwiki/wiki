--Categories:
--[[Category:Equipment modules]]

return {
    _name = "New Kanhon Design Anti-torpedo Bulge (Large)",
    _page = false,
    _id = 204,
    _japanese_name = "艦本新設計 増設バルジ(大型艦)",
    _reading = "かんほんしんせっけいぞうせつバルジ(おおがたかん)",
    _type = 28,
    _icon = 23,
    _rarity = 3,
    _firepower = false,
    _bombing = false,
    _torpedo = false,
    _aa = false,
    _armor = 10,
    _asw = false,
    _shelling_accuracy = false,
    _torpedo_accuracy = false,
    _evasion = -2,
    _los = false,
    _speed = false,
    _luck = false,
    _range = false,
    _special = false,
    _scrap_fuel = false,
    _scrap_ammo = false,
    _scrap_steel = 30,
    _scrap_bauxite = 3,
    _info = "艦政本部によって新設計された、大型艦艇の防御力を強化する増加装甲の一種です。戦艦・正規空母等の大型艦艇への増設により防御力を高めることが可能です。<br/>(戦艦級・正規空母級に適用可能です)",
    _wikipedia = "Anti-torpedo bulge",
    _buildable = false,
    _improvements = {
		_fuel = 180,
		_ammo = false,
		_steel = 980,
		_bauxite = 80,
		_products = {
			[false] = {
				_ships = {
					["Musashi/"] = {Sunday = true, Monday = false, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Musashi/Kai"] = {Sunday = true, Monday = false, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Musashi/Kai Ni"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Yamato/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = true},
					["Yamato/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = false, Saturday = true},
				},
				[0] = {
					_development_material = 20,
					_development_material_x = 30,
					_improvement_material = 6,
					_improvement_material_x = 9,
					_equipment = {["Anti-torpedo Bulge (Large)"] = 1},
				},
				[6] = {
					_development_material = 32,
					_development_material_x = 48,
					_improvement_material = 8,
					_improvement_material_x = 12,
					_equipment = {["Anti-torpedo Bulge (Large)"] = 2},
				},
			},
		},
	},
}