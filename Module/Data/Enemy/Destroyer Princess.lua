--Categories:
--[[Category: Enemy boss ship modules]]

local Destroyer_Princess = {
	[""] = {
		_name = "Destroyer Princess",
		_rarity = 8,
		_back = -11,
		_api_id = 1597,
		_id = 1597,
		_japanese_name = "駆逐棲姫",
		_reading = "くちくせいき",
		_type = 2,
		_hp = 150,
		_firepower = 59,
		_armor = 100,
		_torpedo = 90,
		_evasion = 55, -- from Kan Colle Kai
		_aa = 60,
		_asw = 98, -- from Kan Colle Kai
		_speed = 10,
		_los = 70, -- from Kan Colle Kai
		_range = 1,
		_luck = 70,
		_equipment = {
		    {equipment = "5inch Twin Gun Mount", size = 0},
		    {equipment = "5inch Twin Gun Mount", size = 0},
		    {equipment = "High-speed Abyssal Torpedo", size = 0},
		},
	},
	["Final"] = "/II",
	["II"] = {
		_name = "Destroyer Princess",
		_suffix = "II",
		_display_suffix = "II (Final Form)",
		_rarity = 8,
		_back = -12,
		_api_id = 1598,
		_id = 1598,
		_battle_card_reference = "/",
		_cg_reference = "/",
		_japanese_name = "駆逐棲姫",
		_reading = "くちくせいき",
		_type = 2,
		_hp = 190,
		_firepower = 69,
		_armor = 115,
		_torpedo = 90,
		_evasion = 70, -- from Kan Colle Kai
		_aa = 60,
		_asw = 98 , -- from Kan Colle Kai
		_speed = 10,
		_los = 70, -- from Kan Colle Kai
		_range = 1,
		_luck = 80,
		_equipment = {
		    {equipment = "5inch Twin Gun Mount", size = 0},
		    {equipment = "5inch Twin Gun Mount", size = 0},
		    {equipment = "High-speed Abyssal Torpedo", size = 0},
		},
	},
}
 
return Destroyer_Princess