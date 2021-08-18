local U = require("Module:Core")
local format = U.format
local DataAsset = require("Module:Data/Asset")
local Effects = require('Module:Effects')
local EquipmentTypes = require("Module:EquipmentTypes")
local EquipmentTypesPlural = require("Module:EquipmentTypesPlural")
local ShipTypes = require("Module:ShipTypes")
local ShipCodes = require("Module:ShipCodes")
local SpeedNames = require("Module:SpeedNames")
local RangeNames = require("Module:RangeNames")
local RarityNames = require("Module:RarityNames")
local EquipmentRarityNames = require("Module:EquipmentRarityNames")

local Formatting = {
	_image_template = "[[File:${image}]]",
	_nsfw_image_template = [=[<span class="toggle-target-nsfw">[[File:${image}]]</span>]=],
	_nsfw_damaged_image_template = [=[<span class="toggle-target-nsfw-damaged" >[[File:${image}]]</span>]=],
	_no_image = "Catbomb.png",
	_no_image_size = "300px",
	_resource_template = "${label} ${value}",
	_stat_with_detail_template = "${stat}<br />(${detail})",
	_stat_with_max_template = "${stat} (${max})",
	_remodel_level_template = "'''Level ${level}'''",
	_remodel_items_template = " (${items})",
	_simple_link = "[[${link}${section}]]",
	_aliased_link = "[[${link}${section}|${text}]]",
	_edit_link = '[[${link} ${text}]]',
	_no_edit_link = '[${text}]',
	_external_link = '[${link} ${text}]',
	_external_numbered_link = '[${link}]',
	_edit_action = "edit",
	_stat_effect = "${label}${value:+}",
	_luck_stat_effect = "${label}${value:+.1}",
	_hidden_stat_effect = "${label}: ${value:+}",
	_lang_ja_attribute = {lang = "ja"},
	_tooltip_style = {cursor = "help", ["border-bottom"] = "1px dotted"}, --["text-decoration"] = "underline dotted"
	_display_inline_block_css = {display = "inline-block"},
	_vertical_align_middle_css = {["vertical-align"] = "middle"},
	_div_tag = 'div',
	_span_tag = 'span',
	_id_attribute = 'id',
	_title_attribute = 'title',
	_extra_style_background_image_template = " background-image: ${bloom}${sparkles}",
	_default_bloom = "bloom",
	_strike_template = "<strike>${text}</strike>",
	_clear = [[<div style="clear:both;margin:0;padding:0;"></div>]],
	_star = "☆",
	_double_star = "☆<br />☆",
	_triple_star = "☆<br />☆<br />☆",
	_quad_star = "☆<br />☆<br />☆<br />☆",
	_no_star = "-",
	_excluding_exception_template = "${ship_type} (excluding ${exception})",
	_all = "All",
	_all_except = "All except ",
	_ship_image_template = "${type} ${image_type} ${ship_name}${suffix}.${extension}",
	_ship_image_simple_template = "Ship ${image_type} ${ship_name}${suffix}.${extension}",
	_equipment_image_template = "Equipment ${image_type} ${equipment_name}.png",
	_equipment_image_template_simple = "${equipment_name} ${image_type}.png",
	_item_image_template = "Item ${type} ${name}.png",
	_card_suffix = "Card",
	_icon_suffix = "Icon",
	_card_damaged_suffix = "Card Damaged",
	_banner_suffix = "Banner",
	_banner_damaged_suffix = "Banner Damaged",
	_battle_card_suffix = "Banner",
	_battle_card_damaged_suffix = "Banner Damaged",
	_cg_suffix = "Full",
	_cg_damaged_suffix = "Full Damaged",
	_fairy_suffix = "Character",
	_equipment_suffix = "Item",
	_default_extension = {
		["Card"] = "png",
		["Card Damaged"] = "png",
		["Banner"] = "png",
		["Banner Damaged"] = "png",
		["Full"] = "png",
		["Full Damaged"] = "png",
	},
	_stats = {
		"firepower",
		"bombing",
		"torpedo",
		"aa",
		"armor",
		"asw",
		"shelling_accuracy",
		"evasion",
		"los",
		"speed",
		"luck",
		"range",
	},
	_interceptor_stats = {
		"firepower",
		"bombing",
		"torpedo",
		"aa",
		"armor",
		"asw",
		"anti_bomber",
		"interception",
		"los",
		"speed",
		"luck",
		"range",
	},
	_hidden_stats = {
		"torpedo_accuracy",
	},
	_modernization_stats = {
		"firepower",
		"torpedo",
		"aa",
		"armor",
		"luck",
	},
	_resources = {
		"fuel",
		"ammo",
		"steel",
		"bauxite",
		"devmat",
		"conmat",
		"screw",
	},
}

function Formatting:seconds_to_hms(seconds)
	return format{"${hours:2}:${minutes:2}:${seconds:2}", 
		hours = math.floor(seconds / 3600),
		minutes = math.floor(seconds / 60) % 60,
		seconds = seconds % 60
	}
end

function Formatting:format_image(args)
	local image_options = {}
    local cat = false
	if not args[1] then
		table.insert(image_options, self._no_image)
		cat = true
	else
		table.insert(image_options, args[1])
	end

	if args.format then
		table.insert(image_options, args.format)
	end

	if args.align then
		table.insert(image_options, args.align)
	end

	if args.valign then
		table.insert(image_options, args.valign)
	end

	if args.size then
		table.insert(image_options, args.size)
	elseif not args[1] then
		table.insert(image_options, self._no_image_size)
	end

	if args.link ~= nil then
		table.insert(image_options, "link=" .. (args.link ~= false and args.link or ""))
	end

	if args.caption then
		table.insert(image_options, args.caption)
	end

	return format{
	    args.nsfw and self._nsfw_image_template or args.damaged and self._nsfw_damaged_image_template or self._image_template,
	    image = table.concat(image_options, "|")
	} .. (cat and U.category("Catbomb") or "")
end

function Formatting:inline_block(content, classes, style)
	local result = mw.html.create(self._div_tag):css(style or {}):css(self._display_inline_block_css):wikitext(content)
	if classes then
		if type(classes) == "string" then
			result:addClass(classes)
		else
			for _, class in ipairs(classes or {}) do
				result:addClass(class)
			end
		end
	end
	return tostring(result)
end

function Formatting:ship_card(api_id, ship_name, ship_type, extension_override, simple_naming, hd)
    return self:ship_image_simple(self._card_suffix, ship_name, extension_override, '')
end

function Formatting:ship_card_damaged(api_id, ship_name, ship_type, extension_override, simple_naming, hd)
	return self:ship_image(self._card_suffix, api_id, ship_name, ship_type, extension_override, ' Damaged')
end

function Formatting:ship_battle_card(api_id, ship_name, ship_type, extension_override, simple_naming, hd)
	return self:ship_image(self._battle_card_suffix, api_id, ship_name, ship_type, extension_override, '')
end

function Formatting:ship_battle_card_damaged(api_id, ship_name, ship_type, extension_override, simple_naming, hd)
    return self:ship_image(self._battle_card_suffix, api_id, ship_name, ship_type, extension_override, ' Damaged')
end

function Formatting:ship_cg(api_id, ship_name, ship_type, extension_override, simple_naming, hd)
    return self:ship_image(self._cg_suffix, api_id, ship_name, ship_type, extension_override, '')
end

function Formatting:ship_cg_damaged(api_id, ship_name, ship_type, extension_override, simple_naming, hd)
    return self:ship_image(self._cg_suffix, api_id, ship_name, ship_type, extension_override, ' Damaged')
end

function Formatting:ship_image(image_type, api_id, ship_name, ship_type, extension_override, suffix)
	return format{
	    self._ship_image_template,
	    type = api_id and api_id >= 1501 and 'Enemy' or 'Ship',
	    image_type = image_type,
	    api_id = api_id,
	    ship_name = ship_name,
	    suffix = suffix,
	    extension = extension_override or self._default_extension[image_type] or 'png',
	}
end

function Formatting:ship_image_simple(image_type, ship_name, extension_override, suffix)
	return format{
	    self._ship_image_simple_template,
	    image_type = image_type,
	    ship_name = ship_name,
	    suffix = suffix or '',
	    extension = extension_override or self._default_extension[image_type] or 'png',
	}
end

function Formatting:equipment_card(api_id, equipment_name)
	return self:equipment_image(self._card_suffix, api_id, equipment_name)
end

function Formatting:equipment_fairy(api_id, equipment_name)
	return self:equipment_image(self._fairy_suffix, api_id, equipment_name)
end

function Formatting:equipment_cg(api_id, equipment_name)
	return self:equipment_image(self._equipment_suffix, api_id, equipment_name)
end

function Formatting:equipment_full(api_id, equipment_name)
	return self:equipment_image(self._cg_suffix, api_id, equipment_name)
end

function Formatting:equipment_image(image_type, api_id, equipment_name)
	return format{self._equipment_image_template, image_type = image_type, api_id = api_id, equipment_name = equipment_name}
end

function Formatting:item_card(name)
	return self:item_image(self._card_suffix, name)
end

function Formatting:item_icon(name)
	return self:item_image(self._icon_suffix, name)
end

function Formatting:item_image(type, name)
    return format{self._item_image_template, type = type, name = name}
end

function Formatting:create_formatter(lookup, nil_value, false_value)
	return function(self, stat)
		if stat == nil then
			return nil_value or "??"
		end
		if false_value and stat == false then
		    return false_value
        end
		local result = lookup[stat]
		if result == nil then
			return stat
		else
			return result
		end
	end
end

function Formatting:format_resources(resources)
	local strings = {}
	for _, resource_type in ipairs(self._resources) do
		if resources[resource_type] ~= false then
			table.insert(strings, format{
			    self._resource_template,
			    label = self:format_image{DataAsset[resource_type],
                caption = Formatting:format_resource_name(resource_type)},
                value = self:format_stat(resources[resource_type])
            })
		end
	end
	return table.concat(strings, " ")
end

function Formatting:format_slot_size(size, estimation)
	if estimation then
		return self:_format_slot_size(size) .. "?"
	end
	return self:_format_slot_size(size)
end

function Formatting:format_air_power(ap, estimation)
	if estimation then
		return self:format_stat(ap) .. "?"
	end
	return self:format_stat(ap)
end

function Formatting:format_remodel_level_and_item_cost(remodel_level, blueprint, catapult, report, gunmat, airmat, armament)
	local item_requirements = self:format_remodel_items(blueprint, catapult, report, gunmat, airmat, armament)
	if remodel_level == nil then
		remodel_level = "??"
	end
	local result = format{self._remodel_level_template, level = remodel_level}
	if item_requirements then
		result = result .. format{self._remodel_items_template, items = item_requirements}
	end
	return result
end

function Formatting:format_remodel_item(item, value)
    local title = Formatting:format_resource_name(item)
    return self:format_image{DataAsset[item], caption = title, link = title, size = "24px"}
        .. (value == nil and "?" or type(value) == "number" and "×" .. value or "")
end

function Formatting:format_remodel_items(blueprint, catapult, report, gunmat, airmat, armament)
	local items = {}
	-- explicit items
	if blueprint ~= false then
	    table.insert(items, self:format_remodel_item("blueprint_item", blueprint))
	end
	if catapult ~= false then
	    table.insert(items, self:format_remodel_item("prototype_deck_catapult_item", catapult))
	end
	-- imlicit items
	if report then
	    table.insert(items, self:format_remodel_item("report_item", report))
	end
	if gunmat then
	    table.insert(items, self:format_remodel_item("new_model_gun_mount_improvement_material_item", gunmat))
	end
	if airmat then
	    table.insert(items, self:format_remodel_item("new_model_aerial_armament_material_item", airmat))
	end
	if armament then
	    table.insert(items, self:format_remodel_item("new_model_armament_material_item", armament))
	end
	return #items > 0 and table.concat(items, " ") or nil
end

function Formatting:format_blueprint_requirement(blueprint, force)
	if force or (blueprint ~= false) then
		local value
		if blueprint == false then
			value = "✗"
		elseif blueprint == true then
			value = self:format_image{DataAsset.blueprint_item, size = "24px", caption = Formatting:format_resource_name("blueprint")}
		else
			value = "??"
		end
		return value
	end
	return ""
end

Formatting.format_blueprint_requirement_simple = Formatting.format_blueprint_requirement

function Formatting:format_catapult_requirement(catapult, force)
	if force or (catapult ~= false) then
		local value
		if catapult == false then
			value = "✗"
		elseif catapult == true then
			value = self:format_image{DataAsset.prototype_deck_catapult_item, size = "24px", caption = Formatting:format_resource_name("prototype_deck_catapult_item")}
		else
			value = "??"
		end
		return value
	end
	return ""
end

function Formatting:format_equipment_icon(icon)
	return icon or DataAsset.empty_equipment_icon
end

function Formatting:format_stat_with_detail(stat, detail)
	return format{self._stat_with_detail_template, stat = stat, detail = detail}
end

function Formatting:format_detailed_aircraft(total, slots)
	if not slots or #slots == 0 then
		return self:format_stat(total)
	else
		slot_summary = table.concat(slots, ",")
		return format{self._stat_with_detail_template, stat = total, detail = slot_summary}
	end
end

function Formatting:strike(text)
	return format{self._strike_template, text = text}
end

function Formatting:clear()
	return self._clear
end

function Formatting:tooltip(content, title, cursor, extra_style, raw)
	if not cursor then
		cursor = self._tooltip_style
	end
	result = mw.html.create(self._span_tag):attr(self._title_attribute, title):css(cursor):css(extra_style or {}):wikitext(content)
	if raw then
		return result
	else
		return tostring(result)
	end
end

function Formatting:escape_html_element(text)
    return text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
end

function Formatting:escape_html_attribute(text)
    return Formatting:escape_html_element(text):gsub('"', "&quot;"):gsub("'", "&#39;")
end

function Formatting:tooltip2(text, title, line_break, nbsp)
    text = Formatting:escape_html_element(text)
    title = Formatting:escape_html_attribute(title)
    if line_break then
        title = title:gsub(line_break, "&#10;")
    end
    if nbsp then
        title = title:gsub(nbsp, "&#160;")
    end
    return format{
        [[<span class="explain" title="${title}">${text}</span>]],
        text = text,
        title = title,
    }
end

function Formatting:japanese_text(japanese, reading, cursor, extra_style, raw)
	if reading then
		result = self:tooltip(japanese, reading, cursor, extra_style, true)
	else
		result = mw.html.create(self._span_tag):wikitext(japanese)
	end
	result = result:attr(self._lang_ja_attribute)
	if raw then
		return result
	else
		return tostring(result)
	end
end

function Formatting:format_stat_bonuses(stat_table, separator, applicable_stats, applicable_hidden_stats)
	--normal stats
	local result = {}
	for _, stat in ipairs(applicable_stats or self._stats) do
		local value = stat_table[stat]
		if value ~= false then
			table.insert(result, format{self._stat_effect, label = self:format_image{DataAsset[stat], caption = self:format_stat_name(stat)}, value = self:format_stat(value)})
		end
	end
	result = table.concat(result, separator or " ")
	if stat_table.special ~= false then
		local special = self:format_stat(stat_table.special)
		if result:len() == 0 then
			result = special
		else
			result = result .. "<br />" .. special
		end
	end

	--hidden stats
	local extra_result = {}
	for _, stat in ipairs(applicable_hidden_stats or self._hidden_stats) do
		local value = stat_table[stat]
		if value ~= false then
			table.insert(extra_result, format{self._hidden_stat_effect, label = self:format_stat_name(stat), value = self:format_stat(value)})
		end
	end
	if #extra_result > 0 then
		result = self:tooltip(result, table.concat(extra_result, ", "))
	end

	return result
end

function Formatting:format_stat_bonuses_interceptor(stat_table, separator)
    stat_table.interception = stat_table.evasion
    stat_table.anti_bomber = stat_table.shelling_accuracy
    return self:format_stat_bonuses(stat_table, separator, self._interceptor_stats)
end

function Formatting:format_bonus(value, label, false_value, decimal)
	if value ~= false then
		return format{decimal and self._luck_stat_effect or self._stat_effect, label = label or "", value = self:format_stat(value)}
	else
		return false_value or ""
	end
end

function Formatting:format_modernization_bonuses(stat_table)
	local result = {}
	for _, stat in ipairs(self._modernization_stats) do
		local value = stat_table[stat]
		if value ~= false then
			table.insert(result, format{stat == "luck" and self._luck_stat_effect or self._stat_effect, label = self:format_image{DataAsset[stat], caption = self:format_stat_name(stat)}, value = self:format_stat(value)})
		end
	end

	return table.concat(result, " ")
end

function Formatting:format_stat_with_max(stat, max)
	if max == false then
		return self:format_stat(stat)
	else
		return format{self._stat_with_max_template, stat = self:format_stat(stat), max = self:format_stat(max)}
	end
end

function Formatting:format_link(link, text, section)
	if section then
		section = "#" .. section
	else
		section = ""
	end
	if link == false then
	    return text or ""
	end
	link = self:format_stat(link)
	if text then
		return format{self._aliased_link, link = link, text = text, section = section}
	else
		return format{self._simple_link, link = link, section = section}
	end
end

function Formatting:format_slot_stars(stars)
    return stars == 10 and "★max" or ("★+" .. stars)
end

function Formatting:format_external_link(link, text)
	if link == false then
	    return text or ""
	end
	link = self:format_stat(link)
	if text == false then
		return format{self._external_numbered_link, link = link}
	else
	    return format{self._external_link, link = link, text = text or link}
	end
end

function Formatting:fragment_link(id, prefix, text)
	if prefix then
		id = prefix .. "-" .. id
	end
	return Formatting:format_link("", text, id)
end

function Formatting:id_span(id, prefix, content, raw)
	if prefix then
		id = prefix .. "-" .. id
	end
	local result = mw.html.create(self._span_tag):attr(self._id_attribute, id):wikitext(content)
	if not raw then
		result = tostring(result)
	end
	return result
end

function Formatting:class_span(class, prefix, content, raw)
	if prefix then
		class = prefix .. "-" .. class
	end
	local result = mw.html.create(self._span_tag):addClass(class):wikitext(content)
	if not raw then
		result = tostring(result)
	end
	return result
end

function Formatting:class_div(class, prefix, content, raw)
	if prefix then
		class = prefix .. "-" .. class
	end
	local result = mw.html.create(self._div_tag):addClass(class):wikitext(content)
	if not raw then
		result = tostring(result)
	end
	return result
end

function Formatting:error_span(content)
	return self:class_span("error", nil, content)
end

function Formatting:format_edit_link(page, text, editintro, tooltip)
    text = text or 'Edit'
	if page then
		local args = {action = self._edit_action}
		-- if editintro then
		-- args.editintro = editintro
		-- end
		if tooltip then
			text = self:tooltip(text, tooltip)
		end
		return format{self._edit_link, text = text, link = tostring(mw.uri.fullUrl(page, args))}
	else
		return format{self._no_edit_link, text = self:strike(text)}
	end
end

function Formatting:extra_style_background_image(bloom, sparkles, overlay)
	if bloom or sparkles then
		return format{
		    self._extra_style_background_image_template,
		    bloom = (overlay or bloom) and Effects[overlay or self._default_bloom] or "",
		    sparkles = sparkles and Effects.sparkles or ""
		}
	end
end

function Formatting:format_equipment_compatibility_table(compatibility_table)
	for index, value in pairs(compatibility_table) do
		if type(value) ~= "table" then
			compatibility_table[index] = self:format_equipment_compatibility(value)
		else
			value.value = self:format_equipment_compatibility(value.value)
		end
	end
end

function Formatting:format_stars(stars)
	if not stars then
		return "??"
	end
	local result = {}
	if stars > 0 then
		while stars > 6 do
			table.insert(result, self:inline_block(self._quad_star, nil, self._vertical_align_middle_css))
			stars = stars - 4
		end
		while stars > 4 do
			table.insert(result, self:inline_block(self._triple_star, nil, self._vertical_align_middle_css))
			stars = stars - 3
		end
		if stars == 4 then
			table.insert(result, self:inline_block(self._quad_star, nil, self._vertical_align_middle_css))
		elseif stars == 3 then
			table.insert(result, self:inline_block(self._triple_star, nil, self._vertical_align_middle_css))
		elseif stars == 2 then
			table.insert(result, self:inline_block(self._double_star, nil, self._vertical_align_middle_css))
		elseif stars == 1 then
			table.insert(result, self:inline_block(self._star, nil, self._vertical_align_middle_css))
		end
	else
		table.insert(result, self:inline_block(self._no_star, nil, self._vertical_align_middle_css))
	end
	return table.concat(result, " ")
end

Formatting.format_boolean = Formatting:create_formatter({
	[true] = "Yes",
	[false] = "No",
})

Formatting.format_boolean_short = Formatting:create_formatter({
	[true] = "✔", -- HEAVY CHECK MARK
	[false] = "✘", -- HEAVY BALLOT X
})

Formatting.format_stat_name = Formatting:create_formatter({
	firepower = "Firepower",
	bombing = "Bombing",
	torpedo = "Torpedo",
	aa = "AA",
	armor = "Armor",
	asw = "ASW",
	shelling_accuracy = "Accuracy",
	evasion = "Evasion",
	los = "LOS",
	speed = "Speed",
	luck = "Luck",
	range = "Range",
	torpedo_accuracy = "Torpedo Accuracy (Unused)",
	hp = "HP",
	fuel = "Max Fuel Consumption",
	ammo = "Max Ammo Consumption",
	remodel = "Remodel Level",
	aircraft = "Aircraft",
	anti_bomber = "Anti-Bomber",
	interception = "Interception",
	combat_radius = "Combat Radius",
	deployment_cost = "Deployment Cost",
})

Formatting.format_resource_name = Formatting:create_formatter({
	fuel = "Fuel",
	ammo = "Ammo",
	steel = "Steel",
	bauxite = "Bauxite",
	blueprint = "Blueprint",
	blueprint_item = "Blueprint",
	bucket = "Instant Repair",
	torch = "Instant Construction",
	devmat = "Development Material",
	conmat = "Instant Construction",
	screw = "Improvement Material",
	development_material = "Development Material",
	improvement_material = "Improvement Material",
	furniture_coin = "Furniture Coin",
	furniture_coin_box_small = "Furniture Box (Small)",
	furniture_coin_box_medium = "Furniture Box (Medium)",
	furniture_coin_box_large = "Furniture Box (Large)",
	mamiya = "Mamiya",
	irako = "Irako",
	medal = "Medal",
	first_class_medal = "First Class Medal",
	prototype_deck_catapult = "Prototype Flight Deck Catapult",
	prototype_deck_catapult_item = "Prototype Flight Deck Catapult",
	report_item = "Action Report",
	ne_type_engine = "Ne Type Engine",
	ne_type_engine_item = "Ne Type Engine",
	new_model_gun_mount_improvement_material = "New Model Gun Mount Improvement Material",
	new_model_gun_mount_improvement_material_item = "New Model Gun Mount Improvement Material",
	new_model_aerial_armament_material = "New Model Aerial Armament Material",
	new_model_aerial_armament_material_item = "New Model Aerial Armament Material",
	new_model_armament_material = "New Model Armament Material",
	new_model_armament_material_item = "New Model Armament Material",
})

Formatting.format_ship_back = Formatting:create_formatter({
	[0] = "whitesmoke",
	[1] = "#8eb0ed",
	[2] = "#afddfa",
	[3] = "#92d1cf",
	[4] = "silver",
	[5] = "#ffe140",
	[6] = "#eebbee",
	[7] = "#eebbee",
	[8] = "#eebbee",
	[-1] = "#aab3b2",
	[-2] = "#cc1414",
	[-3] = "#fcc800",
	[-4] = "#aab3b2",
	[-5] = "#cc1414",
	[-6] = "#8bcde0",
	[-7] = "#bdbdc9",
	[-8] = "#b56464",
	[-9] = "#fcc800",
	[-10] = "#bf1313",
	[-11] = "#bf1313",
	[-12] = "#e61616",
	}, "whitesmoke")

Formatting.format_equipment_back = Formatting:create_formatter({
	[-2] = "deepskyblue", --repair team
	[-1] = "lightskyblue", --a kohyoteki, daihatsu
	[0] = "whitesmoke",
	[1] = "lightgrey",
	[2] = "lightblue",
	[3] = "#eebbee",
	[4] = "#eebbee",
	[5] = "#eebbee",
	[6] = "#eebbee",
	[7] = "#ee88ee",
	}, "whitesmoke")

Formatting.format_equipment_compatibility = Formatting:create_formatter({
	[0] = "whitesmoke",
	[1] = "#73ff4d",
	[2] = "#ffff40",
	}, "transparent")

Formatting.format_stat = Formatting:create_formatter({
	[false] = "",
})

function Formatting:format_enemy_stat(id, isVita)
    if id == nil then
        return "??"
    elseif id == false then
        return ""
    elseif isVita then
        return id >= 1501 and id - 1000 or id
    else
        return id < 1501 and id + 1000 or id
    end
end

Formatting._format_slot_size = Formatting:create_formatter({
  [false] = "-",
})

Formatting.format_speed = Formatting:create_formatter(SpeedNames)
Formatting.format_range = Formatting:create_formatter(RangeNames)
Formatting.format_ship_rarity = Formatting:create_formatter(RarityNames)
Formatting.format_ship_type = Formatting:create_formatter(ShipTypes, nil, "-")
Formatting.format_ship_code = Formatting:create_formatter(ShipCodes)

function Formatting:format_ship_compatibility(compatibility_table)
	if compatibility_table[3] == compatibility_table[4] then
		compatibility_table[3] = {value = compatibility_table[3], code = "CL(T)"}
		compatibility_table[4] = false
	end
	if compatibility_table[5] == compatibility_table[6] then
		compatibility_table[5] = {value = compatibility_table[5], code = "CA(V)"}
		compatibility_table[6] = false
	end
	if compatibility_table[18] == compatibility_table[11] then
		compatibility_table[18] = false
	end
	if compatibility_table[7] == compatibility_table[11] then
		compatibility_table[7] = false
		compatibility_table[11] = {value = compatibility_table[11], code = "CV(L)"}
	end
	if compatibility_table[9] == compatibility_table[10] then
		compatibility_table[9] = {value = compatibility_table[9], code = "BB(V)"}
		compatibility_table[10] = false
	end
	if compatibility_table[13] == compatibility_table[14] then
		compatibility_table[13] = {value = compatibility_table[13], code = "SS(V)"}
		compatibility_table[14] = false
	end
	compatibility_table[12] = false
	compatibility_table[15] = false
	local compatible = {}
	local incompatible = {}
	for ship_type, compatibility_value in ipairs(compatibility_table) do
		local code = Formatting:format_ship_code(ship_type)
		if type(compatibility_value) == "table" then
			code = compatibility_value.code
			compatibility_value = compatibility_value.value
		end
		if compatibility_value == 0 then
			table.insert(incompatible, code)
		elseif compatibility_value == 1 then
			table.insert(compatible, code)
		elseif compatibility_value == 2 then
			table.insert(compatible, code)
			table.insert(incompatible, format{self._excluding_exception_template, ship_type = Formatting:format_ship_code(ship_type), exception = code})
		end
	end
	if #incompatible < 5 then
		if #incompatible == 0 then
			return self._all
		end
		return self._all_except .. table.concat(incompatible, ", ")
	else
		return table.concat(compatible, ", ")
	end
end

Formatting.format_equipment_type = Formatting:create_formatter(EquipmentTypes)
Formatting.format_equipment_type_plural = Formatting:create_formatter(EquipmentTypesPlural)
Formatting.format_equipment_icon_simple = Formatting:create_formatter(DataAsset.simple_equipment_icons, DataAsset.empty_equipment_icon)
Formatting.format_equipment_icon = Formatting:create_formatter(DataAsset.equipment_icons, DataAsset.empty_equipment_icon)
Formatting.format_equipment_rarity = Formatting:create_formatter(EquipmentRarityNames)

Formatting.format_fit_bonus = Formatting:create_formatter({
	[-1] = tostring(mw.html.create(Formatting._span_tag):css({["color"] = "crimson"}):wikitext("Overweight")),
	[0] = "Neutral",
	[1] = tostring(mw.html.create(Formatting._span_tag):css({["color"] = "green"}):wikitext("Fit")),
	[false] = "N/A",
	})

local equipment_types = {
    [3] = {
        [44] = {
            [25] = {
                [21] = "Helicopter",
            },
        },
    },
    [22] = {
        [39] = {
            [48] = {
                -- [38] = "Interceptor",
            }
        }
    }
}

function Formatting:format_equipment_types(equipment)
    local type_name = self:format_equipment_type(equipment:type())
    local types = equipment:types()
    if types then
        local extra_type_name = equipment_types
        local i = 1
        while i <= 5 do
            extra_type_name = extra_type_name[types[i]]
            i = i + 1
            if not extra_type_name or type(extra_type_name) == "string" then
                break
            end
        end
        if type(extra_type_name) == "string" then
            return string.format("%s (%s)", type_name, extra_type_name)
        end
    end
    return type_name
end

return Formatting