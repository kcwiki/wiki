local getArgs = require('Module:GetArgs')

local Ship = require('Module:Ship')
local Formatting = require('Module:Formatting')
local format = require('Module:Core').format

local NanaminShipInfo = {
    _sorted_entries = {},
    _rows = {},
    
    _table_start = [[{| style="width: 100%; text-align: center;"]],
    _row_starter = "|-",
    _table_end = [[|}]],
    _ship_card_template = [[| style="width: 40%; padding-left: 5%; border-left: 1px solid lightblue;" |<div class="mw-customtoggle-${class}">${ship_card}</div>]],
    _level_template = [[| style="width: 10%;" |${level}]],
    _embedded_start = [[| colspan="2" |]],
    _embedded_table = [[{| class="mw-collapsible mw-collapsed" id="mw-customcollapsible-${name}" style="width: 100%; text-align: left; padding-left: 10%;"
    | <b>Class</b>: ${class}
    |-
    | <b>Extra Leveling</b>: ${extra_levels}
    |-
    | <b>Notes</b>: ${notes}
    |}]],
}

function NanaminShipInfo:sort_arguments(args)
    --Support two methods of entry:
    ---Each value on a separate line
    ---Each value on the same line, separated by slashes
    --Name/Remodel/Level/Extra Leveling
    local entry = {}
    for _, item in ipairs(args) do
        if item == "-" and #entry > 2 then
            local ship = Ship(entry[1], entry[2])
            local types = {
                [2] = "Destroyer",
                [3] = "Light Cruiser",
                [4] = "Light Cruiser",
                [5] = "Heavy Cruiser",
                [6] = "Heavy Cruiser",
                [7] = "Carrier",
                [8] = "Battleship",
                [9] = "Battleship",
                [10] = "Battleship",
                [11] = "Carrier",
                [12] = "Battleship",
                [13] = "Submarine",
                [14] = "Submarine",
                [18] = "Carrier",
            }
            if ship:type() then
                local type = types[ship:type()] or "Other"
                if not self._sorted_entries[type] then
                    self._sorted_entries[type] = {}
                end
                table.insert(self._sorted_entries[type], { [1] = ship, [2] = tonumber(entry[3]), [3] = entry[4], [4] = entry[5] })
            end
            
            entry = {}
        else
            while mw.ustring.find(item, '/') do
                local split = mw.ustring.find(item, '/')
                local new_entry = mw.ustring.sub(item, 1, split - 1)
                if new_entry == "-" then new_entry = "" end
                table.insert(entry, new_entry)
                item = mw.ustring.sub(item, split + 1)
            end
            if item == "-" then item = "" end
            table.insert(entry, item)
        end
    end
end

function NanaminShipInfo:embed_table(entry)
if entry[3] == "" then entry[3] = "N/A" end
local name = entry[1]:nick() and entry[1]:nick() or entry[1]:name()
table.insert(self._rows, self._embedded_start)
table.insert(self._rows, format{self._embedded_table,
    name = name:gsub(" ", ""),
    class = entry[1]:class():name(),
    extra_levels = entry[3] or "N/A",
    notes = entry[4] or "None",
})
end

function NanaminShipInfo:build_table(class, remove_headers)
    if self._sorted_entries[class] ~= nil or class == "All" then
        if not remove_headers then
            table.insert(self._rows, [[<div style="text-align: center;">]])
            table.insert(self._rows, "=" .. class .. "s=")
            table.insert(self._rows, [[</div>]])
        end
        table.insert(self._rows, self._table_start)
        
        local entries = {}
        if class == "All" then
            for ship_type, entry_table in pairs(self._sorted_entries) do
                for _, entry in pairs(entry_table) do
                    table.insert(entries, entry)
                end
            end
        else
            entries = self._sorted_entries[class]
        end
        table.sort(entries, function(a, b) return a[2] < b[2] end)
        local count = 0
        for a = #entries, 1, -1 do
            count = count + 1
            
            local name = entries[a][1]:nick() and entries[a][1]:nick() or entries[a][1]:name()
            local image = string.gsub(entries[a][1]:battle_card(), "FastBB", "BC")
            table.insert(self._rows, format{self._ship_card_template,
                class = name:gsub(" ", ""),
                ship_card = Formatting:format_image{image, align = "left", valign = "center"},
            })
            table.insert(self._rows, format{self._level_template,
                level = entries[a][2],
            })
            
            if count % 2 == 0 then
                table.insert(self._rows, self._row_starter)
                self:embed_table(entries[a + 1])
                self:embed_table(entries[a])
                table.insert(self._rows, self._row_starter)
            elseif a == 1 then
                table.insert(self._rows, self._row_starter)
                self:embed_table(entries[a])
                table.insert(self._rows, self._embedded_start)
            end
        end
        table.insert(self._rows, self._table_end)
    end
end

function NanaminShipInfo:build_one(class, remove_headers)
    self:build_table(class, remove_headers)
    return table.concat(self._rows, "\n")
end

function NanaminShipInfo:build_all()
    self:build_table("All", true)
    return table.concat(self._rows, "\n")
end

function NanaminShipInfo:Main(args)
    self:sort_arguments(args)
    --mw.log(self._sorted_entries["Light Cruiser"]["111"][1][1])
    table.insert(self._rows, "__NOTOC__")
    if args["class"] then return self:build_one(args["class"], args["remove_headers"]) end
    if args["all"] then return self:build_all() end
    self:build_table("Battleship")
    self:build_table("Carrier")
    self:build_table("Heavy Cruiser")
    self:build_table("Light Cruiser")
    self:build_table("Destroyer")
    self:build_table("Submarine")
    self:build_table("Other")
    return table.concat(self._rows, "\n")
end

function NanaminShipInfo.Begin(frame)
	local args = getArgs{frame = frame:getParent()}
	return NanaminShipInfo:Main(args)
end

return NanaminShipInfo