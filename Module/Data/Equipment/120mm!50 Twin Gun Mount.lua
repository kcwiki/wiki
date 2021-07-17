--Categories:
--[[Category:Equipment modules]]

return {
	_name = "120mm/50 Twin Gun Mount",
	_asset_name = "120mm 50 Twin Gun Mount",
	_page = false,
	_id = 147,
	_japanese_name = "120mm/50 連装砲",
	_reading = nil, --"120ミリれんそうほう"
	_type = 1,
	_icon = 1,
	_rarity = 2,
	_firepower = 3,
	_bombing = false,
	_torpedo = false,
	_aa = 2,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 1,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 1,
	_scrap_steel = 2,
	_scrap_bauxite = false,
	_info =  "パスタの国が生んだ連装の小艦艇用主砲兵装です。<br>口径は同クラスの日本海軍の主力駆逐艦の主砲より小さいものの、優れた機構と高いポテンシャルをもった新型小口径火砲です。",
	_buildable = true,
  _improvements = {
    	_fuel = 10,
    	_ammo = 60,
    	_steel = 80,
    	_bauxite = 10,
    	_products = {
    		["120mm/50 Twin Gun Mount mod.1936"] = {
    			_ships = {
    			    ["Libeccio/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
    			    ["Libeccio/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
    			},
    			[0] = {
    				_development_material = 4,
    				_development_material_x = 5,
    				_improvement_material = 2,
    				_improvement_material_x = 2,
    				_equipment = {["12.7cm Twin Gun Mount Model A"] = 1},
    			},
    			[6] = {
    				_development_material = 5,
    				_development_material_x = 7,
    				_improvement_material = 3,
    				_improvement_material_x = 4,
    				_equipment = {["12.7cm Twin Gun Mount"] = 2},
    			},
    			[10] = {
    				_development_material = 6,
    				_development_material_x = 8,
    				_improvement_material = 4,
    				_improvement_material_x = 6,
    				_equipment = {[true] = 1},
    			},
    		},
        },
    },
}