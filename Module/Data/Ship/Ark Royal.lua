-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Ark Royal",
        _suffix = false,
        _rarity = 7,
        _api_id = 515,
        _id = 315,
        _true_id = false,
        _japanese_name = "Ark Royal",
        _reading = "アークロイヤル",
        _class = "Ark Royal",
        _class_number = 1,
        _type = 11,
        _hp = 55,
        _hp_max = 82,
        _firepower = 0,
        _firepower_max = 27,
        _firepower_mod = false,
        _armor = 26,
        _armor_max = 47,
        _armor_mod = 4,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 32,
        _evasion_max = 57,
        _aa = 30,
        _aa_max = 72,
        _aa_mod = 4,
        _asw = 0,
        _asw_max = false,
        _speed = 10,
        _los = 40,
        _los_max = 72,
        _range = 1,
        _luck = 8,
        _luck_max = 58,
        _luck_mod = false,
        _buildable = false,
        _buildable_lsc = true,
        _build_time = 250,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Ark Royal/Kai",
        _fuel = 55,
        _ammo = 50,
        _scrap_fuel = 8,
        _scrap_ammo = 10,
        _scrap_steel = 28,
        _scrap_baux = 7,
        _equipment = {
            { equipment = "Skua", size = 18 },
            { equipment = "Swordfish", size = 30 },
            { equipment = false, size = 12 },
            { equipment = false, size = 12 },
        },
        _voice_flag = 1,
        _voice_actor = "Uchida Shuu",
        _artist = "Konishi",
        _implementation_date = { 2017, 8, 12 },
        _availability = { "event_reward" },
        _wikipedia = "HMS Ark Royal (91)",
    },
    ["Kai"] = {
        _name = "Ark Royal",
        _suffix = "Kai",
        _rarity = 7,
        _api_id = 393,
        _id = 315,
        _true_id = 1473,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "Ark Royal改",
        _reading = "アークロイヤルかい",
        _class = "Ark Royal",
        _class_number = 1,
        _type = 11,
        _hp = 71,
        _hp_max = 90,
        _firepower = 0,
        _firepower_max = 50,
        _firepower_mod = false,
        _armor = 28,
        _armor_max = 70,
        _armor_mod = 4,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 34,
        _evasion_max = 68,
        _aa = 36,
        _aa_max = 82,
        _aa_mod = 4,
        _asw = 0,
        _asw_max = false,
        _speed = 10,
        _los = 42,
        _los_max = 84,
        _range = 1,
        _luck = 13,
        _luck_max = 68,
        _luck_mod = false,
        _build_time = 250,
        _remodel_level = 45,
        _remodel_ammo = 1300,
        _remodel_steel = 1800,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Ark Royal/",
        _remodel_to = false,
        _fuel = 65,
        _ammo = 60,
        _scrap_fuel = 10,
        _scrap_ammo = 14,
        _scrap_steel = 32,
        _scrap_baux = 10,
        _equipment = {
            { equipment = "Fulmar", size = 24 },
            { equipment = "Swordfish", size = 30 },
            { equipment = "QF 2-pounder Octuple Pom-pom Gun Mount", size = 12 },
            { equipment = false, size = 12 },
        },
        _voice_flag = 3,
    },
    class = {
        _name = "Ark Royal",
        _class = true,
        _base_type = 11,
    },
}