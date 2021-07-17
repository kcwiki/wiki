--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Type 0 Fighter Model 63 (Fighter-bomber)",
    _page = false,
    _id = 219,
    _japanese_name = "零式艦戦63型(爆戦)",
    _reading = "れいしきかんせん63がた(ばくせん)",
    _type = 7,
    _icon = 7,
    _rarity = 3,
    _firepower = false,
    _bombing = 5,
    _torpedo = false,
    _aa = 5,
    _armor = false,
    _asw = 2,
    _shelling_accuracy = false,
    _torpedo_accuracy = false,
    _evasion = false,
    _los = false,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 6,
    _flight_range = 4,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 4,
    _scrap_steel = false,
    _scrap_bauxite = 4,
    _info = "零式艦上戦闘機の戦闘爆撃機仕様、通称「爆戦」の改良後期型です。改良型エンジンに換装、燃料タンクを防弾仕様化した零戦の性能向上型、53型。その胴体下に250kgまたは500kg爆弾懸吊架を増設、爆撃機動に耐えられるよう、一部機体強度も強化しています。重巡改装の攻撃型軽空母などで、ぜひ機動部隊運用を！",
    _buildable = false,
    _improvements = {
        _fuel = 130,
        _ammo = 140,
        _steel = false,
        _bauxite = 290,
        _products = {
            [false] = {
                _ships = {
                    ["Suzuya/Carrier Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
                    ["Kumano/Carrier Kai Ni"] = {Sunday = false, Monday = false, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = false},
                },
                [0] = {
                    _development_material = 5,
                    _development_material_x = 6,
                    _improvement_material = 4,
                    _improvement_material_x = 6,
                    _equipment = {["Type 0 Fighter Model 52"] = 3}
                },
                [6] = {
                    _development_material = 6,
                    _development_material_x = 9,
                    _improvement_material = 5,
                    _improvement_material_x = 7,
                    _equipment = {["Prototype Reppuu Late Model"] = 1}
                },
            },
        },
    },
}