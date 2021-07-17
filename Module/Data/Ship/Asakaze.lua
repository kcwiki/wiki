-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Asakaze",
        _suffix = false,
        _rarity = 4,
        _api_id = 472,
        _id = 272,
        _true_id = false,
        _japanese_name = "朝風",
        _reading = "あさかぜ",
        _class = "Kamikaze",
        _class_number = 2,
        _type = 2,
        _hp = 12,
        _hp_max = 23,
        _firepower = 5,
        _firepower_max = 29,
        _firepower_mod = 1,
        _armor = 5,
        _armor_max = 17,
        _armor_mod = false,
        _torpedo = 12,
        _torpedo_max = 37,
        _torpedo_mod = 1,
        _evasion = 37,
        _evasion_max = 72,
        _aa = 6,
        _aa_max = 27,
        _aa_mod = false,
        _asw = 17,
        _asw_max = 55,
        _speed = 10,
        _los = 6,
        _los_max = 19,
        _range = 1,
        _luck = 13,
        _luck_max = 72,
        _luck_mod = false,
        _buildable = nil,
        _buildable_lsc = nil,
        _build_time = 18,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Asakaze/Kai",
        _fuel = 15,
        _ammo = 15,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 3,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12cm Single Gun Mount", size = 0 },
            { equipment = "53cm Twin Torpedo Mount", size = 0 },
        },
        _voice_flag = 1,
        _voice_actor = "Itou Shizuka",
        _artist = "Parsley",
        _implementation_date = { 2016, 11, 18 },
        _availability = { "event_drop" },
        _wikipedia = "Japanese destroyer Asakaze (1922)",
    },
    ["Kai"] = {
        _name = "Asakaze",
        _suffix = "Kai",
        _rarity = 5,
        _api_id = 370,
        _id = 272,
        _true_id = 1450,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "朝風改",
        _reading = "あさかぜかい",
        _class = "Kamikaze",
        _class_number = 2,
        _type = 2,
        _hp = 23,
        _hp_max = 38,
        _firepower = 8,
        _firepower_max = 42,
        _firepower_mod = 1,
        _armor = 10,
        _armor_max = 37,
        _armor_mod = false,
        _torpedo = 14,
        _torpedo_max = 69,
        _torpedo_mod = 1,
        _evasion = 50,
        _evasion_max = 88,
        _aa = 10,
        _aa_max = 52,
        _aa_mod = false,
        _asw = 18,
        _asw_max = 68,
        _speed = 10,
        _los = 9,
        _los_max = 47,
        _range = 1,
        _luck = 14,
        _luck_max = 88,
        _luck_mod = false,
        _buildable = nil,
        _buildable_lsc = nil,
        _build_time = 18,
        _remodel_level = 50,
        _remodel_ammo = 150,
        _remodel_steel = 80,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Asakaze/",
        _remodel_to = false,
        _fuel = 15,
        _ammo = 15,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 4,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12cm Single Gun Mount", size = 0 },
            { equipment = "53cm Twin Torpedo Mount", size = 0 },
            { equipment = "Type 94 Depth Charge Projector", size = 0 },
        },
        _voice_flag = 3,
    },
}