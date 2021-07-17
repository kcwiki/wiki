--Categories:
--[[Category: Enemy boss ship modules]]

local Aircraft_Carrier_Water_Demon = {
	[""] = {
		_name = "Aircraft Carrier Water Demon",
		_rarity = 8,
		_back = -11,
		_api_id = 1599,
		_id = 1599,
		_japanese_name = "空母水鬼",
		_reading = "くうぼすいき",
		_type = 11,
		_hp = 370,
		_firepower = 140,
		_armor = 170,
		_torpedo = 0,
		_evasion = 60, -- from Kan Colle Kai
		_aa = 110,
		_asw = 0,
		_speed = 10,
		_los = 110, -- from Kan Colle Kai
		_range = 3,
		_luck = 70,
		_equipment = {
		    {equipment = "Abyssal Cat Fighter", size = 66},
		    {equipment = "Abyssal Hell Dive Bomber", size = 60},
		    {equipment = "Abyssal Revenge Torpedo Bomber", size = 60},
		    {equipment = "Abyssal Air Radar", size = 0},
		},
	},
	["Final"] = "/II",
	["II"] = {
		_name = "Aircraft Carrier Water Demon",
		_suffix = "II",
		_display_suffix = "II (Final Form)",
		_rarity = 8,
		_back = -12,
		_api_id = 1600,
		_id = 1600,
		_battle_card_reference = "/",
		_cg_reference = "/",
		_japanese_name = "空母水鬼",
		_reading = "くうぼすいき",
		_type = 11,
		_hp = 390,
		_firepower = 190,
		_armor = 190,
		_torpedo = 0,
		_evasion = 69, -- from Kan Colle Kai
		_aa = 140,
		_asw = 0,
		_speed = 10,
		_los = 140, -- from Kan Colle Kai
		_range = 3,
		_luck = 70,
		_equipment = {
		    {equipment = "Abyssal Cat Fighter", size = 66},
		    {equipment = "Abyssal Hell Dive Bomber", size = 60},
		    {equipment = "Abyssal Revenge Torpedo Bomber", size = 60},
		    {equipment = "Abyssal Air Radar", size = 0},
		},
	},
}
 
return Aircraft_Carrier_Water_Demon