local Equipment = require("Module:Equipment")
local format = require("Module:Core").format
local first = require("Module:Core").first

-- * Mocking Module:Ship, only name and suffix functions based on ship_key string.

local Ship = {}

function Ship:create(ship_key)
    self._name, self._suffix = ship_key:match("(.-)/(.*)")
    if self._suffix == "" then
        self._suffix = false
    end
    if not self._name then
        self._name = ship_key
    end
    return self
end

function Ship:base_name()
    return self._name
end

function Ship:suffix()
    return self._suffix
end

function Ship:name()
    if self:suffix() then
        return self:base_name() .. " " .. self:suffix() 
    else
        return self:base_name()
    end
end

-- * No Module:BaseTable due to all the spans and what not.

local ImprovementTable = {

    _table_start = [[{| class="wikitable typography-xl-optout" style="text-align:center;width:100%;"]],
    _table_end = [[|}]],

    _heading = [[|-
| colspan="16" |<h3><span class="mw-headline" id="${id}">${title}</span></h3>]],

    _header = [=[|-
! rowspan="2" width="25%" |Name
! rowspan="2" width="2%" |★
! colspan="5" width="20%" |Resource
! colspan="7" width="15%" |Day
! rowspan="2" width="16%" |2nd Ship
! rowspan="2" width="22%" |Upgrades to
|-
![[file:Development material.png|25px]]
![[file:Improvement Materials.png|25px]]
![[File:RedGunMedium.png|25px]]
![[file:Fuel.png|Fuel|25px]]<br />[[file:Ammunition.png|Ammunition|25px]]
![[file:Steel.png|Steel|25px]]<br />[[File:Bauxite.png|Bauxite|25px]]
!S
!M
!T
!W
!T
!F
!S]=],

    _row_start = [=[| style="text-align:left;" rowspan="${rowspan}" id="${id}" | ${link}
]=],

    _row = [=[|-
${row_start}| 0
| nowrap | ${devmats0}/${devmats0_x}
| nowrap | ${impmats0}/${impmats0_x}
| nowrap style="background:${equips0_bg};" | ${equips0}
| style="background-color:rgb(169, 197, 168);" rowspan="2" | ${fuel}
| style="background-color:rgb(191, 191, 191);" rowspan="2" | ${steel}
${days}
| rowspan="4" | ${ships}
| rowspan="4" | ${upgrades}
|-
| rowspan="2" |6
| nowrap rowspan="2" | ${devmats6}/${devmats6_x}
| nowrap rowspan="2" | ${impmats6}/${impmats6_x}
| nowrap rowspan="2" style="background:${equips6_bg};" | ${equips6}
|-
| style="background-color:rgb(194, 184, 168);" rowspan="2" | ${ammo}
| style="background-color:rgb(237, 206, 184);" rowspan="2" | ${bauxite}
|-
| 10
| nowrap | ${devmats10}/${devmats10_x}
| nowrap | ${impmats10}/${impmats10_x}
| nowrap style="background:${equips10_bg};" | ${equips10}]=],

    _day_cell = [[| style="background-color:${background}" rowspan="4" | ${ships}]],
    _unavailable_color = [[rgb(255, 153, 153)]],
    _available_color = [[rgb(170, 235, 170)]],

}

function format_ship_link(ship)
    return format{
        [=[<span class="advanced-tooltip">[[${ship_name}]]<div class="tooltip-contents">[[File:${ship_name} Battle.jpg]]</div></span>]=],
        ship_name = ship:name()
    }
end

function format_ships_and_days(ship_keys, equipment, product)
    local result_ships = {}
    local result_days = {}
    local days = {
        Sunday = {}, Monday = {}, Tuesday = {}, Wednesday = {}, Thursday = {}, Friday = {}, Saturday = {}
    }
    local day_names = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
    if ship_keys and equipment then
        local base_forms = {}
        for _, ship_key in ipairs(ship_keys) do
            local availability = equipment:improvement_availability(product, ship_key)
            if ship_key == true then
                table.insert(result_ships, "Any")
                days = availability
                break
            else
                local ship = Ship:create(ship_key)
                if not base_forms[ship:base_name()] then
                    base_forms[ship:base_name()] = true
                    table.insert(result_ships, format_ship_link(ship))
                    for day, day_availability in pairs(availability) do
                        table.insert(days[day], day_availability and string.sub(ship_key, 1, 1))
                    end
                end
            end
        end    
        for _, day in ipairs(day_names) do
            local ships = days[day]
            if ships == true then
                table.insert(result_days, format{
                    ImprovementTable._day_cell,
                    background = ImprovementTable._available_color,
                    ships = "✓",
                })
            elseif ships == false then
                table.insert(result_days, format{
                    ImprovementTable._day_cell,
                    background = ImprovementTable._unavailable_color,
                    ships = "✗",
                })
            else
                local n_ships = 0
                for i, ship in ipairs(days[day]) do
                    if ship ~= false then
                        n_ships = n_ships + 1
                    else
                        days[day][i] = "&nbsp;"
                    end
                end
                table.insert(result_days, format{
                    ImprovementTable._day_cell,
                    background = n_ships > 0 and ImprovementTable._available_color or ImprovementTable._unavailable_color,
                    ships = n_ships > 0 and table.concat(days[day], "<br />") or "✗",
                })
            end
        end
    end
    return table.concat(result_ships, "<br />"), table.concat(result_days, "\n")
end

-- not doing Formatting:advanced_tooltip
function equipment_tooltip(text, equipment_name, equipment_card)
    return format{
        [=[<span class="advanced-tooltip">[[${equipment_name}|${text}]]<div class="tooltip-contents"><div style="word-wrap:break-word;width:150px;text-align:center;">${equipment_name}</div><div>[[File:${equipment_card}|150px]]</div></div></span>]=],
        text = text,
        equipment_name = equipment_name,
        equipment_card = equipment_card
    }
end

function format_equipment_link(equipment)
    return format{
        [=[<span class="advanced-tooltip">[[${equipment_link}]]<div class="tooltip-contents">[[File:${equipment_card}|150px]]</div></span>]=],
        text = text,
        equipment_link = equipment:link(),
        equipment_card = equipment:card()
    }
end

function format_equipment(resources)
    if resources then
        if resources.equipment then
            equipment, amount = first(resources.equipment)
            if equipment == true then
                return tostring(amount)
            elseif equipment then
                return equipment_tooltip(amount, equipment, Equipment(equipment):card())
            end
        elseif resources.equipment == false then
            return "-"
        else
            return "?"
        end
    else
        return "-"
    end
end

function format_equipment_bg(target_equipment, resources)
    if resources and resources.equipment then
        local equipment_name = first(resources.equipment)
        if equipment_name == true then
            return target_equipment:buildable() and "transparent" or "#ffcdd2"
        elseif equipment_name then
            return Equipment(equipment_name):buildable() and "#fff9c4" or "#ffe0b2"
        end
    end
    return "transparent"
end

function format_devmat(resources)
    return resources and (resources.devmat or "?") or "-"
end

function format_screw(resources)
    return resources and (resources.screw or "?") or "-"
end

function format_product(product)
    return product == false and "" or format_equipment_link(Equipment(product))
end

function ImprovementTable:add_row(arg)
    local equipment = Equipment(arg)
    if equipment then
        local products = equipment:improvement_products()
        local resources = equipment:improvement_resources()
        local first = true
        for _, product in ipairs(products) do
            local resources0 = equipment:improvement_resources(false, product, 0)
            local resources0_x = equipment:improvement_resources(true, product, 0)
            local resources6 = equipment:improvement_resources(false, product, 6)
            local resources6_x = equipment:improvement_resources(true, product, 6)
            local resources10 = equipment:improvement_resources(false, product, 10)
            local resources10_x = equipment:improvement_resources(true, product, 10)
            local ships, days = format_ships_and_days(equipment:improvement_ships(product), equipment, product)
            table.insert(self.rows, format{
                self._row,
                row_start = not first and "" or format{
                    self._row_start,
                    rowspan = math.max(4, 4 * #products),
                    id = equipment:link(),
                    link = format_equipment_link(equipment),
                },
                fuel = resources.fuel or 0,
                ammo = resources.ammo or 0,
                steel = resources.steel or 0,
                bauxite = resources.bauxite or 0,
                devmats0 = format_devmat(resources0),
                devmats0_x = format_devmat(resources0_x),
                devmats6 = format_devmat(resources6_x),
                devmats6_x = format_devmat(resources6_x),
                devmats10 = format_devmat(resources10),
                devmats10_x = format_devmat(resources10_x),
                impmats0 = format_screw(resources0),
                impmats0_x = format_screw(resources0_x),
                impmats6 = format_screw(resources6),
                impmats6_x = format_screw(resources6_x),
                impmats10 = format_screw(resources10),
                impmats10_x = format_screw(resources10_x),
                equips0 = format_equipment(resources0),
                equips6 = format_equipment(resources6),
                equips10 = format_equipment(resources10),
                equips0_bg = format_equipment_bg(equipment, resources0),
                equips6_bg = format_equipment_bg(equipment, resources6),
                equips10_bg = format_equipment_bg(equipment, resources10),
                upgrades = format_product(product),
                ships = ships,
                days = days,
            })
            first = false
        end
    end
end

function ImprovementTable:add_rows(args)
    for _, arg in ipairs(args) do
        if string.sub(arg, 1, 1) == '!' then
            table.insert(self.rows, format{self._heading, title = string.sub(arg, 2)})
        elseif arg == "#" then
            table.insert(self.rows, self._header)
        else
            self:add_row(arg)
        end
    end
end

function ImprovementTable:Table(args)
    self.rows = {}
    if not args.only_rows then
        table.insert(self.rows, self._table_start)
    end
    self:add_rows(args)
    if not args.only_rows then
        table.insert(self.rows, self._table_end)
    end
    return table.concat(self.rows, "\n")
end

local getArgs = require("Module:GetArgs")

function ImprovementTable.Main(frame, args)
    args = args or getArgs{frame = frame:getParent()}
    return ImprovementTable:Table(args)
end

--[[
ImprovementTable.test1 = ImprovementTable.Main(nil, {
    "12.7cm Twin Gun Mount",
    "12.7cm Twin Gun Mount Model B Kai 2",
})
--print(p.test1)
]]--

return ImprovementTable