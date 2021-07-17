local getArgs = require('Module:GetArgs')

local Ship = require("Module:Ship")
local Equipment = require("Module:Equipment")
local Formatting = require("Module:Formatting")
local format = require("Module:Core").format

local Functions = require("Module:NanaminFunctions")

local CombinedFleet = {
    _rows = {},
    _ship_list = { ["main"] = {}, ["escort"] = {} },
    _counts = { ["main"] = {}, ["escort"] = {} },
    
    _table_start = [[{| class="mw-collapsible mw-collapsed" id="mw-customcollapsible-${table_name}-${id}"]],
    _table_end = [[|}]],
    _row_starter = "|-",
    
    _header_top_template = [[<div class="mw-customtoggle-${toggle_class}" style="width: 615px; background: #A596B5; border-top-right-radius: 60px; border-top-left-radius: 60px; text-align: center; font-size: 18px; color: #000040; cursor: hand; cursor: pointer;">''Main Fleet''</div>]],
    _header_mid_template = [[<div class="mw-customtoggle-${toggle_class}" style="width: 615px; background: #A596B5; text-align:center; font-size: 18px; color:#000040; cursor: hand; cursor: pointer;">''${text}''</div>]],
    _header_bot_template = [[<div style="width: 615px; background: #A596B5; border-bottom-right-radius: 60px; border-bottom-left-radius: 60px; text-align: center; font-size: 18px; color:#000040;">''${map}''</div>]],
    
    _ship_image_template = [[| colspan="2" style="background-color: #BDACA0; height: 50px;" mode="packed" |<div style="float: left; margin-top: 7px; margin-left: 3px;">${position_image}</div>${ship_card}]],
    _equip_template = [[| style="height: 46px; min-width: 22px; text-align: center; background-color: #BDACA0;" |${equip_icon}
| style="width: 175px; text-align: center; background: #E3D6C9;" |${equip_link}]],
    _info_template = [[| style="background-color: #363636; height: 25px; width: 611px;" |
    {| style="margin: 5px 62px 0 5px;">
    | style="width: 147px; color: #20B2B5;" | ${label}
    | style="width: 438px; background-color: #F1E7E0; border: 2px solid #D0B118; border-top-left-radius: 10px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; border-top-right-radius: 10px; vertical-align: center; text-align: center;" | ${value}
    |}]],
    
    _blank_battle_card = "Empty card.png",
    
    _id = "",
    _fighter_power = 0,
    _elos = 0,
    _hq_level = 0
}

function CombinedFleet:easy_errors()
    --For people that don't know Lua, some errors may not make sense despite being basic
    --This will provide something for missing variables
    if self._args == nil then error("No information has been provided.") end
    
    local must_have = { "route", "hq_level", "map_name" }
    for _, var_name in ipairs(must_have) do
        if self._args[var_name] == nil then
            error("\"" .. var_name .. "\" must be provided. Please double-check that you have this variable and that it is spelled correctly")
        end
    end
end

function CombinedFleet:generate_id()
    --No built-in hashing algorithms, so we'll just cheat and use the route, HQ level and a random number
    self._id = self._args["route"]:gsub("[^%w]", "") .. self._args["hq_level"] .. tostring(math.random(1000000,9999999))
end

function CombinedFleet:organize_args()
    local entry = {}
    for _, item in ipairs(self._args) do
        if mw.ustring.sub(item, 1, 1) == "#" then
        elseif item == "-" then
            if #self._ship_list.main < 6 then
                table.insert(self._ship_list.main, entry)
            else
                table.insert(self._ship_list.escort, entry)
            end
            entry = {}
        else
            local split = Functions.split(item, '/')
            for _, item in pairs(split) do
                table.insert(entry, item)
            end
        end
    end
    if #entry > 0 then
        table.insert(self._ship_list.escort, entry)
    end
end

function CombinedFleet:process_equipment(ship, entry, slot)
    if not ship._equipment then return "", "- Locked -" end --No idea why this fixes ship:slots() being nil
    local slots = ship and ship:slots() or 0
    local equip_icon, equip_link
    if slot > slots then
        equip_icon = ""
        equip_link = "- Locked -"
    elseif entry[slot + 3] == nil then
        equip_icon = ""
        equip_link = "- Unequipped -"
    else
        local equip = Equipment(Functions.process_legacy_name(entry[slot + 3]))
        self._fighter_power = Functions.add_to_fighter_power(self._fighter_power, equip, select(2, ship:slot(slot)))
        self._elos = Functions.add_to_elos(self._elos, equip)
        equip_icon = Formatting:format_image{ Formatting:format_equipment_icon(equip:icon()), size = "22x22px", link = "" }
        equip_link = Formatting:format_link(equip:link())
    end
    return equip_icon, equip_link
end

function CombinedFleet:insert_top_header()
    table.insert(self._rows, format{self._header_top_template,
        toggle_class = "main-fleet-" .. self._id,
    })
end

function CombinedFleet:insert_mid_header(text)
    table.insert(self._rows, format{self._header_mid_template,
        toggle_class = string.lower(text:gsub(" ", "-")) .. "-" .. self._id,
        text = text,
    })
end

function CombinedFleet:insert_bot_header()
    table.insert(self._rows, format{self._header_bot_template,
        map = self._args["map_name"],
    })
end

function CombinedFleet:build_table(table_name)
    table.insert(self._rows, format{self._table_start,
        table_name = table_name .. "-fleet",
        id = self._id,
    })
    
    local ship_list = self._ship_list[table_name]
    for i = 1, 6, 3 do
        local ship_suffix1 = ship_list[i][2] and ship_list[i][2]:gsub('/', '') or ship_list[i][2]
        local ship_suffix2 = ship_list[i + 1][2] and ship_list[i + 1][2]:gsub('/', '') or ship_list[i + 1][2]
        local ship_suffix3 = ship_list[i + 2][2] and ship_list[i + 2][2]:gsub('/', '') or ship_list[i + 2][2]
        local ships = {
            ship1 = Ship(ship_list[i][1], ship_suffix1),
            ship2 = Ship(ship_list[i + 1][1], ship_suffix2),
            ship3 = Ship(ship_list[i + 2][1], ship_suffix3),
        }
        
        for a = 1, 3 do
            local ship = ships["ship" .. a]
            self._elos = Functions.add_to_elos_ship(self._elos, ship_list[i], self._args["use_los"] or false)
            local ship_type = Formatting:format_ship_code(ship:type())
            self._counts[table_name][ship_type] = self._counts[table_name][ship_type] and self._counts[table_name][ship_type] + 1 or 1
            local ship_card = Formatting:format_image{ship:battle_card() or self._blank_battle_card, link = ship:link(), caption = ship:name(), align = "center", size = "160x40px"}
            table.insert(self._rows, format{self._ship_image_template,
                position_image = Formatting:format_image{"Ship position " .. tostring(i + a - 1) .. " icon.png", link = ""},
                ship_card = ship_card,
            })
        end
        table.insert(self._rows, self._row_starter)
        for a = 1, 4 do
            for b = 1, 3 do
                local ship = ships["ship" .. b]
                local equip = ship_list[i + b - 1]
                local equip_icon, equip_link = self:process_equipment(ship, equip, a)
                table.insert(self._rows, format{self._equip_template,
                    equip_icon = equip_icon,
                    equip_link = equip_link,
                })
            end
            table.insert(self._rows, self._row_starter)
        end
        
        if i % 3 == 0 then
        end
    end
    
    table.insert(self._rows, self._table_end)
end

function CombinedFleet:build_info_table()
    local counts = { ["main"] = "", ["escort"] = "" }
    for fleet, ship_types in pairs(self._counts) do
        for ship_type, count in pairs(ship_types) do
            counts[fleet] = counts[fleet] .. tostring(count) .. " " .. ship_type:gsub("^BC$", "FBB") .. " + "
        end
        counts[fleet] = mw.ustring.sub(counts[fleet], 1, -4)
    end
    local information = {
        {
            ["label"] = "Main Fleet Comp",
            ["value"] = counts["main"],
        },
        {
            ["label"] = "Escort Fleet Comp",
            ["value"] = counts["escort"],
        },
        {
            ["label"] = "Route Taken",
            ["value"] = self._args["route"],
        },
        {
            ["label"] = "Fighter Power",
            ["value"] = tostring(self._fighter_power),
        },
        {
            ["label"] = "Effective Line of Sight",
            ["value"] = string.format("%.2f", self._elos - (Functions.get_hq_bracket(self._args["hq_level"]) * 0.61)),
        },
        {
            ["label"] = "HQ Level",
            ["value"] = tostring(self._args["hq_level"])
        },
        {
            ["label"] = "Teitoku Notes",
            ["value"] = self._args["notes"] or "",
        },
    }
    
    table.insert(self._rows, format{self._table_start,
        table_name = "fleet-info",
        id = self._id,
    })
    for _, set in ipairs(information) do
        table.insert(self._rows, format{self._info_template,
            label = set.label,
            value = set.value,
        })
        table.insert(self._rows, self._row_starter)
    end
    table.insert(self._rows, self._table_end)
end

function CombinedFleet:Main(args)
    self._args = args
    
    self:easy_errors()
    self:organize_args()
    self:generate_id()
    
    table.insert(self._rows, [[<div style="display: table; margin: 0 auto;">]])
    self:insert_top_header()
    self:build_table("main")
    self:insert_mid_header("Escort Fleet")
    self:build_table("escort")
    self:insert_mid_header("Fleet Info")
    self:build_info_table()
    self:insert_bot_header()
    table.insert(self._rows, [[</div>]])
    
    return table.concat(self._rows, '\n')
end

function CombinedFleet.Begin(frame)
	local args = getArgs{frame = frame:getParent()}
	return CombinedFleet:Main(args)
end

return CombinedFleet