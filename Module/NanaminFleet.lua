local BaseTable = require('Module:BaseTable')
local Ship = require('Module:Ship')
local ShipBattleCardKai = require('Module:ShipBattleCardKai')
local ShipCardKai = require('Module:ShipCardKai')
local Equipment = require('Module:Equipment')
local Formatting = require('Module:Formatting')
local format = require('Module:Core').format

local NanaminFleet = BaseTable({
    _item_class = Ship,
    _equip_class = Equipment,
    _equip_icon_bg = "#8DCDEE",
    _equip_bg = "#E4F3FB",
    _equip_locked_bg = "#CDDBE2",
    _extra_cells_bg = "#98D2F0",
    _table_start = [[{|]],
    _header_template = nil,
    _calculated_cell_template = [[| colspan="6" style="background: ${bg_color}; text-align: center; font-weight: bold;" |Effective Line of Sight: ${elos} // Fighter Power: ${fighter_power}]],
    _added_cell_template = [[| colspan="6" style="background: ${bg_color}; text-align: center; font-weight: bold;" |${content}]],
    _column_cell_templates = {
        ship = [[| rowspan="4" style="background: white;" |${values.ship_card}]],
        equips = [[| style="background: ${values.icon_bg_color}; width: 15px;" |${values.equip_icon}
        | style="background: ${values.equip_bg_color}; width: 175px;text-align: center;" |${values.equip_link}]],
        ship2 = [[| rowspan="4" style="background: white;" |${values.ship_card}]],
        equips2 = [[| style="background: ${values.icon_bg_color}; width: 15px;" |${values.equip_icon}
        | style="background: ${values.equip_bg_color}; width: 175px; text-align: center;" |${values.equip_link}]]
    },
    _columns = {
        "ship",
        "equips",
        "ship2",
        "equips2"
    },
    _blank = "Empty_ship_slot.png",
    _default_size = "120x165px",
    _route = "",
    _elos = 0,
    _fighter_power = 0,
    _hq_lvl = 0
})

function NanaminFleet:create_table_prep()
    self._size = self._args.image_size or self._default_size

    self._hq_lvl = tonumber(self._args["!hq"])
    
    --Get bracket of 5
    self._hq_lvl = self._hq_lvl - (self._hq_lvl % 5) + 5
    if self._hq_lvl % 5 == 0 then
        self._hq_lvl = self._hq_lvl + 5
    end
    
    self._route = self._args["!route"]
end

function NanaminFleet:ship(row)
    local value
    if row[1] == nil or row[1] == "break" then
        return false
    elseif row[1] == false then
        value = Formatting:format_image{self._blank, size = self._size}
    else
        value = ShipCardKai:get{ship = row[1], size = self._size, link = row[1]:link(), caption = row[1]:name()}
    end
    return {values = {ship_card = value}, bg_color = self._transparent, text_align = self._center_align}
end

function NanaminFleet:ship2(row)
    row = {row[3], row[4]}
    return self:ship(row)
end

function NanaminFleet:equips(row)
    local value, icon, equip_bg_color
    if row[2] == false then
        value = "- Unequipped -"
        icon = ""
        equip_bg_color = self._equip_bg
    elseif row[2] == "locked" then
        value = "- Locked -"
        icon = ""
        equip_bg_color = self._equip_locked_bg
    else
        value = Formatting:format_link(row[2]:link())
        icon = Formatting:format_image{Formatting:format_equipment_icon(row[2]:icon()), size = "22x22px"}
        equip_bg_color = self._equip_bg
    end
    return {values = {equip_link = value, equip_icon = icon, icon_bg_color = self._equip_icon_bg, equip_bg_color = equip_bg_color}, bg_color = self._equip_bg, text_align = self._center_align}
end

function NanaminFleet:equips2(row)
    row = {row[3], row[4]}
    return self:equips(row)
end

function NanaminFleet:process_item_key(item_key)
    local split = mw.ustring.find(item_key, '/')
    if split == nil then
        return item_key
    else
        local ship_name = mw.ustring.sub(item_key, 1, split - 1)
        local ship_suffix_and_los = mw.ustring.sub(item_key, split + 1, -1)
        local ship_suffix = mw.ustring.sub(ship_suffix_and_los, 1, mw.ustring.find(ship_suffix_and_los, '/') - 1)
        if ship_suffix == "Regular" then
            ship_suffix = nil
        end
        return ship_name, ship_suffix
    end
end

function NanaminFleet:create_items()
    local row1, row2, row3, row4 = {}, {}, {}, {}
    local ship_item1, ship_item2

    for index, item_key in ipairs(self._args) do
        local item
        
        if item_key == "-" then
            item = false
        elseif item_key == "!-" then
            item = "locked"
        else
            if mw.ustring.find(item_key, '/') then
                item = self._item_class(self:process_item_key(item_key))
                
                if ship_item1 == nil then
                    ship_item1 = item
                else
                    ship_item2 = item
                end
                
                local los = mw.ustring.sub(item_key, mw.ustring.find(item_key, '/') + 1)
                los = tonumber(mw.ustring.sub(los, mw.ustring.find(los, '/') + 1))
                self._elos = self._elos + math.sqrt(los) * 1.69
            else
                item = self._equip_class(self:process_item_key(item_key))
                
                --Calculate the effective LoS and fighter power
                --[[Effective LoS = Dive Bomber LoS x (1.04) + Torpedo Bomber LoS x (1.37)
                + Carrier-based Recon Plane LoS x (1.66) + Recon Seaplane LoS x (2.00)
                + Seaplane Bomber LoS x (1.78) + Small Radar LoS x (1.00) + Large Radar LoS x (0.99)
                + Searchlight LoS x (0.91) + √(base LoS of each ship) * (1.69)
                + (HQ Lv. rounded up to the next multiple of 5) x (-0.61)--]]
                --HQ level portion done just before insertion into table
                local ship = {}
                if (index - 1) % 10 < 5 then
                    ship = ship_item1
                else
                    ship = ship_item2
                end
                local slot_number = (index - 1) % 5
                local multiplier = {
                    [7] = 1.04,
                    [8] = 1.04,
                    [9] = 1.66,
                    [10] = 2.00,
                    [11] = 1.78,
                    [12] = 1.00,
                    [13] = 0.99,
                    [29] = 0.91
                }
                if multiplier[item:type()] ~= nil and item:los() then
                    self._elos = self._elos + (item:los() * multiplier[item:type()])
                end
                if item:type() == 6 or item:type() == 7 or item:type() == 8 or item:type() == 11 then
                    if ship:slot(slot_number) and item:aa() then
                        mw.log("Adding " .. tostring(item:aa()) .. " from " .. ship:name() .. ", slot " .. tostring(slot_number))
                        self._fighter_power = self._fighter_power + math.floor(math.sqrt(select(2, ship:slot(slot_number))) * item:aa())
                    end
                end
            end
        end
        
        local row_number = {1, 1, 2, 3, 4, 1, 1, 2, 3, 4}
        if row_number[index % 10] == 1 then
            table.insert(row1, item)
        elseif row_number[index % 10] == 2 then
            table.insert(row2, "break")
            table.insert(row2, item)
        elseif row_number[index % 10] == 3 then
            table.insert(row3, "break")
            table.insert(row3, item)
        else
            table.insert(row4, "break")
            table.insert(row4, item)
        end
        
        if index % 10 == 0 then
            table.insert(self._items, row1)
            table.insert(self._items, row2)
            table.insert(self._items, row3)
            table.insert(self._items, row4)
            row1, row2, row3, row4 = {}, {}, {}, {}
            ship_item1 = nil
        end
    end
end


function NanaminFleet:create_data_rows()
    for _, item in ipairs(self._items) do
        local row_values = {}
        for _, column in ipairs(self._columns) do
            if type(item) == "string" then
                row_values = item
            else
                local value = self[column](self, item)
                if value then
                    row_values[column] = value
                end
            end
        end
        table.insert(self._data_rows, row_values)
    end
end

function NanaminFleet:build_rows()
	for index, row_values in ipairs(self._data_rows) do
		if row_values ~= "break" then
			table.insert(self._rows, self._row_starter)
			if row_values == "header" then
				table.insert(self._rows, self._header)
			elseif type(row_values) == "table" then
				for _, column in ipairs(self._columns) do
					if row_values[column] then
						table.insert(self._rows, format(self._column_cell_templates[column] or self._cell, row_values[column]))
					end
				end
		    end
		end
    end
    --Anything that's added after the table ends
    table.insert(self._rows, self._row_starter)
    table.insert(self._rows, format{self._calculated_cell_template,
        elos = string.format("%.2f", self._elos - (self._hq_lvl * 0.61)),
        fighter_power = self._fighter_power,
        bg_color = self._extra_cells_bg,
    })
    table.insert(self._rows, self._row_starter)
    table.insert(self._rows, format{self._added_cell_template,
        content = "Route Taken: " .. self._route,
        bg_color = self._extra_cells_bg,
    })
    if self._args["!difficulty"] then
        table.insert(self._rows, self._row_starter)
        table.insert(self._rows, format{self._added_cell_template,
            content = "Difficulty Chosen: " .. self._args["!difficulty"],
            bg_color = self._extra_cells_bg,
        })
    end
    if self._args["!drops"] then
        table.insert(self._rows, self._row_starter)
        --Drops will be a bunch of ship names separated by /
        local drops_str = self._args["!drops"]
        local drops = {}
        while mw.ustring.find(drops_str, '/') do
            local split = mw.ustring.find(drops_str, '/')
            local ship = Ship(mw.ustring.sub(drops_str, 1, split - 1), "")
            local battle_card = ShipBattleCardKai:get{ship = ship, link = ship:link(), caption = ship:name()}
            table.insert(drops, battle_card)
            drops_str = mw.ustring.sub(drops_str, split + 1)
        end
        local ship = Ship(drops_str, "")
        local battle_card = ShipBattleCardKai:get{ship = ship, link = ship:link(), caption = ship:name()}
        table.insert(drops, battle_card)
        
        local content = "Notable Drops<br />"
        for i = 1, #drops do
            content = content .. drops[i] .. " "
            if i % 4 == 0 then
                content = mw.ustring.sub(content, 1, -2)
                content = content .. "<br />"
            end
        end
        table.insert(self._rows, format{self._added_cell_template,
            content = content,
            bg_color = self._extra_cells_bg,
        })
    end
end

return NanaminFleet