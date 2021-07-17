local Formatting = require('Module:Formatting')
local ShipBattleCardKai = require('Module:ShipBattleCardKai')
local ShipCardListKai = require('Module:ShipCardListKai')

local ShipBattleCardListKai = ShipCardListKai{
	_default_size = ShipBattleCardKai._battle_card_size,
	_blank = "Empty ship battle card slot.png",
}

function ShipBattleCardListKai:card(ship)
	local value
	if ship == false then
		value = Formatting:format_image{self._blank, size = self._size}
	else
		value = ShipBattleCardKai:get{ship = ship, size = self._size, link = ship:link(), caption = ship:name()}
	end
	return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
end

return ShipBattleCardListKai