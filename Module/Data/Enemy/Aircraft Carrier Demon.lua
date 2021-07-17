--Categories:
--[[Category: Enemy boss ship modules]]

local Aircraft_Carrier_Demon = {
	[""] = {
		_name = "Aircraft Carrier Demon",
		_rarity = 8,
		_back = -11,
		_api_id = 1585,
		_id = 1585,
		_japanese_name = "空母棲鬼",
		_reading = "くうぼせいき",
		_type = 11,
		_hp = 250,
		_firepower = 120,
		_armor = 138,
		_torpedo = 0,
		_evasion = 46,
		_aa = 100,
		_asw = 0,
		_speed = 10,
		_los = 100,
		_range = 3,
		_luck = 50,
		_equipment = {
		    {equipment = "Abyssal Cat Fighter", size = 48},
		    {equipment = "Abyssal Hell Dive Bomber", size = 48},
		    {equipment = "Abyssal Revenge Torpedo Bomber", size = 48},
		    {equipment = "Abyssal Air Radar", size = 0},
		},
	},
	["Strong"] = "/II",
	["II"] = {
		_name = "Aircraft Carrier Demon",
		_suffix = "II",
		_display_suffix = "II (Strong)",
		_rarity = 8,
		_back = -11,
		_api_id = 1619,
		_id = 1619,
		_battle_card_reference = "/",
		_battle_card_layers = {"hell_kai_r1", "revenge_kai_r2"},
		_cg_reference = "/",
		_japanese_name = "空母棲鬼",
		_reading = "くうぼせいき",
		_type = 11,
		_hp = 250,
		_firepower = 120,
		_armor = 138,
		_torpedo = 0,
		_evasion = 46, -- from Kan Colle Kai
		_aa = 100,
		_asw = 0,
		_speed = 10,
		_los = 100, -- from Kan Colle Kai
		_range = 3,
		_luck = 50, -- from Kan Colle Kai
		_equipment = {
		    {equipment = "Abyssal Cat Fighter Kai", size = 48},
		    {equipment = "Abyssal Hell Dive Bomber Kai", size = 48},
		    {equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 48},
		    {equipment = "Abyssal Air Radar", size = 0},
		},
	},
}
 
return Aircraft_Carrier_Demon