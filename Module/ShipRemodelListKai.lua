local BaseTable = require('Module:BaseTable')
local Formatting = require('Module:Formatting')
local ResourceIcons = require('Module:Data/Asset')
local Ship = require('Module:Ship')

local format = require('Module:Core').format

local ShipRemodelListKai = BaseTable{
	_header_template = [[! colspan=6 | Before Remodel
! rowspan=2 style="width:30px;" | ⇒
! colspan=3 | After Remodel
! colspan=3 | Required Resources
|-
! style="width: 50px;" | No.
! style="width: 100px;" | Name
! style="width: 30px;" | Type
! style="width: 30px;" | Level
! style="width: 30px;" | ${blueprint}
! style="width: 30px;" | ${catapult}
! style="width: 50px;" | No.
! style="width: 100px;" | Name
! style="width: 30px;" | Type
! style="width: 30px; text-align: center; vertical-align: middle; background-color: darkgoldenrod;" | ${ammo}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: lightgrey;" | ${steel}
! style="width: 30px;" | ${devmat}]],
	_header_template_bottom = [[! style="width: 50px;" | No.
! style="width: 100px;" | Name
! style="width: 30px;" | Type
! style="width: 30px;" | Level
! style="width: 30px;" | ${blueprint}
! style="width: 30px;" | ${catapult}
! rowspan=2 style="width:30px;" | ⇒
! style="width: 50px;" | No.
! style="width: 100px;" | Name
! style="width: 30px;" | Type
! style="width: 30px; text-align: center; vertical-align: middle; background-color: darkgoldenrod;" | ${ammo}
! style="width: 30px; text-align: center; vertical-align: middle; background-color: lightgrey;" | ${steel}
! style="width: 30px;" | ${devmat}
|-
! colspan=6 | Before Remodel
! colspan=3 | After Remodel
! colspan=3 | Required Resources]],
	_columns = {
		"id",
		"name",
		"type",
		"remodel_level",
		"remodel_blueprint",
		"remodel_catapult",
		"arrow",
		"id_after",
		"name_after",
		"type_after",
		"ammo",
		"steel",
		"devmat",
	},
	_empty_cell = [[| style="text-align: center; vertical-align: middle;" | -]],
	_column_empty_cells = {
		arrow = [[| style="text-align: center; vertical-align: middle;" | ⇒]],
	},
	_item_class = Ship,
	_dash = "-",
	_arrow = "⇒",
	_question_marks = "??",
	_fragment_prefix = "shipremodellistkai",
}

function ShipRemodelListKai:id(ship)
	return {values = {value = Formatting:format_stat(ship:id())}, 
		bg_color = self._transparent, --Formatting:format_ship_back(back), 
		extra_style = "", --Formatting:extra_style_background_image(back and back > 7, back and back > 6) or ""
		text_align = self._center_align
	}
end

function ShipRemodelListKai:name(ship)
	return {values = {value = Formatting:id_span(tostring(ship:api_id() or mw.ustring.lower(mw.ustring.gsub(ship:name(), "%s+", self._dash))), self._fragment_prefix, Formatting:format_link(ship:link()))}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:type(ship)
	return {values = {value = Formatting:format_ship_code(ship:type())}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:remodel_level(ship)
	self._remodel_to = ship:remodel_to()
	local remodel_level = false
	if self._remodel_to then
		if self._remodel_to == ship:remodel_from() then
			self._remodel_is_reversion = true
		else
			self._remodel_is_reversion = false
		end
		self._remodel_to = Ship(self._remodel_to)
		if self._remodel_is_reversion then
			remodel_level = ship:remodel_to_level()
		else			
			remodel_level = self._remodel_to:remodel_level()
		end
	end
	return {values = {value = remodel_level == false and self._dash or Formatting:format_stat(remodel_level)}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:remodel_blueprint(ship)
	local value = self._dash
	if self._remodel_to then
		if self._remodel_is_reversion then
			value = Formatting:format_blueprint_requirement(ship:remodel_to_blueprint(), true)
		else
			value = Formatting:format_blueprint_requirement(self._remodel_to:remodel_blueprint(), true)
		end
	elseif self._remodel_to == nil then
		value = self._question_marks
	end
	return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:remodel_catapult(ship)
	local value = self._dash
	if self._remodel_to then
		if self._remodel_is_reversion then
			value = Formatting:format_catapult_requirement(ship:remodel_to_catapult(), true)
		else
			value = Formatting:format_catapult_requirement(self._remodel_to:remodel_catapult(), true)
		end
	elseif self._remodel_to == nil then
		value = self._question_marks
	end
	return {values = {value = value}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:arrow()
	return {values = {value = self._arrow}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:id_after()
	local id_after = self._remodel_to == nil and self._question_marks or self._dash
	if self._remodel_to then
		id_after = Formatting:format_stat(self._remodel_to:id())
	end
	return {values = {value = id_after}, 
		bg_color = self._transparent, --Formatting:format_ship_back(back), 
		extra_style = "", --Formatting:extra_style_background_image(back and back > 7, back and back > 6) or ""
		text_align = self._center_align
	}
end

function ShipRemodelListKai:name_after()
	local name_after = self._remodel_to == nil and self._question_marks or self._dash
	if self._remodel_to then
		name_after = Formatting:fragment_link(tostring(self._remodel_to:api_id() or mw.ustring.lower(mw.ustring.gsub(self._remodel_to:name(), "%s+", self._dash))), self._fragment_prefix, self._remodel_to:name())
	end
	return {values = {value = name_after}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:type_after()
	local type_after = self._remodel_to == nil and self._question_marks or self._dash
	if self._remodel_to then
		type_after = Formatting:format_ship_code(self._remodel_to:type())
	end
	return {values = {value = type_after}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:ammo(ship)
	local ammo = self._remodel_to == nil and self._question_marks or self._dash
	if self._remodel_to then
		if self._remodel_is_reversion then
			ammo = ship:remodel_to_cost().ammo
		else
			ammo = self._remodel_to:remodel_cost().ammo
		end
	end
	return {values = {value = ammo or self._dash}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:steel(ship)
	local steel = self._remodel_to == nil and self._question_marks or self._dash
	if self._remodel_to then
		if self._remodel_is_reversion then
			steel = ship:remodel_to_cost().steel
		else
			steel = self._remodel_to:remodel_cost().steel
		end
	end
	return {values = {value = steel or self._dash}, bg_color = self._transparent, text_align = self._center_align}
end

function ShipRemodelListKai:devmat(ship)
	local devmat = self._remodel_to == nil and self._question_marks or self._dash
	if self._remodel_to then
		if self._remodel_is_reversion then
			devmat = ship:remodel_to_cost().devmat
		else
			devmat = self._remodel_to:remodel_cost().devmat
		end
	end
	return {values = {value = devmat or self._dash}, bg_color = self._transparent, text_align = self._center_align}
end

ShipRemodelListKai.process_item_key = Ship.process_item_key

ShipRemodelListKai.build_rows = ShipRemodelListKai.build_rows_breaks_as_empty_rows

function ShipRemodelListKai:create_header()
	local header_icons = {
		blueprint = ResourceIcons.blueprint,
		catapult = ResourceIcons.prototype_deck_catapult_item,
		ammo = ResourceIcons.ammo,
		steel = ResourceIcons.steel,
		devmat = ResourceIcons.devmat,
	}
	for key, value in pairs(header_icons) do
		header_icons[key] = Formatting:format_image{value, caption = Formatting:format_resource_name(key), size = (key == "blueprint" or key == "catapult") and "24px" or nil}
	end
	self._header = format(self._header_template, header_icons)
	self._header_bottom = format(self._header_template_bottom, header_icons)
end

return ShipRemodelListKai