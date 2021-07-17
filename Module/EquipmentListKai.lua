local BaseTable = require('Module:BaseTable')
local Equipment = require('Module:Equipment')
local Formatting = require('Module:Formatting')
local StatIcons = require('Module:Data/Asset')
local EquipmentLink = require('Module:EquipmentLink')

local format = require('Module:Core').format

-- [[Category:Todo]]: hardcoded icons
local EquipmentListKai = BaseTable{
	_item_class = Equipment,
	_header_template = [=[! No.
! Rarity
! style="width: 240px" | Name
! style="width: 120px" | Type
${stat_columns}
! style="width: 120px" | Classes
! [[File:Icon_Dev.png|20px|Craftable]]
! [[File:Icon_Imp.png|20px|Improvable]]
! style="white-space:nowrap;" | Notes]=],
	_column_cell_templates = {
		name = [[| colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:5px 5px 5px 5px;" |${values.name}<br />${values.icon} ${values.japanese_name}]]
	},
	_columns = {
		"id",
		"rarity",
		"name",
		"equipment_type",
		"stats",
		"compatibility",
		"buildable",
		"improvable",
		"notes",
	},
	_stats_column_label = "Stats",
}

function EquipmentListKai:id(equipment)
	return {values = {value = Formatting:format_stat(equipment:id())}, bg_color = self._transparent, text_align = self._center_align}
end

function EquipmentListKai:rarity(equipment)
	return {values = {value = Formatting:tooltip(Formatting:format_stars(equipment:stars()), Formatting:format_equipment_rarity(equipment:rarity()), nil, Formatting._display_inline_block_css)}, bg_color = self._transparent, text_align = self._center_align}
end

function EquipmentListKai:name(equipment)
	return {values = {
			name = EquipmentLink.format(nil, { equipment:name() }), 
			icon = Formatting:format_image{Formatting:format_equipment_icon(equipment:icon())}, 
			japanese_name = Formatting:format_stat(equipment:japanese_name())
		}, 
		bg_color = self._transparent,
		text_align = self._start_align,
	}
end

function EquipmentListKai:equipment_type(equipment)
    return {values = {value = Formatting:format_equipment_types(equipment)}, bg_color = self._transparent, text_align = self._center_align}
end

function EquipmentListKai:stats(equipment)
    local stats = {
		firepower = equipment:firepower(), 
		bombing = equipment:bombing(), 
		torpedo = equipment:torpedo(), 
		aa = equipment:aa(), 
		armor = equipment:armor(), 
		asw = equipment:asw(), 
		shelling_accuracy = equipment:shelling_accuracy(),
		torpedo_accuracy = equipment:torpedo_accuracy(),
		evasion = equipment:evasion(),
		los = equipment:los(),
		speed = Formatting:format_speed(equipment:speed()),
		luck = equipment:luck(),
		range = Formatting:format_range(equipment:range()),
		special = false,
	}
	return {values = {value = equipment:type() == 48 and Formatting:format_stat_bonuses_interceptor(stats, "<br />") or Formatting:format_stat_bonuses(stats, "<br />"),
		}, 
		bg_color = self._transparent, 
		text_align = self._start_align,
	}
end

function EquipmentListKai:compatibility(equipment)
	return {values = {value = Formatting:format_ship_compatibility(equipment:equippable())}, bg_color = self._transparent, text_align = self._start_align}
end

function EquipmentListKai:buildable(equipment)
	return {values = {value = Formatting:format_boolean_short(equipment:buildable())}, bg_color = self._transparent, text_align = self._center_align}
end

function EquipmentListKai:improvable(equipment)
	return {values = {value = Formatting:format_boolean_short(equipment:improvable())}, bg_color = self._transparent, text_align = self._center_align}
end

function EquipmentListKai:notes(equipment)
	local note = self._notes[equipment]
	if note then
		return {values = {value = note.note or ""}, bg_color = self._transparent}
	end
	return {values = {value = ""}, bg_color = self._transparent}
end

function EquipmentListKai:create_header()
	self._header = format{self._header_template, stat_columns = format{self._column_header_cell_template, value = self._stats_column_label}}
end

return EquipmentListKai