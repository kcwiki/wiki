-- [[Category: Enemy boss ship modules]]

return {
	[""] = {
		_name = "Airfield Princess",
		_rarity = 8,
		_back = -11,
		_api_id = 1556,
		_id = 1556,
		_japanese_name = "飛行場姫",
		_reading = "ひこうじょうき",
		_type = 10,
		_hp = 500,
		_firepower = 70,
		_armor = 140,
		_torpedo = 0,
		_evasion = 1,
		_aa = 120,
		_asw = 0,
		_speed = 0,
		_los = 90,
		_range = 2,
		_luck = 10,
		_equipment = {
		    {equipment = "Abyssal Fighter Mark.II", size = 98},
		    {equipment = "Abyssal Fighter Mark.II", size = 98},
		    {equipment = "Abyssal Dive Bomber Mark.II", size = 98},
		    {equipment = "Abyssal Torpedo Bomber Mark.II", size = 98},
		},
	},
	["A"] = "/II",
	["II"] = {
		_name = "Airfield Princess",
		_suffix = "II",
		_rarity = 8,
		_back = -12,
		_api_id = 1631,
		_id = 1631,
		_battle_card_layers = {"hell_r"},
		_japanese_name = "飛行場姫",
		_reading = "ひこうじょうき",
		_type = 10,
		_hp = 500,
		_firepower = 85,
		_armor = 160,
		_torpedo = 0,
		_evasion = 10, -- from Kan Colle Kai
		_aa = 120,
		_asw = 0,
		_speed = 0,
		_los = 90, -- from Kan Colle Kai
		_range = 3,
		_luck = 40, -- from Kan Colle Kai
		_equipment = {
			{equipment = "Abyssal Cat Fighter Kai", size = 98},
			{equipment = "Abyssal Hell Dive Bomber", size = 98},
			{equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 98},
			{equipment = "Abyssal Revenge Torpedo Bomber", size = 98},
		},
	},
	["B"] = "/III",
	["III"] = {
		_name = "Airfield Princess",
		_suffix = "III",
		_rarity = 8,
		_back = -12,
		_api_id = 1632,
		_id = 1632,
		_battle_card_reference = "/II",
		_battle_card_layers = {"hell_r1", "revenge_kai_r2"},
		_cg_reference = "/II",
		_japanese_name = "飛行場姫",
		_reading = "ひこうじょうき",
		_type = 10,
		_hp = 500,
		_firepower = 90,
		_armor = 175,
		_torpedo = 0,
		_evasion = 20, -- from Kan Colle Kai
		_aa = 130,
		_asw = 0,
		_speed = 0,
		_los = 100, -- from Kan Colle Kai
		_range = 3,
		_luck = 50, -- from Kan Colle Kai
		_equipment = {
			{equipment = "Abyssal Cat Fighter Kai", size = 98},
			{equipment = "Abyssal Hell Dive Bomber Kai", size = 98},
			{equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 98},
			{equipment = "Abyssal Revenge Torpedo Bomber", size = 98},
		},
	},
	["C"] = "/IV",
	["IV"] = {
		_name = "Airfield Princess",
		_suffix = "IV",
		_rarity = 8,
		_back = -12,
		_api_id = 1633,
		_id = 1633,
		_battle_card_reference = "/II",
		_battle_card_layers = {"hell_kai_r1", "revenge_kai_r2"},
		_cg_reference = "/II",
		_japanese_name = "飛行場姫",
		_reading = "ひこうじょうき",
		_type = 10,
		_hp = 500,
		_firepower = 95,
		_armor = 190,
		_torpedo = 0,
		_evasion = 30, -- from Kan Colle Kai
		_aa = 140,
		_asw = 0,
		_speed = 0,
		_los = 110, -- from Kan Colle Kai
		_range = 3,
		_luck = 60, -- from Kan Colle Kai
		_equipment = {
			{equipment = "Abyssal Cat Fighter Kai", size = 98},
			{equipment = "Abyssal Hell Dive Bomber Kai", size = 98},
			{equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 98},
			{equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 98},
		},
	},
	["V"] = {
		_name = "Airfield Princess",
		_suffix = "V",
		_rarity = 8,
		_back = -11,
		_api_id = 1650,
		_id = 1650,
		_battle_card_reference = "/",
		_battle_card_layers = {"liberation_r"},
		_cg_reference = "/",
		_japanese_name = "飛行場姫",
		_reading = "ひこうじょうき",
		_type = 10,
		_hp = 500,
		_firepower = 50,
		_armor = 140,
		_torpedo = 0,
		_evasion = nil,
		_aa = 120,
		_asw = 0,
		_speed = 0,
		_los = nil,
		_range = 2,
		_luck = nil,
		_equipment = {
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 12},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 12},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 8},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 4},
			-- https://twitter.com/Croshadow_/status/1082666202500161536
			-- http://kancolleoperationroom.blogspot.com/2019/01/blog-post.html
		},
	},
	["VI"] = {
		_name = "Airfield Princess",
		_suffix = "VI",
		_rarity = 8,
		_back = -11,
		_api_id = 1651,
		_id = 1651,
		_battle_card_reference = "/",
		_battle_card_layers = {"liberation_ace_r1", "liberation_r2"},
		_cg_reference = "/",
		_japanese_name = "飛行場姫",
		_reading = "ひこうじょうき",
		_type = 10,
		_hp = 500,
		_firepower = 60,
		_armor = 140,
		_torpedo = 0,
		_evasion = nil,
		_aa = 120,
		_asw = 0,
		_speed = 0,
		_los = nil,
		_range = 2,
		_luck = nil,
		_equipment = {
			{equipment = "Abyssal Liberation Land-based Dive Bomber Ace", size = 16},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 16},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 12},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 4},
		},
	},
	["VII"] = {
		_name = "Airfield Princess",
		_suffix = "VII",
		_rarity = 8,
		_back = -11,
		_api_id = 1652,
		_id = 1652,
		_battle_card_reference = "/",
		_battle_card_layers = {"liberation_ace_r1", "liberation_ace_r2"},
		_cg_reference = "/",
		_japanese_name = "飛行場姫",
		_reading = "ひこうじょうき",
		_type = 10,
		_hp = 500,
		_firepower = 70,
		_armor = 140,
		_torpedo = 0,
		_evasion = nil,
		_aa = 120,
		_asw = 0,
		_speed = 0,
		_los = nil,
		_range = 2,
		_luck = nil,
		_equipment = {
			{equipment = "Abyssal Liberation Land-based Dive Bomber Ace", size = 24, estimation = true},
			{equipment = "Abyssal Liberation Land-based Dive Bomber Ace", size = 24, estimation = true},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 16, estimation = true},
			{equipment = "Abyssal Liberation Land-based Dive Bomber", size = 8, estimation = true},
		},
	},
  ["VIII"] = {
    _name = "Airfield Princess",
    _suffix = "VIII",
    _rarity = 8,
    _back = -11,
    _api_id = 1889,
    _id = 1889,
    _battle_card_reference = "/",
	_battle_card_layers = {"fortress_r"},
	_cg_reference = "/",
    _japanese_name = "飛行場姫",
    _reading = "ひこうじょうき",
    _type = 10,
    _hp = 500,
    _firepower = nil,
    _armor = nil,
    _torpedo = nil,
    _evasion = nil,
    _aa = nil,
    _asw = nil,
    _speed = 0,
    _los = nil,
    _range = nil,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal Sky Fortress (Reconnaissance Model)", size = 9},
      {equipment = "Abyssal Sky Fortress (Reconnaissance Model)", size = 9},
      {equipment = "Abyssal Liberation Land-based Dive Bomber Ace", size = 12},
    },
    -- https://twitter.com/Croshadow_/status/1170221292487790594
  },
  ["IX"] = {
    _name = "Airfield Princess",
    _suffix = "IX",
    _rarity = 8,
    _back = -11,
    _api_id = 1890,
    _id = 1890,
    _battle_card_reference = "/",
	_battle_card_layers = {"fortress_ace_r1", "fortress_r2"},
	_cg_reference = "/",
    _japanese_name = "飛行場姫",
    _reading = "ひこうじょうき",
    _type = 10,
    _hp = 500,
    _firepower = nil,
    _armor = nil,
    _torpedo = nil,
    _evasion = nil,
    _aa = nil,
    _asw = nil,
    _speed = 0,
    _los = nil,
    _range = nil,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal Sky Fortress Ace (Reconnaissance Model)", size = 9, estimation = true},
      {equipment = "Abyssal Sky Fortress (Reconnaissance Model)", size = 9, estimation = true},
      {equipment = "Abyssal Liberation Land-based Dive Bomber Ace", size = 12, estimation = true},
      {equipment = "Abyssal Liberation Land-based Dive Bomber", size = 12, estimation = true},
    },
    -- AP = 105, https://twitter.com/Croshadow_/status/1170221292487790594
  },
  ["X"] = {
    _name = "Airfield Princess",
    _suffix = "X",
    _rarity = 8,
    _back = -11,
    _api_id = 1891,
    _id = 1891,
    _battle_card_reference = "/",
	_battle_card_layers = {"fortress_ace_r1", "fortress_ace_r2"},
	_cg_reference = "/",
    _japanese_name = "飛行場姫",
    _reading = "ひこうじょうき",
    _type = 10,
    _hp = 500,
    _firepower = nil,
    _armor = nil,
    _torpedo = nil,
    _evasion = nil,
    _aa = nil,
    _asw = nil,
    _speed = 0,
    _los = nil,
    _range = nil,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal Sky Fortress Ace (Reconnaissance Model)", size = 9, estimation = true},
      {equipment = "Abyssal Sky Fortress Ace (Reconnaissance Model)", size = 9, estimation = true},
      {equipment = "Abyssal Liberation Land-based Dive Bomber Ace", size = 18, estimation = true},
      {equipment = "Abyssal Liberation Land-based Dive Bomber Ace", size = 12, estimation = true},
    },
    -- AP = 140, https://twitter.com/Croshadow_/status/1170226897025785856
  },
  ["XI"] = {
    _name = "Airfield Princess",
    _suffix = "XI",
    _rarity = 8,
    _back = -11,
    _api_id = 1892,
    _id = 1892,
    _battle_card_reference = "/",
    _battle_card_layers = {"fortress_heavy_r"},
	_cg_reference = "/",
    _japanese_name = "飛行場姫",
    _reading = "ひこうじょうき",
    _type = 10,
    _hp = 500,
    _firepower = 70,
    _armor = 140,
    _torpedo = 0,
    _evasion = nil,
    _aa = 120,
    _asw = nil,
    _speed = 0,
    _los = nil,
    _range = nil,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal Sky Fortress (Heavy Bomber Model)", size = 18, estimation = true},
      {equipment = "Abyssal Sky Fortress (Heavy Bomber Model)", size = 12, estimation = true},
      {equipment = "Abyssal Sky Fortress (Reconnaissance Model)", size = 6, estimation = true},
    },
    _air_power_estimation = true,
  },
  ["XII"] = {
    _name = "Airfield Princess",
    _suffix = "XII",
    _rarity = 8,
    _back = -11,
    _api_id = 1893,
    _id = 1893,
    _battle_card_reference = "/",
    _battle_card_layers = {"fortress_heavy_ace_r1", "fortress_heavy_r2"},
	_cg_reference = "/",
    _japanese_name = "飛行場姫",
    _reading = "ひこうじょうき",
    _type = 10,
    _hp = 500,
    _firepower = 80,
    _armor = 140,
    _torpedo = 0,
    _evasion = nil,
    _aa = 120,
    _asw = nil,
    _speed = 0,
    _los = nil,
    _range = nil,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal Sky Fortress Ace (Heavy Bomber Model)", size = 18, estimation = true},
      {equipment = "Abyssal Sky Fortress (Heavy Bomber Model)", size = 12, estimation = true},
      {equipment = "Abyssal Sky Fortress (Heavy Bomber Model)", size = 12, estimation = true},
      {equipment = "Abyssal Sky Fortress (Reconnaissance Model)", size = 6, estimation = true},
    },
    _air_power_estimation = true,
  },
  ["XIII"] = {
    _name = "Airfield Princess",
    _suffix = "XIII",
    _rarity = 8,
    _back = -11,
    _api_id = 1894,
    _id = 1894,
    _battle_card_reference = "/",
    _battle_card_layers = {"fortress_heavy_ace_r1", "fortress_heavy_ace_r2"},
	_cg_reference = "/",
    _japanese_name = "飛行場姫",
    _reading = "ひこうじょうき",
    _type = 10,
    _hp = 500,
    _firepower = 90,
    _armor = 140,
    _torpedo = 0,
    _evasion = nil,
    _aa = 120,
    _asw = nil,
    _speed = 0,
    _los = nil,
    _range = nil,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal Sky Fortress Ace (Heavy Bomber Model)", size = 36, estimation = true},
      {equipment = "Abyssal Sky Fortress Ace (Heavy Bomber Model)", size = 18, estimation = true},
      {equipment = "Abyssal Sky Fortress Ace (Heavy Bomber Model)", size = 12, estimation = true},
      {equipment = "Abyssal Sky Fortress Ace (Reconnaissance Model)", size = 6, estimation = true},
    },
    _air_power_estimation = true,
  },
}