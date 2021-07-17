local BaseData = require('Module:BaseData')
local Ship = require('Module:Ship')
local ShipCardKai = require('Module:ShipCardKai')
local ResourceIcons = require('Module:Data/Asset')
local StatIcons = require('Module:Data/Asset')
local Formatting = require('Module:Formatting')
local EquipmentLink = require('Module:EquipmentLink')
local format = require('Module:Core').format

local ShipInfoKai = BaseData{
	_unbuildable = "''Unbuildable''",
	_remodel_level = "'''Remodel Level'''",
	_build_time = "'''Build Time'''",
	_default_slot_num = 4,
	_normal_construction = "Normal",
	_normal_construction_category = ":Category:Ships buildable in Normal Construction",
	_large_ship_construction = "LSC",
	_large_ship_construction_category = ":Category:Ships buildable in Large Ship Construction",
	_ship_data_documentation = "Template:ShipDataDocumentation/EditIntro",
	_edit_link_text = "Edit",
	_localized_name_template = "<br />''${localized_name}''",
	_kekkon_max_template = "Maximum after marriage: ${value}",
	_kekkon_template = "After marriage: ${value}; Upper bound: ${max}",
	_remodel_level_stat_value_template = "At remodel level: ${value}",
	_simple_nick_template = " (''${nick}'')",
	_nick_template = " (''${nick} ${japanese_nick}'')",
	_overridden_category_template = "[[Category:Pages that override data modules]]",
	_fields = {
		"edit_link",
		"rarity",
		"bg_color",
		"name",
		"localized_name",
		"id",
		"japanese_name",
		"nick",
		"class",
		"type",
		"image",
		"hp",
		"firepower",
		"armor",
		"torpedo",
		"evasion",
		"aa",
		"aircraft",
		"asw",
		"speed",
		"los",
		"range",
		"luck",
		"consumption",
		"modernization",
		"scrap",
		"build_remodel_header",
		"build_remodel_info",
		"slots",
		"slot_details",
		"gun_fit_properties",
		"improvement",
	},
	_slot_template = [[|- align=center style="background-color: whitesmoke; line-height: 1.1;"
| style="width: 36px; height: 36px; background-color: ${color};${extra_style}" | ${icon}
| colspan="4" style="width: 190px;" | ${equipment}${stars}
| style="width: 50px;" | ${slot_size}
]],
	_template = [[{|class="${table_class}" id="${table_id}" style="width: 320px; float: ${float};"
|-
| colspan="6" class="infobox-kai-header-major" style="position: relative; text-align: center; background-color: ${top_bg_color};${top_extra_style}" title="${rarity}" | <div style="position: absolute; right: 5px;">${edit_link}</div>
<p><span style="font-size:20px">'''${name}'''</span>${localized_name}</p>
<div style="font-size:15px">'''No.${id} ${japanese_name}${nick}'''</div>
<p>'''${class} ${type}'''</p>
|- style="background-color: whitesmoke;"
| align=center colspan="6" | <div class="infobox-ship-card">${image}</div>
|-
| colspan="6" class="infobox-kai-header-major" style="text-align: center;"|'''Statistics'''
|- style="background-color:whitesmoke;"
| colspan="2" style="width:88px;white-space:nowrap" | ${icons.hp} ${labels.hp}
| style="width: 66px;white-space:nowrap" | '''${hp}'''
| style="width:88px;white-space:nowrap" | ${icons.firepower} ${labels.firepower}
| colspan="2" style="width:60px;white-space:nowrap" | '''${firepower}'''
|- style="background-color:whitesmoke;"
| colspan="2" style="width:88px;white-space:nowrap" | ${icons.armor} ${labels.armor}
| style="width: 66px;white-space:nowrap" | '''${armor}'''
| style="width:88px;white-space:nowrap" | ${icons.torpedo} ${labels.torpedo}
| colspan="2" style="width:66px;white-space:nowrap" | '''${torpedo}'''
|- style="background-color:whitesmoke;"
| colspan="2" style="width:88px;white-space:nowrap" | ${icons.evasion} ${labels.evasion}
| style="width: 66px;white-space:nowrap" | '''${evasion}'''
| style="width:88px;white-space:nowrap" | ${icons.aa} ${labels.aa}
| colspan="2" style="width:66px;white-space:nowrap" | '''${aa}'''
|- style="background-color:whitesmoke;"
| colspan="2" style="width:88px;white-space:nowrap" | ${icons.aircraft} ${labels.aircraft}
| style="width: 66px;white-space:nowrap" | '''${aircraft}'''
| style="width:88px;white-space:nowrap" | ${icons.asw} ${labels.asw}
| colspan="2" style="width:66px;white-space:nowrap" | '''${asw}'''
|- style="background-color:whitesmoke;"
| colspan="2" style="width:88px;white-space:nowrap" | ${icons.speed} ${labels.speed}
| style="width:66px;white-space:nowrap" | '''${speed}'''
| style="width:88px;white-space:nowrap" | ${icons.los} ${labels.los}
| colspan="2" style="width:66px;white-space:nowrap" | '''${los}'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width:88px;white-space:nowrap" | ${icons.range} ${labels.range}
| style="width:66px;white-space:nowrap" | '''${range}'''
| style="width:88px;white-space:nowrap" | ${icons.luck} ${labels.luck}
| colspan="2" style="width:66px;white-space:nowrap" | '''${luck}'''
|-
| colspan="6" style="text-align: center; background-color: lightgrey;"|'''Resource Consumption'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width:88px;white-space:nowrap" | ${icons.fuel} Fuel
| style="width:66px;white-space:nowrap" | '''${fuel}'''
| style="width:88px;white-space:nowrap" | ${icons.ammo} Ammo
| colspan="2" style="width:66px;white-space:nowrap" | '''${ammo}'''
|-
| colspan="5" class="infobox-kai-header-major" style="text-align: center;"|${build_remodel_header}
| class="infobox-kai-header-major" style="text-align: center; width: 50px;" | '''Slots'''
|-  style="background-color: whitesmoke;"
| colspan="5" style="text-align: center;"|${build_remodel_info}
| align=center style="width: 50px;" |${slots}
|-
| colspan="5" class="infobox-kai-header-major" style="text-align: center;"|'''Stock Equipment'''
| class="infobox-kai-header-major" style="text-align: center; width: 50px;" | '''Space'''
${slot_details}|-
| colspan="6" style="text-align: center; padding: 0px;" | <div class="mw-collapsible mw-collapsed infobox-kai-expandable-cells">
<div class="infobox-kai-header-major" style="text-align: center; margin: 0px;">'''Extra Statistics'''</div>
<div class="mw-collapsible-content">
${remodel_cost}${reversion_cost}<div class="infobox-kai-header-minor" style="text-align: center; margin:2px 0px 2px;">'''Modernization Bonus'''</div>
<div style="text-align: center; margin:2px 0px 2px;">${modernization}</div>
<div class="infobox-kai-header-minor" style="text-align: center; margin:2px 0px 2px;">'''Scrap Value'''</div>
<div style="text-align: center; margin:2px 0px 0px;">${scrap}</div>
${gun_fit_properties}${improvement}</div>
</div>
|}]],
	_remodel_cost_template = [[<div class="infobox-kai-header-minor" style="text-align: center; margin:2px 0px 2px;">'''Remodel Cost'''</div>
<div style="text-align: center; margin:2px 0px 2px;">${remodel_cost}</div>
]],
	_reversion_cost_template = [[<div class="infobox-kai-header-minor" style="text-align: center; margin:2px 0px 2px;">'''Reversion to ${suffix}'''</div>
<div style="text-align: center; margin:2px 0px 2px;">${level_items}<br />${resources}</div>
]],
	_gun_fit_properties_template = format{[[<div class="infobox-kai-header-minor" style="text-align: center; margin:2px 0px 2px;"><b>${subtitle}</b></div>
${gun_fit_groups}]], subtitle = "[[Overweight_Penalty_and_Fit_Gun_Bonus#Battleships|Large Caliber Fit Gun Properties]]"},
	_gun_fit_group_template = [[<div style="text-align: left; display: flex; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; display: flex; align-items: center;"><span>${fit_group}</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;"><b>${fit}</b></div>
</div>
]],
    _improvement_template = [[<div class="infobox-kai-header-minor" style="text-align: center; margin:2px 0px 2px;">'''Improvement'''</div>
<div style="text-align: center; background-color: whitesmoke; margin:2px 0px 2px;">${category_tree}</div>
]],
    _improvement_category_template = "Equipment that can be improved with ${ship_name} as helper ship",
}

function ShipInfoKai:Infobox(args)
	return self{
		_args = args,
	}:create_infobox()
end

function ShipInfoKai:edit_link()
	self._vars.edit_link = Formatting:format_edit_link(self._ship_data_module, self._edit_link_text, self._ship_data_documentation)
end

function ShipInfoKai:bg_color()
	local back = self._ship:back()
	self._vars.top_bg_color, self._vars.top_extra_style = Formatting:format_ship_back(back), Formatting:extra_style_background_image(back and back > 7, back and back > 6, self._ship:overlay()) or ""
end

function ShipInfoKai:rarity()
	self._vars.rarity = Formatting:format_ship_rarity(self._ship:rarity())
end

function ShipInfoKai:name()
	self._vars.name = Formatting:format_link(self._ship:base_link())
end

function ShipInfoKai:localized_name()
	local localized_name = self._ship:localized_name()
	if localized_name then
		self._vars.localized_name = format{self._localized_name_template, localized_name = Formatting:format_stat(localized_name)}
	else
		self._vars.localized_name = ""
	end
end

function ShipInfoKai:japanese_name()
	self._vars.japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(self._ship:japanese_name()), Formatting:format_stat(self._ship:reading())))
end

function ShipInfoKai:nick()
	local nick = self._ship:nick()
	if nick then
		local japanese_nick = self._ship:japanese_nick()
		local reading_nick = self._ship:reading_nick()
		if japanese_nick and reading_nick then
			japanese_nick = tostring(Formatting:japanese_text(Formatting:format_stat(japanese_nick), Formatting:format_stat(reading_nick)))
		end
		if japanese_nick then
			self._vars.nick = format{self._nick_template, nick = nick, japanese_nick = japanese_nick}
		else
			self._vars.nick = format{self._simple_nick_template, nick = nick}
		end
	else
		self._vars.nick = ""
	end
end

function ShipInfoKai:id()
	local true_id = self._ship:true_id()
	if true_id then
		self._vars.id = Formatting:tooltip(Formatting:format_stat(self._ship:id()), Formatting:format_stat(true_id))
	else
		self._vars.id = Formatting:format_stat(self._ship:id())
	end
end

function ShipInfoKai:class()
	local class = self._ship:class()
	self._vars.class = Formatting:format_stat(class and class:name())
end

function ShipInfoKai:type()
	local class = self._ship:class()
	local ship_type = Formatting:format_ship_type(self._ship:type())
	if class and class:is_type() then
		ship_type = "(" .. ship_type .. ")"
	end
	self._vars.type = ship_type
end

function ShipInfoKai:image()
	self._vars.image = ShipCardKai:get{ship = self._ship, hd = true}
end

function ShipInfoKai:base_hp()
    local hp = self._ship:hp()
    local hp_mod = self._ship:hp_mod()
	self._vars.hp = hp_mod and hp_mod > 0 and Formatting:format_stat_with_max(hp, hp + hp_mod) or Formatting:format_stat(hp)
end

function ShipInfoKai:hp()
	self:base_hp()
	local hp = self._ship:hp_married()
	if hp then
	    local hp_mod = self._ship:hp_mod_married()
		self._vars.hp = Formatting:tooltip(self._vars.hp, format{
		    self._kekkon_template,
		    value = hp_mod and hp_mod > 0 and Formatting:format_stat_with_max(hp, hp + hp_mod) or Formatting:format_stat(hp),
		    max = Formatting:format_stat(self._ship:hp_max())
        })
	end
end

function ShipInfoKai:firepower()
	self._vars.firepower = Formatting:format_stat_with_max(self._ship:firepower(), self._ship:firepower_max())
end

function ShipInfoKai:armor()
	self._vars.armor = Formatting:format_stat_with_max(self._ship:armor(), self._ship:armor_max())
end

function ShipInfoKai:torpedo()
	self._vars.torpedo = Formatting:format_stat_with_max(self._ship:torpedo(), self._ship:torpedo_max())
end

function ShipInfoKai:evasion()
	local evasion, evasion_max
	local override = self._args.evasion
	local override_max = self._args.evasion_max
	local overridden = false
	if override and override ~= "auto" then
		evasion = override
		overridden = true
	else
		evasion = self._ship:evasion()
	end
	if override_max and override_max ~= "auto" then
		evasion_max = override_max
		overridden = true
	else
		evasion_max = self._ship:evasion_max()
	end
	if not overridden and evasion and evasion_max then
	    local remodel_level = self._ship:remodel_level()
	    if self._ship:remodel_level() then
	        evasion = Formatting:tooltip(evasion, format{self._remodel_level_stat_value_template, value = Formatting:format_stat(self._ship:evasion_leveled(remodel_level))})
	    end
		evasion_max = Formatting:tooltip(evasion_max, format{self._kekkon_max_template, value = Formatting:format_stat(self._ship:evasion_leveled(175))})
	end
	local result = Formatting:format_stat_with_max(evasion, evasion_max)
	if overridden then
		result = result .. self._overridden_category_template
	end
	self._vars.evasion = result
end

function ShipInfoKai:aa()
	self._vars.aa = Formatting:format_stat_with_max(self._ship:aa(), self._ship:aa_max())
end

function ShipInfoKai:aircraft()
	self._vars.aircraft = Formatting:format_stat(self._ship:total_space())
end

function ShipInfoKai:asw()
	local asw, asw_max
	local overridden = false
	local override = self._args.asw
	local override_max = self._args.asw_max
	if override and override ~= "auto" then
		asw = override
		overridden = true
	else
		asw = self._ship:asw()
	end
	if override_max and override_max ~= "auto" then
		asw_max = override_max
		overridden = true
	else
		asw_max = self._ship:asw_max()
	end
	if not overridden and asw and asw_max then
	    local remodel_level = self._ship:remodel_level()
	    if self._ship:remodel_level() then
		    asw = Formatting:tooltip(asw, format{self._remodel_level_stat_value_template, value = Formatting:format_stat(self._ship:asw_leveled(remodel_level))})
        end
		asw_max = Formatting:tooltip(asw_max, format{self._kekkon_max_template, value = Formatting:format_stat(self._ship:asw_leveled(175))})
	end
	local result = Formatting:format_stat_with_max(asw, asw_max)
	if overridden then
		result = result .. self._overridden_category_template
	end
	self._vars.asw = result
end

function ShipInfoKai:speed()
	self._vars.speed = Formatting:format_speed(self._ship:speed())
end

function ShipInfoKai:los()
	local los, los_max
	local override = self._args.los
	local override_max = self._args.los_max
	local overridden = false
	if override and override ~= "auto" then
		los = override
		overridden = true
	else
		los = self._ship:los()
	end
	if override_max and override_max ~= "auto" then
		los_max = override_max
		overridden = true
	else
		los_max = self._ship:los_max()
	end
	if not overridden and los and los_max then
	    local remodel_level = self._ship:remodel_level()
	    if self._ship:remodel_level() then
		    los = Formatting:tooltip(los, format{self._remodel_level_stat_value_template, value = Formatting:format_stat(self._ship:los_leveled(remodel_level))})
        end
		los_max = Formatting:tooltip(los_max, format{self._kekkon_max_template, value = Formatting:format_stat(self._ship:los_leveled(175))})
	end
	local result = Formatting:format_stat_with_max(los, los_max)
	if overridden then
		result = result .. self._overridden_category_template
	end
	self._vars.los = result
end

function ShipInfoKai:range()
	self._vars.range = Formatting:format_range(self._ship:range())
end

function ShipInfoKai:luck()
	self._vars.luck = Formatting:format_stat_with_max(self._ship:luck(), self._ship:luck_max())
end

function ShipInfoKai:build_remodel_header()
	self._vars.build_remodel_header = self._ship:remodel_from() and self._remodel_level or self._build_time
end

function ShipInfoKai:build_remodel_info()
	local remodel_from = self._ship:remodel_from()
	if remodel_from then
		self._vars.build_remodel_info = Formatting:format_remodel_level_and_item_cost(
			self._ship:remodel_level(),
			self._ship:remodel_blueprint(), self._ship:remodel_catapult(), self._ship:remodel_report(),
			self._ship:remodel_gunmat(), self._ship:remodel_airmat(), self._ship:remodel_armament()
		)
		self._vars.remodel_cost = format{self._remodel_cost_template, remodel_cost = Formatting:format_resources(self._ship:remodel_cost())}
	else
		local buildable = self._ship:buildable()
		local buildable_lsc = self._ship:buildable_lsc()
		if buildable or buildable_lsc then
			local buildable_methods = {}
			if buildable then
				table.insert(buildable_methods, Formatting:format_link(self._normal_construction_category, self._normal_construction))
			end
			if buildable_lsc then
				table.insert(buildable_methods, Formatting:format_link(self._large_ship_construction_category, self._large_ship_construction))
			end
			self._vars.build_remodel_info = Formatting:format_stat_with_max(Formatting:seconds_to_hms(self._ship:build_time() * 60), table.concat(buildable_methods, ", "))
		else
			local build_time = self._ship:build_time()
			self._vars.build_remodel_info = build_time and Formatting:tooltip(self._unbuildable, Formatting:seconds_to_hms(build_time * 60)) or self._unbuildable
		end
		self._vars.remodel_cost = ""
	end

    -- [[Category:Todo]]: _reversible is a hack
	if remodel_from ~= false and remodel_from == self._ship:remodel_to() or self._ship._reversible then		
		self._vars.reversion_cost = format{self._reversion_cost_template, 
			suffix = Formatting:format_stat(Ship(self._ship:remodel_to()):display_suffix()), 
			level_items = Formatting:format_remodel_level_and_item_cost(self._ship:remodel_to_level(), self._ship:remodel_to_blueprint(), self._ship:remodel_to_catapult(), self._ship:remodel_to_report(), self._ship:remodel_to_gunmat(), self._ship:remodel_to_airmat()),
			resources = Formatting:format_resources(self._ship:remodel_to_cost())
		}
	else
		self._vars.reversion_cost = ""
	end
end

function ShipInfoKai:slots()
	self._vars.slots = Formatting:format_stat(self._ship:slots())
end

function ShipInfoKai:slot_details()
	local slots, num_of_slots, num_of_enabled_slots, slots_to_show = {}, self._ship:slots_length(), self._ship:slots()
	if num_of_slots then
		slots_to_show = math.max(self._default_slot_num, num_of_slots)
	else
		slots_to_show = self._default_slot_num
	end
	for i = 1, slots_to_show do
		local disabled, equipment, stars, size, estimation, icon, color, equipment_type = num_of_enabled_slots and i > num_of_enabled_slots
		if num_of_slots and i > num_of_slots then
			equipment, size, estimation, icon, color, equipment_type = "- Locked -", false, false, "", 0, false
		else
			equipment, size, estimation, eqStars = self._ship:slot(i)
			if equipment then
				icon = equipment:icon()
				color = equipment:back()
				equipment_type = equipment:type()
				equipment = EquipmentLink.format(nil, { equipment:name() })
				if eqStars then
				    stars = " " .. Formatting:format_slot_stars(eqStars)
				end
			else
				icon = disabled and "" or false
				color = 0
				equipment = equipment == false and (disabled and "- Locked -" or "- Unequipped -") or Formatting:format_stat(equipment)
				equipment_type = false
			end
			if icon ~= "" then
				icon = Formatting:format_image{Formatting:format_equipment_icon(icon), caption = Formatting:format_equipment_type(equipment_type)}
			end
		end
		table.insert(slots, format{self._slot_template, 
			icon = icon, 
			equipment = equipment,
			stars = stars or "",
			slot_size = Formatting:format_slot_size(size, estimation), 
			color = "whitesmoke", --Formatting:format_equipment_back(color), 
			extra_style = "", --Formatting:extra_style_background_image(false, color >= 4)
		})
	end
	self._vars.slot_details = table.concat(slots)
end

function ShipInfoKai:consumption()
	self._vars.fuel, self._vars.ammo = Formatting:format_stat(self._ship:fuel()), Formatting:format_stat(self._ship:ammo())
end

function ShipInfoKai:modernization()
	self._vars.modernization = Formatting:format_modernization_bonuses(self._ship:modernization())
end

function ShipInfoKai:scrap()
	self._vars.scrap = Formatting:format_resources(self._ship:scrap())
end

function ShipInfoKai:gun_fit_properties()
	local ship_type = self._ship:type()
	if ship_type == 8 or ship_type == 9 or ship_type == 10 then
		local rows = {}
		for _, fit_group in ipairs(require('Module:GunFitGroups').large_caliber) do
			table.insert(rows, format{self._gun_fit_group_template, fit_group = fit_group, fit = Formatting:format_fit_bonus(self._ship:gun_fit_properties(fit_group))})
		end
		self._vars.gun_fit_properties = format{self._gun_fit_properties_template, gun_fit_groups = table.concat(rows)}
	else
		self._vars.gun_fit_properties = ""
	end
end

function ShipInfoKai:improvement()
    self._vars.improvement = format{self._improvement_template, category_tree = tostring(require('Module:CategoryTree'){category = format{self._improvement_category_template, ship_name = self._ship:name()}, depth = 1})}
end

function ShipInfoKai:create_item()
	if self._args.name then
		self._ship = Ship(self._args.name, self._args.model)
	else
		self._ship = Ship(self._args[1])
	end
	if self._args.override and self._ship then
	    for key, value in pairs(self._args.override) do
            self._ship[key] = value
	    end
	end
end

function ShipInfoKai:get_module()
	self._ship_data_module = Ship:get_module(self._args.name or self._args[1])
end

function ShipInfoKai:create_infobox_prep()
	local icons = {
		hp = StatIcons.hp,
		firepower = StatIcons.firepower,
		armor = StatIcons.armor,
		torpedo = StatIcons.torpedo,
		evasion = StatIcons.evasion,
		aa = StatIcons.aa,
		aircraft = StatIcons.aircraft,
		asw = StatIcons.asw,
		speed = StatIcons.speed,
		los = StatIcons.los,
		range = StatIcons.range,
		luck = StatIcons.luck,
		fuel = ResourceIcons.fuel,
		ammo = ResourceIcons.ammo,
	}
	local labels = {}
	for k,v in pairs(icons) do
		icons[k] = Formatting:format_image{v, size = "18px"}
		labels[k] = Formatting:format_stat_name(k)
	end
	self._vars = {icons = icons, labels = labels}
	local table_classes = {"typography-xl-optout", "infobox", "infobox-kai", "infobox-ship"}
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
	self._vars.float = self._args.float or "none"
end

function ShipInfoKai:format_template()
	for _, field in ipairs(self._fields) do
		self[field](self)
	end
	return format(self._template, self._vars)
end

function ShipInfoKai:add_fields()
	return
end

function ShipInfoKai:create_infobox()
	self:add_fields()
	self:create_item()
	self:get_module()
	self:create_infobox_prep()
	return self:format_template()
end

return ShipInfoKai