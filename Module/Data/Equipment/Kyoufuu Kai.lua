--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Kyoufuu Kai",
    _localized_name = "Mighty Wind Kai",
    _page = false,
    _id = 217,
    _japanese_name = "強風改",
    _reading = "きょうふうかい",
    _type = 45,
    _icon = 43,
    _rarity = 3,
    _firepower = false,
    _bombing = false,
    _torpedo = false,
    _aa = 5,
    _armor = false,
    _asw = false,
    _shelling_accuracy = false,
    _torpedo_accuracy = false,
    _evasion = 3,
    _los = 1,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 6,
    _flight_range = 3,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 1,
    _scrap_steel = false,
    _scrap_bauxite = 6,
    _info = "現代にも系譜を繋ぐ水上機の名門が開発を手掛けた、空戦に特化した水上機「強風」。難航する本機開発の繋ぎとして投入された二式水戦の後継として、その登場が期待されました。期待された性能を発揮することはできませんでしたが、本機をベースに開発された「紫電改」は本土防空等に奮戦します。機体を熟成、各強度を改良強化した「強風改」として登場です！",
    _wikipedia = "Kawanishi N1K",
    _buildable = false,
    _improvements = {
        _fuel = 130,
        _ammo = 80,
        _steel = false,
        _bauxite = 300,
        _products = {
            [false] = {
                _ships = {
                    ["Mizuho/"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
                    ["Mizuho/Kai"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
                    ["Suzuya/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
                },
                [0] = {
                    _development_material = 10,
                    _development_material_x = 12,
                    _improvement_material = 6,
                    _improvement_material_x = 8,
                    _equipment = {["Shiden Kai 2"] = 1}
                },
                [6] = {
                    _development_material = 12,
                    _development_material_x = 17,
                    _improvement_material = 7,
                    _improvement_material_x = 11,
                    _equipment = {["Shiden Kai 2"] = 1}
                },
            },
        },
    },
}