--Categories:
--[[Category:Equipment modules]]

return {
  _name = "Bofors 15.2cm Twin Gun Mount Model 1930",
  _id = 303,
  _japanese_name = "Bofors 15.2cm連装砲 Model 1930",
  _reading = "ボフォース 15.2センチれんそうほう モデル 1930",
  _type = 2, -- 1,1,2,2,0
  _icon = 2,
  _rarity = 3,
  _firepower = 5,
  _bombing = false,
  _torpedo = false,
  _aa = 4,
  _armor = false,
  _asw = false,
  _shelling_accuracy = 3,
  _torpedo_accuracy = false,
  _evasion = 1,
  _los = false,
  _speed = false,
  _luck = false,
  _range = 2,
  _flight_cost = false,
  _flight_range = false,
  _special = false,
  _scrap_fuel = false,
  _scrap_ammo = 2,
  _scrap_steel = 3,
  _scrap_bauxite = 1,
  _buildable = false,
  _info = "北欧スウェーデンの名門火器メーカーが開発した軽巡用中口径連装主砲兵装です。<br>日本の5,500t級軽巡とほぼ同じ排水量を持つ、スウェーデン海軍の軽巡級に採用されました。限定的ではありますが、対空戦闘にも対応可能です。",
  _improvements = {
    _fuel = 20,
    _ammo = 300,
    _steel = 150,
    _bauxite = 20,
    _products = {
        [false] = {
            _ships = {
                ["Gotland/"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
                ["Gotland/Kai"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
                ["Gotland/Andra"] = {Sunday = true, Monday = true, Tuesday = true, Wednesday = true, Thursday = true, Friday = true, Saturday = true},
            },
            [0] = {
                _development_material = 5,
                _development_material_x = 6,
                _improvement_material = 3,
                _improvement_material_x = 3,
                _equipment = {["15.2cm Single Gun Mount"] = 1},
            },
            [6] = {
                _development_material = 7,
                _development_material_x = 9,
                _improvement_material = 3,
                _improvement_material_x = 5,
                _equipment = {["15.2cm Twin Gun Mount"] = 1},
            },
          },
      },
  }
}