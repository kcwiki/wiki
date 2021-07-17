local Ship = require("Module:Ship")
local Equipment = require("Module:Equipment")
local Formatting = require("Module:Formatting")
local format = require("Module:Core").format

local NanaminCombinedFleet = {
    _rows = {},
    _ship_list = {},
    
    _tabber_start = [[<tabber>]],
    _tabber_end = [[</tabber>]],
    _table_start = [[{|]],
    _table_end = [[|}]],
    _row_starter = "|-",
    _info_container_start = [[<div style="padding: 10px;">]],
    _info_container_end = [[</div>]],
    
    _transparent = "transparent",
    _ship_image_bg = "#7FB8D6",
    _equip_icon_bg = "#8DCDEE",
    _equip_link_bg = "#E4F3FB",
    _equip_locked_bg = "#CDDBE2",
    _equip_icon_size = "22x22px",
    _center_align = "center",
    
    _ship_image_template = [[| colspan="2" style="background-color: ${values.bg_color};" |${values.ship_image}]],
    _equip_icon_template = [[| style="text-align: center; background-color: ${values.bg_color};" |${values.equip_icon}]],
    _equip_link_template = [[| style="width: 175px; text-align: center; background: ${values.bg_color};" |${values.equip_link}]],
    _info_template = [[<b>${values.label}</b>: ${values.text}<br />]],
    
    _fighter_power = 0,
    _elos = 0,
    _hq_level = 0
}

function NanaminCombinedFleet:add_to_fighter_power(equip, planes)
    --Only fighter planes, dive bombers, torpedo bombers and seaplane bombers with an AA stat are counted
    local types_allowed = { [6] = true, [7] = true, [8] = true, [11] = true }
    if types_allowed[equip:type()] and equip:aa() then
        self._fighter_power = self._fighter_power + math.floor(math.sqrt(planes) * equip:aa())
    end
end

function NanaminCombinedFleet:add_to_elos(equip)
    --[[Effective LoS = Dive Bomber LoS x (1.04) + Torpedo Bomber LoS x (1.37)
    + Carrier-based Recon Plane LoS x (1.66) + Recon Seaplane LoS x (2.00)
    + Seaplane Bomber LoS x (1.78) + Small Radar LoS x (1.00) + Large Radar LoS x (0.99)
    + Searchlight LoS x (0.91) + √(base LoS of each ship) * (1.69)
    + (HQ Lv. rounded up to the next multiple of 5) x (-0.61)--]]
    local multiplier = { [7] = 1.04, [8] = 1.04, [9] = 1.66, [10] = 2.00, [11] = 1.78, [12] = 1.00, [13] = 0.99, [29] = 0.91 }
    if multiplier[equip:type()] ~= nil and equip:los() then
        self._elos = self._elos + (equip:los() * multiplier[equip:type()])
    end
end

function NanaminCombinedFleet:process_ship(item)
    --Will come in as "Ship/Remodel"
    local split = mw.ustring.find(item, '/')
    local ship_name = mw.ustring.sub(item, 1, split - 1)
    local temp = mw.ustring.sub(item, split + 1)
    split = mw.ustring.find(temp, '/')
    local ship_suffix = mw.ustring.sub(temp, 1, split - 1)
    local los = mw.ustring.sub(temp, split + 1)
    return Ship(ship_name, ship_suffix), los
end

function NanaminCombinedFleet:process_equipment(ship, item, slot)
    --Check if it's a locked slot
    local slot_info, plane_count = ship:slot(slot)
    if slot_info == nil then
        return "- Locked -", 0
    elseif item == "-" then
        return "- Unequipped -", plane_count
    else
        local equipment = Equipment(item)
        self:add_to_fighter_power(equipment, plane_count)
        self:add_to_elos(equipment)
        return equipment, plane_count
    end
end

function NanaminCombinedFleet:organize_args()
    local ship_index, ship, los = 0
    for index, item in ipairs(self._args) do
        --Arguments that begin in ! will end up outside of this as args["!something"] - no need to check for it
        if mw.ustring.sub(item, 1, 1) ~= "#" then
            --Assume that people are not crazy and will actually put their equips below the ship designation
            if mw.ustring.find(item, '/') then
                ship_index = ship_index + 1
                ship, los = self:process_ship(item)
                self._ship_list[ship_index] = { ship = ship, equips = {} }
                self._elos = self._elos + math.sqrt(los) * 1.69
            else
                local slot = #self._ship_list[ship_index].equips + 1
                local equipment, planes = self:process_equipment(ship, item, slot)
                table.insert(self._ship_list[ship_index].equips, { equip = equipment, planes = planes })
            end
        end
    end
end

function NanaminCombinedFleet:begin_tabber()
    --table.insert(self._rows, self._tabber_start)
end

function NanaminCombinedFleet:end_tabber()
    --table.insert(self._rows, self._tabber_end)
end

function NanaminCombinedFleet:begin_table()
    table.insert(self._rows, self._table_start)
end

function NanaminCombinedFleet:end_table()
    table.insert(self._rows, self._table_end)
end

function NanaminCombinedFleet:build_fleet_table(tab_name, i_start, i_end)
    table.insert(self._rows, tab_name)
    self:begin_table()
    --Tentative style of 3 cards across the top
    for a = i_start, i_end do
        for b = 1, 3 do
            local ship_num = (a - 1) * 3 + b
            table.insert(self._rows, format{self._ship_image_template, values = {
                bg_color = self._ship_image_bg,
                ship_image = Formatting:format_image{self._ship_list[ship_num].ship:battle_card(), align = self._center_align}
            }})
        end
        table.insert(self._rows, self._row_starter)
        for b = 1, 4 do
            row = {}
            for c = 1, 3 do
                local ship_num = (a - 1) * 3 + c
                local equip = self._ship_list[ship_num].equips[b].equip
                local equip_icon, equip_link
                if type(equip) == "string" then
                    equip_icon = ""
                    equip_link = equip
                else
                    equip_icon = Formatting:format_image{Formatting:format_equipment_icon(equip:icon()), size = self._equip_icon_size}
                    equip_link = Formatting:format_link(equip:link())
                end
                table.insert(self._rows, format{self._equip_icon_template, values = {
                   bg_color = self._equip_icon_bg,
                   equip_icon = equip_icon
                }})
                table.insert(self._rows, format{self._equip_link_template, values = {
                    bg_color = self._equip_link_bg,
                    equip_link = equip_link
                }})
            end
            table.insert(self._rows, self._row_starter)
        end
    end
    self:end_table()
end

function NanaminCombinedFleet:add_info(label, text)
    table.insert(self._rows, format{self._info_template, values = {
        label = label,
        text = text
    }})
end

function NanaminCombinedFleet:build_info_tab()
    --Finish eLoS calculation
    self._hq_level = tonumber(self._args["!hq"]) - (tonumber(self._args["!hq"]) % 5)
    if tonumber(self._args["!hq"]) % 5 ~= 0 then
        self._hq_level = self._hq_level + 5
    end
    self._elos = self._elos - (self._hq_level * 0.61)
    
    table.insert(self._rows, "|-|Information=")
    table.insert(self._rows, self._info_container_start)
    self:add_info("Route Taken", self._args["!route"] or "Unavailable")
    self:add_info("Fighter Power", self._fighter_power or 0)
    self:add_info("Effective Line of Sight", string.format("%.2f", self._elos) or 0)
    self:add_info("HQ Level", self._args["!hq"] or "Unavailable")
    table.insert(self._rows, self._info_container_end)
end

function NanaminCombinedFleet:join_rows()
    return table.concat(self._rows, "\n")
end

function NanaminCombinedFleet:Fleetbox(args)
    self._args = args
    
    self:organize_args()
    
    self:begin_tabber()
    self:build_fleet_table("Main Fleet=", 1, 2)
    self:build_fleet_table("|-|Escort Fleet=", 3, 4)
    self:build_info_tab()
    self:end_tabber()
    
    return self:join_rows()
end

return NanaminCombinedFleet