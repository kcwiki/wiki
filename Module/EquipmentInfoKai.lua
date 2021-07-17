local BaseData = require('Module:BaseData')
local Equipment = require('Module:Equipment')
local EquipmentCardKai = require('Module:EquipmentCardKai')
local EquipmentGraphicKai = require('Module:EquipmentGraphicKai')
local Formatting = require('Module:Formatting')
local Tabber = require('Module:Tabber')

local U = require('Module:Core')
local format = U.format

local EquipmentInfoKai = BaseData{
	_template = [[{|class="${table_class}" id="${table_id}" style="border: 1px solid darkgray; width: 380px; background-color: #fafafa;${float}"
|-
| colspan="2" id="kc-eq-namecard" style="position: relative; padding: 10px 40px; text-align: center; background-color: ${back};${extra_style};" title="${rarity}" | <div id="kc-eq-edit-link" style="position: absolute; right: 5px;">${edit_link}</div>
<div id="kc-eq-en-name" style="font-size: 20px; margin:0 0 4px 0;">'''${name}'''</div>
${localized_name}
<div id="kc-eq-jp-entry" style="margin:4px 0 0 0;">'''No.${id} ${japanese_name}'''</div>
|-
| colspan="2" id="kc-eq-statscard" style="text-align: center; background-color: whitesmoke;" |
<div id="kc-eq-category" style="margin:0 0 4px 0;">${icon} <b>${eq_type}</b>${eq_group}</div>
<div id="kc-eq-effects" style="margin:4px 0;"><b>Effects: ${effects}</b></div>
${flight_stats}
<div id="kc-eq-scrap" style="margin:4px 0 0 0;">'''Scrap value: ${scrap}''' (${buildable})</div>
${alternative_names}
|-
| colspan="2" id="kc-eq-pictures" style="text-align: center;" | ${card}
|-
| colspan="2" id="kc-eq-fits" style="text-align: center; background-color: LightSkyBlue;" | '''Refittable Class'''
${compatibility_details}${bonus_details}
|}]],
    _bonus_header = [=[|-
| colspan="2" id="kc-eq-bonus" style="text-align: center; background-color: LightSkyBlue;" | '''Bonus'''${category}]=],
    _bonus_row = [=[|-
| style="width: 190px; text-align: center;" | ${text}
| style="width: 190px; text-align: center;" | ${stats}]=],
--|-
--| colspan="2" style="text-align: center; padding: 0px;" | <div class="mw-collapsible mw-collapsed">
--<div style="background-color: lightskyblue; text-align: center; margin: 0px;">'''Improvement'''</div>
--<div class="mw-collapsible-content" style="margin-bottom: -2px;">
--${improvement}
--</div>
--</div>
--|}]],
	_row_starter = "|-",
	_compatibility_cell = [[| style="width: 190px; text-align: center; background-color: ${bg_color};" | ${label}]],
	_localized_name_template = [[<div id="kc-eq-local-name" style="margin:4px 0;">${localized_name}</div>]],
	_flight_stats_template = [[<div id="kc-eq-flights"><b>Combat Radius: ${combat_radius}</b> (Deployment Cost: ${deployment_cost})</div>]],
	_alternative_names_template = [[ 
|-
| colspan="2" id="kc-eq-altnames" style="text-align: center; padding: 0px;" | <div class="mw-collapsible mw-collapsed" style="background-color: lightgrey; margin: 0px;">''Alternate names''<div class="mw-collapsible-content" style="background-color: whitesmoke;">
${names}
</div></div>]],
--	_collapsed_content_header = [[<div style="text-align: center; background-color: lightgrey; margin:2px 0px 2px;">'''${content}'''</div>]],
--	_collapsed_content_row = [[<div style="text-align: center; background-color: whitesmoke; margin:2px 0px 2px;">${content}</div>]],
	_alternative_name_template = [[<div style="display: inline-block; vertical-align: middle;"><small>''${label}:''</small></div> <div style="display: inline-block; vertical-align: middle;"><small>''${name}<br />${japanese_name}''</small></div>]],
	_eq_group_template = " (${eq_group})",
	_fit_group_tooltip = "Fit group based on experimental findings",
	_concentrated_label = "Concentrated",
	_air_radar_label = "Air Radar",
	_high_angle_label = "High-angle",
	_plus_fire_director_label = " + Fire Director",
	_library_name_label = "Library name",
	_list_name_label = "List name",
	_comparison_name_label = "Comparison name",
	_battle_name_label = "Battle name",
	_equipment_data_documentation = "Template:EquipmentDataDocumentation/EditIntro",
	_edit_link_text = "Edit",
	_empty_card = "Empty equipment card slot.png",
	_buildable = "'''Buildable'''",
	_unbuildable = "''Unbuildable''",
	_float_style_template =  "float: ${float};",
	_shown_ship_types = {
		1, 2,
		3, 4,
		5, 21,
		6, 8,
		9, 10,
		7, 11,
		18, 16,
		13, 14,
		20, 22,
		19, 17
	},
	_fields = {
		"edit_link",
		"rarity",
		"back",
		"name",
		"localized_name",
		"flight_stats",
		"alternative_names",
		"id",
		"japanese_name",
		"icon",
		"eq_type",
		"effects",
		"scrap",
		"image",
		"crafting",
		"compatibility_details",
		"bonus_details",
	},
}

function EquipmentInfoKai:Infobox(args)
	return self{
		_args = args,
	}:create_infobox()
end

function EquipmentInfoKai:edit_link()
	self._vars.edit_link = Formatting:format_edit_link(self._equipment_data_module, self._edit_link_text, self._equipment_data_documentation)
end

function EquipmentInfoKai:rarity()
	self._vars.rarity = Formatting:format_equipment_rarity(self._equipment:rarity())
end

function EquipmentInfoKai:back()
	local back = self._equipment:back()
	self._vars.back, self._vars.extra_style = Formatting:format_equipment_back(back), Formatting:extra_style_background_image(false, back and back > 4)
end

function EquipmentInfoKai:name()
	self._vars.name = Formatting:format_link(self._equipment:link())
end

function EquipmentInfoKai:localized_name()
	local localized_name = self._equipment:localized_name()
	if localized_name then
		self._vars.localized_name = format{self._localized_name_template, localized_name = localized_name}
	else
		self._vars.localized_name = ""
	end
end

function EquipmentInfoKai:flight_stats()
	if self._equipment:is_lbas_plane() then
		self._vars.flight_stats = format{self._flight_stats_template, combat_radius = Formatting:format_stat(self._equipment:combat_radius()), deployment_cost = Formatting:format_resources(self._equipment:deployment_cost())}
	else
		self._vars.flight_stats = ""
	end
end

function EquipmentInfoKai:alternative_names()
	local alternative_names = {}
	local list_name = self._equipment:list_name()
	local library_name = self._equipment:library_name()
	local comparison_name = self._equipment:comparison_name()
	local battle_name = self._equipment:battle_name()
	if list_name then
		local list_japanese_name = self._equipment:list_japanese_name()
		local list_reading = self._equipment:list_reading()
		if list_reading ~= false then
			list_japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(list_japanese_name), Formatting:format_stat(list_reading)))
		end
		local list_localized_name = self._equipment:list_localized_name()
		if list_localized_name then
			list_name = Formatting:tooltip(Formatting:format_stat(list_name), Formatting:format_stat(list_localized_name))
		else
			list_name = Formatting:format_stat(list_name)
		end
		table.insert(alternative_names, format{self._alternative_name_template, label = self._list_name_label, name = list_name, japanese_name = list_japanese_name})
	end
	if library_name then
		local library_japanese_name = self._equipment:library_japanese_name()
		local library_reading = self._equipment:library_reading()
		if library_reading ~= false then
			library_japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(library_japanese_name), Formatting:format_stat(library_reading)))
		end
		local library_localized_name = self._equipment:library_localized_name()
		if library_localized_name then
			library_name = Formatting:tooltip(Formatting:format_stat(library_name), Formatting:format_stat(library_localized_name))
		else
			library_name = Formatting:format_stat(library_name)
		end
		table.insert(alternative_names, format{self._alternative_name_template, label = self._library_name_label, name = library_name, japanese_name = library_japanese_name})
	end
	if comparison_name then
		local comparison_japanese_name = self._equipment:comparison_japanese_name()
		local comparison_reading = self._equipment:comparison_reading()
		if comparison_reading ~= false then
			comparison_japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(comparison_japanese_name), Formatting:format_stat(comparison_reading)))
		end
		local comparison_localized_name = self._equipment:comparison_localized_name()
		if comparison_localized_name then
			comparison_name = Formatting:tooltip(Formatting:format_stat(comparison_name), Formatting:format_stat(comparison_localized_name))
		else
			comparison_name = Formatting:format_stat(comparison_name)
		end
		table.insert(alternative_names, format{self._alternative_name_template, label = self._comparison_name_label, name = comparison_name, japanese_name = comparison_japanese_name})
	end
	if battle_name then
		local battle_japanese_name = self._equipment:battle_japanese_name()
		local battle_reading = self._equipment:battle_reading()
		if battle_reading ~= false then
			battle_japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(battle_japanese_name), Formatting:format_stat(battle_reading)))
		end
		local battle_localized_name = self._equipment:battle_localized_name()
		if battle_localized_name then
			battle_name = Formatting:tooltip(Formatting:format_stat(battle_name), Formatting:format_stat(battle_localized_name))
		else
			battle_name = Formatting:format_stat(battle_name)
		end
		table.insert(alternative_names, format{self._alternative_name_template, label = self._battle_name_label, name = battle_name, japanese_name = battle_japanese_name})
	end
	if #alternative_names == 0 then
		self._vars.alternative_names = ""
	else
		self._vars.alternative_names = format{self._alternative_names_template, names = table.concat(alternative_names, "<br/>")}
	end
end

function EquipmentInfoKai:id()
	self._vars.id = Formatting:format_stat(self._equipment:id())
end

function EquipmentInfoKai:japanese_name()
	self._vars.japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(self._equipment:japanese_name()), Formatting:format_stat(self._equipment:reading())))
end

function EquipmentInfoKai:icon()
	self._vars.icon = Formatting:format_image{Formatting:format_equipment_icon(self._equipment:icon())}
end

function EquipmentInfoKai:eq_type()
	local eq_type = self._equipment:type()
	self._vars.eq_type = Formatting:format_equipment_types(self._equipment)
	local album_type = self._equipment:album_type()
	if album_type then
		self._vars.eq_type = Formatting:tooltip(self._vars.eq_type, album_type)
	end
	self._vars.eq_group = ""
	if eq_type == 3 or eq_type == 38 then
		self._vars.eq_group = format{self._eq_group_template, eq_group = Formatting:tooltip(Formatting:format_stat(self._equipment:gun_fit_group()), self._fit_group_tooltip)}
	elseif eq_type == 21 then
		local aa = self._equipment:aa()
		if aa and aa >= 9 then
			self._vars.eq_group = format{self._eq_group_template, eq_group = self._concentrated_label}
		end
	elseif eq_type == 12 or eq_type == 13 or eq_type == 93 then
		local aa = self._equipment:aa()
		if aa and aa >= 2 then
			self._vars.eq_group = format{self._eq_group_template, eq_group = self._air_radar_label}
		end
	else
		local icon = self._equipment:icon()
		if icon and icon == 16 then
			local aa = self._equipment:aa()
			local eq_group = self._high_angle_label
			if aa and aa >= 8 then
				eq_group = eq_group .. self._plus_fire_director_label
			end
			self._vars.eq_group = format{self._eq_group_template, eq_group = eq_group}
		end
	end
end

function EquipmentInfoKai:effects()
    local stats = {
		firepower = self._equipment:firepower(), 
		bombing = self._equipment:bombing(), 
		torpedo = self._equipment:torpedo(), 
		aa = self._equipment:aa(), 
		armor = self._equipment:armor(), 
		asw = self._equipment:asw(), 
		shelling_accuracy = self._equipment:shelling_accuracy(),
		torpedo_accuracy = self._equipment:torpedo_accuracy(),
		evasion = self._equipment:evasion(),
		los = self._equipment:los(),
		speed = Formatting:format_speed(self._equipment:speed()),
		luck = self._equipment:luck(),
		range = Formatting:format_range(self._equipment:range()),
		special = self._equipment:special(),
	}
    if self._equipment:type() == 48 then
        self._vars.effects = Formatting:format_stat_bonuses_interceptor(stats)
    else
    	self._vars.effects = Formatting:format_stat_bonuses(stats)
    end
end

function EquipmentInfoKai:scrap()
	self._vars.scrap = Formatting:format_resources(self._equipment:scrap())
end

function EquipmentInfoKai:image()
	local tabber = Tabber()
	local caption = nil
	local card_name = self._equipment:card_name()
	if card_name then
		local card_caption = {}
		local card_local = self._equipment:card_localized_name()
		if card_local then
			table.insert(card_caption, Formatting:format_stat_with_max(card_name, card_local))
		else
			table.insert(card_caption, card_name)
		end
		table.insert(card_caption, "/")
		table.insert(card_caption, Formatting:format_stat_with_max(self._equipment:card_japanese_name(), self._equipment:card_reading()))

		caption = table.concat(card_caption)
	end
	tabber:add_tab("Card", EquipmentCardKai:get{equip = self._equipment, caption = caption})
	tabber:add_tab("Fairy", EquipmentGraphicKai:get{equip = self._equipment, fairy = "only"})
	tabber:add_tab("Equipment", EquipmentGraphicKai:get{equip = self._equipment})
	tabber:add_tab("Combination", EquipmentGraphicKai:get{equip = self._equipment, fairy = true})
	self._vars.card = tostring(tabber)
end

function EquipmentInfoKai:compatibility_details()
	local result = {}
	for index, ship_type in ipairs(self._shown_ship_types) do
		if index % 2 == 1 then
			table.insert(result, self._row_starter)
		end
		local compatibility, note, ship_label
		if ship_type then
			compatibility, note = self._equipment:equippable(ship_type)
			ship_label = Formatting:format_ship_type(ship_type)-- + " " + Formatting:format_equipment_compatibility_symbol(compatibility)
			if note then
				ship_label = Formatting:tooltip(ship_label, note)
			end
		else
			ship_label = Formatting:format_ship_type(ship_type)
		end 
		table.insert(result, format{self._compatibility_cell, bg_color = Formatting:format_equipment_compatibility(compatibility), label = ship_label})
		--table.insert(result, format{self._compatibility_cell, bg_color = Formatting:format_equipment_compatibility_color(compatibility), label = ship_label})
	end
	self._vars.compatibility_details = table.concat(result, "\n")
end

local function format_bonus_text(desc)
    local with_formats = {
        ["Radar"] = "[[File:Radar.png|link=Radar|Radar with accuracy ≥ 3]]",
        ["SRadar"] = "[[File:Radar.png|link=Radar|Surface Radar with accuracy ≥ 3]]",
        ["ARadar"] = "[[File:Radar.png|link=Radar|Air Radar with accuracy ≥ 3]]",
        ["53Torpedo"] = "[[File:Torpedo.png|link=53cm Twin Torpedo Mount|53cm Twin Torpedo Mount]]",
        ["61Torpedo"] = "[[File:Torpedo.png|link=Category:Equipment fits with 12.7cm Single High-angle Gun Mount (Late Model)|Fits with 61cm Triple Torpedo Mount and 61cm Triple (Oxygen) Torpedo Mount only]]",
    }
    local with = desc._with and with_formats[desc._with] and " " .. with_formats[desc._with] or ""
    local count = desc._count and " " .. Formatting:tooltip("×" .. desc._count, "amount of equipment") or ""
    local text = desc._ship and
        string.format("[[%s]]%s", desc._ship, count) or
        desc._class and
        string.format(
            "[[:Category:%s Class|%s Class]]%s%s",
            desc._class,
            desc._class,
            desc._suffix and " " .. desc._suffix or "",
            count
        ) or
        "??"
    return text, with
end

local function format_bonus_stat(desc, stat)
    return type(desc[stat]) == "table" and
        Formatting:tooltip(U.isum(desc[stat]), U.ijoin(U.imap(desc[stat], function(e) return "+" .. e end), " ")) or
        desc[stat] or
        false
end

function EquipmentInfoKai:bonus_details()
    --[=[
    local result = { format{self._bonus_header, category = U.category("Equipment with stat bonuses") } }
    for _, ship in ipairs(U.isort(U.keys(self._equipment._bonus or {}))) do
        local s = self._equipment._bonus[ship] or {}
        table.insert(result, format{
            self._bonus_row,
            text = string.sub(ship, 1, 1) == "@" and string.sub(ship, 2) or ("[[" .. ship .. "]]"),
            stats = Formatting:format_stat_bonuses({
		        firepower = s._firepower or false,
	    	    bombing = s._bombing or false,
		        torpedo = s._torpedo or false,
		        aa = s._aa or false,
		        armor = s._armor or false,
		        asw = s._asw or false,
		        shelling_accuracy = s._shelling_accuracy or false,
		        torpedo_accuracy = s._torpedo_accuracy or false,
		        evasion = s._evasion or false,
		        los = s._los or false,
		        speed = s._speed or false,
		        luck = s._luck or false,
		        range = s._range or false,
		        special = s._special or false,
	        })
        })
    end
    local text, with, prevText
    for _, desc in ipairs(self._equipment._bonuses or {}) do
        text, with = format_bonus_text(desc)
        table.insert(result, format{
            self._bonus_row,
            text = text ~= prevText and text .. with or with,
            stats = Formatting:format_stat_bonuses({
		        firepower = format_bonus_stat(desc, "_firepower"),
	    	    bombing = format_bonus_stat(desc, "_bombing"),
		        torpedo = format_bonus_stat(desc, "_torpedo"),
		        aa = format_bonus_stat(desc, "_aa"),
		        armor = format_bonus_stat(desc, "_armor"),
		        asw = format_bonus_stat(desc, "_asw"),
		        shelling_accuracy = format_bonus_stat(desc, "_shelling_accuracy"),
		        torpedo_accuracy = format_bonus_stat(desc, "_torpedo_accuracy"),
		        evasion = format_bonus_stat(desc, "_evasion"),
		        los = format_bonus_stat(desc, "_los"),
		        speed = format_bonus_stat(desc, "_speed"),
		        luck = format_bonus_stat(desc, "_luck"),
		        range = format_bonus_stat(desc, "_range"),
		        special = format_bonus_stat(desc, "_special"),
	        })
        })
        prevText = text
    end
    ]=]--
    self._vars.bonus_details = "" -- #result > 1 and ("\n" .. table.concat(result, "\n")) or ""
end

function EquipmentInfoKai:crafting()
	local craft_methods
	if self._equipment:buildable() then
		self._vars.buildable = self._buildable
	else
		self._vars.buildable = self._unbuildable
	end
end

--function EquipmentInfoKai:improvement()
--	local cells = {}
--	local improvement = self._equipment:improvement()
--	if improvement then
--		Formatting:format_resources(improvement:resources())
--		for ship, ship_info in pairs(improvement:ships()) do
--			format{self._}
--end

function EquipmentInfoKai:create_item()
	self._equipment = Equipment(self._args[1], self._enemy)
end

function EquipmentInfoKai:get_module()
	self._equipment_data_module = Equipment:get_module(self._args.name or self._args[1])
end

function EquipmentInfoKai:create_infobox_prep()
	self._vars = {}
	local table_classes = {"infobox", "infobox-left", "infobox-equipment"}
	if self._args.classes then
		table.insert(table_classes, self._args.classes)
	end
	local collapsible = self._args.collapsible
	if collapsible then
		table.insert(table_classes, "mw-collapsible")
		table.insert(table_classes, "mw-collapsed")
	end
	self._vars.table_class = table.concat(table_classes, " ")
	self._vars.table_id = collapsible and collapsible ~= "true" and ("mw-customcollapsible-" .. collapsible) or ""
	self._vars.float = self._args.float and format{self._float_style_template, float = self._args.float} or ""
end

function EquipmentInfoKai:format_template()
	for _, field in ipairs(self._fields) do
		self[field](self)
	end
	return format(self._template, self._vars)
end

function EquipmentInfoKai:add_fields()
	return
end

function EquipmentInfoKai:create_infobox()
	self:add_fields()
	self:create_item()
	self:get_module()
	self:create_infobox_prep()
	return self:format_template()
end

return EquipmentInfoKai