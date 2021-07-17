local CardList = require('Module:CardList')
local Equipment = require('Module:Equipment')
local EquipmentCardKai = require('Module:EquipmentCardKai')
local Formatting = require('Module:Formatting')

local EquipmentCardListKai = CardList{
	_item_class = Equipment,
	_blank = "Empty equipment card slot.png",
	_default_size = EquipmentCardKai._card_size,
	_column_count = 5,
	_row_starter = nil,
	-- Seems like lua inheritance is fake? _row_starter = nil here doesn't penetrate thought
	-- EquipmentCardListKai -> CardList -> BaseTable chain, since CardList has _row_starter = "",
	-- thus we use _disable_row_starter hack here.
	_disable_row_starter = true,
}

function EquipmentCardListKai:process_item_key(item_key)
	return item_key
end

function EquipmentCardListKai:card(equipment)
	local value
	if equipment == false then
		value = Formatting:format_image{self._blank, size = self._size}
	else
		value = EquipmentCardKai:get{equipment = equipment, size = self._size, link = equipment:link(), caption = equipment:name()}
	end
	return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
end

return EquipmentCardListKai