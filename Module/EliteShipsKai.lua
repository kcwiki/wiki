local BaseTable = require('Module:BaseTable')
local Formatting = require('Module:Formatting')
local ResourceIcons = require('Module:Data/Asset')
local Ship = require('Module:Ship')
local StatIcons = require('Module:Data/Asset')

local format = require('Module:Core').format
local split = require('Module:Core').split

local EliteShipsKai = BaseTable({
	_table_start = [[{| class="wikitable typography-xl-optout" style="width: -moz-max-content; width: -webkit-max-content; width: max-content;"]],
	_header_template = [[!No.
!Name
!Class
! style="white-space:nowrap;" | ${remodel}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: lightcoral;" | ${firepower}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: lightskyblue;" | ${torpedo}
${night_battle_header_cell}! style="width: 24px; text-align: center; vertical-align: middle; background-color: sandybrown;" | ${aa}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: #9C8FEE;" | ${asw}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: aquamarine;" | ${los}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: palegreen;" | ${luck}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: pink;" | ${hp}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: #F2E279;" | ${armor}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: violet;" | ${evasion}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: #72E6E6;" | ${speed}
${range_header_cell}! style="width: 24px; text-align: center; vertical-align: middle; background-color: silver;" | ${aircraft}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: forestgreen;" | ${fuel}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: darkgoldenrod;" | ${ammo}
! class="toggle-target-eliteshipskai-detail" style="text-align:left;" | Notes]],
	_column_cell_templates = {
		luck = [[| colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;" | ${values.luck}(${values.luck_max})]],
		id = [[| colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;${extra_style}" |${values.value}]],
		notes = [[| class="${class}" colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;" |<small>${values.value}</small>]],
		["!"] = [[| class="${class}" colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;" |<div style="max-width: 600px;">${values.value}</div>]]
	},
	_night_battle_header_cell = [[! style="width: 24px; text-align: center; vertical-align: middle; background-color: slategrey;" | ${firepower}${torpedo}
]],
	_range_header_cell = [[! style="width: 24px; text-align: center; vertical-align: middle;" | ${range}
]],
	_base_columns = { --gets copied to self._columns in create_table_prep so we can mutate it. Don't mutate base_columns!
		"id",
		"name",
		"class",
		"remodel",
		"firepower",
		"torpedo", --night_battle is added after this depending on args in create_table_prep. If adding columns please preserve this behaviour.
		"aa",
		"asw",
		"los",
		"luck",
		"hp",
		"armor",
		"evasion",
		"speed", --range is added after this depending on args in create_table_prep. If adding columns please preserve this behaviour.
		"aircraft",
		"fuel",
		"ammo",
		"notes",
	},
	_no_remodel_level = "-",
	_simple_class = "toggle-anti-target-eliteshipskai-detail",
	_detailed_class = "toggle-target-eliteshipskai-detail hidden",
	_detailed_start = '<span class="toggle-target-eliteshipskai-detail hidden">',
	_detailed_end = '</span>',
	_name_style = {["max-width"] = "150px"},
	_detailed_columns = 1,
	_detail_toggle = '<div class="toggle" data-target="eliteshipskai-detail" data-anti-target="eliteshipskai-detail" data-default="hide" style="display: none;"><span class="toggle-show" style="cursor: pointer; color: #006cb0;">☑ Show details</span><span class="toggle-hide" style="cursor: pointer; color: #006cb0;">☒ Show details</span></div>',
	_nickname_template = "''${nick} ${japanese_nick}''",
	_kekkon_max_template = "Maximum after marriage: ${value}",
	_kekkon_template = "After marriage: ${value}",
	_item_class = Ship,
})

function EliteShipsKai:name(ship)
	local link, text, section = ship:link()
	local value = {Formatting:inline_block(Formatting:format_link(link, text, section))}
	local japanese_name = ship:japanese_name()
	if japanese_name and (text or link) ~= japanese_name then
		table.insert(value, self._detailed_start)
		table.insert(value, " ")
		table.insert(value, self._detailed_end)
		table.insert(value, self._detailed_start)
		table.insert(value, Formatting:inline_block(Formatting:format_stat(japanese_name)))
		table.insert(value, self._detailed_end)
	end
	local nick = ship:nick()
	if nick then
		table.insert(value, "<br />")
		table.insert(value, self._detailed_start)
		table.insert(value, Formatting:inline_block(format{self._nickname_template, 
		    nick = Formatting:format_stat(nick), 
		    japanese_nick = Formatting:format_stat(ship:japanese_nick())}))
		table.insert(value, self._detailed_end)
	end
	return {values = {value = Formatting:inline_block(table.concat(value), nil, self._name_style)}, bg_color = self._transparent, text_align = self._center_align}
end

function EliteShipsKai:id(ship)
	local back = ship:back()
	return {values = {value = Formatting:format_stat(ship:id())}, 
		bg_color = self._transparent, --Formatting:format_ship_back(back), 
		extra_style = "", --Formatting:extra_style_background_image(back and back > 7, back and back > 6) or ""
		text_align = self._center_align
	}
end

function EliteShipsKai:class(ship)
	local class = ship:class()
	if class then
		local ship_type = ship:type()
		local value = class:short_base_name()
		local show_type
		if self._reference_types then
			show_type = not self._reference_types[ship_type]
		else
			show_type = ship_type ~= class:base_type()
		end
		if show_type then
			value = Formatting:format_stat_with_detail(value, Formatting:format_ship_code(ship_type))
		end
		return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
	else
		return {values = {value = "??"}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function EliteShipsKai:remodel(ship)
	local remodel_level = ship:remodel_level()
	return {values = {value = Formatting:format_stat(remodel_level == false and self._no_remodel_level or remodel_level)}, bg_color = self:get_bg_color(self._cell_color.remodel, remodel_level, self._args.remodel_level_operator, self._args.remodel_level_outstanding, self._args.remodel_level_good, self._args.remodel_level_bad), text_align = self._center_align}
end

function EliteShipsKai:firepower(ship)
	local firepower_max = ship:firepower_max()
	if firepower_max == false then
		firepower_max = ship:firepower()
	end
	return {values = {value = Formatting:format_stat(firepower_max)}, bg_color = self:get_bg_color(self._cell_color.firepower, firepower_max, self._args.firepower_operator, self._args.firepower_outstanding, self._args.firepower_good, self._args.firepower_bad), text_align = self._center_align}
end

function EliteShipsKai:torpedo(ship)
	local torpedo_max = ship:torpedo_max()
	if torpedo_max == false then
		torpedo_max = ship:torpedo()
	end
	return {values = {value = Formatting:format_stat(torpedo_max)}, bg_color = self:get_bg_color(self._cell_color.torpedo, torpedo_max, self._args.torpedo_operator, self._args.torpedo_outstanding, self._args.torpedo_good, self._args.torpedo_bad), text_align = self._center_align}
end

function EliteShipsKai:night_battle(ship)
	local firepower_max = ship:firepower_max()
	if firepower_max == false then
		firepower_max = ship:firepower()
	end
	local torpedo_max = ship:torpedo_max()
	if torpedo_max == false then
		torpedo_max = ship:torpedo()
	end
	local night_battle = firepower_max
	if not firepower_max then
	    night_battle = torpedo_max
	elseif torpedo_max then
	    night_battle = night_battle + torpedo_max
	end
	return {values = {value = Formatting:format_stat(night_battle)}, bg_color = self:get_bg_color(self._cell_color.night_battle, night_battle, self._args.night_battle_operator, self._args.night_battle_outstanding, self._args.night_battle_good, self._args.night_battle_bad), text_align = self._center_align}
end

function EliteShipsKai:range(ship)
	local range = ship:range()
	return {values = {value = Formatting:format_range(range)}, bg_color = self:get_bg_color(self._cell_color.range, range, self._args.range_operator, self._args.range_outstanding, self._args.range_good, self._args.range_bad), text_align = self._center_align}
end

function EliteShipsKai:aa(ship)
	local aa_max = ship:aa_max()
	if aa_max == false then
		aa_max = ship:aa()
	end
	return {values = {value = Formatting:format_stat(aa_max)}, bg_color = self:get_bg_color(self._cell_color.aa, aa_max, self._args.aa_operator, self._args.aa_outstanding, self._args.aa_good, self._args.aa_bad), text_align = self._center_align}
end

function EliteShipsKai:asw(ship)
	local asw_max = ship:asw_max()
	if asw_max == false then
		asw_max = ship:asw()
		return {values = {value = Formatting:format_stat(asw_max)}, bg_color = self:get_bg_color(self._cell_color.asw, asw_max, self._args.asw_operator, self._args.asw_outstanding, self._args.asw_good, self._args.asw_bad), text_align = self._center_align}
	end
	return {values = {value = Formatting:tooltip(Formatting:format_stat(asw_max), format{self._kekkon_max_template, value = Formatting:format_stat(ship:asw_leveled(175))})}, bg_color = self:get_bg_color(self._cell_color.asw, asw_max, self._args.asw_operator, self._args.asw_outstanding, self._args.asw_good, self._args.asw_bad), text_align = self._center_align}
end

function EliteShipsKai:los(ship)
	local los_max = ship:los_max()
	if los_max == false then
		los_max = ship:los()
		return {values = {value = Formatting:format_stat(los_max)}, bg_color = self:get_bg_color(self._cell_color.los, los_max, self._args.los_operator, self._args.los_outstanding, self._args.los_good, self._args.los_bad), text_align = self._center_align}
	end
	return {values = {value = Formatting:tooltip(Formatting:format_stat(los_max), format{self._kekkon_max_template, value = Formatting:format_stat(ship:los_leveled(175))})}, bg_color = self:get_bg_color(self._cell_color.los, los_max, self._args.los_operator, self._args.los_outstanding, self._args.los_good, self._args.los_bad), text_align = self._center_align}
end

function EliteShipsKai:luck(ship)
	local luck = ship:luck()
	local luck_max = ship:luck_max()
	return {values = {luck = Formatting:format_stat(luck), luck_max = self:get_emphasis(luck_max, Formatting:format_stat(luck_max), self._args.luck_max_operator, self._args.luck_max_good)}, bg_color = self:get_bg_color(self._cell_color.luck, luck, self._args.luck_operator, self._args.luck_outstanding, self._args.luck_good, self._args.luck_bad), text_align = self._center_align}
end

function EliteShipsKai:hp(ship)
	local hp = ship:hp()
	local hp_married = ship:hp_married()
	if hp_married then
	    local hp_mod_married = ship:hp_mod_married()
		return {values = {value = Formatting:tooltip(Formatting:format_stat(hp), format{
		    self._kekkon_template,
		    value = hp_mod_married and hp_mod_married > 0 and Formatting:format_stat_with_max(hp_married, hp_married + hp_mod_married) or Formatting:format_stat(hp_married)
        })}, bg_color = self:get_bg_color(self._cell_color.hp, hp, self._args.hp_operator, self._args.hp_outstanding, self._args.hp_good, self._args.hp_bad), text_align = self._center_align}
	else
		return {values = {value = Formatting:format_stat(hp)}, bg_color = self:get_bg_color(self._cell_color.hp, hp, self._args.hp_operator, self._args.hp_outstanding, self._args.hp_good, self._args.hp_bad), text_align = self._center_align}
	end
end

function EliteShipsKai:armor(ship)
	local armor_max = ship:armor_max()
	if armor_max == false then
		armor_max = ship:armor()
	end
	return {values = {value = Formatting:format_stat(armor_max)}, bg_color = self:get_bg_color(self._cell_color.armor, armor_max, self._args.armor_operator, self._args.armor_outstanding, self._args.armor_good, self._args.armor_bad), text_align = self._center_align}
end

function EliteShipsKai:evasion(ship)
	local evasion_max = ship:evasion_max()
	if evasion_max == false then
		evasion_max = ship:evasion()
		return {values = {value = Formatting:format_stat(evasion_max)}, bg_color = self:get_bg_color(self._cell_color.evasion, evasion_max, self._args.evasion_operator, self._args.evasion_outstanding, self._args.evasion_good, self._args.evasion_bad), text_align = self._center_align}
	end
	return {values = {value = Formatting:tooltip(Formatting:format_stat(evasion_max), format{self._kekkon_max_template, value = Formatting:format_stat(ship:evasion_leveled(175))})}, bg_color = self:get_bg_color(self._cell_color.evasion, evasion_max, self._args.evasion_operator, self._args.evasion_outstanding, self._args.evasion_good, self._args.evasion_bad), text_align = self._center_align}
end

function EliteShipsKai:speed(ship)
	local speed = ship:speed()
	return {values = {value = Formatting:format_speed(speed)}, bg_color = self:get_bg_color(self._cell_color.speed, speed, self._args.speed_operator, self._args.speed_outstanding, self._args.speed_good, self._args.speed_bad), text_align = self._center_align}
end

function EliteShipsKai:aircraft(ship)
	local aircraft = ship:total_space()
	local slots = {}
	if aircraft and aircraft > 0 then
		for i = 1, ship:slots_length() do
			local size = ship:slot_space(i)
			table.insert(slots, self:get_emphasis(size, Formatting:format_stat(size), self._args.aircraft_slot_operator, self._args.aircraft_slot_good))
		end
	end
	return {values = {value = Formatting:format_detailed_aircraft(aircraft, slots)}, bg_color = self:get_bg_color(self._cell_color.aircraft, aircraft, self._args.aircraft_operator, self._args.aircraft_outstanding, self._args.aircraft_good, self._args.aircraft_bad), text_align = self._center_align}
end

function EliteShipsKai:fuel(ship)
	local fuel = ship:fuel()
	return {values = {value = Formatting:format_stat(fuel)}, bg_color = self:get_bg_color(self._cell_color.fuel, fuel, self._args.fuel_operator, self._args.fuel_outstanding, self._args.fuel_good, self._args.fuel_bad), text_align = self._center_align}
end

function EliteShipsKai:ammo(ship)
	local ammo = ship:ammo()
	return {values = {value = Formatting:format_stat(ammo)}, bg_color = self:get_bg_color(self._cell_color.ammo, ammo, self._args.ammo_operator, self._args.ammo_outstanding, self._args.ammo_good, self._args.ammo_bad), text_align = self._center_align}
end

function EliteShipsKai:notes(ship)
	local note = self._notes[ship]
	if note then
		local bg_color
		if note.highlight == "outstanding" then
			bg_color = self._outstanding_stat_color
		elseif note.highlight == "good" then
			bg_color = self._good_stat_color
		elseif note.highlight == "bad" then
			bg_color = self._bad_stat_color
		else
			bg_color = self._transparent
		end
		return {values = {value = note.note or ""}, bg_color = bg_color, class = self._detailed_class}
	end
	return {values = {value = ""}, bg_color = self._transparent, class = self._detailed_class}
end

function EliteShipsKai:process_item_key(item_key)
	local split = mw.ustring.find(item_key, '/')
	local ship_base_name, ship_suffix
	if split == nil then
		ship_base_name = item_key
	else
		ship_base_name = mw.ustring.sub(item_key, 1, split - 1)
		ship_suffix = mw.ustring.sub(item_key, split + 1, -1)
	end
	return ship_base_name, ship_suffix
end

function EliteShipsKai:start_rows()
	self._rows = {self._detail_toggle, self._table_start, self._header}
end

EliteShipsKai.create_data_rows = EliteShipsKai.create_data_rows_merge_vertical

function EliteShipsKai:create_table_prep()
    self._columns = {}
    for _, column in ipairs(self._base_columns) do
        table.insert(self._columns, column)
    end
	if self._args.reference_type then
		self._reference_types = {}
		for _, reference_type in ipairs(split(self._args.reference_type, ',%s*')) do
			self._reference_types[tonumber(reference_type)] = true
		end
    end
    if self._args.night_battle then
        table.insert(self._columns, 7, "night_battle")
    end
    if self._args.range then
        table.insert(self._columns, self._args.night_battle and 16 or 15, "range")
    end
end

function EliteShipsKai:append_custom_row(custom_row_key)
	table.insert(self._rows, self._row_starter)
	table.insert(self._rows,
		format{self._column_cell_templates["!"] or self._cell,
			class = "",
			colspan = #self._columns, rowspan = 1,
			text_align = self._args[self._custom_row_prefix .. custom_row_key .. self._text_align_suffix] or self._start_align,
			bg_color = self._args[self._custom_row_prefix .. custom_row_key .. self._bg_color_suffix] or self._transparent,
			values = {
				value = self._args[self._custom_row_prefix .. custom_row_key .. self._content_suffix] or "",
			},
		}
	)
end

function EliteShipsKai:create_header()
	local header_icons = {
		remodel = StatIcons.remodel, 
		firepower = StatIcons.firepower, 
		torpedo = StatIcons.torpedo, 
		aa = StatIcons.aa, 
		asw = StatIcons.asw, 
		los = StatIcons.los, 
		luck = StatIcons.luck, 
		hp = StatIcons.hp, 
		armor = StatIcons.armor,
		evasion = StatIcons.evasion,
		speed = StatIcons.speed,
		range = StatIcons.range,
		aircraft = StatIcons.aircraft,
		fuel = ResourceIcons.fuel,
		ammo = ResourceIcons.ammo,
	}
	for key, value in pairs(header_icons) do
		header_icons[key] = Formatting:format_image{value, caption = Formatting:format_stat_name(key)}
	end
	self._header = format(format{
		self._header_template,
		night_battle_header_cell = self._args.night_battle and self._night_battle_header_cell or "",
		range_header_cell = self._args.range and self._range_header_cell or ""
	}, header_icons)
end

return EliteShipsKai