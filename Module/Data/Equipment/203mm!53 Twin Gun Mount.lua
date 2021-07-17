--Categories:
--[[Category:Equipment modules]]
 
local _203mm_53_Twin_Gun_Mount = {
	_name = "203mm/53 Twin Gun Mount",
    _asset_name = "203mm 53 Twin Gun Mount",
	_page = false,
	_id = 162,
	_japanese_name = "203mm/53 連装砲",
	_reading = "203みり/53 れんそうほう",
	_type = 2,
	_icon = 2,
	_rarity = 3,
	_firepower = 9,
	_bombing = false,
	_torpedo = false,
	_aa = 1,
	_armor = false,
	_asw = false,
	_shelling_accuracy = -2,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = 3,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 4,
	_scrap_steel = 4,
	_scrap_bauxite = false,
	_info = "パスタの国で生まれた中口径主砲です。昼間砲撃戦で優位を確保すべく誕生したザラ級重巡の主兵装として採用されました。最大仰角で射撃では戦艦並の長射程距離を誇りましたが、構造上の問題でその精度と命中率には課題を抱えています。",
	_wikipedia = "203 mm /53 Italian naval gun",
	_buildable = false,
	_improvements = {
		_fuel = 10,
		_ammo = 180,
		_steel = 190,
		_bauxite = 0,
		_products = {
			[false] = {
				_ships = {
					["Zara/Due"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = false, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 4,
					_development_material_x = 5,
					_improvement_material = 3,
					_improvement_material_x = 4,
					_equipment = {["20.3cm Twin Gun Mount"] = 2},
				},
				[6] = {
					_development_material = 5,
					_development_material_x = 8,
					_improvement_material = 4,
					_improvement_material_x = 7,
					_equipment = {["20.3cm (No.2) Twin Gun Mount"] = 1},
				},
			},
		},
	},
}
 
return _203mm_53_Twin_Gun_Mount