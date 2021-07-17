--Categories:
--[[Category:Equipment modules]]

return {
	_name = "12.7cm Twin Gun Mount Model B Kai 2",
	_page = false,
	_id = 63,
	_japanese_name = "12.7cm連装砲B型改二",
	_reading = "12.7せんちれんそうほうBがたかいに",
	_type = 1,
	_icon = 1,
	_rarity = 1,
	_firepower = 3,
	_bombing = false,
	_torpedo = false,
	_aa = 2,
	_armor = false,
	_asw = false,
	_shelling_accuracy = false,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = 1,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 1,
	_scrap_steel = 2,
	_scrap_bauxite = false,
	_buildable = false,
	_info = "艦隊型駆逐艦の主砲のマイナーチェンジバージョンです。<br>基本形と同様、防盾で全周を遮蔽、弾片や荒天対策を施しており、また本バージョンでは仰角範囲等も改良されました。<br>駆逐艦夕立等に搭載されたとも云われています。",
	_wikipedia = "12.7 cm/50 Type 3 naval gun",
	_improvements = {
		_fuel = 10,
		_ammo = 40,
		_steel = 70,
		_bauxite = false,
		_products = {
			["12.7cm Twin Gun Mount Model C Kai 2"] = {
				_ships = {
					["Ayanami/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
					["Kawakaze/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = false, Saturday = false},
					["Yuudachi/Kai Ni"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
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
					_development_material_x = 2,
					_improvement_material = 2,
					_improvement_material_x = 4,
					_equipment = {[true] = 1},
				},
				[10] = {
					_development_material = 4,
					_development_material_x = 8,
					_improvement_material = 4,
					_improvement_material_x = 7,
					_equipment = {["12.7cm Twin Gun Mount"] = 3},
				},
				_stars = false,
			},
		},
	},
	_bonus = {
	    ["Shigure Kai Ni"] = {
	        _firepower = 1,
	    },
	    ["Murasame Kai Ni"] = {
	        _evasion = 1,
	    },
	    ["Yuudachi Kai Ni"] = {
	        _firepower = 1,
	        _torpedo = 1,
	        _aa = 1,
	        _evasion = 2,
	    },
	    ["Kawakaze Kai Ni"] = {
	        _evasion = 2,
	    },
	    ["Shiratsuyu Kai"] = {
	        _evasion = 1,
	    },
	    ["@<span class='explain' title='Ayanami/Akatsuki/Hatsuharu'>DD</span>-class"] = {
	        _aa = 1,
	    },
	},
}