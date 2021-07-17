local BaseData = require('Module:BaseData')
local Iterator = require('Module:Iterator')
local format = require('Module:Core').format

local BaseTable = BaseData{
	_table_start = [[{| class="wikitable typography-xl-optout" style="width: -moz-fit-content; width: -webkit-fit-content; width: fit-content;"]],
	_row_starter = "|-",
	_row_starter_with_attributes = [[|- class="${classes}"]],
	_header_template = "",
	_column_header_cell_template = "! ${value}",
	_cell_color = {
	},
	_cell = [[| class="${classes}" colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;" |${values.value}]],
	_empty_cell = [[|]],
	_column_cell_templates = {
	},
	_column_empty_cells = {
	},
	_header1 = "<h2>${value}</h2>",
	_custom_row_class = "custom-row",
	_custom_row_prefix = "custom_row_",
	_classes_suffix = "_classes",
	_text_align_suffix = "_text_align",
	_bg_color_suffix = "_bg_color",
	_content_suffix = "_content",
	_good_stat_color = "#ffff40",
	_outstanding_stat_color = "#73ff4d",
	_bad_stat_color = "#bcbcbc",
	_emphasis_template = "'''${value}'''",
	_transparent = "transparent",
	_left_align = "left",
	_start_align = "start",
	_center_align = "center",
	_none = "none",
	_notes_suffix = "_notes",
	_highlight_suffix = "_highlight",
	_table_end = [[|}]],
	_operators = {
		["<"] = function(x,y) return x < y end,
		[">"] = function(x,y) return x > y end,
	},
}

function BaseTable:Table(args, params)
	return self{
		_args = args,
		_params = params,
	}:create_table()
end

function BaseTable:get_emphasis(value, formatted, operator, good)
	local comparison = self._operators[operator or ">"]
	if value and good and comparison(value, tonumber(good)) then
		return format{self._emphasis_template, value = formatted}
	end
	return formatted
end

function BaseTable:get_bg_color(default, value, operator, outstanding, good, bad)
	if not value then
		return default or self._transparent
	end
	local comparison = self._operators[operator or ">"]
	if outstanding and comparison(value, tonumber(outstanding)) then
		return self._outstanding_stat_color
	elseif good and comparison(value, tonumber(good)) then
		return self._good_stat_color
	elseif bad and not comparison(value, tonumber(bad)) then
		return self._bad_stat_color
	else
		return default or self._transparent
	end
end

function BaseTable.compare_values(val1, val2)
	if #val1 == #val2 then
		for value_type, value in pairs(val1) do
			if value ~= val2[value_type] then
				return false
			end
		end
	else
		return false
	end
	return true
end

function BaseTable:create_header()
	self._header = self._header_template
	self._header_bottom = self._header_template_bottom or self._header_template
end

function BaseTable:process_item_key(item_key)
	return item_key
end

function BaseTable:create_items()
	for index, item_key in ipairs(self._args) do
		if item_key == "-" then
			table.insert(self._items, "break")
		elseif item_key == "~" then
			table.insert(self._items, "empty")
		elseif item_key == "#" then
			table.insert(self._items, "header")
		elseif mw.ustring.sub(item_key, 1, 1) == "!" then
			table.insert(self._items, mw.ustring.sub(item_key, 2))
		else
			local item = self._item_class(self:process_item_key(item_key), self._enemy)
			table.insert(self._items, item)
			local note = self._args[item_key .. self._notes_suffix]
			if note then
				note = {note = note}
				local note_highlight = self._args[item_key .. self._notes_suffix .. self._highlight_suffix]
				if note_highlight then
					note.highlight = note_highlight
				end
				self._notes[item] = note
			end
		end
	end
end

function BaseTable:create_data_rows_plain()
	for _, item in ipairs(self._items) do
		local row_values
		if type(item) == "string" then
			row_values = item
		else
			row_values = {}
			for _, column in ipairs(self._columns) do
				row_values[column] = self[column](self, item)
				row_values[column].rowspan = 1
				row_values[column].colspan = 1
			end
			--check if a row function is defined
			if self.row then
				--get row attributes
				row_values._row = self:row(item)
			end
		end
		table.insert(self._data_rows, row_values)
	end
end

BaseTable.create_data_rows = BaseTable.create_data_rows_plain

--create the data rows, merging cells vertically between rows if they contain the same data values.
function BaseTable:create_data_rows_merge_vertical()
	for index, item in ipairs(self._items) do
		local row_values
		if type(item) == "string" then
			row_values = item
		else
			row_values = {}
			for _, column in ipairs(self._columns) do
				row_values[column] = self[column](self, item)
			end
			if index > 1 then
				--This row is not the first row, we have to look at previous rows to determine if we need to merge vertically adjacent cells.
				for _, column in ipairs(self._columns) do
					--Look on a column basis
					for i=index-1,1,-1 do
						--Starting at the previous row and going to the first row.
						local previous_row = self._data_rows[i]
						local previous_row_is_data = type(previous_row) ~= "string"
						local previous_cell = previous_row_is_data and previous_row[column] or false
						if previous_cell then
							--The previous row has a cell in the column to compare with
							if self.compare_values(row_values[column].values, previous_cell.values) then
								--The cell values in the column are identical, extend the previous cell's rowspan
								--and clear the cell value in the current row to merge them
								previous_cell.rowspan = previous_cell.rowspan + 1
								row_values[column] = nil
							else
								--Values don't match, set rowspan and colspan to 1 to start a new cell.
								row_values[column].rowspan = 1
								row_values[column].colspan = 1
							end
							--We've found the previous row that has a cell in the column, no need to look further.
							break
						elseif not previous_row_is_data then
							--Previous row is not data, so we set rowspan and colspan to one to start a new cell.
							row_values[column].rowspan = 1
							row_values[column].colspan = 1
							break
						end
					end
				end
			else
				--This row is the first row, we have no previous rows to look at, so set rowspan and colspan for all cells to 1 to start new cells.
				for _, column in ipairs(self._columns) do
					row_values[column].rowspan = 1
					row_values[column].colspan = 1
				end
			end
			--check if a row function is defined
			if self.row then
				--get row attributes
				row_values._row = self:row(item)
			end
		end
		table.insert(self._data_rows, row_values)
	end
end

function BaseTable:start_rows()
	self._rows = {self._table_start}
	if not self._args.no_header and self._header then
	    table.insert(self._rows, self._header)
    end
end

function BaseTable:build_rows()
	for index, row_values in ipairs(self._data_rows) do
		if row_values ~= "break" then
			if row_values == "header" then
			    if self._row_starter then
				    table.insert(self._rows, self._row_starter)
			    end
				if self._header then
				    table.insert(self._rows, self._header)
				end
		    elseif row_values == "empty" then
		        if self._row_starter then
				    table.insert(self._rows, self._row_starter)
				end
				for _, column in ipairs(self._columns) do
					table.insert(self._rows, self._column_empty_cells[column] or self._empty_cell)
				end
			elseif type(row_values) == "table" then
				if row_values._row then
				    if self._row_starter_with_attributes then
					    table.insert(self._rows, format(self._row_starter_with_attributes, row_values._row))
					end
				else
				    if self._row_starter then
					    table.insert(self._rows, self._row_starter)
					end
				end
				for _, column in ipairs(self._columns) do
					if row_values[column] then
						table.insert(self._rows, format(self._column_cell_templates[column] or self._cell, row_values[column]))
					end
				end
			else
				self:append_custom_row(row_values)
			end
		end
	end
end

--deprecated
function BaseTable:build_rows_breaks_as_empty_rows()
	for index, row_values in ipairs(self._data_rows) do
	    if self._row_starter then
		    table.insert(self._rows, self._row_starter)
		end
		if row_values == "break" then
			for _, column in ipairs(self._columns) do
				table.insert(self._rows, self._column_empty_cells[column] or self._empty_cell)
			end
		elseif row_values == "header" and self._header then
			table.insert(self._rows, self._header)
		elseif type(row_values) == "table" then
			for _, column in ipairs(self._columns) do
				if row_values[column] then
					table.insert(self._rows, format(self._column_cell_templates[column] or self._cell, row_values[column]))
				end
			end
		else
			self:append_custom_row(row_values)
		end
	end
end

function BaseTable:append_custom_row(custom_row_key)
    if mw.ustring.sub(custom_row_key, 1, 1) == "#" then
        local value = mw.ustring.sub(custom_row_key, 2)
        if not self._disable_row_starter and self._row_starter then
		    table.insert(self._rows, self._row_starter)
		end
        table.insert(self._rows, format{
            self._cell,
			colspan = #self._columns, rowspan = 1,
			classes = self._custom_row_class,
			text_align = self._left_align,
			bg_color = self._transparent,
			values = {
				value = format{
		            self._header1,
		            value = value
                }
			},
		})
		if not self._disable_row_starter and self._row_starter then
	        table.insert(self._rows, self._row_starter)
	    end
	    if not self._disable_row_starter and self._header then
            table.insert(self._rows, self._header)
        end
	elseif self._custom_rows and self._custom_rows[custom_row_key] then
		if type(self._custom_rows[custom_row_key]) == "table" then
		    if self._row_starter_with_attributes then
			    table.insert(self._rows, format(self._row_starter_with_attributes, self._custom_rows[custom_row_key].row or {}))
			end
			table.insert(self._rows, self._custom_rows[custom_row_key].content)
		else
		    if self._row_starter then
			    table.insert(self._rows, self._row_starter)
			end
			table.insert(self._rows, self._custom_rows[custom_row_key])
		end
    else
        if self._row_starter then
		    table.insert(self._rows, self._row_starter)
		end
		local classes = self._args[self._custom_row_prefix .. custom_row_key .. self._classes_suffix]
		if classes then
		    classes = " " .. classes
		else
		    classes = ""
		end
		table.insert(self._rows, 
			format{self._column_cell_templates["!"] or self._cell, 
				colspan = #self._columns, rowspan = 1, 
				classes = self._custom_row_class .. classes,
				text_align = self._args[self._custom_row_prefix .. custom_row_key .. self._text_align_suffix] or self._start_align, 
				bg_color = self._args[self._custom_row_prefix .. custom_row_key .. self._bg_color_suffix] or self._transparent,
				values = {
					value = self._args[self._custom_row_prefix .. custom_row_key .. self._content_suffix] or "",
				},
			}
		)
	end
end

function BaseTable:finish_rows()
    if not self._args.no_header_bottom then
        if self._row_starter then
	        table.insert(self._rows, self._row_starter)
	    end
	    if self._header_bottom or self._header then
	        table.insert(self._rows, self._header_bottom or self._header)
	    end
    end
	table.insert(self._rows, self._table_end)
end

function BaseTable:join_rows()
	self._result = table.concat(self._rows, "\n")
end

function BaseTable:prepare_iterator()
    local buildIterator = Iterator[self._args.iterator]
    if buildIterator then
        local iterator = buildIterator(self._args)
        while iterator.next() do
            table.insert(self._args, iterator.current())
        end
    end
    buildIterator = Iterator[self._args.iterator2]
    if buildIterator then
        table.insert(self._args, "#")
        local iterator = buildIterator(self._args, 2)
        while iterator.next() do
            table.insert(self._args, iterator.current())
        end
    end
end

function BaseTable:create_table_prep()
	return
end

function BaseTable:create_items_post()
	return
end

function BaseTable:post_process()
	return
end

function BaseTable:create_table()
	self._items = {}
	self._notes = {}
	self._data_rows = {}
	self:prepare_iterator()
	self:create_table_prep()

	self:create_items()
	self:create_items_post()
	self:create_data_rows()
	self:create_header()

	self:start_rows()
	self:build_rows()
	self:finish_rows()
	self:join_rows()
	self:post_process()
	return self._result
end

return BaseTable