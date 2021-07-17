--Categories:
--[[Category: Enemy boss ship modules]]

local Isolated_Island_Demon = {
	[""] = {
		_name = "Isolated Island Demon",
		_rarity = 8,
		_back = -11,
		_api_id = 1574,
		_id = 1574,
		_japanese_name = "離島棲鬼",
		_reading = "りとうせいき",
		_type = 10,
		_hp = 450,
		_firepower = 150,
		_armor = 150,
		_torpedo = 0,
		_evasion = 10,
		_aa = 100,
		_asw = 0,
		_speed = 0,
		_los = 80,
		_range = 2,
		_luck = 50,
		_equipment = {
		    {equipment = "Abyssal Fighter Mark.III", size = 90},
		    {equipment = "Abyssal Dive Bomber Mark.II", size = 90},
		    {equipment = "Abyssal Torpedo Bomber Mark.III", size = 90},
		    {equipment = "Abyssal Torpedo Bomber Mark.III", size = 90},
		},
	},
	["A"] = "/II",
	["II"] = {
		_name = "Isolated Island Demon",
		_suffix = "II",
		_rarity = 8,
		_back = -12,
		_api_id = 1634,
		_id = 1634,
		_battle_card_reference = "/",
		_battle_card_layers = {"hell_r1", "revenge_r2"},
		_cg_reference = "/",
		_japanese_name = "離島棲鬼",
		_reading = "りとうせいき",
		_type = 10,
		_hp = 450,
		_firepower = 150,
		_armor = 155,
		_torpedo = 0,
		_evasion = 15, -- from Kan Colle Kai
		_aa = 100,
		_asw = 0,
		_speed = 0,
		_los = 80, -- from Kan Colle Kai
		_range = 2, -- 3 in Kan Colle Kai
		_luck = 50, -- from Kan Colle Kai
		_equipment = {
		    {equipment = "Abyssal Cat Fighter Kai", size = 90},
		    {equipment = "Abyssal Hell Dive Bomber Kai", size = 90},
		    {equipment = "Abyssal Hell Dive Bomber", size = 90},
		    {equipment = "Abyssal Revenge Torpedo Bomber", size = 90},
		},
	},
	["B"] = "/III",
	["III"] = {
		_name = "Isolated Island Demon",
		_suffix = "III",
		_rarity = 8,
		_back = -12,
		_api_id = 1635,
		_id = 1635,
		_battle_card_reference = "/",
		_battle_card_layers = {"hell_r1", "revenge_kai_r2"},
		_cg_reference = "/",
		_japanese_name = "離島棲鬼",
		_reading = "りとうせいき",
		_type = 10,
		_hp = 450,
		_firepower = 165,
		_armor = 170,
		_torpedo = 0,
		_evasion = 25, -- from Kan Colle Kai
		_aa = 110,
		_asw = 0,
		_speed = 0,
		_los = 90, -- from Kan Colle Kai
		_range = 2, -- 3 in Kan Colle Kai
		_luck = 60, -- from Kan Colle Kai
		_equipment = {
		    {equipment = "Abyssal Cat Fighter Kai", size = 90},
		    {equipment = "Abyssal Hell Dive Bomber Kai", size = 90},
		    {equipment = "Abyssal Hell Dive Bomber", size = 90},
		    {equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 90},
		},
	},
	["C"] = "/IV",
	["IV"] = {
		_name = "Isolated Island Demon",
		_suffix = "IV",
		_rarity = 8,
		_back = -12,
		_api_id = 1636,
		_id = 1636,
		_battle_card_reference = "/",
		_battle_card_layers = {"revenge_kai_r1", "revenge_kai_r2"},
		_cg_reference = "/",
		_japanese_name = "離島棲鬼",
		_reading = "りとうせいき",
		_type = 10,
		_hp = 450,
		_firepower = 180,
		_armor = 185,
		_torpedo = 0,
		_evasion = 35, -- from Kan Colle Kai
		_aa = 120,
		_asw = 0,
		_speed = 0,
		_los = 100, -- from Kan Colle Kai
		_range = 2, -- 3 in Kan Colle Kai
		_luck = 70, -- from Kan Colle Kai
		_equipment = {
		    {equipment = "Abyssal Cat Fighter Kai", size = 90},
		    {equipment = "Abyssal Hell Dive Bomber Kai", size = 90},
		    {equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 90},
		    {equipment = "Abyssal Revenge Torpedo Bomber Kai", size = 90},
		},
	},
}
 
return Isolated_Island_Demon