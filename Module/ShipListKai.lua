local BaseTable = require('Module:BaseTable')
local Formatting = require('Module:Formatting')
local ResourceIcons = require('Module:Data/Asset')
local Ship = require('Module:Ship')
local StatIcons = require('Module:Data/Asset')

local format = require('Module:Core').format

local ShipListKai = BaseTable({
	_header_template = [[! No.
! style="width: 100px;" | Name
! style="width: 75px;" | Class
! Type
! style="width: 30px; text-align: center; vertical-align: middle; background-color: lightcoral;" | ${firepower}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: lightskyblue;" | ${torpedo}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: sandybrown;" | ${aa}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: #9C8FEE;" | ${asw}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: aquamarine;" | ${los}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: palegreen;" | ${luck}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: pink;" | ${hp}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: #F2E279;" | ${armor}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: violet;" | ${evasion}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: #72E6E6;" | ${speed}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: silver;" | ${aircraft}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: lightseagreen;" | ${range}
! style="width: 30px; text-align: center; vertixal-align: middle; background-color: forestgreen;" | ${fuel}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: darkgoldenrod;" | ${ammo}
! style="width: 250px; text-align: center; vertical-align: middle;" | Build / Remodel Info
! style="text-align:left;" | Notes]],
	_columns = {
		"id",
		"name",
		"class",
		"type",
		"firepower",
		"torpedo",
		"aa",
		"asw",
		"los",
		"luck",
		"hp",
		"armor",
		"evasion",
		"speed",
		"aircraft",
		"range",
		"fuel",
		"ammo",
		"build",
		"notes",
	},
	_cell = [[| style="text-align: ${text_align}; padding:5px 5px 5px 5px;" |${value}]],
	_item_class = Ship,
	_class_number_template = "${class_name}<br />#${class_number}",
	_normal_construction = "Normal",
	_large_ship_construction = "LSC",
	_build_label = "Construction: ",
	_remodel_from_label = "Remodel From: ",
	_remodel_to_label = "Remodel To: ",
	_remodel_template = "${link} (Level ${level})",
	_unbuildable_label = "''Unbuildable''",
	_fragment_prefix = "shiplistkai",
	_dash = "-",
})

function ShipListKai:name(ship)
	local link, text, section = ship:link()
	local value = {Formatting:format_link(link, text, section)}
	local japanese_name = ship:japanese_name()
	if japanese_name and (text or link) ~= japanese_name then
		table.insert(value, Formatting:format_stat(ship:japanese_name()))
	end
	return {value = Formatting:id_span(tostring(ship:api_id() or mw.ustring.lower(mw.ustring.gsub(ship:name(), "%s+", self._dash))), self._fragment_prefix, table.concat(value, "<br />")), text_align = self._start_align}
end

function ShipListKai:id(ship)
	return {value = Formatting:format_stat(ship:true_id() or ship:id()),
		text_align = self._center_align,
	}
end

function ShipListKai:class(ship)
	local class = ship:class()
	local class_name = class and class:base_name() or "??"
	local class_number = ship:class_number()
	if class_number == nil then
		class_number = "??"
	end
	return {value = class_number and format{self._class_number_template, class_name = class_name, class_number = class_number} or class_name, text_align = self._start_align}
end

function ShipListKai:type(ship)
	return {value = Formatting:format_ship_code(ship:type()), text_align = self._start_align}
end

function ShipListKai:firepower(ship)
	return {value = Formatting:format_stat(ship:firepower()), text_align = self._center_align}
end

function ShipListKai:torpedo(ship)
	return {value = Formatting:format_stat(ship:torpedo()), text_align = self._center_align}
end

function ShipListKai:aa(ship)
	return {value = Formatting:format_stat(ship:aa()), text_align = self._center_align}
end

function ShipListKai:asw(ship)
	return {value = Formatting:format_stat(ship:asw()), text_align = self._center_align}
end

function ShipListKai:los(ship)
	return {value = Formatting:format_stat(ship:los()), text_align = self._center_align}
end

function ShipListKai:luck(ship)
	return {value = Formatting:format_stat(ship:luck()), text_align = self._center_align}
end

function ShipListKai:hp(ship)
	return {value = Formatting:format_stat(ship:hp()), text_align = self._center_align}
end

function ShipListKai:armor(ship)
	return {value = Formatting:format_stat(ship:armor()), text_align = self._center_align}
end

function ShipListKai:evasion(ship)
	return {value = Formatting:format_stat(ship:evasion()), text_align = self._center_align}
end

function ShipListKai:speed(ship)
	return {value = Formatting:format_speed(ship:speed()), text_align = self._center_align}
end

function ShipListKai:aircraft(ship)
	return {value = Formatting:format_stat(ship:total_space()), text_align = self._center_align}
end

function ShipListKai:range(ship)
	return {value = Formatting:format_range(ship:range()), text_align = self._center_align}
end

function ShipListKai:fuel(ship)
	return {value = Formatting:format_stat(ship:fuel()), text_align = self._center_align}
end

function ShipListKai:ammo(ship)
	return {value = Formatting:format_stat(ship:ammo()), text_align = self._center_align}
end

function ShipListKai:build(ship)
	local remodel_from = ship:remodel_from()
	local build_info = {}
	if not remodel_from then
		local buildable = ship:buildable()
		local buildable_lsc = ship:buildable_lsc()
		local buildable_methods = {}
		if buildable then
			table.insert(buildable_methods, self._normal_construction)
		end
		if buildable_lsc then
			table.insert(buildable_methods, self._large_ship_construction)
		end
		if #buildable_methods == 0 then
			table.insert(build_info, self._unbuildable_label)
		else
			table.insert(build_info, self._build_label .. table.concat(buildable_methods, ", "))
		end
	else
		remodel_from = Ship(remodel_from)
		local remodel_level = ship:remodel_level()
		if ship:remodel_blueprint() or ship:remodel_catapult() then
			remodel_level = table.concat({remodel_level, Formatting:format_remodel_items(ship:remodel_blueprint(), ship:remodel_catapult())}, " + ")
		end
		table.insert(build_info, self._remodel_from_label .. format{self._remodel_template, link = Formatting:fragment_link(tostring(remodel_from:api_id() or mw.ustring.lower(mw.ustring.gsub(remodel_from:name(), "%s+", self._dash))), self._fragment_prefix, remodel_from:name()), level = remodel_level})
	end

	local remodel_to = ship:remodel_to()
	if remodel_to then
		local remodel_level
		if remodel_to == ship:remodel_from() then
			remodel_level = ship:remodel_to_level()
			if ship:remodel_to_blueprint() or ship:remodel_to_catapult() then
				remodel_level = table.concat({remodel_level, Formatting:format_remodel_items(ship:remodel_to_blueprint(), ship:remodel_to_catapult())}, " + ")
			end
			remodel_to = remodel_from
		else
			remodel_to = Ship(remodel_to)
			remodel_level = remodel_to:remodel_level()
			if remodel_to:remodel_blueprint() or remodel_to:remodel_catapult() then
				remodel_level = table.concat({remodel_level, Formatting:format_remodel_items(remodel_to:remodel_blueprint(), remodel_to:remodel_catapult())}, " + ")
			end
		end
		table.insert(build_info, self._remodel_to_label .. format{self._remodel_template, link = Formatting:fragment_link(tostring(remodel_to:api_id() or mw.ustring.lower(mw.ustring.gsub(remodel_to:name(), "%s+", self._dash))), self._fragment_prefix, remodel_to:name()), level = remodel_level})
	end
	return {value = table.concat(build_info, "<br />"), text_align = self._start_align}
end

function ShipListKai:notes(ship)
	local note = self._notes[ship]
	if note then
		return {value = note.note or "", text_align = self._start_align}
	end
	return {value = "", text_align = self._start_align}
end

ShipListKai.process_item_key = Ship.process_item_key

ShipListKai.build_rows = ShipListKai.build_rows_breaks_as_empty_rows

function ShipListKai:create_header()
	local header_icons = {
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
		aircraft = StatIcons.aircraft,
		range = StatIcons.range,
		fuel = ResourceIcons.fuel,
		ammo = ResourceIcons.ammo,
	}
	for key, value in pairs(header_icons) do
		header_icons[key] = Formatting:format_image{value, caption = Formatting:format_stat_name(key)}
	end
	self._header = format(self._header_template, header_icons)
end

return ShipListKai