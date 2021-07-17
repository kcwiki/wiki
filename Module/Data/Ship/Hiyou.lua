-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Hiyou",
        _rarity = 4,
        _api_id = 75,
        _id = 65,
        _true_id = false,
        _japanese_name = "飛鷹",
        _reading = "ひよう",
        _class = "Hiyou",
        _class_number = 1,
        _type = 7,
        _hp = 40,
        _hp_max = 64,
        _firepower = 0,
        _firepower_max = 19,
        _firepower_mod = false,
        _armor = 21,
        _armor_max = 39,
        _armor_mod = 2,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 28,
        _evasion_max = 54,
        _aa = 21,
        _aa_max = 59,
        _aa_mod = 3,
        _asw = 0,
        _asw_max = false,
        _speed = 5,
        _los = 38,
        _los_max = 59,
        _range = 1,
        _luck = 10,
        _luck_max = 49,
        _luck_mod = false,
        _buildable = true,
        _buildable_lsc = true,
        _build_time = 180,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Hiyou/Kai",
        _fuel = 40,
        _ammo = 40,
        _scrap_fuel = 6,
        _scrap_ammo = 6,
        _scrap_steel = 20,
        _scrap_baux = 6,
        _equipment = {
            { equipment = "Type 96 Fighter", size = 12 },
            { equipment = "Type 99 Dive Bomber", size = 18 },
            { equipment = "Type 97 Torpedo Bomber", size = 18 },
            { equipment = false, size = 10 },
        },
        _voice_actor = "Ootsubo Yuka",
        _artist = "Kuu Ro Kuro",
        _implementation_date = { 2013, 4, 23 },
        _availability = { "drop" },
        _wikipedia = "Japanese aircraft carrier Hiyō",
    },
    ["Kai"] = {
        _name = "Hiyou",
        _suffix = "Kai",
        _rarity = 5,
        _api_id = 283,
        _id = 65,
        _true_id = 1383,
        _japanese_name = "飛鷹改",
        _reading = "ひようかい",
        _class = "Hiyou",
        _class_number = 1,
        _type = 7,
        _hp = 50,
        _hp_max = 79,
        _firepower = 0,
        _firepower_max = 29,
        _firepower_mod = false,
        _armor = 30,
        _armor_max = 59,
        _armor_mod = 3,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 28,
        _evasion_max = 69,
        _aa = 25,
        _aa_max = 69,
        _aa_mod = 3,
        _asw = 0,
        _asw_max = false,
        _speed = 5,
        _los = 40,
        _los_max = 79,
        _range = 1,
        _luck = 12,
        _luck_max = 59,
        _luck_mod = false,
        _remodel_level = 25,
        _remodel_ammo = 250,
        _remodel_steel = 500,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Hiyou/",
        _remodel_to = false,
        _fuel = 45,
        _ammo = 45,
        _scrap_fuel = 6,
        _scrap_ammo = 10,
        _scrap_steel = 25,
        _scrap_baux = 8,
        _equipment = {
            { equipment = "Type 0 Fighter Model 52", size = 18 },
            { equipment = "Suisei", size = 18 },
            { equipment = "Type 97 Torpedo Bomber", size = 18 },
            { equipment = false, size = 12 },
        },
    },
    class = {
        _name = "Hiyou",
        _class = true,
        _base_type = 7,
    },
}