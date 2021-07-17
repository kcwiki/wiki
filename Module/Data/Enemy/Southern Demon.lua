--Categories:
--[[Category: Enemy boss ship modules]]

local Southern_Demon = {
	[""] = {
		_name = "Southern Demon",
		_rarity = 8,
		_back = -11,
		_api_id = 1546,
		_id = 1546,
		_japanese_name = "南方棲鬼",
		_reading = "なんぽうせいき",
		_type = 10,
		_hp = 210, -- 180, until 12/27/2018
		_firepower = 90,
		_armor = 118, -- 90, unti 12/27/2018
		_torpedo = 80,
		_evasion = 20,
		_aa = 70,
		_asw = 0,
		_speed = 5,
		_los = 70,
		_range = 3,
		_luck = 30,
		_equipment = {
		    {equipment = "16inch Triple Gun Mount", size = 0},
		    {equipment = "8inch Triple Gun Mount", size = 0},
		    {equipment = "Abyssal Fighter Mark.II", size = 50},
		    {equipment = "Abyssal Surface Radar", size = 0}, -- since 12/27/2018
		},
	},
}
 
return Southern_Demon