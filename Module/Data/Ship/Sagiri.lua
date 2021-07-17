-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Sagiri",
        _suffix = false,
        _rarity = 4,
        _api_id = 480,
        _id = 280,
        _true_id = false,
        _japanese_name = "狭霧",
        _reading = "さぎり",
        _class = "Ayanami",
        _class_number = 6,
        _type = 2,
        _hp = 15,
        _hp_max = 29,
        _firepower = 10,
        _firepower_max = 29,
        _firepower_mod = false,
        _armor = 5,
        _armor_max = 19,
        _armor_mod = false,
        _torpedo = 27,
        _torpedo_max = 69,
        _torpedo_mod = 1,
        _evasion = 40,
        _evasion_max = 79,
        _aa = 12,
        _aa_max = 39,
        _aa_mod = false,
        _asw = 20,
        _asw_max = 49,
        _speed = 10,
        _los = 5,
        _los_max = 19,
        _range = 1,
        _luck = 6,
        _luck_max = 46,
        _luck_mod = false,
        _buildable = false,
        _buildable_lsc = false,
        _build_time = 20,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Sagiri/Kai",
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
        _voice_flag = 0,
        _voice_actor = "Suzuki Minori",
        _artist = "drew",
        _implementation_date = { 2017, 8, 10 },
        _availability = { "drop" },
        _wikipedia = "Japanese destroyer Sagiri",
    },
    ["Kai"] = {
        _name = "Sagiri",
        _suffix = "Kai",
        _rarity = 5,
        _api_id = 391,
        _id = 280,
        _true_id = 1471,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "狭霧改",
        _reading = "さぎりかい",
        _class = "Ayanami",
        _class_number = 6,
        _type = 2,
        _hp = 30,
        _hp_max = 49,
        _firepower = 11,
        _firepower_max = 50,
        _firepower_mod = 1,
        _armor = 13,
        _armor_max = 49,
        _armor_mod = 1,
        _torpedo = 27,
        _torpedo_max = 82,
        _torpedo_mod = 1,
        _evasion = 44,
        _evasion_max = 88,
        _aa = 15,
        _aa_max = 49,
        _aa_mod = 1,
        _asw = 24,
        _asw_max = 59,
        _speed = 10,
        _los = 7,
        _los_max = 41,
        _range = 1,
        _luck = 7,
        _luck_max = 57,
        _luck_mod = false,
        _build_time = 20,
        _remodel_level = 30,
        _remodel_ammo = 130,
        _remodel_steel = 110,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Sagiri/",
        _remodel_to = false,
        _fuel = 15,
        _ammo = 20,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 10,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin Gun Mount Model B Kai 2", size = 0 },
            { equipment = "Type 94 Depth Charge Projector", size = 0 },
            { equipment = "25mm Single Autocannon Mount", size = 0 },
        },
        _voice_flag = 3,
    },
    seasonals = {
        { _suffix = "Mackerel Pike Festival", _season = "Sanma 2017" },
        { _suffix = "Autumn Casual", _season = "Fall 2017" },
        { _suffix = "Late Fall Casual", _season = "Late Fall 2017" },
        { _suffix = "Christmas", _season = "Christmas 2017" },
        { _suffix = "Rainy", _season = "Rainy Season 2018" },
        { _suffix = "Setsubun", _season = "Setsubun 2019" },
        { _suffix = "Valentine", _season = "Valentines 2019" },
        { _suffix = "Hinamatsuri", _season = "Spring 2019" },
        { _suffix = "Yukata", _season = "Fall 2020" },
    },
}