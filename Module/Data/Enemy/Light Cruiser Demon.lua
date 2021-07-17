--Categories:
--[[Category: Enemy boss ship modules]]

local Light_Cruiser_Demon = {
	[""] = {
		_name = "Light Cruiser Demon",
		_rarity = 8,
		_back = -11,
		_api_id = 1601,
		_id = 1601,
		_japanese_name = "軽巡棲鬼",
		_reading = "けいじゅんせいき",
		_type = 3,
		_hp = 210,
		_firepower = 59,
		_armor = 135,
		_torpedo = 88,
		_evasion = 52, -- from Kan Colle Kai
		_aa = 60,
		_asw = 98, -- from Kan Colle Kai
		_speed = 10,
		_los = 70, -- from Kan Colle Kai
		_range = 2,
		_luck = 70,
		_equipment = {
		    {equipment = "6inch Twin Rapid Fire Gun Mount", size = 0},
		    {equipment = "6inch Twin Rapid Fire Gun Mount", size = 0},
		    {equipment = "Surface Radar Mark.II", size = 0},
		    {equipment = "Abyssal Reconnaissance Plane", size = 3},
		},
	},
	["Final"] = "/II",
	["II"] = {
		_name = "Light Cruiser Demon",
		_suffix = "II",
		_display_suffix = "II (Final Form)",
		_rarity = 8,
		_back = -12,
		_api_id = 1602,
		_id = 1602,
		_japanese_name = "軽巡棲鬼",
		_reading = "けいじゅんせいき",
		_type = 3,
		_hp = 270,
		_firepower = 69,
		_armor = 170,
		_torpedo = 98,
		_evasion = 77, -- from Kan Colle Kai
		_aa = 60,
		_asw = 98, -- from Kan Colle Kai
		_speed = 10,
		_los = 70, -- from Kan Colle Kai
		_range = 2,
		_luck = 90,
		_equipment = {
		    {equipment = "6inch Twin Rapid Fire Gun Mount", size = 0},
		    {equipment = "6inch Twin Rapid Fire Gun Mount", size = 0},
		    {equipment = "Surface Radar Mark.II", size = 0},
		    {equipment = "Abyssal Reconnaissance Plane", size = 3},
		},
	},
}
 
return Light_Cruiser_Demon