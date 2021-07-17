local EnemyShip = require('Module:EnemyShip')
local ShipCapabilities = require('Module:ShipCapabilities')
local ShipGraphicKai = require('Module:ShipGraphicKai')
local ShipInfoKai = require('Module:ShipInfoKai')
local Formatting = require('Module:Formatting')
local Tabber = require('Module:Tabber')

local format = require('Module:Core').format

local EnemyShipInfoKai = ShipInfoKai{
	_template = [[{|class="typography-xl-optout ${table_class}" id="${table_id}" style="border: 1px solid darkgray; width: 320px;"
|-
| colspan="6" style="position: relative; text-align: center; padding: 1px 40px; background-color: ${top_bg_color};${top_extra_style}" | <div style="position: absolute; right: 5px;">${edit_link}</div>
<p><span style="font-size:20px; text-shadow: ${text_shadow}">'''${name}'''</span>${localized_name}</p>
<div style="font-size:15px">'''No.${id} ${japanese_name}${nick}'''</div>
<p>'''${class} ${type}'''</p>
|- style="background-color: whitesmoke;"
| align=center colspan="6" | ${image}
|-
| colspan="6" style="text-align: center; background-color: LightSkyBlue;"|'''Statistics'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width: 88px;" | ${icons.hp} ${labels.hp}
| style="width: 66px;" | '''${hp}'''
| style="width: 88px;" | ${icons.firepower} ${labels.firepower}
| colspan="2" style="width: 60px;" | '''${firepower}'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width: 88px;" | ${icons.armor} ${labels.armor}
| style="width: 66px;" | '''${armor}'''
| style="width: 88px;" | ${icons.torpedo} ${labels.torpedo}
| colspan="2" style="width: 66px;" | '''${torpedo}'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width: 88px;" | ${icons.evasion} ${labels.evasion}
| style="width: 66px;" | '''${evasion}'''
| style="width: 88px;" | ${icons.aa} ${labels.aa}
| colspan="2" style="width: 66px;" | '''${aa}'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width: 88px;" | ${icons.aircraft} ${labels.aircraft}
| style="width: 66px;" | '''${aircraft}'''
| style="width: 88px;" | ${icons.asw} ${labels.asw}
| colspan="2" style="width: 66px;" | '''${asw}'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width: 88px;" | ${icons.speed} ${labels.speed}
| style="width: 66px;" | '''${speed}'''
| style="width: 88px;" | ${icons.los} ${labels.los}
| colspan="2" style="width: 66px;" | '''${los}'''
|- style="background-color: whitesmoke;"
| colspan="2" style="width: 88px;" | ${icons.range} ${labels.range}
| style="width: 66px;" | '''${range}'''
| style="width: 88px;" | ${icons.luck} ${labels.luck}
| colspan="2" style="width: 66px;" | '''${luck}'''
|-
| colspan="5" style="text-align: center; background-color: LightSkyBlue;"| '''Air Power'''
| style="text-align: center; background-color: LightSkyBlue; width: 50px;" | '''Slots'''
|-  style="background-color: whitesmoke;"
| colspan="5" style="text-align: center;"| ${air_power}
| align=center style="width: 50px;" | ${slots}
|-
| colspan="5" style="text-align: center; background-color: LightSkyBlue;"| '''Equipment'''
| style="text-align: center; background-color: LightSkyBlue; width: 50px;" | '''Space'''
${slot_details}|-
| colspan="6" style="text-align: center; padding: 0px;" | <div class="mw-collapsible mw-collapsed">
<div style="background-color: lightskyblue; text-align: center; margin: 0px;">'''Extra Statistics'''</div>
<div class="mw-collapsible-content">
<div style="text-align: left; display: ${opening_airstrike_display}; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; display: flex; align-items: center;"><span>${icons.aircraft} Opening Airstrike</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;">'''${opening_airstrike}'''</div>
</div>
<div style="text-align: left; display: ${opening_torpedo_display}; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; display: flex; align-items: center;"><span>${icons.torpedo} Opening Torpedo</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;">'''${opening_torpedo}'''</div>
</div>
<div style="text-align: left; display: flex; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; color: dodgerblue; display: flex; align-items: center;"><span>${icons.firepower} Day Battle</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;">'''${day_battle}'''</div>
</div>
<div style="text-align: left; display: ${artillery_spotting_display}; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; color: forestgreen; display: flex; align-items: center;"><span>${icons.firepower}${icons.los} Artillery Spotting</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;">'''${artillery_spotting}'''</div>
</div>
<div style="text-align: left; display: ${closing_torpedo_display}; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; display: flex; align-items: center;"><span>${icons.torpedo} Closing Torpedo</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;">'''${closing_torpedo}'''</div>
</div>
<div style="text-align: left; display: flex; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; display: flex; align-items: center;"><span>${icons.asw} ASW Attack</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;">'''${asw_attack}'''</div>
</div>
<div style="text-align: left; display: flex; margin: 2px 0px;">
<div style="margin-right: 1px; flex-shrink: 0; flex-basis: 140px; background-color: whitesmoke; color: midnightblue; display: flex; align-items: center;"><span>${icons.firepower}${icons.torpedo} Night Battle</span></div>
<div style="margin-left: 1px; flex-grow: 1; background-color: whitesmoke; display: flex; align-items: center;">'''${night_battle}'''</div>
</div>
</div>
</div>
|}]],
	_abyssal_class = "Abyssal",
	_common_background_color = "darkgrey",
	_background_color = "grey",
	_background_image = "background-image: radial-gradient(circle farthest-corner at center center , rgba(102, 102, 102, 0) 0%, rgba(102, 102, 102, 0) 60%, rgb(102, 102, 102) 100%);",
	_plain_rare_background_color = "#d8d840",
	_plain_rare_background_image = "background-image: radial-gradient(circle farthest-corner at center center , rgba(192, 192, 0, 0) 0%, rgba(192, 192, 0, 0.4) 60%, rgba(144, 144, 0, 0.7) 100%);",
	_elite_glow_background_color = "#c95050",
	_mid_boss_background_color = "#A67474",
	_mid_boss_background_image = "background-image: radial-gradient(circle farthest-corner at center center , rgba(140, 98, 98, 0) 0%, rgba(140, 98, 98, 0) 60%, rgb(140, 98, 98) 100%);",
	_rare_background_color = "#d84040",
	_rare_background_image = "background-image: radial-gradient(circle farthest-corner at center center , #e65555 0%, #c04040 90%, #A04040);",
	_link_color = "#3a3a3a",
	_text_shadow_template = "0 0 ${radius} ${color}",
	_text_shadows = {
		"0.1em",
		"0.3em",
		"0.6em",
		"0.9em",
	},
	_basic_glow_colors = {
		"#a0f6d9",
		"#8becd5",
	},
	_kai_glow_colors = {
		"darkturquoise",
		"dodgerblue",
	},
	_late_model_basic_glow_colors = {
		"#e6e6e6",
		"#e6e6e6",
	},
	_late_model_glow_colors = {
		"#8becd5",
		"#e6e6e6",
		"#e6e6e6",
	},
	_boss_glow_colors = {
		"floralwhite",
		"floralwhite",
	},
	_link_color_template = [[<span style="color: ${color};">${text}</span>]],
	_cg_size = "300x300px",
	_tabber_cg_size = "294x294px",
	_display_flex = "flex",
	_display_none = "none",
}

function EnemyShipInfoKai:get_module()
	self._ship_data_module = EnemyShip:get_module(self._args.name or self._args[1], true)
end

function EnemyShipInfoKai:bg_color()
	local rarity = self._ship:rarity()
	local bg_color
	local extra_style = ""
	if rarity then
		if rarity >= 4 and rarity <= 7 then
			if rarity == 5 then
				bg_color = self._elite_glow_background_color
			elseif rarity == 6.5 then
				bg_color = self._mid_boss_background_color
				extra_style = self._mid_boss_background_image
			elseif rarity == 7 then
			    bg_color = self._plain_rare_background_color
				extra_style = self._plain_rare_background_image
			else
				bg_color = self._background_color
				extra_style = self._background_image
			end
		elseif rarity < 4 then
			bg_color = self._common_background_color
		else
			bg_color = self._rare_background_color
			extra_style = self._rare_background_image
		end
	else
		bg_color = self._common_background_color
	end
	local back = self._ship:back()
	local back_color = Formatting:format_ship_back(back)
	local glow_colors = {}
	if back then
		if back == -1 then
			glow_colors = self._basic_glow_colors
		elseif back > -7 and back < -3 then
			glow_colors = self._kai_glow_colors
		elseif back > -10 and back < -6 then
			glow_colors = (back == -7) and self._late_model_basic_glow_colors or self._late_model_glow_colors
		elseif back < -9 then
			glow_colors = self._boss_glow_colors
		end
	end
	local text_shadows = {}
	for index, radius in ipairs(self._text_shadows) do
		local color = back_color
		if index <= #glow_colors then
				color = glow_colors[index]
		end
		--table.insert(text_shadows, format{self._text_shadow_template, radius = radius, color = color})
	end
	self._vars.top_bg_color, self._vars.text_shadow, self._vars.top_extra_style = bg_color, table.concat(text_shadows, ", "), extra_style
end

function EnemyShipInfoKai:name()
	local link, text, section = self._ship:link()
	text = format{self._link_color_template, color = self._link_color, text = text or link}
	self._vars.name = Formatting:format_link(link, text, section)
end

function EnemyShipInfoKai:id()
	self._vars.id = Formatting:format_stat(self._ship:id())
end

function EnemyShipInfoKai:class()
	self._vars.class = self._abyssal_class
end

function EnemyShipInfoKai:type()
	local ship_type = Formatting:format_ship_type(self._ship:type())
	if self._ship:speed() == 0 then
		ship_type = ship_type ..
		(self._ship:is_pillbox() and " (Pillbox)" or " (Installation)")
	end
	-- automatically make units with 0 speed installations
	-- deprecate _installation
	self._vars.type = ship_type
end

function EnemyShipInfoKai:image()
	if self._ship:can_debuff() then
		local tabber = Tabber()
		tabber:add_tab("Normal", ShipGraphicKai:get{ship = self._ship, size = self._args.cg_size or self._tabber_cg_size, hd = true})
		tabber:add_tab("Armor Broken", ShipGraphicKai:get{ship = self._ship, damaged = true, size = self._args.cg_size or self._tabber_cg_size})
		self._vars.image = tostring(tabber)
	else
		self._vars.image = ShipGraphicKai:get{ship = self._ship, size = self._args.cg_size or self._cg_size, hd = true}
	end
end

EnemyShipInfoKai.hp = EnemyShipInfoKai.base_hp

function EnemyShipInfoKai:firepower()
	self._vars.firepower = Formatting:format_stat(self._ship:firepower())
end

function EnemyShipInfoKai:armor()
    local equipment_armor = self._ship:equipment_armor()
    local armor = self._ship:armor()
    local stat = Formatting:format_stat(armor)
	self._vars.armor = equipment_armor ~= 0 and Formatting:tooltip(stat, armor + equipment_armor) or stat
end

function EnemyShipInfoKai:torpedo()
	self._vars.torpedo = Formatting:format_stat(self._ship:torpedo())
end

function EnemyShipInfoKai:evasion()
	local evasion
	local override = self._args.evasion
	local overridden = false
	if override and override ~= "auto" then
		evasion = override
		overridden = true
	else
		evasion = self._ship:evasion()
	end
	local result = Formatting:format_stat(evasion)
	if overridden then
		result = result .. self._overridden_category_template
	end
	self._vars.evasion = result
end

function EnemyShipInfoKai:aa()
	self._vars.aa = Formatting:format_stat(self._ship:aa(), self._ship:aa_max())
end

function EnemyShipInfoKai:asw()
	local asw
	local overridden = false
	local override = self._args.asw
	if override and override ~= "auto" then
		asw = override
		overridden = true
	else
		asw = self._ship:asw()
	end
	local result = Formatting:format_stat(asw)
	if overridden then
		result = result .. self._overridden_category_template
	end
	self._vars.asw = result
end

function EnemyShipInfoKai:los()
	local los
	local override = self._args.los
	local overridden = false
	if override and override ~= "auto" then
		los = override
		overridden = true
	else
		los = self._ship:los()
	end
	local result = Formatting:format_stat(los)
	if overridden then
		result = result .. self._overridden_category_template
	end
	self._vars.los = result
end

function EnemyShipInfoKai:luck()
	self._vars.luck = Formatting:format_stat(self._ship:luck())
end

function EnemyShipInfoKai:air_power()
	self._vars.air_power = Formatting:format_air_power(self._ship:air_power(), self._ship:air_power_estimation())
end

function EnemyShipInfoKai:capabilities()
	local capabilities = ShipCapabilities{ship = self._ship}
	local opening_airstrike = { capabilities:opening_airstrike() }
	local opening_torpedo = { capabilities:opening_torpedo() }
	local day_battle = { capabilities:day_battle() }
	local artillery_spotting = { capabilities:artillery_spotting() }
	local closing_torpedo = { capabilities:closing_torpedo() }
	local asw_attack = { capabilities:asw_attack() }
	local night_battle = { capabilities:night_battle() }
	self._vars.opening_airstrike_display, self._vars.opening_airstrike = opening_airstrike[1] and self._display_flex or self._display_none, capabilities:format_opening_airstrike(unpack(opening_airstrike))
	self._vars.opening_torpedo_display, self._vars.opening_torpedo = opening_torpedo[1] and self._display_flex or self._display_none, capabilities:format_opening_torpedo(unpack(opening_torpedo))
	self._vars.day_battle = capabilities:format_day_battle(unpack(day_battle))
	self._vars.artillery_spotting_display, self._vars.artillery_spotting = artillery_spotting[1] and self._display_flex or self._display_none, capabilities:format_artillery_spotting(unpack(artillery_spotting))
	self._vars.closing_torpedo_display, self._vars.closing_torpedo = closing_torpedo[1] and self._display_flex or self._display_none, capabilities:format_closing_torpedo(unpack(closing_torpedo))
	self._vars.asw_attack = capabilities:format_asw_attack(unpack(asw_attack))
	self._vars.night_battle = capabilities:format_night_battle(unpack(night_battle))
end

function EnemyShipInfoKai:create_item()
	if self._args.name then
		self._ship = EnemyShip(self._args.name, self._args.model)
	else
		self._ship = EnemyShip(self._args[1])
	end
end

function EnemyShipInfoKai:add_fields()
	table.insert(self._fields, "air_power")
	table.insert(self._fields, "capabilities")
end

return EnemyShipInfoKai