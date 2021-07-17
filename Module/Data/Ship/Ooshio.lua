-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Ooshio",
        _rarity = 1,
        _api_id = 96,
        _id = 86,
        _true_id = false,
        _japanese_name = "大潮",
        _reading = "おおしお",
        _class = "Asashio",
        _class_number = 2,
        _type = 2,
        _hp = 16,
        _hp_max = 33,
        _firepower = 10,
        _firepower_max = 29,
        _firepower_mod = false,
        _armor = 6,
        _armor_max = 19,
        _armor_mod = 1,
        _torpedo = 24,
        _torpedo_max = 69,
        _torpedo_mod = 1,
        _evasion = 43,
        _evasion_max = 79,
        _aa = 9,
        _aa_max = 39,
        _aa_mod = false,
        _asw = 21,
        _asw_max = 49,
        _speed = 10,
        _los = 5,
        _los_max = 19,
        _range = 1,
        _luck = 10,
        _luck_max = 49,
        _luck_mod = false,
        _buildable = true,
        _buildable_lsc = false,
        _build_time = 22,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Ooshio/Kai",
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 5,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin Gun Mount", size = 0 },
            { equipment = false, size = 0 },
        },
        _voice_actor = "Miyakawa Wakana",
        _artist = "Konishi",
        _implementation_date = { 2013, 4, 23 },
        _availability = { "drop" },
        _wikipedia = "Japanese destroyer Ōshio",
    },
    ["Kai"] = {
        _name = "Ooshio",
        _suffix = "Kai",
        _rarity = 4,
        _api_id = 249,
        _id = 86,
        _true_id = 1349,
        _japanese_name = "大潮改",
        _reading = "おおしおかい",
        _class = "Asashio",
        _class_number = 2,
        _type = 2,
        _hp = 31,
        _hp_max = 49,
        _firepower = 12,
        _firepower_max = 49,
        _firepower_mod = 1,
        _armor = 14,
        _armor_max = 49,
        _armor_mod = 1,
        _torpedo = 28,
        _torpedo_max = 79,
        _torpedo_mod = 1,
        _evasion = 46,
        _evasion_max = 89,
        _aa = 16,
        _aa_max = 49,
        _aa_mod = 1,
        _asw = 24,
        _asw_max = 59,
        _speed = 10,
        _los = 8,
        _los_max = 39,
        _range = 1,
        _luck = 12,
        _luck_max = 59,
        _luck_mod = false,
        _remodel_level = 20,
        _remodel_ammo = 100,
        _remodel_steel = 100,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Ooshio/",
        _remodel_to = "Ooshio/Kai Ni",
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 10,
        _scrap_baux = false,
        _equipment = {
            { equipment = "10cm Twin High-angle Gun Mount", size = 0 },
            { equipment = "61cm Quadruple (Oxygen) Torpedo Mount", size = 0 },
            { equipment = false, size = 0 },
        },
    },
    ["Kai Ni"] = {
        _name = "Ooshio",
        _suffix = "Kai Ni",
        _rarity = 6,
        _api_id = 199,
        _id = 199,
        _true_id = false,
        _japanese_name = "大潮改二",
        _reading = "おおしおかいに",
        _class = "Asashio",
        _class_number = 2,
        _type = 2,
        _hp = 31,
        _hp_max = 53,
        _firepower = 17,
        _firepower_max = 67,
        _firepower_mod = 2,
        _armor = 14,
        _armor_max = 51,
        _armor_mod = 1,
        _torpedo = 33,
        _torpedo_max = 90,
        _torpedo_mod = 2,
        _evasion = 47,
        _evasion_max = 90,
        _aa = 20,
        _aa_max = 62,
        _aa_mod = 1,
        _asw = 26,
        _asw_max = 64,
        _speed = 10,
        _los = 12,
        _los_max = 54,
        _range = 1,
        _luck = 17,
        _luck_max = 69,
        _luck_mod = false,
        _remodel_level = 65,
        _remodel_ammo = 200,
        _remodel_steel = 270,
        _remodel_development_material = false,
        _remodel_blueprint = true,
        _remodel_catapult = false,
        _remodel_from = "Ooshio/Kai",
        _remodel_to = false,
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 10,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin Gun Mount Model B Kai 2", size = 0 },
            { equipment = "61cm Quadruple (Oxygen) Torpedo Mount", size = 0 },
            { equipment = "Daihatsu Landing Craft", size = 0 },
        },
        _implementation_date = { 2016, 4, 1 },
    },
    seasonals = {
        { _suffix = "Mackerel Pike Festival", _season = "Fall 2018" },
        { _suffix = "Kai Ni Mackerel Pike Festival", _season = "Fall 2018", _season_suffix = "Kai Ni" },
    },
}