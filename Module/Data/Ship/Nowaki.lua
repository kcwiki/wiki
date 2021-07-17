-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Nowaki",
        _rarity = 5,
        _api_id = 415,
        _id = 215,
        _true_id = false,
        _japanese_name = "野分",
        _reading = "のわき",
        _class = "Kagerou",
        _class_number = 15,
        _type = 2,
        _hp = 16,
        _hp_max = 34,
        _firepower = 10,
        _firepower_max = 29,
        _firepower_mod = false,
        _armor = 6,
        _armor_max = 19,
        _armor_mod = 1,
        _torpedo = 24,
        _torpedo_max = 69,
        _torpedo_mod = 1,
        _evasion = 44,
        _evasion_max = 79,
        _aa = 12,
        _aa_max = 44,
        _aa_mod = false,
        _asw = 24,
        _asw_max = 49,
        _speed = 10,
        _los = 8,
        _los_max = 19,
        _range = 1,
        _luck = 14,
        _luck_max = 49,
        _luck_mod = false,
        _buildable = false,
        _buildable_lsc = false,
        _build_time = 24,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Nowaki/Kai",
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 6,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin Gun Mount", size = 0 },
            { equipment = "61cm Quadruple Torpedo Mount", size = 0 },
        },
        _voice_actor = "Ozawa Ari",
        _artist = "Konishi",
        _implementation_date = { 2014, 11, 14 },
        _availability = { "drop", "event_reward" },
        _wikipedia = "Japanese destroyer Nowaki (1940)",
    },
    ["Kai"] = {
        _name = "Nowaki",
        _suffix = "Kai",
        _rarity = 6,
        _api_id = 329,
        _id = 215,
        _true_id = 1421,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "野分改",
        _reading = "のわきかい",
        _class = "Kagerou",
        _class_number = 15,
        _type = 2,
        _hp = 32,
        _hp_max = 49,
        _firepower = 12,
        _firepower_max = 48,
        _firepower_mod = 1,
        _armor = 14,
        _armor_max = 49,
        _armor_mod = 1,
        _torpedo = 28,
        _torpedo_max = 79,
        _torpedo_mod = 1,
        _evasion = 46,
        _evasion_max = 88,
        _aa = 16,
        _aa_max = 49,
        _aa_mod = 1,
        _asw = 28,
        _asw_max = 68,
        _speed = 10,
        _los = 8,
        _los_max = 39,
        _range = 1,
        _luck = 13,
        _luck_max = 59,
        _luck_mod = false,
        _remodel_level = 35,
        _remodel_ammo = 140,
        _remodel_steel = 110,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Nowaki/",
        _remodel_to = false,
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 10,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin High-angle Gun Mount (Late Model)", size = 0 },
            { equipment = "Type 93 Passive Sonar", size = 0 },
            { equipment = false, size = 0 },
        },
    },
    seasonals = {
        { _suffix = "Winter 2018 Event", _season = "Eve Of Battle 2018" },
    },
}