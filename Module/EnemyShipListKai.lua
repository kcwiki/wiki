local BaseTable = require('Module:BaseTable')
local EnemyColors = require('Module:EnemyColors')
local EnemyShip = require('Module:EnemyShip')
local Formatting = require('Module:Formatting')
local ShipBattleCardKai = require('Module:ShipBattleCardKai')
local ShipCapabilities = require('Module:ShipCapabilities')
local StatIcons = require('Module:Data/Asset')

local format = require('Module:Core').format

local EnemyShipListKai = BaseTable{
	_header_template = [[! style="min-width: 180px;" | Card
! style="min-width: 75px;" | Name
! Type
! style="width: 30px; text-align: center; vertical-align: middle; background-color: pink;" | ${hp}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: lightcoral;" | ${firepower}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: lightskyblue;" | ${torpedo}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: sandybrown;" | ${aa}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: #9C8FEE;" | ${asw}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: #F2E279;" | ${armor}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: violet;" | ${evasion}
! style="text-align: center; vertical-align: middle;" | Armament
! style="text-align:left;" | Notes]],
	_columns = {
		"card",
		"name",
		"type",
		"hp",
		"firepower",
		"torpedo",
		"aa",
		"asw",
		"armor",
		"evasion",
		"armament",
		"notes",
	},
	_cell = [[| style="text-align: ${text_align}; padding:5px 5px 5px 5px; background-color: ${bg_color};" |${value}]],
	_column_cell_templates = {
		card = [[| style="text-align: ${text_align}; padding:5px 5px 5px 5px; background-color: ${bg_color}; background-image: ${background_image}" |${value}]],
	},
	_item_class = function(item_key) return EnemyShip(item_key) end,
	_fragment_prefix = "enemyshiplistkai",
	_icon_caption_template = "${equipment} - ${equipment_type}",
	_installation_label = "Installation",
	_pillbox_label = "Pillbox",
	_opening_torpedo_label = "Opening Torpedo",
	_air_power_template = "${air_power} Air Power",
	_night_bombing_label = "Night Bombing",
	_asw_label = "ASW",
	_high_asw_label = "High ASW",
	_estimation_label = "Estimation",
}

function EnemyShipListKai:name(ship)
	local name = Formatting:format_link(ship:link())
	local value = {name}
	local japanese_name = ship:japanese_name()
	if japanese_name and name ~= japanese_name then
		local reading = ship:reading()
		if reading then
			japanese_name = Formatting:japanese_text(japanese_name, reading)
		end
		table.insert(value, Formatting:format_stat(japanese_name))
	end
	return {value = Formatting:id_span(tostring(ship:api_id() or mw.ustring.lower(mw.ustring.gsub(ship:name(), "%s+"))), self._fragment_prefix, table.concat(value, "<br />")), bg_color = self._transparent, text_align = self._start_align}
end

function EnemyShipListKai:card(ship)
	local value
	local bg_color, background_image = EnemyColors:rarity_colors(ship)
	background_image = EnemyColors:variant_background_image(ship, background_image)
	if ship == false then
		value = Formatting:format_image{self._blank, size = self._size}
	else
		value = ShipBattleCardKai:get{ship = ship, size = self._size, link = ship:link(), hd = true, size = '160px', caption = ship:name()}
	end
	return {value = value, bg_color = bg_color, background_image = background_image or self._none, text_align = self._center_align}
end

function EnemyShipListKai:type(ship)
	return {value = Formatting:format_ship_code(ship:type()), bg_color = self._transparent, text_align = self._start_align}
end

function EnemyShipListKai:firepower(ship)
	return {value = Formatting:format_stat(ship:firepower()), bg_color = "#e6cfcf", text_align = self._center_align}
end

function EnemyShipListKai:torpedo(ship)
	return {value = Formatting:format_stat(ship:torpedo()), bg_color = "#cfdde6", text_align = self._center_align}
end

function EnemyShipListKai:aa(ship)
	return {value = Formatting:format_stat(ship:aa()), bg_color = "#e6d9cf", text_align = self._center_align}
end

function EnemyShipListKai:asw(ship)
	return {value = Formatting:format_stat(ship:asw()), bg_color = "#d2cee6", text_align = self._center_align}
end

function EnemyShipListKai:hp(ship)
	return {value = Formatting:format_stat(ship:hp()), bg_color = "#f0d9dd", text_align = self._center_align}
end

function EnemyShipListKai:armor(ship)
	return {value = Formatting:format_stat(ship:armor()), bg_color = "#e6e3cf", text_align = self._center_align}
end

function EnemyShipListKai:evasion(ship)
	return {value = Formatting:format_stat(ship:evasion()), bg_color = "#e6cee6", text_align = self._center_align}
end

function EnemyShipListKai:armament(ship)
	local icons, roles = {}, {}
	local sonar, dc, air_power, active_midget_submarine = false, false, false, false

	for i = 1, ship:slots_length() do
		local equipment, size, estimation = ship:slot(i)
		local icon, equipment_type, equipment_link
		if equipment then
			icon = equipment:icon()
			equipment_type = equipment:type()
			if ShipCapabilities:_is_air_power_plane(equipment) then
				air_power = true
			elseif ShipCapabilities:_is_sonar(equipment) then
				sonar = true
			elseif ShipCapabilities:_is_depth_charge(equipment) then
				dc = true
			elseif ShipCapabilities._is_active_midget_submarine(equipment) then
				active_midget_submarine = true
			end
			local real_equipment = equipment:link()
			equipment = real_equipment or equipment
			equipment_link = equipment
			--[[
			equipment_link, equipment = Formatting:format_link(equipment:link())
			equipment = equipment or equipment_link
			]]
		else
			icon = disabled and "" or false
			equipment = equipment == false and (disabled and "- Locked -" or "- Unequipped -") or Formatting:format_stat(equipment)
			equipment_link = false
			equipment_type = false
		end
		if icon ~= "" then
			icon = Formatting:format_image{Formatting:format_equipment_icon(icon), link = equipment_link, caption = format{self._icon_caption_template, equipment_type = Formatting:format_equipment_type(equipment_type), equipment = equipment}}
		end
		table.insert(icons, icon)
	end
	if ShipCapabilities:_is_submarine(ship) then
		if ship:suffix() and (ship:suffix():match("Elite") or ship:suffix():match("Flagship")) then
			table.insert(roles, self._opening_torpedo_label)
		end
	elseif active_midget_submarine then
		table.insert(roles, self._opening_torpedo_label)
	end
	if air_power then
	    local ap_text = format{self._air_power_template, air_power = Formatting:format_stat(ship:air_power())}
	    if ship:air_power_estimation() then
	        ap_text = Formatting:tooltip(ap_text, self._estimation_label)
        end
		table.insert(roles, ap_text)
	end
	if ShipCapabilities:_is_night_bombing(ship) then
		table.insert(roles, self._night_bombing_label)
	end
	if sonar or dc then
		if sonar and dc then
			table.insert(roles, self._high_asw_label)
		else
			table.insert(roles, self._asw_label)
		end
	end

	return {value = table.concat(icons) .. '<br/>' .. table.concat(roles, ", "), bg_color = self._transparent, text_align = self._start_align}
end

function EnemyShipListKai:notes(ship)
	local note = self._notes[ship]
	local back = ship:back() or 0
	local value = {}
	if back < -1 then
		table.insert(value, tostring(mw.html.create('span'):css({color = Formatting:format_ship_back(back)}):tag('b'):wikitext(Formatting:format_ship_rarity(back)):allDone()))
	end
	if ship:speed() == 0 then
		table.insert(value, tostring(mw.html.create('b'):wikitext(ship:is_pillbox() and self._pillbox_label or self._installation_label)))
	end
	if note then
		table.insert(value, note.note or "")
	end
	return {value = table.concat(value, "<br/>"), bg_color = self._transparent, text_align = self._start_align}
end

EnemyShipListKai.process_item_key = EnemyShip.process_item_key

EnemyShipListKai.build_rows = EnemyShipListKai.build_rows_breaks_as_empty_rows

function EnemyShipListKai:create_header()
	local header_icons = {
		firepower = StatIcons.firepower, 
		torpedo = StatIcons.torpedo, 
		aa = StatIcons.aa, 
		asw = StatIcons.asw,  
		hp = StatIcons.hp, 
		armor = StatIcons.armor,
		evasion = StatIcons.evasion,
	}
	for key, value in pairs(header_icons) do
		header_icons[key] = Formatting:format_image{value, caption = Formatting:format_stat_name(key)}
	end
	self._header = format(self._header_template, header_icons)
end

function EnemyShipListKai.Invoke(frame)
	local args = require('Module:GetArgs'){frame = frame:getParent()}
	return EnemyShipListKai:Table(args)
end

return EnemyShipListKai