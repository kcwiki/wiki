--Categories:
--[[Category:Equipment modules]]

return {
	_name = "12cm 30-tube Rocket Launcher",
	_page = false,
	_id = 51,
	_japanese_name = "12cm30連装噴進砲",
	_reading = "12せんち30れんそうふんしんほう",
	_type = 21,
	_icon = 15,
	_rarity = 2,
	_firepower = false,
	_bombing = false,
	_torpedo = false,
	_aa = 8,
	_armor = false,
	_asw = false,
	_shelling_accuracy = false,
	_torpedo_accuracy = false,
	_evasion = false,
	_los = false,
	_speed = false,
	_luck = false,
	_range = false,
	_special = false,
	_scrap_fuel = false,
	_scrap_ammo = 4,
	_scrap_steel = 2,
	_scrap_bauxite = 2,
	_buildable = true,
	_info = "12cm30連装噴進砲は、艦載用対空ロケットランチャーです。<br/>四式ロケット式焼霰弾（ロサ弾）を30連発で連続発射する脅威の弾幕は、肉薄する敵艦載機から味方艦を護ります。<br/>ぜひ、改装した伊勢・日向に満載して、敵空母の猛攻を突破してください！",
	_improvements = {
		_fuel = 90,
		_ammo = 270,
		_steel = 50,
		_bauxite = 180,
		_products = {
			["12cm 30-tube Rocket Launcher Kai Ni"] = {
				_ships = {
					["Ise/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = false, Friday = true, Saturday = true},
					["Hyuuga/Kai"] = {Sunday = false, Monday = true, Tuesday = true, Wednesday = false, Thursday = false, Friday = false, Saturday = false},
				},
				[0] = {
					_development_material = 3,
					_development_material_x = 6,
					_improvement_material = 2,
					_improvement_material_x = 3,
					_equipment = {[true] = 1},
				},
				[6] = {
					_development_material = 5,
					_development_material_x = 9,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {[true] = 2},
				},
				[10] = {
					_development_material = 10,
					_development_material_x = 30,
					_improvement_material = 7,
					_improvement_material_x = 10,
					_equipment = {
					    ["25mm Triple Autocannon Mount"] = 3,
					    ["Action Report"] = 1
					},
				},
			},
		},
	},
}