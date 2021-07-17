local BaseTable = require('Module:BaseTable')
local Formatting = require('Module:Formatting')
local StatIcons = require('Module:Data/Asset')
local Ship = require('Module:Ship')

local format = require('Module:Core').format

local ShipModernizationListKai = BaseTable{
	_header_template = [[! Class
! Name
! style="text-align: center; vertical-align: middle; background-color: lightcoral;" | ${firepower}
! style="text-align: center; vertical-align: middle; background-color: lightskyblue;" | ${torpedo}
! style="text-align: center; vertical-align: middle; background-color: sandybrown;" | ${aa}
! style="text-align: center; vertical-align: middle; background-color: #F2E279;" | ${armor}
! style="text-align: center; vertical-align: middle; background-color: palegreen;" | ${luck}
! Name
! ${remodel}
! style="text-align: center; vertical-align: middle; background-color: lightcoral;" | ${firepower}
! style="text-align: center; vertical-align: middle; background-color: lightskyblue;" | ${torpedo}
! style="text-align: center; vertical-align: middle; background-color: sandybrown;" | ${aa}
! style="text-align: center; vertical-align: middle; background-color: #F2E279;" | ${armor}
! style="text-align: center; vertical-align: middle; background-color: palegreen;" | ${luck}]],
	_columns = {
		"class",
		"name1",
		"firepower_mod1",
		"torpedo_mod1",
		"aa_mod1",
		"armor_mod1",
		"luck_mod1",
		"name2",
		"remodel",
		"firepower_mod2",
		"torpedo_mod2",
		"aa_mod2",
		"armor_mod2",
		"luck_mod2",
	},
	_empty_cell = [[| style="text-align: center; vertical-align: middle;" | -]],
	_column_empty_cells = {
		arrow = [[| style="text-align: center; vertical-align: middle;" | ⇒]],
	},
	_item_class = Ship,
	_dash = "-",
	_question_marks = "??",
	_column_bg_colors = {
		{
			firepower = "#e6cfcf",
			torpedo = "#cfdde6",
			aa = "#e6d9cf",
			armor = "#e6e3cf",
		},
		{
			firepower = "#e6c3c3",
			torpedo = "#c3d9e6",
			aa = "#e6d3c3",
			armor = "#e6e2c3",
		},
		{
			firepower = "#e6b8b8",
			torpedo = "#b8d4e6",
			aa = "#e6ccb8",
			armor = "#e6e0b8",
		},
		{
			firepower = "#e6adad",
			torpedo = "#add0e6",
			aa = "#e6c5ad",
			armor = "#e6dead",
		},
		{
			firepower = "#e6a1a1",
			torpedo = "#a1cbe6",
			aa = "#e6bfa1",
			armor = "#e6dda1",
		},
		{
			firepower = "#e69696",
			torpedo = "#96c7e6",
			aa = "#e6b996",
			armor = "#e6db96",
		},
		{
			firepower = "#e68a8a",
			torpedo = "#8ac2e6",
			aa = "#e6b28a",
			armor = "#e6da8a",
		},
		{
			firepower = "#e67f7f",
			torpedo = "#7fbee6",
			aa = "#e6ab7f",
			armor = "#e6d87f",
		},
		[1.2] = {
			luck = "#b8e6b8",
		},
		[1.6] = {
			luck = "#8ae68a",
		},
		firepower = "#e6cfcf",
		torpedo = "#cfdde6",
		aa = "#e6d9cf",
		armor = "#e6e3cf",
		luck = "#cfe6cf",
	}
}

function ShipModernizationListKai:class(pair)
	self._left = pair[1]
	self._left_modernization = self._left and self._left:modernization() or false
	self._right = pair[2]
	self._right_modernization = self._right and self._right:modernization() or false
	local left_class, right_class, class_name = self._left and self._left:class(), self._right and self._right:class(), false
	if left_class or right_class then
		if left_class == right_class or not right_class then
			class_name = left_class:short_base_name()
		elseif not left_class then
			class_name = right_class:short_base_name()
		else
			class_name = left_class:short_base_name() .. "/" .. right_class:short_base_name()
		end
	end
	return {values = {value = class_name or self._question_marks}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipModernizationListKai:name1()
	if self._left then
		return self:name(self._left)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:name2()
	if self._right then
		return self:name(self._right)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:firepower_mod1()
	if self._left then
		return self:firepower_mod(self._left_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:firepower_mod2()
	if self._right then
		return self:firepower_mod(self._right_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:torpedo_mod1()
	if self._left then
		return self:torpedo_mod(self._left_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:torpedo_mod2()
	if self._right then
		return self:torpedo_mod(self._right_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:aa_mod1()
	if self._left then
		return self:aa_mod(self._left_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:aa_mod2()
	if self._right then
		return self:aa_mod(self._right_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:armor_mod1()
	if self._left then
		return self:armor_mod(self._left_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:armor_mod2()
	if self._right then
		return self:armor_mod(self._right_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:luck_mod1()
	if self._left then
		return self:luck_mod(self._left_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:luck_mod2()
	if self._right then
		return self:luck_mod(self._right_modernization)
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:name(ship)
	local link, text, section = ship:link()
	local value = {Formatting:inline_block(Formatting:format_link(link, text, section))}
	local japanese_name = ship:japanese_name()
	if japanese_name and (text or link) ~= japanese_name then
		table.insert(value, Formatting:inline_block(Formatting:format_stat(ship:japanese_name())))
	end
	return {values = {value = table.concat(value, " ")}, bg_color = self._transparent, text_align = self._start_align}
end

function ShipModernizationListKai:remodel()
	if self._right then
		local remodel_level = self._right:remodel_level()
		return {values = {value = Formatting:format_stat(remodel_level == false and self._dash or remodel_level)}, bg_color = self._transparent, text_align = self._center_align}
	else
		return {values = {value = self._dash}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ShipModernizationListKai:firepower_mod(modernization)
	return {values = {value = Formatting:format_bonus(modernization.firepower, nil, self._dash)}, bg_color = modernization.firepower and (self._column_bg_colors[modernization.firepower] or self._column_bg_colors).firepower or self._transparent, text_align = self._center_align}
end

function ShipModernizationListKai:torpedo_mod(modernization)
	return {values = {value = Formatting:format_bonus(modernization.torpedo, nil, self._dash)}, bg_color = modernization.torpedo and (self._column_bg_colors[modernization.torpedo] or self._column_bg_colors).torpedo or self._transparent, text_align = self._center_align}
end

function ShipModernizationListKai:aa_mod(modernization)
	return {values = {value = Formatting:format_bonus(modernization.aa, nil, self._dash)}, bg_color = modernization.aa and (self._column_bg_colors[modernization.aa] or self._column_bg_colors).aa or self._transparent, text_align = self._center_align}
end

function ShipModernizationListKai:armor_mod(modernization)
	return {values = {value = Formatting:format_bonus(modernization.armor, nil, self._dash)}, bg_color = modernization.armor and (self._column_bg_colors[modernization.armor] or self._column_bg_colors).armor or self._transparent, text_align = self._center_align}
end

function ShipModernizationListKai:luck_mod(modernization)
	return {values = {value = Formatting:format_bonus(modernization.luck, nil, self._dash, true)}, bg_color = modernization.luck and (self._column_bg_colors[modernization.luck] or self._column_bg_colors).luck or self._transparent, text_align = self._center_align}
end

ShipModernizationListKai.create_data_rows = ShipModernizationListKai.create_data_rows_merge_vertical

function ShipModernizationListKai:create_items_post()
	local items = {}
	local left = false
	local right = false
	for _, item in ipairs(self._items) do
		if type(item) == "string" then
			table.insert(items, {left, right})
			left, right = false, false
			if item == "break" then
				table.insert(items, item)
			end
		elseif left then
			if right then
				table.insert(items, {left, right})
			end
			right = item
		else
			left = item
			right = false
		end
	end
	if left then
		table.insert(items, {left, right})
	end
	self._items = items
end

function ShipModernizationListKai:create_header()
	local header_icons = {
		firepower = StatIcons.firepower,
		torpedo = StatIcons.torpedo,
		aa = StatIcons.aa,
		armor = StatIcons.armor,
		luck = StatIcons.luck,
		remodel = StatIcons.remodel,
	}
	for key, value in pairs(header_icons) do
		header_icons[key] = Formatting:format_image{value, caption = Formatting:format_stat_name(key)}
	end
	self._header = format(self._header_template, header_icons)
end

return ShipModernizationListKai