--Categories:
--[[Category: Enemy ship modules]]

local Battleship_Re_Class = {
	[""] = {
		_name = "Battleship Re-Class",
		_rarity = 6,
		_back = -1,
		_api_id = 1561,
		_id = 1561,
		_japanese_name = "戦艦レ級",
		_reading = "せんかんレきゅう",
		_type = 10,
		_hp = 180,
		_firepower = 90,
		_armor = 110,
		_torpedo = 100,
		_evasion = 45,
		_aa = 80,
		_asw = 90,
		_speed = 10,
		_los = 50,
		_range = 3,
		_luck = 60,
		_night_bombing = true,
		_equipment = {
			{equipment = "16inch Triple Gun Mount", size = 0},
			{equipment = "12.5inch Twin Secondary Gun Mount", size = 0},
			{equipment = "High-speed Abyssal Torpedo", size = 0},
			{equipment = "Flying Fish Dive Bomber", size = 140},
		},
	},
	["Elite"] = {
		_name = "Battleship Re-Class",
		_suffix = "Elite",
		_rarity = 8,
		_back = -2,
		_api_id = 1562,
		_id = 1562,
		_japanese_name = "戦艦レ級elite",
		_reading = "せんかんレきゅうエリート",
		_type = 10,
		_hp = 270,
		_firepower = 130,
		_armor = 130,
		_torpedo = 120,
		_evasion = 50,
		_aa = 100,
		_asw = 100,
		_speed = 10,
		_los = 70,
		_range = 3,
		_luck = 70,
		_night_bombing = true,
		_equipment = {
			{equipment = "16inch Triple Gun Mount", size = 0},
			{equipment = "12.5inch Twin Secondary Gun Mount", size = 0},
			{equipment = "Abyssal Cuttlefish Torpedo", size = 0},
			{equipment = "Flying Fish Dive Bomber", size = 180},
		},
	},
}
 
return Battleship_Re_Class