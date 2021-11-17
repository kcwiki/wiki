-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Yamato",
        _rarity = 8,
        _api_id = 131,
        _id = 131,
        _true_id = false,
        _japanese_name = "大和",
        _reading = "やまと",
        _class = "Yamato",
        _class_number = 1,
        _type = 9,
        _hp = 93,
        _hp_max = 98,
        _firepower = 96,
        _firepower_max = 129,
        _firepower_mod = 7,
        _armor = 88,
        _armor_max = 108,
        _armor_mod = 5,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 27,
        _evasion_max = 59,
        _aa = 50,
        _aa_max = 94,
        _aa_mod = 2,
        _asw = 0,
        _asw_max = false,
        _speed = 5,
        _los = 15,
        _los_max = 39,
        _range = 4,
        _luck = 12,
        _luck_max = 79,
        _luck_mod = false,
        _buildable = false,
        _buildable_lsc = true,
        _build_time = 480,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Yamato/Kai",
        _fuel = 250,
        _ammo = 300,
        _scrap_fuel = 35,
        _scrap_ammo = 50,
        _scrap_steel = 100,
        _scrap_baux = 10,
        _equipment = {
            { equipment = "46cm Triple Gun Mount", size = 7 },
            { equipment = "15.5cm Triple Secondary Gun Mount", size = 7 },
            { equipment = "Type 0 Observation Seaplane", size = 7 },
            { equipment = false, size = 7 },
        },
        _voice_actor = "Taketatsu Ayana",
        _artist = "Shizuma Yoshinori",
        _implementation_date = { 2013, 8, 8 },
        _availability = { "event_reward" },
        _wikipedia = "Japanese battleship Yamato",
    },
    ["Kai"] = {
        _name = "Yamato",
        _suffix = "Kai",
        _rarity = 8,
        _api_id = 136,
        _id = 136,
        _true_id = false,
        _japanese_name = "大和改",
        _reading = "やまとかい",
        _class = "Yamato",
        _class_number = 1,
        _type = 9,
        _hp = 96,
        _hp_max = 108,
        _firepower = 92,
        _firepower_max = 142,
        _firepower_mod = 6,
        _armor = 92,
        _armor_max = 118,
        _armor_mod = 6,
        _torpedo = 0,
        _torpedo_max = false,
        _torpedo_mod = false,
        _evasion = 28,
        _evasion_max = 64,
        _aa = 68,
        _aa_max = 104,
        _aa_mod = 3,
        _asw = 0,
        _asw_max = false,
        _speed = 5,
        _los = 17,
        _los_max = 39,
        _range = 4,
        _luck = 13,
        _luck_max = 88,
        _luck_mod = false,
        _remodel_level = 60,
        _remodel_ammo = 2500,
        _remodel_steel = 3000,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Yamato/",
        _remodel_to = false,
        _fuel = 250,
        _ammo = 325,
        _scrap_fuel = 35,
        _scrap_ammo = 50,
        _scrap_steel = 110,
        _scrap_baux = 20,
        _equipment = {
            { equipment = "46cm Triple Gun Mount", size = 7 },
            { equipment = "12.7cm Twin High-angle Gun Mount", size = 7 },
            { equipment = "Type 22 Surface Radar", size = 7 },
            { equipment = false, size = 8 },
        },
        _gun_fit_properties = {
            ["35.6cm/38cm"] = 0,
            ["381mm"] = 0,
            ["41cm"] = 0,
            ["16inch"] = nil,
            ["Proto 46cm"] = 0,
            ["46cm"] = 0,
            ["51cm"] = 0,
        },
    },
    seasonals = {
        { _suffix = "Summer", _season = "Early Summer 2016" },
        { _suffix = "New Year", _season = "New Year 2018" },
        { _suffix = "Winter 2018 Event", _season = "Eve Of Battle 2018" },
        { _suffix = "Kai Winter 2018 Event", _season = "Eve Of Battle 2018" },
        { _suffix = "Cleaning", _season = "Fifth Anniversary" },
    },
    class = {
        _name = "Yamato",
        _class = true,
        _base_type = 9,
    },
}