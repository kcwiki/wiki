local BaseData = require('Module:BaseData')
local Formatting = require('Module:Formatting')
local Equipment = require('Module:Equipment')

local format = require('Module:Core').format

local EquipmentCategoriesKai = BaseData{
	_type_category_template = "Category:${equipment_type}",
	_gun_fit_group_template = "Category:Guns in ${fit_group} fit group",
}

function EquipmentCategoriesKai:Categories(args)
	return self{
		_args = args
	}:get_categories()
end

function EquipmentCategoriesKai:create_equipment()
	local name = self._args.name or self._args[1]
	if name then
		self._equipment = Equipment(name)
	end
end

function EquipmentCategoriesKai:create_static_categories()
	table.insert(self._categories, "Category:Player equipment")
end

function EquipmentCategoriesKai:create_type_categories()
	local equipment_type = self._equipment:type()
	if equipment_type then
		table.insert(self._categories, format{self._type_category_template, equipment_type = Formatting:format_equipment_type_plural(equipment_type)})
	end
	if equipment_type == 3 or equipment_type == 38 then
		local fit_group = self._equipment:gun_fit_group()
		if fit_group then
			table.insert(self._categories, format{self._gun_fit_group_template, fit_group = fit_group})
		end
	end
end

function EquipmentCategoriesKai:create_rarity_categories()
	local rarity = self._equipment:rarity()
	if rarity then
		table.insert(self._categories, format{"Category:${rarity} rarity equipment", rarity = Formatting:format_equipment_rarity(rarity)})
	end
end

function EquipmentCategoriesKai:create_obtainability_categories()
	local buildable, improvable, obtainable_through_upgrade = self._equipment:buildable(), self._equipment:improvement_products(), self._equipment:improvement_from()
	if buildable then
		table.insert(self._categories, format{"Category:Equipment buildable in Development"})
	end
	if improvable then
		table.insert(self._categories, format{"Category:Equipment improvable in Akashi's Improvement Arsenal"})
	end
	if obtainable_through_upgrade then
		table.insert(self._categories, format{"Category:Equipment obtainable by upgrade through Akashi's Improvement Arsenal"})
	end
end

function EquipmentCategoriesKai:write_categories()
	local links = {}
	for _, category in ipairs(self._categories) do
		table.insert(links, Formatting:format_link(category))
	end
	return table.concat(links)
end

function EquipmentCategoriesKai:get_categories()
	self._categories = {}
	self:create_equipment()
	if self._equipment then
		self:create_categories()
	end
	return self:write_categories()
end

function EquipmentCategoriesKai:create_categories()
	self:create_static_categories()
	self:create_type_categories()
	--self:create_rarity_categories()
	self:create_obtainability_categories()
end

return EquipmentCategoriesKai