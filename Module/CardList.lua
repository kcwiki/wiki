local BaseTable = require('Module:BaseTable')
local Formatting = require('Module:Formatting')

local CardList = BaseTable{
	_table_start = [[{| class="wikitable typography-xl-optout" style="width: -moz-max-content; width: -webkit-max-content; width: max-content;"]],
	_row_starter = "",
	_header_template = nil,
	_cell = [[${values.value}]],
}

function CardList:create_table_prep()
	self._size = self._args.image_size or self._default_size
	self._columns = {}
	if self._args.column_count then
	    if self._args.column_count == "false" then
	        self._column_count = false
	    else
	        self._column_count = tonumber(self._args.column_count)
	    end
    end
    if self._column_count then
    	for i=1, self._column_count do
    	    table.insert(self._columns, i)
    	end
    end
end

function CardList:start_rows()
	self._rows = {}
end

function CardList:finish_rows()
	return
end

function CardList:process_item_key(item_key)
	local split = mw.ustring.find(item_key, '/')
	local ship_base_name, ship_suffix
	if split == nil then
		ship_base_name = item_key
	else
		ship_base_name = mw.ustring.sub(item_key, 1, split - 1)
		ship_suffix = mw.ustring.sub(item_key, split + 1, -1)
	end
	return ship_base_name, ship_suffix
end

function CardList:create_items()
	local count = 0
	local row = {}
	for index, item_key in ipairs(self._args) do
		if mw.ustring.sub(item_key, 1, 1) == "!" then
		    if self._column_count then
    			local filled = #row
    			if filled ~= 0 then
    				for i=1, self._column_count - filled do
    					table.insert(row, false)
    				end
    				table.insert(self._items, row)
    				row = {}
    				for i=1, filled do
    					table.insert(row, false)
    				end
			    end
		    end
			table.insert(self._items, mw.ustring.sub(item_key, 2))
	    elseif not self._column_count and item_key == "~" then
	        table.insert(self._items, row)
	        row = {}
	        count = 0
		else				
			count = count + 1
			local item
			if item_key == "-" then
				item = false
			else
				item = self._item_class(self:process_item_key(item_key))
			end
			table.insert(row, item)
			if self._column_count and (count % self._column_count == 0) then
				table.insert(self._items, row)
				row = {}
			elseif not self._column_count then
			    self._max_columns = math.max(self._max_columns or 0, count)
			end
		end
	end
	if #row > 0 then
		if self._column_count then
    		for i=1, self._column_count - #row do
    			table.insert(row, false)
    		end
		end
		table.insert(self._items, row)
	end
    if not self._column_count then
    	for i=1, self._max_columns do
    	    table.insert(self._columns, i)
    	end
    end
end

function CardList:create_data_rows()
	for _, item in ipairs(self._items) do
		local row_values
		if type(item) == "string" then
			row_values = item
		else
			row_values = {}
			for _, column in ipairs(self._columns) do
			    if self._column_count or item[column] then
    				row_values[column] = self:card(item[column])
    				row_values[column].rowspan = 1
    				row_values[column].colspan = 1
    			end
			end
		end
		table.insert(self._data_rows, row_values)
	end
end

return CardList