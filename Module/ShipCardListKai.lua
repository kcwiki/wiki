local CardList = require('Module:CardList')
local Formatting = require('Module:Formatting')
local Ship = require('Module:Ship')
local ShipCardKai = require('Module:ShipCardKai')

local ShipCardListKai = CardList{
	_item_class = Ship,
	_blank = "Empty ship slot.png",
	_default_size = ShipCardKai._card_size,
	_column_count = 5,
}

function ShipCardListKai:card(ship)
	local value
	if ship == false then
		value = Formatting:format_image{self._blank, size = self._size}
	else
		value = ShipCardKai:get{ship = ship, size = self._size, link = ship:link(), caption = ship:name()}
	end
	return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
end

return ShipCardListKai