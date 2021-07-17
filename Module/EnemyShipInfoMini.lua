local Formatting = require('Module:Formatting')
local ShipInfoKai = require('Module:ShipInfoKai')

local EnemyShipInfoMini = ShipInfoKai{
	_template = [[{|class="typography-xl-optout ${table_class}" style="margin: auto; float: none; border: 1px solid darkgray; width: 160px;"
|-
! colspan="4" style="height: 80px;" | ${name}<br />${japanese_name}
|-
! colspan="4" style="background-color: LightSkyBlue;" | Statistics
|- style="background-color: whitesmoke;"
| style="text-align: center;" | ${icons.hp}
| style="text-align: center;" | ${hp}
| style="text-align: center;" | ${icons.armor}
| style="text-align: center;" | ${armor}
|- style="background-color: whitesmoke;"
| style="text-align: center;" | ${icons.firepower}
| style="text-align: center;" | ${firepower}
| style="text-align: center;" | ${icons.torpedo}
| style="text-align: center;" | ${torpedo}
|- style="background-color: whitesmoke;"
| style="text-align: center;" | ${icons.asw}
| style="text-align: center;" | ${asw}
| style="text-align: center;" | ${icons.aa}
| style="text-align: center;" | ${aa}
|-
! colspan="4" style="background-color: LightSkyBlue;" | '''Equipment'''
|- style="background-color: whitesmoke;"
| colspan="4" style="text-align: center;" | ${slot_details}
|-
| colspan="4" style="padding: 0px;" |<div style="background-color: lightskyblue; cursor: pointer; text-align: center; margin: 0px;" class="mw-customtoggle-extra">'''Extra'''</div>
<div class="mw-collapsible mw-collapsed" id="mw-customcollapsible-extra" style="padding: 2px; font-size: 12px;">
Some notes maybe
</div>
|}]],
}

function EnemyShipInfoMini:name()
	local link, text, section = self._ship:link()
	self._vars.name = Formatting:format_link(link, text, section)
end

function EnemyShipInfoMini:firepower()
	self._vars.firepower = Formatting:format_stat(self._ship:firepower())
end
 
function EnemyShipInfoMini:armor()
	self._vars.armor = Formatting:format_stat(self._ship:armor())
end
 
function EnemyShipInfoMini:torpedo()
	self._vars.torpedo = Formatting:format_stat(self._ship:torpedo())
end

function EnemyShipInfoMini:aa()
	self._vars.aa = Formatting:format_stat(self._ship:aa(), self._ship:aa())
end

function EnemyShipInfoMini:asw()
	self._vars.asw = Formatting:format_stat(self._ship:asw(), self._ship:asw())
end

function EnemyShipInfoMini:slot_details()
	local slots = {}
	for i = 1, self._default_slot_num do
		local num_of_slots, num_of_enabled_slots = self._ship:slots_length(), self._ship:slots()
		local locked = num_of_enabled_slots and i > num_of_enabled_slots
		local icon = ""
		if num_of_slots and i > num_of_slots then

		else
			local equipment, link = self._ship:slot(i), nil
			if equipment then
				icon = equipment:icon()
				link = equipment:link()
			else
				icon = locked and "" or false
			end
			if icon ~= "" then
				icon = Formatting:format_image{Formatting:format_equipment_icon(icon), caption = link, link = link}
			end
		end
		table.insert(slots, icon)
	end
	self._vars.slot_details = table.concat(slots)
end

-- EnemyShipInfoMini.test = EnemyShipInfoMini:Infobox({"Destroyer I-Class"})

return EnemyShipInfoMini