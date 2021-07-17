-- [[Category:Player ship modules]]

return {
  [""] = {
    _name = "Giuseppe Garibaldi",
    _suffix = false,
    _rarity = 6,
    _api_id = 590,
    _id = 390,
    _true_id = false,
    _japanese_name = "G.Garibaldi",
    _reading = "ガリバルディ",
    _class = "Duca degli Abruzzi",
    _class_number = 2,
    _type = 3,
    _hp = 37,
    _hp_max = 55,
    _firepower = 28,
    _firepower_max = 50,
    _firepower_mod = 2,
    _armor = 33,
    _armor_max = 51,
    _armor_mod = 2,
    _torpedo = 20,
    _torpedo_max = 66,
    _torpedo_mod = 1,
    _evasion = 34,
    _evasion_max = 65,
    _aa = 20,
    _aa_max = 60,
    _aa_mod = 1,
    _asw = 20,
    _asw_max = 40,
    _speed = 10,
    _los = 12,
    _los_max = 40,
    _range = 2,
    _luck = 20,
    _luck_max = 89,
    _luck_mod = false,
    _buildable = false,
    _buildable_lsc = false,
    _build_time = 70,
    _remodel_level = false,
    _remodel_from = false,
    _remodel_to = "Giuseppe Garibaldi/Kai",
    _fuel = 40,
    _ammo = 50,
    _scrap_fuel = 2,
    _scrap_ammo = 3,
    _scrap_steel = 12,
    _scrap_baux = 2,
    _equipment = {
      {equipment = "152mm/55 Triple Rapid Fire Gun Mount", size = 2},
      {equipment = false, size = 2},
      {equipment = false, size = 2},
    },
    _voice_flag = 1,
    _voice_actor = "Asami Haruna",
    _artist = "Jiji",
    _implementation_date = {2019, 5, 21},
    _availability = { "event_reward" },
    _wikipedia = "Italian cruiser Giuseppe_Garibaldi (1936)",
  },
  ["Kai"] = {
    _name = "Giuseppe Garibaldi",
    _suffix = "Kai",
    _rarity = 7,
    _api_id = 691,
    _id = 390,
    _true_id = 1491,
    _japanese_name = "G.Garibaldi改",
    _reading = "ガリバルディかい",
    _class = "Duca degli Abruzzi",
    _class_number = 2,
    _type = 3,
    _hp = 52,
    _hp_max = 63,
    _firepower = 34,
    _firepower_max = 72,
    _firepower_mod = 3,
    _armor = 42,
    _armor_max = 75,
    _armor_mod = 2,
    _torpedo = 22,
    _torpedo_max = 70,
    _torpedo_mod = 1,
    _evasion = 38,
    _evasion_max = 78,
    _aa = 24,
    _aa_max = 70,
    _aa_mod = 1,
    _asw = 25,
    _asw_max = 60,
    _speed = 10,
    _los = 13,
    _los_max = 48,
    _range = 2,
    _luck = 30,
    _luck_max = 100,
    _luck_mod = false,
    _build_time = 70,
    _remodel_level = 45,
    _remodel_ammo = 320,
    _remodel_steel = 400,
    _remodel_development_material = false,
    _remodel_blueprint = false,
    _remodel_catapult = false,
    _remodel_report = false,
    _remodel_from = "Giuseppe Garibaldi/",
    _remodel_to = false,
    _fuel = 40,
    _ammo = 55,
    _scrap_fuel = 3,
    _scrap_ammo = 6,
    _scrap_steel = 16,
    _scrap_baux = 2,
    _equipment = {
      {equipment = "152mm/55 Triple Rapid Fire Gun Mount Kai", size = 2},
      {equipment = false, size = 2},
      {equipment = false, size = 2},
      {equipment = false, size = 2},
    },
    _voice_flag = 3,
  },
}