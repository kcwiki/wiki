local U = require('Module:Core')
local Utils = require('Module:Core')
local format = require('Module:Core').format
local getArgs = require('Module:GetArgs')

local artists = require('Module:Collection/Artists')
local seiyuus = require('Module:Collection/Seiyuus')
local types = require('Module:Collection/ShipsByType')

local function requireSeasonModule(name)
  local success, data = U.requireModule('Data/Season/' .. name)
  if not success then
    success, data = U.requireModule('Seasonal/' .. name)
  end
  if not success then
    data = {index = {}, ships = {}}
  end
  return data
end

function findType(ship)
    for type, data in pairs(types) do
        if data.ships and Utils.find(data.ships, ship) then
            return type
        end
    end
    return "?"
end

function genToc(args, tbl, format)
    local result = ""
    local i = 0
    local n = 0
    for _, k in ipairs(tbl.index) do
        local data = tbl[k]
        local ships = Utils.filter(data.ships, function(ship) return Utils.find(args, ship) end)
        if #ships > 0 then
            i = i + 1
            n = n + #ships
            local ships_str = table.concat(Utils.map(ships, function(ship) return string.format("[[#%s|%s]]", args.art and (tbl.type == "types" and k or findType(ship)) or ship, ship) end), ", ")
            if data.url then
                result = result .. string.format("|-\n|[%s %s]\n|%s\n", data.url, k, ships_str)
            elseif tbl.type == "types" then
                result = result .. string.format("|-\n|[[#%s|%s]] (%s)\n|%s\n", args[k] and (k .. " 2") or k, k, #ships, ships_str)
            else
                result = result .. string.format("|-\n|%s\n|%s\n", k, ships_str)
            end
        end
    end
    return format(result, i, n)
end

local Seasonal = {}

-- Template:SeasonalTOC
function Seasonal.toc(frame)
    local args = getArgs{frame = frame:getParent()}
    return
        genToc(args, types, function(r, i, n) return string.format([===[{| class="mw-collapsible mw-collapsed wikitable typography-xl-optout" style="width:100%%"
|-
!width=20%%|Class
!%s (%s)
]===], args.text or "Ship girls", n) .. r .. "|}" end)
        .. "\n" ..
        genToc(args, args.art and artists or seiyuus, function(r, i, n) return string.format([===[{| class="mw-collapsible mw-collapsed wikitable typography-xl-optout" style="width:100%%"
|-
!width=20%%|[[%s]] (%s)
!
]===], args.art and "Glossary#List_of_Vessels_by_Artist|Artist" or "Glossary#List_of_Vessels_by_Seiyuu|Seiyuu", i) .. r .. "|}" end)

end 

-- Template:SeasonalQuotesInclude
function Seasonal.include(frame)

    local ship_row_template = [=[|align="center" rowspan="${rowspan}"|[[${ship}]]
]=]

    local id_string_template = [[id="${ship}"]]

    local quote_template = [=[|- ${id_string}
${ship_row}|align="center"|<span class="audio-button click-parent">[[File:${ship}${form} ${season}${line}.ogg|Play]]</span>
|lang="ja"|${ja}
|${en}
|${note}]=]

    local args = getArgs{frame = frame:getParent()}
    local season, type = args[1], args[2]
    local only = args.only
    local result = {
        "|-",
        string.format([=[!colspan="5"|From [[Seasonal/%s|%s]]]=], season, season)
    }
    local seasonal_data = requireSeasonModule(season)
    for _, ship in ipairs(seasonal_data.index[type]) do
        if only and Utils.find(args, ship) or not only and not Utils.find(args, ship) then
            local ship_data = seasonal_data.ships[ship]
            local quotes = Utils.ifilter(ship_data, function(quote)
                return not Utils.find(args, string.format("%s/%s", ship, quote.line or ""))
            end)
            for i, quote in ipairs(quotes) do
                local note = args[ship .. "." .. "note"]
                if note and note == "nil" then
                    note = ""
                elseif note and note:sub(-1) == "+" then
                    note = note:sub(1, -2) .. (quote.note or "")
                end
                table.insert(result, format{
                    quote_template,
                    id_string = i > 1 and "" or format{
                        id_string_template,
                        ship = ship,
                    },
                    ship_row = i > 1 and "" or format{
                        ship_row_template,
                        rowspan = #quotes,
                        ship = ship,
                    },
                    ship = quote.ship or ship,
                    form = quote.form or "",
                    season = quote.season or season,
                    line = quote.line and " " .. quote.line or "",
                    ja = quote.ja or "",
                    en = quote.en or "",
                    note = (quote.ship and "''As " .. quote.ship .. "''<br>" or "") .. (quote.line and "''" .. quote.line .. "''<br>" or "") .. (note or quote.note or ""),
                })
            end
        end
    end
    return table.concat(result, "\n")

end

return Seasonal