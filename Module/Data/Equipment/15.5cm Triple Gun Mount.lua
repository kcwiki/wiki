--Categories:
--[[Category:Equipment modules]]

return {
	_name = "15.5cm Triple Gun Mount",
	_page = false,
	_id = 5,
	_japanese_name = "15.5cm三連装砲",
	_reading = "15.5せんちさんれんそうほう",
	_type = 2,
	_icon = 2,
	_rarity = 0,
	_back = 2,
	_firepower = 7,
	_bombing = false,
	_torpedo = false,
	_aa = 4,
	_armor = false,
	_asw = false,
	_shelling_accuracy = 1,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = 2,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 2,
	_scrap_steel = 5,
	_scrap_bauxite = false,
	_info = "条約下で保有数に制限のあった重巡を、火力を増強した強力な軽巡で補うために開発されました。<br/>初の三連装砲でしたが、射程・発射速度・運用面全てに高い評価を得ることになりました。<br/>後に有名な「大和」型戦艦の副砲としても採用されています。<br/>対空戦にも効果を発揮する傑作砲です。",
	_wikipedia = "15.5 cm/60 3rd Year Type naval gun",
	_buildable = true,
	_improvements = {
		_fuel = 10,
		_ammo = 90,
		_steel = 120,
		_bauxite = false,
		_products = {
			["15.5cm Triple Gun Mount Kai"] = {
				_ships = {
					["Mogami/"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Mogami/Kai"] = {Sunday = false, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Ooyodo/"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Ooyodo/Kai"] = {Sunday = true, Monday = true, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 2,
					_development_material_x = 2,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = false,
				},
				[6] = {
					_development_material = 2,
					_development_material_x = 3,
					_improvement_material = 2,
					_improvement_material_x = 4,
					_equipment = {[true] = 1},
				},
				[10] = {
					_development_material = 8,
					_development_material_x = 12,
					_improvement_material = 4,
					_improvement_material_x = 8,
					_equipment = {
					    [true] = 2,
					    ["New Model Gun Mount Improvement Material"] = 1
					},
				},
				_stars = false,
			}
		},
	},
}