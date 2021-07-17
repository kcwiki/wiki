--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Skua",
    _id = 248,
    _japanese_name = "Skua",
    _reading = nil,
    _type = 7, -- 3,5,7,7,14
    _icon = 7,
    _rarity = 2,
    _firepower = false,
    _bombing = 4,
    _torpedo = false,
    _aa = 2,
    _armor = false,
    _asw = 2,
    _shelling_accuracy = false,
    _torpedo_accuracy = false,
    _evasion = 2,
    _los = false,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 4,
    _flight_range = 4,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 2,
    _scrap_steel = false,
    _scrap_bauxite = 1,
    _buildable = false,
    _info = "紅茶の国で生まれた運動性の高い艦上爆撃機です。<br/>非力ではありますが、高性能な艦上戦闘機を装備しない初期の同海軍の海上航空戦力として、よく空を支えました。名機「Spitfire」の艦戦型などにその任を引き継いでいきます。",
    _improvements = {
        _fuel = 90,
        _ammo = 70,
        _steel = false,
        _bauxite = 220,
        _products = {
            [false] = {
                _ships = {
                    ["Ark Royal/"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = false},
                    ["Ark Royal/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = true, Thursday = true, Friday = true, Saturday = false},
                },
                [0] = {
                    _development_material = 3,
					_development_material_x = 4,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {["Type 96 Fighter"] = 1},
                },
                [6] = {
                    _development_material = 4,
                    _development_material_x = 6,
                    _improvement_material = 2,
                    _improvement_material_x = 4,
                    _equipment = {["Type 0 Fighter Model 21"] = 1},
                },
            },
        },
    },
}