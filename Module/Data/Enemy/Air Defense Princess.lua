--Categories:
--[[Category: Enemy boss ship modules]]

local Air_Defense_Princess = {
	["A"] = "/",
	[""] = {
		_name = "Air Defense Princess",
		_rarity = 8,
		_back = -12,
		_api_id = 1628,
		_id = 1628,
		_japanese_name = "防空棲姫",
		_reading = "ぼうくうせいき",
		_type = 2,
		_hp = 255,
		_firepower = 130,
		_armor = 193,
		_torpedo = 85,
		_evasion = 80, -- from Kan Colle Kai
		_aa = 300,
		_asw = 0,
		_speed = 10,
		_los = 70, -- from Kan Colle Kai
		_range = 2,
		_luck = 80, -- from Kan Colle Kai
		_equipment = {
			{equipment = "4inch Twin Dual Purpose Gun Mount + CIC", size = 0},
			{equipment = "4inch Twin Dual Purpose Gun Mount + CIC", size = 0},
			{equipment = "Abyssal Surface Radar", size = 0},
		},
	},
	["B"] = "/II",
	["II"] = {
		_name = "Air Defense Princess",
		_suffix = "II",
		_rarity = 8,
		_back = -12,
		_api_id = 1629,
		_id = 1629,
		_battle_card_reference = "/",
		_cg_reference = "/",
		_japanese_name = "防空棲姫",
		_reading = "ぼうくうせいき",
		_type = 2,
		_hp = 255,
		_firepower = 160,
		_armor = 223,
		_torpedo = 90,
		_evasion = 90, -- from Kan Colle Kai
		_aa = 360,
		_asw = 0,
		_speed = 10,
		_los = 80, -- from Kan Colle Kai
		_range = 2,
		_luck = 85, -- from Kan Colle Kai
		_equipment = {
			{equipment = "4inch Twin Dual Purpose Gun Mount + CIC", size = 0},
			{equipment = "4inch Twin Dual Purpose Gun Mount + CIC", size = 0},
			{equipment = "Abyssal Surface Radar", size = 0},
		},
	},
	["Strong"] = "/II",
	["C"] = "/III",
	["III"] = {
		_name = "Air Defense Princess",
		_suffix = "III",
		_rarity = 8,
		_back = -12,
		_api_id = 1630,
		_id = 1630,
		_battle_card_reference = "/",
		_cg_reference = "/",
		_japanese_name = "防空棲姫",
		_reading = "ぼうくうせいき",
		_type = 2,
		_hp = 255,
		_firepower = 190,
		_armor = 273,
		_torpedo = 95,
		_evasion = 98, -- from Kan Colle Kai
		_aa = 390,
		_asw = 0,
		_speed = 10,
		_los = 90, -- from Kan Colle Kai
		_range = 2,
		_luck = 90, -- from Kan Colle Kai
		_equipment = {
			{equipment = "4inch Twin Dual Purpose Gun Mount + CIC", size = 0},
			{equipment = "4inch Twin Dual Purpose Gun Mount + CIC", size = 0},
			{equipment = "Abyssal Surface Radar", size = 0},
		},
	},
	["Final"] = "/III",
}
 
return Air_Defense_Princess