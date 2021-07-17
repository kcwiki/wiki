-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Kisaragi",
        _rarity = 2,
        _api_id = 2,
        _id = 32,
        _true_id = false,
        _japanese_name = "如月",
        _reading = "きさらぎ",
        _class = "Mutsuki",
        _class_number = 2,
        _type = 2,
        _hp = 13,
        _hp_max = 24,
        _firepower = 6,
        _firepower_max = 29,
        _firepower_mod = false,
        _armor = 5,
        _armor_max = 18,
        _armor_mod = false,
        _torpedo = 18,
        _torpedo_max = 49,
        _torpedo_mod = 1,
        _evasion = 37,
        _evasion_max = 69,
        _aa = 7,
        _aa_max = 29,
        _aa_mod = false,
        _asw = 16,
        _asw_max = 39,
        _speed = 10,
        _los = 4,
        _los_max = 17,
        _range = 1,
        _luck = 10,
        _luck_max = 49,
        _luck_mod = false,
        _buildable = true,
        _buildable_lsc = false,
        _build_time = 18,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Kisaragi/Kai",
        _fuel = 15,
        _ammo = 15,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 4,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12cm Single Gun Mount", size = 0 },
            { equipment = false, size = 0 },
        },
        _voice_actor = "Hidaka Rina",
        _artist = "Kusada Souta",
        _implementation_date = { 2013, 4, 23 },
        _availability = { "drop" },
        _wikipedia = "Japanese destroyer Kisaragi (1925)",
    },
    ["Kai"] = {
        _name = "Kisaragi",
        _suffix = "Kai",
        _rarity = 4,
        _api_id = 255,
        _id = 32,
        _true_id = 1355,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "如月改",
        _reading = "きさらぎかい",
        _class = "Mutsuki",
        _class_number = 2,
        _type = 2,
        _hp = 24,
        _hp_max = 39,
        _firepower = 9,
        _firepower_max = 39,
        _firepower_mod = false,
        _armor = 11,
        _armor_max = 39,
        _armor_mod = false,
        _torpedo = 18,
        _torpedo_max = 69,
        _torpedo_mod = 1,
        _evasion = 40,
        _evasion_max = 89,
        _aa = 12,
        _aa_max = 39,
        _aa_mod = false,
        _asw = 18,
        _asw_max = 59,
        _speed = 10,
        _los = 6,
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
        _remodel_from = "Kisaragi/",
        _remodel_to = "Kisaragi/Kai Ni",
        _fuel = 15,
        _ammo = 15,
        _scrap_fuel = 1,
        _scrap_ammo = 1,
        _scrap_steel = 4,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin Gun Mount", size = 0 },
            { equipment = "61cm Triple Torpedo Mount", size = 0 },
            { equipment = false, size = 0 },
        },
    },
    ["Kai Ni"] = {
        _name = "Kisaragi",
        _suffix = "Kai Ni",
        _rarity = 6,
        _api_id = 435,
        _id = 235,
        _true_id = false,
        _japanese_name = "如月改二",
        _reading = "きさらぎかいに",
        _class = "Mutsuki",
        _class_number = 2,
        _type = 2,
        _hp = 27,
        _hp_max = 43,
        _firepower = 10,
        _firepower_max = 46,
        _firepower_mod = 1,
        _armor = 12,
        _armor_max = 43,
        _armor_mod = false,
        _torpedo = 28,
        _torpedo_max = 80,
        _torpedo_mod = 2,
        _evasion = 50,
        _evasion_max = 91,
        _aa = 18,
        _aa_max = 57,
        _aa_mod = 1,
        _asw = 27,
        _asw_max = 69,
        _speed = 10,
        _los = 9,
        _los_max = 44,
        _range = 1,
        _luck = 13,
        _luck_max = 60,
        _luck_mod = false,
        _remodel_level = 65,
        _remodel_ammo = 100,
        _remodel_steel = 170,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Kisaragi/Kai",
        _remodel_to = false,
        _fuel = 15,
        _ammo = 15,
        _scrap_fuel = 1,
        _scrap_ammo = 2,
        _scrap_steel = 7,
        _scrap_baux = false,
        _equipment = {
            { equipment = "12.7cm Twin High-angle Gun Mount (Late Model)", size = 0 },
            { equipment = "61cm Triple (Oxygen) Torpedo Mount", size = 0 },
            { equipment = "Enhanced Kanhon Type Boiler", size = 0 },
        },
        _implementation_date = { 2015, 4, 23 },
    },
    seasonals = {
        { _suffix = "Valentine", _season = "Valentines 2015" },
        { _suffix = "Setsubun", _season = "Setsubun 2018" },
    },
}