local ShipCategoriesKai = require('Module:ShipCategoriesKai')

--local format = require('Module:Core').format

local EnemyShipCategoriesKai = ShipCategoriesKai{
	_type_category_template = "Category:Abyssal ${ship_type}s",
	_stock_equipment_category_template = "Category:Enemy ships with ${equipment_name} as equipment",
}

function EnemyShipCategoriesKai:create_static_categories()
	table.insert(self._categories, "Category:Enemy ships")
end

--function EnemyShipCategoriesKai:create_class_categories()
--	local ship_class = self._ship:base_name()
--	if ship_class then
--		table.insert(self._categories, format{"Category:${ship_class}", ship_class = ship_class})
--	end
--end

function EnemyShipCategoriesKai:create_categories()
	self:create_static_categories()
	self:create_type_categories()
	--self:create_class_categories()
	--self:create_rarity_categories()
	--self:create_construction_categories()
	--self:create_remodel_categories()
	self:create_stock_equipment_categories()
end

return EnemyShipCategoriesKai