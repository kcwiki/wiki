--Categories:
--[[Category: Enemy boss ship modules]]

local Seaplane_Tender_Princess = {
	["A"] = "/",
	[""] = {
		_name = "Seaplane Tender Princess",
		_rarity = 8,
		_back = -11,
		_api_id = 1625,
		_id = 1625,
		_japanese_name = "水母棲姫",
		_reading = "すいぼせいき",
		_type = 16,
		_hp = 350,
		_firepower = 75,
		_armor = 150,
		_torpedo = 88,
		_evasion = 60, -- from Kan Colle Kai
		_aa = 70,
		_asw = 98, -- from Kan Colle Kai
		_speed = 10,
		_los = 120, -- from Kan Colle Kai
		_range = 2,
		_luck = 70, -- from Kan Colle Kai
		_equipment = {
			{equipment = "5inch Twin Dual Purpose Gun Mount", size = 0},
			{equipment = "5inch Twin Dual Purpose Gun Mount", size = 0},
			{equipment = "Abyssal Cuttlefish Torpedo", size = 0},
			{equipment = "Abyssal Attack Seaplane", size = 32},
		},
	},
	["B"] = "/II",
	["II"] = {
		_name = "Seaplane Tender Princess",
		_suffix = "II",
		_rarity = 8,
		_back = -11,
		_api_id = 1626,
		_id = 1626,
		_battle_card_reference = "/",
		_battle_card_layers = {"attack_seaplane_kai_r"},
		_cg_reference = "/",
		_japanese_name = "水母棲姫",
		_reading = "すいぼせいき",
		_type = 16,
		_hp = 350,
		_firepower = 95,
		_armor = 175,
		_torpedo = 98,
		_evasion = 65, -- from Kan Colle Kai
		_aa = 80,
		_asw = 98, -- from Kan Colle Kai
		_speed = 10,
		_los = 140, -- from Kan Colle Kai
		_range = 2,
		_luck = 80, -- from Kan Colle Kai
		_equipment = {
			{equipment = "5inch Twin Dual Purpose Gun Mount", size = 0},
			{equipment = "5inch Twin Dual Purpose Gun Mount", size = 0},
			{equipment = "Abyssal Cuttlefish Torpedo", size = 0},
			{equipment = "Abyssal Attack Seaplane Kai", size = 64},
		},
	},
	["Strong"] = "/II",
	["C"] = "/III",
	["III"] = {
		_name = "Seaplane Tender Princess",
		_suffix = "III",
		_rarity = 8,
		_back = -11,
		_api_id = 1627,
		_id = 1627,
		_battle_card_reference = "/",
		_battle_card_layers = {"attack_seaplane_kai_r"},
		_cg_reference = "/",
		_japanese_name = "水母棲姫",
		_reading = "すいぼせいき",
		_type = 16,
		_hp = 350,
		_firepower = 115,
		_armor = 195,
		_torpedo = 98,
		_evasion = 75, -- from Kan Colle Kai
		_aa = 90,
		_asw = 98, -- from Kan Colle Kai
		_speed = 10,
		_los = 160, -- from Kan Colle Kai
		_range = 2,
		_luck = 90, -- from Kan Colle Kai
		_equipment = {
			{equipment = "5inch Twin Dual Purpose Gun Mount", size = 0},
			{equipment = "5inch Twin Dual Purpose Gun Mount", size = 0},
			{equipment = "Abyssal Cuttlefish Torpedo", size = 0},
			{equipment = "Abyssal Attack Seaplane Kai", size = 96},
		},
	},
	["Final"] = "/III",
}
 
return Seaplane_Tender_Princess