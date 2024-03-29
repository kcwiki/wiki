-- [[Category: Enemy ship modules]]

return {
	[""] = {
		_name = "Destroyer Ni-Class",
		_rarity = 1,
		_back = -1,
		_api_id = 1504,
		_id = 1504,
		_japanese_name = "駆逐ニ級",
		_reading = "くちくニきゅう",
		_type = 2,
		_hp = 28,
		_firepower = 8,
		_armor = 9,
		_torpedo = 24,
		_evasion = 18,
		_aa = 8,
		_asw = 35,
		_speed = 10,
		_los = 4,
		_range = 1,
		_luck = 5,
		_equipment = {
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "21inch Torpedo Early Model", size = 0},
		},
	},
	["Elite"] = {
		_name = "Destroyer Ni-Class",
		_suffix = "Elite",
		_rarity = 4,
		_back = -2,
		_api_id = 1517,
		_id = 1517,
		_battle_card_extension = "png",
		_japanese_name = "駆逐ニ級elite",
		_reading = "くちくニきゅうエリート",
		_type = 2,
		_hp = 45,
		_firepower = 20,
		_armor = 18,
		_torpedo = 40,
		_evasion = 40,
		_aa = 18,
		_asw = 45,
		_speed = 10,
		_los = 7,
		_range = 1,
		_luck = 10,
		_equipment = {
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "High-speed Abyssal Torpedo", size = 0},
		},
	},
	["Late Model"] = {
		_name = "Destroyer Ni-Class",
		_suffix = "Late Model",
		_rarity = 4,
		_back = -7,
		_api_id = 1578,
		_id = 1578,
		_japanese_name = "駆逐ニ級後期型",
		_reading = "くちくニきゅうこうきがた",
		_type = 2,
		_hp = 40,
		_firepower = 48,
		_armor = 33,
		_torpedo = 84,
		_evasion = 66,
		_aa = 38,
		_asw = 88,
		_speed = 10,
		_los = 28,
		_range = 1,
		_luck = 48,
		_equipment = {
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "High-speed Abyssal Torpedo", size = 0},
			{equipment = "Abyssal Depth Charge Projector", size = 0},
		},
	},
	["Late Model Elite"] = {
		_name = "Destroyer Ni-Class",
		_suffix = "Late Model Elite",
		_rarity = 5,
		_back = -8,
		_api_id = 1624,
		_id = 1624,
		_japanese_name = "駆逐ニ級後期型elite",
		_reading = "くちくニきゅうこうきがたエリート",
		_type = 2,
		_hp = 49,
		_firepower = 64,
		_armor = 48,
		_torpedo = 98,
		_evasion = 80, -- from Kan Colle Kai
		_aa = 48,
		_asw = 98, -- from Kan Colle Kai
		_speed = 10,
		_los = 36, -- from Kan Colle Kai
		_range = 1,
		_luck = 80, -- from Kan Colle Kai
		_opening_asw = true,
		_equipment = {
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "Abyssal FCS + CIC", size = 0},
		},
	},
  ["Kai"] = {
    _name = "Destroyer Ni-Class",
    _suffix = "Kai",
    _rarity = 1,
    _back = -4,
    _api_id = 1858,
    _id = 1858,
    _battle_card_reference = "/",
    _cg_reference = "/",
    _battle_card_damaged_reference = "/",
    _cg_damaged_reference = "/",
    _japanese_name = "駆逐ニ級改",
    _reading = "くちくニきゅうかい",
    _type = 2,
    _hp = 39,
    _firepower = 34,
    _armor = 19,
    _torpedo = 48,
    _evasion = nil,
    _aa = 28,
    _asw = nil,
    _speed = 10,
    _los = nil,
    _range = 2,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal 5inch Single Gun Mount Mk.30", size = 0, estimation = true},
      {equipment = "21inch Torpedo Late Model", size = 0, estimation = true},
      {equipment = "Abyssal Surface Radar", size = 0, estimation = true},
    },
  },
  ["Kai Late Model"] = {
    _name = "Destroyer Ni-Class",
    _suffix = "Kai Late Model",
    _rarity = 4,
    _back = -4,
    _api_id = 1859,
    _id = 1859,
    _battle_card_reference = "/Late Model",
    _cg_reference = "/Late Model",
    _battle_card_damaged_reference = "/Late Model",
    _cg_damaged_reference = "/Late Model",
    _japanese_name = "駆逐ニ級改後期型",
    _reading = "くちくニきゅうかいこうきがた",
    _type = 2,
    _hp = 49,
    _firepower = 54,
    _armor = 39,
    _torpedo = 88,
    _evasion = nil,
    _aa = 48,
    _asw = nil,
    _speed = 10,
    _los = nil,
    _range = 2,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal 5inch Single Gun Mount Mk.30", size = 0, estimation = true},
      {equipment = "21inch Torpedo Late Model", size = 0, estimation = true},
      {equipment = "Abyssal Surface Radar", size = 0, estimation = true},
    },
  },
  ["Kai Late Model Elite"] = {
    _name = "Destroyer Ni-Class",
    _suffix = "Kai Late Model Elite",
    _rarity = 5,
    _back = -5,
    _api_id = 1860,
    _id = 1860,
    _battle_card_reference = "/Late Model Elite",
    _cg_reference = "/Late Model Elite",
    _battle_card_damaged_reference = "/Late Model Elite",
    _cg_damaged_reference = "/Late Model Elite",
    _japanese_name = "駆逐ニ級改後期型elite",
    _reading = "くちくニきゅうかいこうきがたエリート",
    _type = 2,
    _hp = 49,
    _firepower = 64,
    _armor = 49,
    _torpedo = 98,
    _evasion = nil,
    _aa = 58,
    _asw = nil,
    _speed = 10,
    _los = nil,
    _range = 2,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal 5inch Single Gun Mount Mk.30", size = 0, estimation = true},
      {equipment = "21inch Torpedo Late Model", size = 0, estimation = true},
      {equipment = "Abyssal Surface Radar", size = 0, estimation = true},
    },
  },
  ["Kai Late Model Flagship"] = {
    _name = "Destroyer Ni-Class",
    _suffix = "Kai Late Model Flagship",
    _rarity = 8,
    _back = -6,
    _api_id = 1861,
    _id = 1861,
    _japanese_name = "駆逐ニ級改後期型flagship",
    _reading = "くちくニきゅうかいこうきがたフラグシップ",
    _type = 2,
    _hp = 49,
    _firepower = 68,
    _armor = 59,
    _torpedo = 98,
    _evasion = nil,
    _aa = 68,
    _asw = nil,
    _speed = 10,
    _los = nil,
    _range = 2,
    _luck = nil,
    _equipment = {
      {equipment = "Abyssal 5inch Single Gun Mount Mk.30", size = 0, estimation = true},
      {equipment = "21inch Torpedo Late Model", size = 0, estimation = true},
      {equipment = "Abyssal Surface Radar", size = 0, estimation = true},
    },
  },
}