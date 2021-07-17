-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "I-58",
        _nick = "Goya",
        _rarity = 4,
        _api_id = 127,
        _id = 127,
        _true_id = false,
        _japanese_name = "伊58",
        _japanese_nick = "ゴーヤ",
        _reading = "い58",
        _reading_nick = false,
        _class = "Junsen Type B Kai Ni",
        _class_number = 3,
        _type = 13,
        _hp = 14,
        _hp_max = 19,
        _firepower = 2,
        _firepower_max = 9,
        _firepower_mod = false,
        _armor = 4,
        _armor_max = 19,
        _armor_mod = false,
        _torpedo = 30,
        _torpedo_max = 69,
        _torpedo_mod = 2,
        _evasion = 13,
        _evasion_max = 36,
        _aa = 0,
        _aa_max = false,
        _aa_mod = false,
        _asw = 0,
        _asw_max = false,
        _speed = 5,
        _los = 10,
        _los_max = 39,
        _range = 1,
        _luck = 40,
        _luck_max = 79,
        _luck_mod = false,
        _buildable = true,
        _buildable_lsc = false,
        _build_time = 22,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "I-58/Kai",
        _fuel = 10,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 2,
        _scrap_baux = 1,
        _equipment = {
            { equipment = false, size = 0 },
        },
        _voice_actor = "Nakajima Megumi",
        _artist = "Shobon",
        _implementation_date = { 2013, 8, 1 },
        _availability = { "drop", "event_drop" },
        _wikipedia = "Japanese submarine I-58 (1943)",
    },
    ["Kai"] = {
        _name = "I-58",
        _nick = "Goya",
        _suffix = "Kai",
        _rarity = 5,
        _api_id = 399,
        _id = 127,
        _true_id = 1499,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "伊58改",
        _japanese_nick = "ゴーヤ",
        _reading = "い58かい",
        _reading_nick = false,
        _class = "Junsen Type B Kai Ni",
        _class_number = 2,
        _type = 14,
        _hp = 18,
        _hp_max = 24,
        _firepower = 3,
        _firepower_max = 12,
        _firepower_mod = false,
        _armor = 5,
        _armor_max = 19,
        _armor_mod = false,
        _torpedo = 36,
        _torpedo_max = 84,
        _torpedo_mod = 2,
        _evasion = 15,
        _evasion_max = 49,
        _aa = 0,
        _aa_max = false,
        _aa_mod = 1,
        _asw = 0,
        _asw_max = false,
        _speed = 5,
        _los = 15,
        _los_max = 39,
        _range = 1,
        _luck = 50,
        _luck_max = 79,
        _luck_mod = false,
        _remodel_level = 50,
        _remodel_ammo = 200,
        _remodel_steel = 140,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "I-58/",
        _remodel_to = false,
        _fuel = 10,
        _ammo = 25,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 2,
        _scrap_baux = 2,
        _equipment = {
            { equipment = false, size = 1 },
            { equipment = false, size = 1 },
        },
    },
}