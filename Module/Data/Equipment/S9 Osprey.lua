--Categories:
--[[Category:Equipment modules]]

return {
  _name = "S9 Osprey",
  _id = 304,
  _japanese_name = "S9 Osprey",
  _reading = "S9 オスプレイ",
  _type = 10, -- 5,7,10,10,28
  _icon = 10,
  _rarity = 2,
  _firepower = false,
  _bombing = false,
  _torpedo = false,
  _aa = 1,
  _armor = false,
  _asw = 2,
  _shelling_accuracy = 2,
  _torpedo_accuracy = false,
  _evasion = false,
  _los = 4,
  _speed = false,
  _luck = false,
  _range = false,
  _flight_cost = 3,
  _flight_range = 3,
  _special = false,
  _scrap_fuel = 1,
  _scrap_ammo = 1,
  _scrap_steel = false,
  _scrap_bauxite = 2,
  _buildable = false,
    _improvements = {
	_fuel = 100,
	_ammo = 30,
	_steel = false,
	_bauxite = 220,
	_products = {
		["Swordfish Mk.III Kai (Seaplane Model)"] = {
			_ships = {
			    ["Gotland/"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
			    ["Gotland/Kai"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
			    ["Gotland/Andra"] = {Sunday = true, Monday = false, Tuesday = false, Wednesday = false, Thursday = true, Friday = true, Saturday = true},
			},
			[0] = {
				_development_material = 6,
				_development_material_x = 7,
				_improvement_material = 2,
				_improvement_material_x = 3,
				_equipment = {["Type 0 Reconnaissance Seaplane"] = 1},
			},
			[6] = {
				_development_material = 7,
				_development_material_x = 9,
				_improvement_material = 4,
				_improvement_material_x = 6,
				_equipment = {["Zuiun"] = 1},
            },
    			[10] = {
				_development_material = 30,
  				_development_material_x = 49,
   				_improvement_material = 9,
   				_improvement_material_x = 17,
				_equipment = {
				    ["Swordfish Mk.II Kai (Reconnaissance Seaplane Model)"] = 1,
				    ["New Model Aerial Armament Material"] = 2,
   				    ["Skilled Crew Member"] = 1,
   				},
			},
		},
    },
  },
  _info = "紅茶の国で生まれた複葉複座機の傑作機Hawker Hart。<br>やや旧式ではありますが、同ベストセラー機の改良水上機型が本機「Osprey」です。<br>スウェーデン海軍にも採用され、偵察や弾着観測機として運用されました。",
}