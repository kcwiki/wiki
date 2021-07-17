local BaseTable = require('Module:BaseTable')
local Equipment = require('Module:Equipment')
local Formatting = require('Module:Formatting')
local ResourceIcons = require('Module:Data/Asset')
local Ship = require('Module:Ship')

local format = require('Module:Core').format

local ImprovementTableKai = BaseTable{
	_item_class = Equipment,
	_header_template = [[
! style="text-align: center; padding: 5px;" | ${resources}
! style="text-align: center; padding: 5px;" | ★
! style="text-align: center; padding: 5px;" | ${devmat}
! style="text-align: center; padding: 5px;" | ${screw}
! class="multi-toggle-target-improvementtablekai-day-Sunday" style="text-align: center; padding: 5px;" | S
! class="multi-toggle-target-improvementtablekai-day-Monday" style="text-align: center; padding: 5px;" | M
! class="multi-toggle-target-improvementtablekai-day-Tuesday" style="text-align: center; padding: 5px;" | T
! class="multi-toggle-target-improvementtablekai-day-Wednesday" style="text-align: center; padding: 5px;" | W
! class="multi-toggle-target-improvementtablekai-day-Thursday" style="text-align: center; padding: 5px;" | T
! class="multi-toggle-target-improvementtablekai-day-Friday" style="text-align: center; padding: 5px;" | F
! class="multi-toggle-target-improvementtablekai-day-Saturday" style="text-align: center; padding: 5px;" | S
! style="text-align: center; padding: 5px;" | Helper Ship]],
	_column_cell_templates = {
		["!"] = [[| class="${classes}" colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;" |${values.value}]],
		name = [[| colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:5px 5px 5px 5px;" |${values.name}<br />${values.icon} ${values.japanese_name}]]
	},
	_columns = {
		"input_output",
		"improvement_level",
		"development_material",
		"improvement_material",
		"sunday",
		"monday",
		"tuesday",
		"wednesday",
		"thursday",
		"friday",
		"saturday",
		"helper_ships",
	},
	_improvement_brackets = {
		0,
		6,
		10
	},
	_caption_template = [[|+ style="position: relative;" | ${icon}${name}<span style="position: absolute; right: 5px; font-weight: normal;">${edit_link}</span>]],
	_name_custom_row_template = [[! colspan="${colspan}" style="text-align: center; padding:5px 5px 5px 5px;" class="${classes}" | <div style="position: relative; padding: 0px 40px 0px 0px;">${icon}${name}: ${resources}<span style="position: absolute; right: 5px; font-weight: normal;">${edit_link}</span></div>]],
	_custom_row_class = "custom-row multi-toggle-target-improvementtablekai-day",
	_edit_link_text = "Edit",
	_equipment_data_documentation = "Template:EquipmentDataDocumentation/EditIntro",
	_basic_resources_label = "Improvement Cost: ",
	_consumed_equipment_label = "<small>Consumes: ${list}</small>",
	_produced_equipment_label = "<b><small>Produces: 1x ${icon}${name}${stars}</small></b>",
	_produced_equipment_stars_template = "★+${stars}",
	_extended_initial_template = "${initial}<small>${extension}</small>",
	_equipment_item = "${count}x ${icon}${name}",
	_material_cell_content = "${normal}/${slider}",
	_unavailable_color = "#f99",
	_available_color = "#aaebaa",
	_small_icon_size = "24x24px",
	_combined_names_template = "${text}<small> (${combined_text})</small>",
	_required_ship_category_template = "Category:Equipment that can be improved with ${ship_name} as helper ship",
	_consumed_equip_category_template = "Category:Equipment that consume ${equip_name} during improvement",
	_single_screw_improvement_category = "Category:Equipment that can be improved using only one improvement material",
	_detail_toggle = [[<div class="hidden multi-toggle" data-target="improvementtablekai-day" data-states='["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]' data-base-colspan="${colspan}" data-filter="true" style="display: none;">]]
		.. '<span class="multi-toggle-button" data-state="none"><span class="multi-toggle-active">Filter by day:</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Show all</span></span>'
		.. ' <span class="multi-toggle-button" data-state="Sunday"><span class="multi-toggle-active" style="cursor: pointer; color: #006cb0; text-decoration: underline;">Sunday</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Sunday</span></span>'
		.. ' <span class="multi-toggle-button" data-state="Monday"><span class="multi-toggle-active" style="cursor: pointer; color: #006cb0; text-decoration: underline;">Monday</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Monday</span></span>'
		.. ' <span class="multi-toggle-button" data-state="Tuesday"><span class="multi-toggle-active" style="cursor: pointer; color: #006cb0; text-decoration: underline;">Tuesday</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Tuesday</span></span>'
		.. ' <span class="multi-toggle-button" data-state="Wednesday"><span class="multi-toggle-active" style="cursor: pointer; color: #006cb0; text-decoration: underline;">Wednesday</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Wednesday</span></span>'
		.. ' <span class="multi-toggle-button" data-state="Thursday"><span class="multi-toggle-active" style="cursor: pointer; color: #006cb0; text-decoration: underline;">Thursday</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Thursday</span></span>'
		.. ' <span class="multi-toggle-button" data-state="Friday"><span class="multi-toggle-active" style="cursor: pointer; color: #006cb0; text-decoration: underline;">Friday</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Friday</span></span>'
		.. ' <span class="multi-toggle-button" data-state="Saturday"><span class="multi-toggle-active" style="cursor: pointer; color: #006cb0; text-decoration: underline;">Saturday</span><span class="multi-toggle-inactive" style="cursor: pointer; color: #006cb0;">Saturday</span></span>'
		.. '</div>',
	_day_of_week_class_prefix = "multi-toggle-target-improvementtablekai-day-",
}

ImprovementTableKai._column_cell_templates["!"] = ImprovementTableKai._column_cell_templates["!"] .. ImprovementTableKai._detail_toggle

function ImprovementTableKai:create_items_post()
	self._custom_rows = {}
	local result = {}
	if #self._items == 1 then
		self._single_item = true
	end
	for item_index, item in ipairs(self._items) do
		if type(item) ~= "string" then
			local products = item:improvement_products()
			local edit_link = Formatting:format_edit_link(Equipment:get_module(self._args[item_index]), self._edit_link_text, self._equipment_data_documentation)
			if self._single_item then
				self._title_row = format{self._caption_template, 
					icon = Formatting:format_image{Formatting:format_equipment_icon(item:icon())}, 
					name = Formatting:format_link(item:link()), 
					edit_link = edit_link,
				}
			else
				self._custom_rows[item:name()] = {content = format{self._name_custom_row_template, 
				    colspan = #self._columns,
				    classes = self._custom_row_class,
					icon = Formatting:format_image{Formatting:format_equipment_icon(item:icon())}, 
					name = Formatting:format_link(item:link()), 
					resources = Formatting:format_resources(item:improvement_resources() or {devmat = false, conmat = false, screw = false}), 
					edit_link = edit_link,
				}, row = {classes = {}}} --The classes table will be mutated by this item's various rows as a set of css classes for the multi toggle.
				table.insert(result, item:name())
			end
			if products then
				for _, product in ipairs(products) do
					local ships = item:improvement_ships(product)
					local availability = {}
					local ship_data = {}
					for _, ship in ipairs(ships) do
						availability[ship] = item:improvement_availability(product, ship)
						if type(ship) == "string" then
							ship_data[ship] = Ship(ship)
    						if self._single_item and self._args.categories then
    						    self._ships = self._ships or {}
    						    self._ships[ship] = ship_data[ship]
    						end
						end
					end
					local combined_ships = {}
					local indexes_to_delete = {}
					local ship_names = {}
					for index, ship in ipairs(ships) do
						if ship ~= true and ship ~= false then
							local remodel_from = ship_data[ship]:remodel_from()
							if ship_data[remodel_from] then
								local identical = true
								for day, possible in pairs(availability[ship]) do
									if availability[remodel_from][day] ~= possible then
										identical = false
									end
								end
								if identical then
									table.insert(indexes_to_delete, index)
									-- The text to add when combining with a less remodelled form.
									local combined_name
									if ship_data[remodel_from]:base_name() == ship_data[ship]:base_name() then
										-- The ship has the same base name as the preceding form,
										-- so we only need to add the suffix.
										combined_name = ship_data[ship]:display_suffix()
									else
										-- The ship has a different base name as the preceding form,
										-- so we need to add the full name.
										combined_name = ship_data[ship]:name()
									end
									-- Find the most basic form
									while combined_ships[remodel_from] do
										remodel_from = combined_ships[remodel_from]
									end
									-- Leave a marker that we combined this form with another form
									combined_ships[ship] = remodel_from
									-- Prevent nil errors
									if not ship_names[remodel_from] then
										ship_names[remodel_from] = {}
									end
									-- Add the combine text to a table so it can be displayed with the most basic form later
									table.insert(ship_names[remodel_from], combined_name)
									if ship_names[ship] then
										-- If this form has had other forms combined with it, add those forms' text too
										-- This order of operations should keep the combined text readable.
										for _, suffix in ipairs(ship_names[ship]) do
											table.insert(ship_names[remodel_from], suffix)
										end
										ship_names[ship] = nil
									end
								end
							end
						end
					end
					table.sort(indexes_to_delete, function(a,b) return a > b end)
					for _, index in ipairs(indexes_to_delete) do
						table.remove(ships, index)
					end

					local group = {}
					for index, ship in ipairs(ships) do
						if ship ~= true and ship ~= false then
							table.insert(group, index)
						end
					end
					local initials = self:create_initials(ships, ship_data, group)

					for _, stars in ipairs(item:improvement_brackets(product)) do
						table.insert(result, {item = item, classes = self._single_item and {} or self._custom_rows[item:name()].row.classes, product = product, stars = stars, ships = ships, ship_data = ship_data, ship_names = ship_names, initials = initials, availability = availability, resources = item:improvement_resources(false, product, stars), resources_x = item:improvement_resources(true, product, stars)})
					end
				end
			else
				table.insert(result, {item = item, classes = self._single_item and {} or self._custom_rows[item:name()].row.classes})
			end
		else
			table.insert(result, item)
		end
	end
	self._items = result
end

function ImprovementTableKai:create_initials(ships, ship_data, group, initials, place, force_significance)
	place = place or 1
	initials = initials or {}
	local subgroup_index = 1
	local forced_groups = {}
	local new_initials = {}
	local subgroups = {}
	local previous_initial = nil
	local max_place = 0
	local significant = force_significance or place == 1
	for _, ship_index in ipairs(group) do
		local name = ship_data[ships[ship_index]]:name()
		max_place = math.max(max_place, #name)
		local initial = false
		if #name >= place then
			initial = mw.ustring.sub(name, place, place)
		end
		new_initials[ship_index] = initial
		if previous_initial == nil then
			previous_initial = initial
		elseif initial ~= previous_initial then
			previous_initial = initial
			significant = true
			subgroup_index = subgroup_index + 1
		end
		if initial == " " then
			forced_groups[subgroup_index] = true
		end
		if not subgroups[subgroup_index] then
			subgroups[subgroup_index] = {}
		end
		table.insert(subgroups[subgroup_index], ship_index)
	end
	if significant then
		for _, ship_index in pairs(group) do
			if not initials[ship_index] then
				initials[ship_index] = new_initials[ship_index]
			elseif new_initials[ship_index] then
				initials[ship_index] = initials[ship_index] .. new_initials[ship_index]
			end
		end
	end
	if place < max_place then
		for subgroup_index, subgroup in ipairs(subgroups) do
			if forced_groups[subgroup_index] then
				initials = self:create_initials(ships, ship_data, subgroup, initials, place + 1, true)				
			elseif #subgroup > 1 then
				initials = self:create_initials(ships, ship_data, subgroup, initials, place + 1)
			end
		end
	end
	return initials
end

function ImprovementTableKai:input_output(row_data)
	local value = "-"
	if row_data.resources then
		local result = {}
		local consumed_equipment_table = row_data.resources.equipment or {}
		if row_data.resources.equipment == nil then
			consumed_equipment_table[false] = false
		end
		local consumed_equipment = {}
		for equip, count in pairs(consumed_equipment_table) do
			local equipment
			if equip ~= true then
				if equip == false then
					equipment = Equipment()
				else
					equipment = Equipment(equip)
				end
			else
				equipment = row_data.item
			end
			if self._single_item and self._args.categories and equip ~= false then
			    self._consumed_equipment = self._consumed_equipment or {}
			    self._consumed_equipment[equip == true and equipment:name() or equip] = equipment
			end
			table.insert(consumed_equipment, format{self._equipment_item, count = count or Formatting:format_stat(nil), icon = Formatting:format_image{Formatting:format_equipment_icon_simple(equipment:icon()), size = self._small_icon_size}, name = equip == true and Formatting:format_stat(equipment:name()) or Formatting:format_link(equipment:link())})
		end
		if #consumed_equipment > 0 then
			table.insert(result, format{self._consumed_equipment_label, list = table.concat(consumed_equipment, "<br />")})
		end
		if row_data.stars == self._improvement_brackets[#self._improvement_brackets] and row_data.product then
		    local productName = string.gsub(row_data.product, '*', '')
			local product = Equipment(productName)
			local stars = row_data.item:improvement_product_initial_level(productName)
			table.insert(result, format{self._produced_equipment_label, 
					icon = Formatting:format_image{Formatting:format_equipment_icon_simple(product:icon()), size = self._small_icon_size}, 
					name = Formatting:format_link(product:link()),
					stars = stars and format{self._produced_equipment_stars_template, stars = stars} or ""
				})
		end
		if #result > 0 then
			value = table.concat(result, "<br />")
		end
	end
	return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
end

function ImprovementTableKai:improvement_level(row_data)
	return {values = {value = row_data.stars or "-"}, bg_color = self._transparent, text_align = self._center_align}
end

function ImprovementTableKai:development_material(row_data)
	if row_data.resources then
		return {values = {value = format{self._material_cell_content, normal = Formatting:format_stat(row_data.resources.devmat), slider = Formatting:format_stat(row_data.resources_x.devmat)}}, bg_color = self._transparent, text_align = self._center_align}
	else
		return {values = {value = "-"}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ImprovementTableKai:improvement_material(row_data)
	if row_data.resources then
	    if self._single_item and self._args.categories and row_data.resources.screw == 1 then
	        self._single_screw_improvement = true
	    end
		return {values = {value = format{self._material_cell_content, normal = Formatting:format_stat(row_data.resources.screw), slider = Formatting:format_stat(row_data.resources_x.screw)}}, bg_color = self._transparent, text_align = self._center_align}
	else
		return {values = {value = "-"}, bg_color = self._transparent, text_align = self._center_align}
	end
end

function ImprovementTableKai:sunday(row_data)
	return self:availability(row_data, "Sunday")
end

function ImprovementTableKai:monday(row_data)
	return self:availability(row_data, "Monday")
end

function ImprovementTableKai:tuesday(row_data)
	return self:availability(row_data, "Tuesday")
end

function ImprovementTableKai:wednesday(row_data)
	return self:availability(row_data, "Wednesday")
end

function ImprovementTableKai:thursday(row_data)
	return self:availability(row_data, "Thursday")
end

function ImprovementTableKai:friday(row_data)
	return self:availability(row_data, "Friday")
end

function ImprovementTableKai:saturday(row_data)
	return self:availability(row_data, "Saturday")
end

function ImprovementTableKai:availability(row_data, day)
	local availability = {}
	local available = false
	local bg_color = self._transparent
	if row_data.ships then
		for index, ship in ipairs(row_data.ships) do
			local local_availability = row_data.availability[ship][day]
			if local_availability ~= false then
				available = true
				local ship_initial
				if local_availability == nil then
					ship_initial = "?"
				else
					if ship == true then
						ship_initial = "✓"
					elseif ship == false then
						ship_initial = "_"
					else
						ship_initial = row_data.initials[index]
						if #ship_initial > 1 then
							ship_initial = format{self._extended_initial_template, initial = mw.ustring.sub(ship_initial, 1, 1), extension = mw.ustring.sub(ship_initial, 2)}
						end
					end
					bg_color = self._available_color
				end
				table.insert(availability, ship_initial)
			else
				table.insert(availability, "&nbsp;")
			end
		end
	end
	local day_of_week_class = self._day_of_week_class_prefix .. day
	if not available then
		bg_color = self._unavailable_color
	elseif not self._single_item then
		row_data.classes[day_of_week_class] = true
	end
	--values.ships is not displayed in the table (cell template string doesn't ask for ships).
	--It is included in order to keep availability cells from merging when helper ships cells were split.
	--This was only observed to occur when no ship had availability for a certain day across multiple improvement paths.
	return {values = {value = available and table.concat(availability, "<br />") or "✗", ships = row_data.ships}, classes = day_of_week_class, bg_color = bg_color, text_align = self._center_align}
end

function ImprovementTableKai:helper_ships(row_data)
	local ships = {}
	if row_data.ships then
		for index, ship in ipairs(row_data.ships) do
			if ship == false then
				table.insert(ships, "??")
			elseif ship ~= true then
				link, text, section = row_data.ship_data[ship]:link()
				if row_data.ship_names[ship] then
					text = format{self._combined_names_template, text = text or link, combined_text = table.concat(row_data.ship_names[ship], "/")}
				end
				table.insert(ships, Formatting:format_link(link, text, section))
			else
				table.insert(ships, "Any")
			end
		end
	end
	return {values = {value = table.concat(ships, "<br />")}, bg_color = self._transparent, text_align = self._center_align}
end

function ImprovementTableKai:row(row_data)
	--This gets rendered in start_rows()
	return {classes = row_data.classes}
end

function ImprovementTableKai:start_rows()
	--Render class string for normal rows
	for index, row_values in ipairs(self._data_rows) do
		if type(row_values) == "table" then
			if row_values._row and row_values._row.classes then
				--create list from set
				local classes = {}
				for key, _ in pairs(row_values._row.classes) do
					table.insert(classes, key)
				end
				--create class string
				row_values._row.classes = table.concat(classes, " ")
			end
		end
	end
	--Render class string for custom rows
	for key, value in pairs(self._custom_rows) do
		--create list from set
		local classes = {}
		for key, _ in pairs(value.row.classes) do
			table.insert(classes, key)
		end
		--create class string
		value.row.classes = table.concat(classes, " ")
	end
	if self._single_item then
		self._rows = {self._table_start, self._title_row, self._header}
	elseif #self._data_rows > 0 and type(self._data_rows[1]) ~= "table" then
		self._rows = {self._table_start}
	else
		self._rows = {self._table_start, self._header}
	end
end

function ImprovementTableKai:create_table_prep()
	self._header_icons = {
		devmat = ResourceIcons.devmat,
		screw = ResourceIcons.screw,
	}
	for key, value in pairs(self._header_icons) do
		self._header_icons[key] = Formatting:format_image{value, caption = Formatting:format_resource_name(key)}
	end
end

function ImprovementTableKai:create_header()
	if self._single_item then
		self._header_icons.resources = self._basic_resources_label .. Formatting:format_resources(self._items[1].item:improvement_resources() or {devmat = false, conmat = false, screw = false})
	else
		self._header_icons.resources = ""
	end
	self._header = format(self._header_template, self._header_icons)
end

function ImprovementTableKai:finish_rows()
	if not self._single_item then
		table.insert(self._rows, self._row_starter)
		table.insert(self._rows, self._header_bottom or self._header)
	end
	table.insert(self._rows, self._table_end)
end

function ImprovementTableKai:post_process()
    if self._single_item and self._args.categories then
        local categories = {}
        local ships_index = {}
        for ship, ship_data in pairs(self._ships or {}) do
            table.insert(ships_index, ship)
        end
        table.sort(ships_index)
        for _, ship in ipairs(ships_index) do
            table.insert(categories, Formatting:format_link(format{self._required_ship_category_template, ship_name = self._ships[ship]:name()}))
        end
        local equip_index = {}
        for equip, equip_data in pairs(self._consumed_equipment or {}) do
            table.insert(equip_index, equip)
        end
        table.sort(equip_index)
        for _, equip in ipairs(equip_index) do
            table.insert(categories, Formatting:format_link(format{self._consumed_equip_category_template, equip_name = self._consumed_equipment[equip]:common_name()}))
        end
        if self._single_screw_improvement then
            table.insert(categories, Formatting:format_link(self._single_screw_improvement_category))
        end
        self._result = self._result .. table.concat(categories)
    end
end

ImprovementTableKai.create_data_rows = ImprovementTableKai.create_data_rows_merge_vertical

return ImprovementTableKai