-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Hatsuharu",
        _rarity = 3,
        _api_id = 38,
        _id = 75,
        _true_id = false,
        _japanese_name = "初春",
        _reading = "はつはる",
        _class = "Hatsuharu",
        _class_number = 1,
        _type = 2,
        _hp = 16,
        _hp_max = 31,
        _firepower = 10,
        _firepower_max = 29,
        _firepower_mod = 1,
        _armor = 6,
        _armor_max = 19,
        _armor_mod = false,
        _torpedo = 27,
        _torpedo_max = 79,
        _torpedo_mod = 1,
        _evasion = 43,
        _evasion_max = 89,
        _aa = 12,
        _aa_max = 39,
        _aa_mod = false,
        _asw = 21,
        _asw_max = 49,
        _speed = 10,
        _los = 5,
        _los_max = 19,
        _range = 1,
        _luck = 12,
        _luck_max = 49,
        _luck_mod = false,
        _buildable = true,
        _buildable_lsc = false,
        _build_time = 20,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Hatsuharu/Kai",
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 5,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin Gun Mount", size = 0 },
            { equipment = "61cm Triple Torpedo Mount", size = 0 },
        },
        _voice_actor = "Kobayashi Motoko",
        _artist = "Ayaki",
        _implementation_date = { 2013, 4, 23 },
        _availability = { "drop" },
        _wikipedia = "Japanese destroyer Hatsuharu (1933)",
    },
    ["Kai"] = {
        _name = "Hatsuharu",
        _suffix = "Kai",
        _rarity = 4,
        _api_id = 238,
        _id = 75,
        _true_id = 1338,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "初春改",
        _reading = "はつはるかい",
        _class = "Hatsuharu",
        _class_number = 1,
        _type = 2,
        _hp = 30,
        _hp_max = 48,
        _firepower = 12,
        _firepower_max = 49,
        _firepower_mod = 1,
        _armor = 13,
        _armor_max = 49,
        _armor_mod = 1,
        _torpedo = 28,
        _torpedo_max = 79,
        _torpedo_mod = 1,
        _evasion = 45,
        _evasion_max = 89,
        _aa = 15,
        _aa_max = 49,
        _aa_mod = 1,
        _asw = 24,
        _asw_max = 59,
        _speed = 10,
        _los = 7,
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
        _remodel_from = "Hatsuharu/",
        _remodel_to = "Hatsuharu/Kai Ni",
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 10,
        _scrap_baux = false,
        _equipment = {
            { equipment = "61cm Triple (Oxygen) Torpedo Mount", size = 0 },
            { equipment = "25mm Twin Autocannon Mount", size = 0 },
            { equipment = false, size = 0 },
        },
    },
    ["Kai Ni"] = {
        _name = "Hatsuharu",
        _suffix = "Kai Ni",
        _rarity = 6,
        _api_id = 326,
        _id = 204,
        _true_id = false,
        _japanese_name = "初春改二",
        _reading = "はつはるかいに",
        _class = "Hatsuharu",
        _class_number = 1,
        _type = 2,
        _hp = 31,
        _hp_max = 52,
        _firepower = 13,
        _firepower_max = 55,
        _firepower_mod = 1,
        _armor = 14,
        _armor_max = 51,
        _armor_mod = 1,
        _torpedo = 32,
        _torpedo_max = 90,
        _torpedo_mod = 2,
        _evasion = 48,
        _evasion_max = 90,
        _aa = 23,
        _aa_max = 73,
        _aa_mod = 1,
        _asw = 30,
        _asw_max = 69,
        _speed = 10,
        _los = 10,
        _los_max = 45,
        _range = 1,
        _luck = 16,
        _luck_max = 59,
        _luck_mod = false,
        _remodel_level = 65,
        _remodel_ammo = 200,
        _remodel_steel = 200,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Hatsuharu/Kai",
        _remodel_to = false,
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 10,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin Gun Mount Model B Kai 2", size = 0 },
            { equipment = "Type 13 Air Radar Kai", size = 0 },
            { equipment = "25mm Triple Autocannon Mount", size = 0 },
        },
        _implementation_date = { 2014, 10, 10 },
    },
    class = {
        _name = "Hatsuharu",
        _class = true,
        _base_type = 2,
    },
}