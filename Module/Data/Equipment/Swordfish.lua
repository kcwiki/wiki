--Categories:
--[[Category:Equipment modules]]

return {
    _name = "Swordfish",
    _id = 242,
    _japanese_name = "Swordfish",
    _reading = "Swordfish",
    _type = 8, -- 3,5,8,8,28
    _icon = 8,
    _rarity = 2,
    _firepower = 2,
    _bombing = false,
    _torpedo = 3,
    _aa = false,
    _armor = false,
    _asw = 4,
    _shelling_accuracy = 1,
    _torpedo_accuracy = false,
    _evasion = false,
    _los = 1,
    _speed = false,
    _luck = false,
    _range = false,
    _flight_cost = 3,
    _flight_range = 3,
    _special = false,
    _scrap_fuel = 1,
    _scrap_ammo = 1,
    _scrap_steel = false,
    _scrap_bauxite = 1,
    _buildable = true,
    _improvements = {
		_fuel = 90,
		_ammo = 280,
		_steel = 0,
		_bauxite = 210,
		_products = {
			["Swordfish Mk.II (Skilled)"] = {
				_ships = {
					["Ark Royal/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
					["Ark Royal/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
				},
				[0] = {
					_development_material = 4,
					_development_material_x = 5,
					_improvement_material = 2,
					_improvement_material_x = 2,
					_equipment = {["Type 97 Torpedo Bomber"] = 1},
				},
				[6] = {
					_development_material = 5,
					_development_material_x = 9,
					_improvement_material = 3,
					_improvement_material_x = 5,
					_equipment = {["Tenzan"] = 1},
				},
				[10] = {
					_development_material = 12,
					_development_material_x = 18,
					_improvement_material = 6,
					_improvement_material_x = 9,
					_equipment = {
					    ["Ryuusei"] = 2,
					    ["Skilled Crew Member"] = 1,
				    },
				},
			},
		},
	},
    _info = "複葉非全金属製の旧世代機でありながら、高い信頼性と運用性を誇る、メカジキの名を持つ紅茶の国の艦上攻撃機。<br>航空母艦「Ark Royal」搭載の本機は、戦艦「Bismarck」と英艦隊との激闘に大きな一撃を放ちます。旧式ながら赫々たる戦果をおさめた傑作機、遂に実装です！",
    _wikipedia = "Fairey Swordfish",
}