--Categories:
--[[Category: Enemy ship modules]]

local Destroyer_I_Class = {
	[""] = {
		_name = "Destroyer I-Class",
		_rarity = 1,
		_back = -1,
		_api_id = 1501,
		_id = 1501,
		_japanese_name = "駆逐イ級",
		_reading = "くちくイきゅう",
		_type = 2,
		_hp = 20,
		_firepower = 5,
		_armor = 5,
		_torpedo = 15,
		_evasion = 14,
		_aa = 6,
		_asw = 25,
		_speed = 10,
		_los = 3,
		_range = 1,
		_luck = 1,
		_equipment = {
			{equipment = "5inch Single Gun Mount", size = 0},
			{equipment = false, size = 0},
		},
	},
	["Elite"] = {
		_name = "Destroyer I-Class",
		_suffix = "Elite",
		_rarity = 4,
		_back = -2,
		_api_id = 1514,
		_id = 1514,
		_battle_card_extension = "png",
		_japanese_name = "駆逐イ級elite",
		_reading = "くちくイきゅうエリート",
		_type = 2,
		_hp = 30,
		_firepower = 15,
		_armor = 12,
		_torpedo = 32,
		_evasion = 30,
		_aa = 10,
		_asw = 35,
		_speed = 10,
		_los = 6,
		_range = 1,
		_luck = 10,
		_equipment = {
			{equipment = "5inch Single Gun Mount", size = 0},
			{equipment = "21inch Torpedo Late Model", size = 0},
		},
	},
	["Flagship"] = {
		_name = "Destroyer I-Class",
		_suffix = "Flagship",
		_rarity = 4,
		_back = -3,
		_api_id = 1564,
		_id = 1564,
		_japanese_name = "駆逐イ級flagship",
		_reading = "くちくイきゅうフラグシップ",
		_type = 2,
		_hp = 39,
		_firepower = 32,
		_armor = 24,
		_torpedo = 60,
		_evasion = 60,
		_aa = 24,
		_asw = 60,
		_speed = 10,
		_los = 10,
		_range = 1,
		_luck = 30,
		_equipment = {
			{equipment = "Abyssal Surface Radar", size = 0},
			{equipment = "Abyssal Sonar Mk.II", size = 0},
			{equipment = "Abyssal Depth Charge Projector", size = 0},
		},
	},
	["Late Model"] = {
		_name = "Destroyer I-Class",
		_suffix = "Late Model",
		_rarity = 4,
		_back = -7,
		_api_id = 1575,
		_id = 1575,
		_japanese_name = "駆逐イ級後期型",
		_reading = "くちくイきゅうこうきがた",
		_type = 2,
		_hp = 35,
		_firepower = 38,
		_armor = 22,
		_torpedo = 60,
		_evasion = 48,
		_aa = 30,
		_asw = 72,
		_speed = 10,
		_los = 20,
		_range = 1,
		_luck = 30,
		_equipment = {
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "Abyssal Sonar Mk.II", size = 0},
			{equipment = "Abyssal Depth Charge Projector", size = 0},
		},
	},
	["Late Model Elite"] = {
		_name = "Destroyer I-Class",
		_suffix = "Late Model Elite",
		_rarity = 5,
		_back = -8,
		_api_id = 1621,
		_id = 1621,
		_japanese_name = "駆逐イ級後期型elite",
		_reading = "くちくイきゅうこうきがたエリート",
		_type = 2,
		_hp = 39,
		_firepower = 48,
		_armor = 30,
		_torpedo = 76,
		_evasion = 65, -- from Kan Colle Kai
		_aa = 40,
		_asw = 80, -- from Kan Colle Kai
		_speed = 10,
		_los = 30, -- from Kan Colle Kai
		_range = 1,
		_luck = 50, -- from Kan Colle Kai
		_equipment = {
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "5inch Twin Gun Mount", size = 0},
			{equipment = "Abyssal FCS + CIC", size = 0},
		},
	},
}

return Destroyer_I_Class