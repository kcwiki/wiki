-- [[Category:Player ship modules]]

return {
  [""] = {
    _name = "De Ruyter",
    _suffix = false,
    _rarity = 4,
    _api_id = 604,
    _id = 399,
    _true_id = false,
    _japanese_name = "De Ruyter",
    _reading = "デ・ロイテル",
    _class = "De Ruyter",
    _class_number = 1,
    _type = 3,
    _hp = 28,
    _hp_max = 43,
    _firepower = 21,
    _firepower_max = 50,
    _firepower_mod = 1,
    _armor = 15,
    _armor_max = 31,
    _armor_mod = 2,
    _torpedo = 0,
    _torpedo_max = 50,
    _torpedo_mod = false,
    _evasion = 35,
    _evasion_max = 68,
    _aa = 20,
    _aa_max = 70,
    _aa_mod = 1,
    _asw = 10,
    _asw_max = 40,
    _speed = 10,
    _los = 10,
    _los_max = 42,
    _range = 2,
    _luck = 9,
    _luck_max = 49,
    _luck_mod = false,
    _buildable = false,
    _buildable_lsc = false,
    _build_time = 60,
    _remodel_level = false,
    _remodel_from = false,
    _remodel_to = "De Ruyter/Kai",
    _fuel = 30,
    _ammo = 35,
    _scrap_fuel = 3,
    _scrap_ammo = 4,
    _scrap_steel = 12,
    _scrap_baux = 1,
    _equipment = {
      {equipment = "Bofors 15cm Twin Rapid Fire Gun Mount Mk.9 Model 1938", size = 1},
      {equipment = false, size = 1},
      {equipment = false, size = 2},
    },
    _voice_flag = 1,
    _voice_actor = "Moriyama Yurika",
    _artist = "Sara",
    _implementation_date = {2019, 11, 30},
    _availability = { "event_drop" },
    _get_message = "",
  },
  ["Kai"] = {
    _name = "De Ruyter",
    _suffix = "Kai",
    _rarity = 5,
    _api_id = 609,
    _id = 399,
    _true_id = 1494,
    _cg_reference = "/",
    _cg_damaged_reference = "/",
    _japanese_name = "De Ruyter改",
    _reading = "デ・ロイテルかい",
    _class = "De Ruyter",
    _class_number = 1,
    _type = 3,
    _hp = 43,
    _hp_max = 60,
    _firepower = 29,
    _firepower_max = 70,
    _firepower_mod = 1,
    _armor = 29,
    _armor_max = 67,
    _armor_mod = 2,
    _torpedo = 0,
    _torpedo_max = 60,
    _torpedo_mod = false,
    _evasion = 39,
    _evasion_max = 73,
    _aa = 25,
    _aa_max = 75,
    _aa_mod = 1,
    _asw = 15,
    _asw_max = 50,
    _speed = 10,
    _los = 12,
    _los_max = 55,
    _range = 2,
    _luck = 10,
    _luck_max = 57,
    _luck_mod = false,
    _build_time = 60,
    _remodel_level = 50,
    _remodel_ammo = 400,
    _remodel_steel = 360,
    _remodel_development_material = false,
    _remodel_blueprint = false,
    _remodel_catapult = false,
    _remodel_report = false,
    _remodel_from = "De Ruyter/",
    _remodel_to = false,
    _fuel = 30,
    _ammo = 40,
    _scrap_fuel = 3,
    _scrap_ammo = 5,
    _scrap_steel = 13,
    _scrap_baux = 1,
    _equipment = {
      {equipment = "Bofors 15cm Twin Rapid Fire Gun Mount Mk.9 Kai + Single Rapid Fire Gun Mount Mk.10 Kai Model 1938", size = 1},
      {equipment = false, size = 2},
      {equipment = false, size = 2},
    },
    _voice_flag = 3,
  },
    seasonals = {
        { _suffix = "Christmas", _season = "Christmas 2019" },
        { _suffix = "Christmas 2", _cg_damaged = false, _season = "Christmas 2019" },
        { _suffix = "Setsubun", _season = "Setsubun 2020" },
    },
    class = {
        _name = "De Ruyter",
        _class = true,
        _base_type = 3,
    },
}