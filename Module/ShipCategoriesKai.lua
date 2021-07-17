local BaseData = require('Module:BaseData')
local Formatting = require('Module:Formatting')
local Ship = require('Module:Ship')

local format = require('Module:Core').format

local ShipCategoriesKai = BaseData{
	_type_category_template = "Category:${ship_type}s",
	_stock_equipment_category_template = "Category:Ships with ${equipment_name} as stock equipment",
}

function ShipCategoriesKai:Categories(args)
	return self{
		_args = args
	}:get_categories()
end

function ShipCategoriesKai:create_ship()
	local name = self._args.name or self._args[1]
	if name then
		self._ship = Ship(name, self._args.model)
	end
end

function ShipCategoriesKai:create_static_categories()
	table.insert(self._categories, "Category:Player ships")
end

function ShipCategoriesKai:create_type_categories()
	local ship_type = self._ship:type()
	if ship_type then
		table.insert(self._categories, format{self._type_category_template, ship_type = Formatting:format_ship_type(ship_type)})
	end
end

function ShipCategoriesKai:create_class_categories()
	local ship_class = self._ship:class()
	if ship_class then
		table.insert(self._categories, format{"Category:${ship_class}", ship_class = ship_class:name()})
	end
end

function ShipCategoriesKai:create_rarity_categories()
	local rarity = self._ship:rarity()
	if rarity then
		table.insert(self._categories, format{"Category:${rarity} rarity ships", rarity = Formatting:format_ship_rarity(rarity)})
	end
end

function ShipCategoriesKai:create_construction_categories()
	local buildable, buildable_lsc = self._ship:buildable(), self._ship:buildable_lsc()
	if buildable then
		table.insert(self._categories, format{"Category:Ships buildable in Normal Construction"})
	end
	if buildable_lsc then
		table.insert(self._categories, format{"Category:Ships buildable in Large Ship Construction"})
	end
end

function ShipCategoriesKai:create_remodel_categories()
	if self._ship:remodel_blueprint() then
		table.insert(self._categories, 'Category:Ships that consume Blueprint during remodeling')
	end
	if self._ship:remodel_catapult() then
		table.insert(self._categories, 'Category:Ships that consume Prototype Flight Deck Catapult during remodeling')
	end
	if self._ship:remodel_report() then
		table.insert(self._categories, 'Category:Ships that consume Action Report during remodeling')
	end
	if self._ship:remodel_gunmat() then
		table.insert(self._categories, 'Category:Ships that consume New Model Gun Mount Improvement Material during remodeling')
	end
	if self._ship:remodel_airmat() then
		table.insert(self._categories, 'Category:Ships that consume New Model Aerial Armament Material during remodeling')
	end
	if self._ship:remodel_armament() then
		table.insert(self._categories, 'Category:Ships that consume New Model Armament Material during remodeling')
	end
	if self._ship:remodel_development_material() then
		table.insert(self._categories, 'Category:Ships that consume Development Material during remodeling')
	end
	if self._ship:remodel_construction_material() then
		table.insert(self._categories, 'Category:Ships that consume Instant Construction Material during remodeling')
	end
end

function ShipCategoriesKai:create_stock_equipment_categories()
	local slots = self._ship:slots_length()
	if slots then
		for i = 1, slots do
			local equipment, size = self._ship:slot(i)
			if equipment then
				table.insert(self._categories, format{self._stock_equipment_category_template, equipment_name = equipment:link()})
			end
		end
	end
end

function ShipCategoriesKai:write_categories()
	local links = {}
	for _, category in ipairs(self._categories) do
		table.insert(links, Formatting:format_link(category))
	end
	return table.concat(links)
end

function ShipCategoriesKai:get_categories()
	self._categories = {}
	self:create_ship()
	if self._ship then
		self:create_categories()
	end
	return self:write_categories()
end

function ShipCategoriesKai:create_categories()
	self:create_static_categories()
	self:create_type_categories()
	self:create_class_categories()
	--self:create_rarity_categories()
	self:create_construction_categories()
	self:create_remodel_categories()
	self:create_stock_equipment_categories()
end

return ShipCategoriesKai