local EquipmentGraphicKai = require('Module:EquipmentGraphicKai')
local EquipmentInfoKai = require('Module:EquipmentInfoKai')
local Tabber = require('Module:Tabber')
local Equipment = require('Module:Equipment')

local EnemyEquipmentInfoKai = EquipmentInfoKai{
	_enemy = true,
	_template = [[{|class="${table_class}" id="${table_id}" style="border: 1px solid darkgray; width: 380px; background-color: #fafafa;${float}"
|-
| colspan="2" style="position: relative; padding: 1px 40px; text-align: center; background-color: ${back};${extra_style};" title="${rarity}" | <div style="position: absolute; right: 5px;">${edit_link}</div>
<p style="font-size: 20px;">'''${name}'''</p>${localized_name}
<p>'''No.${id} ${japanese_name}'''</p>
|-
| colspan="2" style="text-align: center; background-color: whitesmoke;" |
<div>${icon} <b>${eq_type}</b></div>
<p><b>Effects: ${effects}</b></p>
<div>${buildable}</div>${alternative_names}
|- 
| colspan="2" style="text-align: center;" | ${card}
|-
| colspan="2" style="text-align: center; background-color: LightSkyBlue;" | '''Refittable Class'''
${compatibility_details}
|}]],
	_plane_types = {
		[6] = true,
		[7] = true,
		[8] = true,
		[9] = true, -- LBAS only
		[10] = true, -- LBAS only
		[11] = true,
		[41] = true, -- LBAS only
		[47] = true,
	},
	_abyssal_equipment_label = "''Abyssal Equipment''",
}

function EnemyEquipmentInfoKai:get_module()
	self._equipment_data_module = Equipment:get_module(self._args.name or self._args[1], 'EnemyEquipment')
end

function EnemyEquipmentInfoKai:image()
	self._vars.card = EquipmentGraphicKai:get{equip = self._equipment, size = '350px'}
	if self._plane_types[self._equipment:type()] then
		local tabber = Tabber()
		tabber:add_tab("Equipment", self._vars.card)
		tabber:add_tab("Flying", EquipmentGraphicKai:get{equip = self._equipment, flying = true})
		self._vars.card = tostring(tabber)
	end
end

function EnemyEquipmentInfoKai:crafting()
	self._vars.buildable = self._abyssal_equipment_label
end

return EnemyEquipmentInfoKai