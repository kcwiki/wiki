local Equipment = require('Module:Equipment')
local EquipmentListKai = require('Module:EquipmentListKai')
local Formatting = require('Module:Formatting')
local ResourceIcons = require('Module:Data/Asset')
local StatIcons = require('Module:Data/Asset')

local format = require('Module:Core').format

local EquipmentComparisonKai = EquipmentListKai{
	_columns = {
		"id",
		"rarity",
		"name",
		"equipment_type",
		"firepower",
		"torpedo",
		"bombing",
		"aa",
		"asw",
		"los",
		"luck",
		"armor",
		"shelling_accuracy",
		"evasion",
		"anti_bomber",
		"interception",
		"speed",
		"range",
		"combat_radius",
		"deployment_cost",
		"compatibility",
		"buildable",
		"improvable",
		"notes",
	},
	_stat_columns = {
		"firepower",
		"torpedo",
		"bombing",
		"aa",
		"asw",
		"los",
		"luck",
		"armor",
		"shelling_accuracy",
		"evasion",
		"anti_bomber",
		"interception",
		"speed",
		"range",
		"combat_radius",
		"deployment_cost",
	},
	_stat_colors = {
		firepower = "lightcoral",
		torpedo = "lightskyblue",
		bombing = "firebrick",
		aa = "sandybrown",
		asw = "#9C8FEE",
		los = "aquamarine",
		luck = "palegreen",
		armor = "#F2E279",
		shelling_accuracy = "darkseagreen",
		evasion = "violet",
		anti_bomber = "darkseagreen",
		interception = "violet",
		combat_radius = "lightseagreen",
		deployment_cost = "#D4B390",
		speed = "#72E6E6",
		range = "lightseagreen",
	},
	_column_header_cell_template = [[! style="background-color: ${bg_color};" | ${value}]],
	_stats_column_label = "Stats",
}

function EquipmentComparisonKai:firepower(equipment)
	local firepower = equipment:firepower()
	if firepower ~= false then
		self._shown_stats.firepower = true
	else
		firepower = 0
	end
	return {values = {value = Formatting:format_stat(firepower)}, bg_color = self:get_bg_color(self._cell_color.firepower, firepower, self._args.firepower_operator, self._args.firepower_outstanding, self._args.firepower_good, self._args.firepower_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:torpedo(equipment)
	local torpedo = equipment:torpedo()
	if torpedo ~= false then
		self._shown_stats.torpedo = true
	else
		torpedo = 0
	end
	return {values = {value = Formatting:format_stat(torpedo)}, bg_color = self:get_bg_color(self._cell_color.torpedo, torpedo, self._args.torpedo_operator, self._args.torpedo_outstanding, self._args.torpedo_good, self._args.torpedo_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:bombing(equipment)
	local bombing = equipment:bombing()
	if bombing ~= false then
		self._shown_stats.bombing = true
	else
		bombing = 0
	end
	return {values = {value = Formatting:format_stat(bombing)}, bg_color = self:get_bg_color(self._cell_color.bombing, bombing, self._args.bombing_operator, self._args.bombing_outstanding, self._args.bombing_good, self._args.bombing_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:aa(equipment)
	local aa = equipment:aa()
	if aa ~= false then
		self._shown_stats.aa = true
	else
		aa = 0
	end
	return {values = {value = Formatting:format_stat(aa)}, bg_color = self:get_bg_color(self._cell_color.aa, aa, self._args.aa_operator, self._args.aa_outstanding, self._args.aa_good, self._args.aa_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:asw(equipment)
	local asw = equipment:asw()
	if asw ~= false then
		self._shown_stats.asw = true
	else
		asw = 0
	end
	return {values = {value = Formatting:format_stat(asw)}, bg_color = self:get_bg_color(self._cell_color.asw, asw, self._args.asw_operator, self._args.asw_outstanding, self._args.asw_good, self._args.asw_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:los(equipment)
	local los = equipment:los()
	if los ~= false then
		self._shown_stats.los = true
	else
		los = 0
	end
	return {values = {value = Formatting:format_stat(los)}, bg_color = self:get_bg_color(self._cell_color.los, los, self._args.los_operator, self._args.los_outstanding, self._args.los_good, self._args.los_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:luck(equipment)
	local luck = equipment:luck()
	if luck ~= false then
		self._shown_stats.luck = true
	else
		luck = 0
	end
	return {values = {value = Formatting:format_stat(luck)}, bg_color = self:get_bg_color(self._cell_color.luck, luck, self._args.luck_operator, self._args.luck_outstanding, self._args.luck_good, self._args.luck_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:armor(equipment)
	local armor = equipment:armor()
	if armor ~= false then
		self._shown_stats.armor = true
	else
		armor = 0
	end
	return {values = {value = Formatting:format_stat(armor)}, bg_color = self:get_bg_color(self._cell_color.armor, armor, self._args.armor_operator, self._args.armor_outstanding, self._args.armor_good, self._args.armor_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:shelling_accuracy(equipment)
	local shelling_accuracy = equipment:shelling_accuracy()
	if equipment:type() == 48 then
	    shelling_accuracy = false
	end
	if shelling_accuracy ~= false then
		self._shown_stats.shelling_accuracy = true
	else
		shelling_accuracy = 0
	end
	return {values = {value = Formatting:format_stat(shelling_accuracy)}, bg_color = self:get_bg_color(self._cell_color.shelling_accuracy, shelling_accuracy, self._args.shelling_accuracy_operator, self._args.shelling_accuracy_outstanding, self._args.shelling_accuracy_good, self._args.shelling_accuracy_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:anti_bomber(equipment)
	local anti_bomber = equipment:shelling_accuracy()
	if equipment:type() ~= 48 then
	    anti_bomber = false
	end
	if anti_bomber ~= false then
		self._shown_stats.anti_bomber = true
	else
		anti_bomber = 0
	end
	return {values = {value = Formatting:format_stat(anti_bomber)}, bg_color = self:get_bg_color(self._cell_color.anti_bomber, anti_bomber, self._args.anti_bomber_operator, self._args.anti_bomber_outstanding, self._args.anti_bomber_good, self._args.anti_bomber_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:evasion(equipment)
	local evasion = equipment:evasion()
	if equipment:type() == 48 then
	    evasion = false
	end
	if evasion ~= false then
		self._shown_stats.evasion = true
	else
		evasion = 0
	end
	return {values = {value = Formatting:format_stat(evasion)}, bg_color = self:get_bg_color(self._cell_color.evasion, evasion, self._args.evasion_operator, self._args.evasion_outstanding, self._args.evasion_good, self._args.evasion_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:interception(equipment)
	local interception = equipment:evasion()
	if equipment:type() ~= 48 then
	    interception = false
	end
	if interception ~= false then
		self._shown_stats.interception = true
	else
		interception = 0
	end
	return {values = {value = Formatting:format_stat(interception)}, bg_color = self:get_bg_color(self._cell_color.interception, interception, self._args.interception_operator, self._args.interception_outstanding, self._args.interception_good, self._args.interception_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:speed(equipment)
	local speed = equipment:speed()
	if speed ~= false then
		self._shown_stats.speed = true
	else
		speed = 0
	end
	return {values = {value = Formatting:format_speed(speed)}, bg_color = self:get_bg_color(self._cell_color.speed, speed, self._args.speed_operator, self._args.speed_outstanding, self._args.speed_good, self._args.speed_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:range(equipment)
	local range = equipment:range()
	if range ~= false then
		self._shown_stats.range = true
	else
		range = 0
	end
	return {values = {value = Formatting:format_range(range)}, bg_color = self:get_bg_color(self._cell_color.range, range, self._args.range_operator, self._args.range_outstanding, self._args.range_good, self._args.range_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:combat_radius(equipment)
    local combat_radius = equipment:combat_radius()
    if combat_radius then
        self._shown_stats.combat_radius = true
    else
        combat_radius = "-"
    end
    return {values = {value = Formatting:format_stat(combat_radius)}, bg_color = self:get_bg_color(self._cell_color.combat_radius, combat_radius, self._args.combat_radius_operator, self._args.combat_radius_outstanding, self._args.combat_radius_good, self._args.combat_radius_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:deployment_cost(equipment)
    local deployment_cost = equipment:deployment_cost().bauxite
    if deployment_cost then
        self._shown_stats.deployment_cost = true
    else
        deployment_cost = "-"
    end
    return {values = {value = Formatting:format_stat(deployment_cost)}, bg_color = self:get_bg_color(self._cell_color.deployment_cost, deployment_cost, self._args.deployment_cost_operator, self._args.deployment_cost_outstanding, self._args.deployment_cost_good, self._args.deployment_cost_bad), text_align = self._center_align}
end

function EquipmentComparisonKai:notes(equipment)
	local note = self._notes[equipment]
	if note then
		local bg_color = self._transparent
		if note.highlight then
			if note.highlight == "outstanding" then
				bg_color = self._outstanding_stat_color
			elseif note.highlight == "good" then
				bg_color = self._good_stat_color
			elseif note.highlight == "bad" then
				bg_color = self._bad_stat_color
			end
		end
		return {values = {value = note.note or ""}, bg_color = bg_color}
	end
	return {values = {value = ""}, bg_color = self._transparent}
end

function EquipmentComparisonKai:create_table_prep()
	self._shown_stats = {}
end	

EquipmentComparisonKai.create_data_rows = EquipmentComparisonKai.create_data_rows_merge_vertical

function EquipmentComparisonKai:create_header()
	local stat_columns = {}
	for _, column in ipairs(self._stat_columns) do
		if self._shown_stats[column] then
			table.insert(stat_columns, format{self._column_header_cell_template, value = Formatting:format_image{StatIcons[column] or (column == "deployment_cost" and ResourceIcons.bauxite or nil), caption = Formatting:format_stat_name(column)}, bg_color = self._stat_colors[column]})
		else
			for _, row_values in ipairs(self._data_rows) do
				if type(row_values) == "table" then
					row_values[column] = nil
				end
			end
		end
	end
	self._header = format{self._header_template, stat_columns = table.concat(stat_columns, "\n")}
end

return EquipmentComparisonKai