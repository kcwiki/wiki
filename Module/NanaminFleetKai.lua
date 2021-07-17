local getArgs = require('Module:GetArgs')

local Ship = require('Module:Ship')
local ShipBattleCardKai = require('Module:ShipBattleCardKai')
local ShipCardKai = require('Module:ShipCardKai')
local Equipment = require('Module:Equipment')

local Formatting = require('Module:Formatting')
local format = require('Module:Core').format

local Functions = require('Module:NanaminFunctions')

local NanaminFleetKai = {
    _rows = {},
    _items = {},
    
    _collapse_button_template = [[<div class="mw-customtoggle-${id} wikia-menu-button">Click this button to view the fleet</div>]],
    _collapse_div_start = [[<div id="mw-customcollapsible-${id}" class="mw-collapsible mw-collapsed">]],
    _collapse_div_end = [[</div>]],
    
    _table_start = [[<table class="nanaminfleetkai">]],
    _table_end = [[</table>]],
    _row_starter = [[</tr><tr>]],
    _added_cell_template = [[<td colspan="6" style="background-color:${bg_color};">'''${content}'''</td>]],
    _ship_template = [[<td rowspan="4">${ship_card}</td>]],
    _equip_template = [[<td>${equip_icon}</td><td style="${style}">${equip_link}</td>]],
    _blank_entry = [[<td style="display:none;"></td>]],
    
    _header_bg = "#98D2F0",
    _equip_locked_bg = "#CDDBE2",
    _extra_cells_bg = "#98D2F0",
    
    _blank = "Empty_ship_slot.png",
    _size = "120x165px",
    
    _id = "",
    _elos = 0,
    _fighter_power = 0,
    _hq_lvl = 0,
}

function NanaminFleetKai:process_hq_level()
    self._hq_lvl = tonumber(self._args["hq"] or 0)
    
    --Get bracket of 5
    self._hq_lvl = self._hq_lvl - (self._hq_lvl % 5) + 5
    if tonumber(self._args["hq"] or 0) % 5 == 0 then
        self._hq_lvl = self._hq_lvl + 5
    end
end

function NanaminFleetKai:generate_id()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()
    self._id = self._args["route"]:gsub("[^%w]", "") .. (self._args["hq"] or "0") .. tostring(math.random(1000000,9999999))
end

function NanaminFleetKai:process_los(entry)
    local ship = Ship(entry[1], entry[2] ~= "/" and entry[2] or "")
    local los = ship:los() or 0
    local los_max = ship:los_max() or los
    if self._args["use_los"] then
        los = tonumber(entry[3]) or 0
    else
        los = math.floor(los + ((los_max - los) * tonumber(entry[3]) / 99))
    end
    self._elos = self._elos + math.sqrt(los) * 1.69
end

function NanaminFleetKai:process_args(args)
    local entry = {}
    for index, item in ipairs(args) do
        if mw.ustring.sub(item, 1, 1) == "#" then
            table.insert(self._items, mw.ustring.sub(item, 2))
        elseif item == "-" and #entry > 0 then
            self:process_los(entry)
            table.insert(self._items, entry)
            entry = {}
        else
            local processed = Functions.split(item, '/')
            for _, item in ipairs(processed) do
                table.insert(entry, item)
            end
        end
    end
    if #entry > 0 then
        self:process_los(entry)
        table.insert(self._items, entry)
    end
end

function NanaminFleetKai:process_equipment(equip, plane_count)
    local multiplier = { [7] = 1.04, [8] = 1.04, [9] = 1.66, [10] = 2.00, [11] = 1.78, [12] = 1.00, [13] = 0.99, [29] = 0.91 }
    if multiplier[equip:type()] ~= nil and equip:los() then
        self._elos = self._elos + (equip:los() * multiplier[equip:type()])
    end
    local can_fight = { [6] = true, [7] = true, [8] = true, [11] = true }
    if can_fight[equip:type()] then
        if plane_count and equip:aa() then
            self._fighter_power = self._fighter_power + math.floor(math.sqrt(plane_count) * equip:aa())
        end
    end
end

function NanaminFleetKai:insert_ship_row(ship)
    local ship_card
    if self._args["text_only"] then
        ship_card = ship and ship:name() or "Invalid Ship Name"
    elseif ship and ship:name() then
        ship_card = ShipCardKai:get{ship = ship, size = self._size, link = ship:link(), caption = ship:name()}
    else
        ship_card = Formatting:format_image{self._blank, size = self._size}
    end
    table.insert(self._rows, format{self._ship_template, ship_card = ship_card})
end

function NanaminFleetKai:insert_equip_row(ship, entry, slot)
    local slots = ship and ship:slots() or 0
    local equip_icon, equip_link, style
    if slot > slots then
        equip_link = "- Locked -"
        style = "background-color:" .. self._equip_locked_bg .. ";"
    elseif entry[slot + 3] == nil then
        equip_link = "- Unequipped -"
        style = "background-color:" .. self._equip_locked_bg .. ";"
    else
        local equip = Equipment(Functions.process_legacy_name(entry[slot + 3]))
        self:process_equipment(equip, select(2, ship:slot(slot)))
        if self._args["text_only"] then
            equip_link = Functions.shorten_name("", equip:name())
        else
            equip_icon = Formatting:format_image{ Formatting:format_equipment_icon(equip:icon()), size = "22x22px", link = "" }
            equip_link = Formatting:format_link(Functions.shorten_name(equip:link()))
        end
    end
    table.insert(self._rows, format{self._equip_template,
        equip_icon = equip_icon or "",
        style = style or "",
        equip_link = equip_link,
    })
end

function NanaminFleetKai:add_header(content)
    table.insert(self._rows, self._row_starter)
    table.insert(self._rows, format{self._added_cell_template, content = content, bg_color = self._header_bg })
    table.insert(self._rows, self._row_starter)
end

function NanaminFleetKai:build_table()
    local i = 1
    while i <= #self._items do
        if type(self._items[i]) == "string" then
            self:add_header(self._items[i])
            i = i + 1
        end
        local ship1 = Ship(self._items[i][1], self._items[i][2] ~= "/" and self._items[i][2] or "")
        self:insert_ship_row(ship1)
        self:insert_equip_row(ship1, self._items[i], 1)
        
        if type(self._items[i + 1]) == "string" then
            --self:add_header(self._items[i])
            i = i + 1
        end
        local ship2
        if self._items[i + 1] then
            if self._items[i + 1][2] then self._items[i + 1][2] = self._items[i + 1][2]:gsub('/', '') end
            ship2 = Ship(self._items[i + 1][1], self._items[i + 1][2])
            self:insert_ship_row(ship2)
            self:insert_equip_row(ship2, self._items[i + 1], 1)
        else
            self:insert_ship_row(nil)
            self:insert_equip_row(nil, nil, 1)
        end
        
        for j = 2, 4 do
            table.insert(self._rows, self._row_starter)
            table.insert(self._rows, self._blank_entry)
            self:insert_equip_row(ship1, self._items[i], j)
            if self._items[i + 1] then
                table.insert(self._rows, self._blank_entry)
                self:insert_equip_row(ship2, self._items[i + 1], j)
            else
                table.insert(self._rows, self._blank_entry)
                self:insert_equip_row(nil, nil, 1)
            end
        end
        table.insert(self._rows, self._row_starter)
        i = i + 2
    end
end

function NanaminFleetKai:insert_extra(content)
    table.insert(self._rows, self._row_starter)
    table.insert(self._rows, format{self._added_cell_template, content = content, bg_color = self._extra_cells_bg })
end

function NanaminFleetKai:add_extras()
    local elos = string.format("%.2f", self._elos - (self._hq_lvl * 0.61))
    if not self._args["hq"] then elos = elos .. " #ERROR:MissingHQ" end
    local content = "Effective Line of Sight: " .. elos .. " // Fighter Power: " .. tostring(self._fighter_power)
    self:insert_extra(content)
    
    content = "Route Taken: " .. (self._args["route"] or "")
    self:insert_extra(content)
    
    if self._args["difficulty"] then
        self:insert_extra("Difficulty Chosen: " .. self._args["difficulty"])
    end
    
    if self._args["drops"] then
        local drops = Functions.split(self._args["drops"], '/')
        content = "Notable Drops<br />"
        for i = 1, #drops do
            local ship = Ship(drops[i], "")
            local card = ShipBattleCardKai:get{ship = ship, link = ship:link(), caption = ship:name()}
            if self._args["text_only"] then
                card = ship:name()
                content = content .. "*"
            end
            content = content .. card .. " "
            if i % 3 == 0 then
                content = mw.ustring.sub(content, 1, -2) .. "<br />"
            end
        end
        self:insert_extra(content)
    end
end

function NanaminFleetKai:Main(args)
    self._args = args
    
    self:process_hq_level()
    self:process_args(args)
    self:generate_id()
    table.insert(self._rows, format{self._collapse_button_template, id = self._id})
    table.insert(self._rows, format{self._collapse_div_start, id = self._id})
    table.insert(self._rows, self._table_start)
    table.insert(self._rows, "<tr>")
    self:build_table()
    self:add_extras()
    table.insert(self._rows, "</tr>")
    table.insert(self._rows, self._table_end)
    table.insert(self._rows, self._collapse_div_end)
    return table.concat(self._rows, "\n")
end

function NanaminFleetKai.Begin(frame)
	local args = getArgs{frame = frame:getParent()}
	return NanaminFleetKai:Main(args)
end

return NanaminFleetKai