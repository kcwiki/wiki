-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Shimushu",
        _rarity = 4,
        _api_id = 517,
        _id = 317,
        _true_id = false,
        _japanese_name = "占守",
        _reading = "しむしゅ",
        _class = "Shimushu",
        _class_number = 1,
        _type = 1,
        _hp = 9,
        _hp_max = 18,
        _firepower = 4,
        _firepower_max = 18,
        _firepower_mod = 1,
        _armor = 4,
        _armor_max = 16,
        _armor_mod = 0,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 42,
        _evasion_max = 83,
        _aa = 7,
        _aa_max = 24,
        _aa_mod = 0,
        _asw = 32,
        _asw_max = 72,
        _speed = 5,
        _los = 3,
        _los_max = 13,
        _range = 1,
        _luck = 40,
        _luck_max = 79,
        _luck_mod = false,
        _buildable = false,
        _buildable_lsc = false,
        _build_time = 14,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Shimushu/Kai",
        _fuel = 10,
        _ammo = 10,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 2,
        _scrap_baux = 0,
        _equipment = {
            { equipment = "12cm Single Gun Mount", size = 0 },
            { equipment = "25mm Twin Autocannon Mount", size = 0 },
        },
        _voice_flag = 1,
        _voice_actor = "Sasaki Hitomi",
        _artist = "UGUME",
        _implementation_date = { 2017, 5, 2 },
        _availability = { "event_drop" },
        _wikipedia = "Japanese_escort_Shimushu",
    },
    ["Kai"] = {
        _name = "Shimushu",
        _suffix = "Kai",
        _rarity = 5,
        _api_id = 376,
        _id = 317,
        _true_id = 1456,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "占守改",
        _reading = "しむしゅかい",
        _class = "Shimushu",
        _class_number = 1,
        _type = 1,
        _hp = 17,
        _hp_max = 28,
        _firepower = 5,
        _firepower_max = 35,
        _firepower_mod = 1,
        _armor = 7,
        _armor_max = 33,
        _armor_mod = 0,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 58,
        _evasion_max = 92,
        _aa = 11,
        _aa_max = 53,
        _aa_mod = 1,
        _asw = 35,
        _asw_max = 77,
        _speed = 5,
        _los = 5,
        _los_max = 28,
        _range = 1,
        _luck = 50,
        _luck_max = 89,
        _luck_mod = false,
        _build_time = 14,
        _remodel_level = 40,
        _remodel_ammo = 90,
        _remodel_steel = 60,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Shimushu/",
        _remodel_to = false,
        _fuel = 10,
        _ammo = 10,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 2,
        _scrap_baux = 0,
        _equipment = {
            { equipment = "Type 94 Depth Charge Projector", size = 0 },
            { equipment = "Type 95 Depth Charge", size = 0 },
            { equipment = "25mm Twin Autocannon Mount", size = 0 },
        },
        _voice_flag = 1,
    },
    class = {
        _name = "Shimushu",
        _class = true,
        _base_type = 1,
    },
}