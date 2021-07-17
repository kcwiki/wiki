-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Nachi",
        _rarity = 1,
        _api_id = 63,
        _id = 56,
        _true_id = false,
        _japanese_name = "那智",
        _reading = "なち",
        _class = "Myoukou",
        _class_number = 2,
        _type = 5,
        _hp = 44,
        _hp_max = 56,
        _firepower = 40,
        _firepower_max = 54,
        _firepower_mod = 2,
        _armor = 32,
        _armor_max = 49,
        _armor_mod = 2,
        _torpedo = 24,
        _torpedo_max = 49,
        _torpedo_mod = 1,
        _evasion = 34,
        _evasion_max = 59,
        _aa = 16,
        _aa_max = 54,
        _aa_mod = false,
        _asw = 0,
        _asw_max = false,
        _speed = 10,
        _los = 12,
        _los_max = 39,
        _range = 2,
        _luck = 10,
        _luck_max = 49,
        _luck_mod = false,
        _buildable = true,
        _buildable_lsc = false,
        _build_time = 80,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Nachi/Kai",
        _fuel = 40,
        _ammo = 65,
        _scrap_fuel = 2,
        _scrap_ammo = 2,
        _scrap_steel = 12,
        _scrap_baux = 1,
        _equipment = {
            { equipment = "20.3cm Twin Gun Mount", size = 2 },
            { equipment = false, size = 2 },
            { equipment = false, size = 2 },
        },
        _voice_actor = "Taneda Risa",
        _artist = "bob",
        _implementation_date = { 2013, 4, 23 },
        _availability = { "drop" },
        _wikipedia = "Japanese cruiser Nachi",
    },
    ["Kai"] = {
        _name = "Nachi",
        _suffix = "Kai",
        _rarity = 4,
        _api_id = 266,
        _id = 56,
        _true_id = 1366,
        _cg_reference = "/",
        _cg_damaged_reference = "/",
        _japanese_name = "那智改",
        _reading = "なちかい",
        _class = "Myoukou",
        _class_number = 2,
        _type = 5,
        _hp = 55,
        _hp_max = 69,
        _firepower = 48,
        _firepower_max = 76,
        _firepower_mod = 3,
        _armor = 42,
        _armor_max = 73,
        _armor_mod = 2,
        _torpedo = 24,
        _torpedo_max = 69,
        _torpedo_mod = 1,
        _evasion = 39,
        _evasion_max = 79,
        _aa = 18,
        _aa_max = 69,
        _aa_mod = 1,
        _asw = 0,
        _asw_max = false,
        _speed = 10,
        _los = 14,
        _los_max = 49,
        _range = 2,
        _luck = 10,
        _luck_max = 59,
        _luck_mod = false,
        _remodel_level = 25,
        _remodel_ammo = 450,
        _remodel_steel = 300,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Nachi/",
        _remodel_to = "Nachi/Kai Ni",
        _fuel = 40,
        _ammo = 70,
        _scrap_fuel = 4,
        _scrap_ammo = 7,
        _scrap_steel = 20,
        _scrap_baux = 2,
        _equipment = {
            { equipment = "20.3cm Twin Gun Mount", size = 2 },
            { equipment = "12.7cm Twin High-angle Gun Mount", size = 2 },
            { equipment = "61cm Quadruple (Oxygen) Torpedo Mount", size = 2 },
            { equipment = false, size = 2 },
        },
    },
    ["Kai Ni"] = {
        _name = "Nachi",
        _suffix = "Kai Ni",
        _rarity = 6,
        _api_id = 192,
        _id = 192,
        _true_id = false,
        _japanese_name = "那智改二",
        _reading = "なちかいに",
        _class = "Myoukou",
        _class_number = 2,
        _type = 5,
        _hp = 56,
        _hp_max = 71,
        _firepower = 50,
        _firepower_max = 81,
        _firepower_mod = 3,
        _armor = 48,
        _armor_max = 78,
        _armor_mod = 2,
        _torpedo = 34,
        _torpedo_max = 85,
        _torpedo_mod = 1,
        _evasion = 44,
        _evasion_max = 83,
        _aa = 33,
        _aa_max = 83,
        _aa_mod = 2,
        _asw = 0,
        _asw_max = false,
        _speed = 10,
        _los = 20,
        _los_max = 63,
        _range = 2,
        _luck = 18,
        _luck_max = 71,
        _luck_mod = false,
        _remodel_level = 65,
        _remodel_ammo = 900,
        _remodel_steel = 800,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Nachi/Kai",
        _remodel_to = false,
        _fuel = 45,
        _ammo = 75,
        _scrap_fuel = 4,
        _scrap_ammo = 7,
        _scrap_steel = 20,
        _scrap_baux = 2,
        _equipment = {
            { equipment = "20.3cm (No.2) Twin Gun Mount", size = 2 },
            { equipment = "20.3cm (No.2) Twin Gun Mount", size = 2 },
            { equipment = "61cm Quadruple (Oxygen) Torpedo Mount", size = 4 },
            { equipment = false, size = 4 },
        },
        _implementation_date = { 2015, 1, 23 },
    },
}