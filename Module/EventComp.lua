local getArgs = require('Module:GetArgs')

local BaseTable = require('Module:BaseTable')
local Ship = require('Module:Ship')
local Equipment = require('Module:Equipment')
local Formatting = require('Module:Formatting')
local format = require('Module:Core').format

local EventComp = {
    _item_class = Ship,
    _equip_class = Equipment,
    _table_start = [[{| style="border-collapse: collapse;"]],
    _header_template = [[]],
    _column_cell_templates = {
        ship = [[| rowspan="${rowspan}" style="border-bottom: 1px solid grey;" |${values.ship}]],
        level = [[| rowspan="${rowspan}" style="width: 100px; text-align: center; border-bottom: 1px solid grey;" |${values.level}]],
        equipment = [[| style="${style}" |${equip_name}]],
    },
    _columns = {
        "ship",
        "level",
        "equipment",
    },

    _blank_battle_card = "Empty card.png",
    
    _fighter_power = 0,
    _elos = 0,
}

function EventComp:ship(entry)
    return { values = { ship = Formatting:format_image{entry.ship:battle_card() or self._blank_battle_card, link = entry.ship:link(), caption = entry.ship:name() } }, rowspan = #entry.equips }
end

function EventComp:level(entry)
    return { values = { level = entry.level }, rowspan = #entry.equips }
end

function EventComp:equipment(entry)
    return entry.equips
end

function EventComp:process_hq_level()
    local bracket = tonumber(self._args['hq'] or 0)
 
    --Get bracket of 5
    bracket = bracket - (bracket % 5) + 5
    if tonumber(hq_level or 0) % 5 == 0 then
        bracket = bracket + 5
    end
 
    self._elos = -(bracket * 0.61)
end

function EventComp:process_equipment(equip, planes)
    --Fighter power
    --Only fighter planes, dive bombers, torpedo bombers and seaplane bombers with an AA stat are counted
    local types_allowed = { [6] = true, [7] = true, [8] = true, [11] = true }
    if types_allowed[equip:type()] and equip:aa() then
        self._fighter_power = self._fighter_power + math.floor(math.sqrt(planes or 0) * equip:aa())
    end
    
    --Effective Line of Sight
    local multiplier = { [7] = 1.04, [8] = 1.04, [9] = 1.66, [10] = 2.00, [11] = 1.78, [12] = 1.00, [13] = 0.99, [29] = 0.91 }
    if multiplier[equip:type()] ~= nil and equip:los() then
        self._elos = self._elos + (equip:los() * multiplier[equip:type()])
    end
end

function EventComp:build_items()
    local entry = {
        ship = nil,
        level = nil,
        equips = {},
    }
    for index, item_key in ipairs(self._args) do
        if index == #self._args then
            table.insert(entry.equips, self._equip_class(item_key))
            table.insert(self._items, entry)
        elseif item_key == "-" then
            table.insert(self._items, entry)
            
            entry = {
                ship = nil,
                level = nil,
                equips = {},
            }
        elseif entry.ship and entry.level then
            local equip = self._equip_class(item_key)
            table.insert(entry.equips, equip)
            self:process_equipment(equip, select(2, entry.ship:slot(#entry.equips)))
        elseif entry.ship then
            entry.level = tonumber(item_key)
            
            --Perform eLoS calculation
            local los = entry.ship:los() or 0
            local los_max = entry.ship:los_max() or los
            los = math.floor(los + ((los_max - los) * entry.level / 99))
            self._elos = self._elos + math.sqrt(los) * 1.69
        else
            entry.ship = self._item_class(item_key)
        end
    end
end

function EventComp:build_data_rows()
    for _, item in ipairs(self._items) do
        local row_values = {}
        for _, column in ipairs(self._columns) do
            row_values[column] = self[column](self, item)
        end
        table.insert(self._data_rows, row_values)
    end
end

function EventComp:build_rows()
    for _, row_values in ipairs(self._data_rows) do
        for _, column in ipairs(self._columns) do
            if column == "equipment" then
                for index, equip in ipairs(row_values[column]) do
                    local values = { equip_name = Formatting:format_link(equip:link()), style = "" }
                    if index == #row_values[column] then values.style = "border-bottom: 1px solid grey;" end
                    table.insert(self._rows, "| style=\"" .. values.style .. "\" |" .. Formatting:format_image{Formatting:format_equipment_icon(equip:icon()), size = '20px'})
                    table.insert(self._rows, format(self._column_cell_templates[column], values))
                    table.insert(self._rows, "|-")
                end
            else
                table.insert(self._rows, format(self._column_cell_templates[column], row_values[column]))
            end
        end
    end
end

--If this isn't separate, "frame" is nil and gives an error when testing with the debug console
function EventComp:Main(args)
    self._args = args
    self._items = {}
    self._data_rows = {}
    self._rows = { [[{| style="border-collapse: collapse;"]] }
    self:process_hq_level()
    
    self:build_items()
    self:build_data_rows()
    self:build_rows()
    table.insert(self._rows, "|}")
    
    table.insert(self._rows, "HQ level: " .. self._args['hq'] .. "<br />")
    table.insert(self._rows, "Fighter Power: " .. self._fighter_power .. "<br />")
    table.insert(self._rows, "eLoS: " .. string.format("%.2f", self._elos))
    
    return table.concat(self._rows, '\n')
end

function EventComp.Build(frame)
    local args = getArgs{frame = frame:getParent()}
    return EventComp:Main(args)
end

return EventComp