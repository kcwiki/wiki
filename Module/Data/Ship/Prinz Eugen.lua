-- [[Category:Player ship modules]]

return {
    [""] = {
        _name = "Prinz Eugen",
        _rarity = 6,
        _api_id = 176,
        _id = 176,
        _true_id = false,
        _japanese_name = "Prinz Eugen",
        _reading = "プリンツ・オイゲン",
        _class = "Admiral Hipper",
        _class_number = 3,
        _type = 5,
        _hp = 50,
        _hp_max = 72,
        _firepower = 38,
        _firepower_max = 56,
        _firepower_mod = 2,
        _armor = 38,
        _armor_max = 64,
        _armor_mod = 2,
        _torpedo = 32,
        _torpedo_max = 64,
        _torpedo_mod = 1,
        _evasion = 34,
        _evasion_max = 68,
        _aa = 16,
        _aa_max = 44,
        _aa_mod = false,
        _asw = 0,
        _asw_max = false,
        _speed = 10,
        _los = 15,
        _los_max = 40,
        _range = 2,
        _luck = 30,
        _luck_max = 79,
        _luck_mod = false,
        _buildable = false,
        _buildable_lsc = false,
        _build_time = 200,
        _remodel_level = false,
        _remodel_from = false,
        _remodel_to = "Prinz Eugen/Kai",
        _fuel = 50,
        _ammo = 70,
        _scrap_fuel = 2,
        _scrap_ammo = 3,
        _scrap_steel = 15,
        _scrap_baux = 2,
        _equipment = {
            { equipment = "SKC34 20.3cm Twin Gun Mount", size = 3 },
            { equipment = "Ar196 Kai", size = 3 },
            { equipment = false, size = 3 },
        },
        _voice_actor = "Ozawa Ari",
        _artist = "Shimada Humikane",
        _implementation_date = { 2014, 11, 14 },
        _availability = { "event_reward" },
        _wikipedia = "German cruiser Prinz Eugen",
    },
    ["Kai"] = {
        _name = "Prinz Eugen",
        _suffix = "Kai",
        _rarity = 7,
        _api_id = 177,
        _id = 177,
        _true_id = false,
        _japanese_name = "Prinz Eugen改",
        _reading = "プリンツ・オイゲンかい",
        _class = "Admiral Hipper",
        _class_number = 3,
        _type = 5,
        _hp = 63,
        _hp_max = 79,
        _firepower = 48,
        _firepower_max = 75,
        _firepower_mod = 3,
        _armor = 48,
        _armor_max = 82,
        _armor_mod = 3,
        _torpedo = 40,
        _torpedo_max = 84,
        _torpedo_mod = 2,
        _evasion = 40,
        _evasion_max = 74,
        _aa = 18,
        _aa_max = 60,
        _aa_mod = 1,
        _asw = 0,
        _asw_max = false,
        _speed = 10,
        _los = 16,
        _los_max = 50,
        _range = 2,
        _luck = 40,
        _luck_max = 89,
        _luck_mod = false,
        _remodel_level = 45,
        _remodel_ammo = 600,
        _remodel_steel = 700,
        _remodel_development_material = false,
        _remodel_blueprint = false,
        _remodel_catapult = false,
        _remodel_from = "Prinz Eugen/",
        _remodel_to = false,
        _fuel = 55,
        _ammo = 75,
        _scrap_fuel = 4,
        _scrap_ammo = 8,
        _scrap_steel = 22,
        _scrap_baux = 3,
        _equipment = {
            { equipment = "SKC34 20.3cm Twin Gun Mount", size = 3 },
            { equipment = "2cm Flakvierling 38", size = 3 },
            { equipment = "FuMO25 Radar", size = 3 },
            { equipment = false, size = 3 },
        },
    },
}