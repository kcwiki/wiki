local getArgs = require('Module:GetArgs')
local format = require('Module:Core').format
local EnemyShip = require("Module:EnemyShip")
local ShipBattleCardKai = require("Module:ShipBattleCardKai")

local templates = {

    table_header = [[{| class="wikitable mw-collapsible mw-collapsed typography-xl-optout" style="width:100%"
! colspan="7" |<span style="float:right;">&#x5b;[http://kancolle.wikia.com/wiki/Module:Map_${map_id}/Nodes Edit]&#x5d;</span><span style="float:left;padding-left:10px;">Enemy patterns</span>
|-
!#
!Formation
! style="min-width:calc(160px * 3);width:calc(160px * 3);" |Fleet
!<span class="explain" title="Enemy fleet's air control: AP/AS/AS+ values.">Air</span>
!<span class="explain" title="Base node experience.">Exp</span>
!<span class="explain" title="Registered HQ level range for a pattern.">HQ</span>
]],

    table_footer = '\n|}',

    node_title_row = [[|-
! colspan="7" style="color:${color};" |Node ${node_label} : ${node_name}${type_suffix} ${note}]],

    node_pattern_row = [[|- style="background:#${background_color};"
| style="text-align:center;color:${color};" |${node_label}<sub>${pattern_id}</sub>
| style="text-align:center;" |${formations_string}
| style="text-align:left;" |${fleet_string}
| style="text-align:center;" |${air_string}
| style="text-align:center;" |${exp}
| style="text-align:center;" |${hq}]],

    empty_node_row = [[|-
| colspan="7" style="text-align:center;" |Must be my imagination (battle avoided)/No enemies sighted<br />気のせいだった（戦闘回避）/敵影を見ず。(戦闘なし)]],

}

local type_styles = {
    night = { type_suffix = " (Night Battle)", background_color = "BBDEFB" },
    aerial = { type_suffix = " (Aerial Battle)", background_color = "C8E6C9" },
    raid = { type_suffix = " (Air Raid Battle)", background_color = "81C784" },
    boss = { type_suffix = " (Boss Node)", color = "red", background_color = "FFE0B2" },
}

function formatTable(map_id, map_nodes)
    local rows = {}
    for _, node_data in ipairs(map_nodes) do
        local type_style = type_styles[node_data.type]
        table.insert(rows, format{
            templates.node_title_row,
            node_label = node_data.label or "?",
            node_name = node_data.name or "?",
            type_suffix = type_style and type_style.type_suffix or "",
            note = node_data.note or "",
            color = type_style and type_style.color or "",
        })
        if node_data.type == "empty" then
            table.insert(rows, templates.empty_node_row)
        else
        for i, pattern_data in ipairs(node_data.patterns) do
            local formations_string = table.concat(pattern_data.formations, "<br />")
            local fleet_string = table.concat(pattern_data.fleet, "<br />")
            local enemy_images = {}
            local enemy_fleet_air_power = 0
            local air_power_complete = true

            -- TODO: refactor, try caching enemy data

            for j, enemy_name in ipairs(pattern_data.fleet) do
                local ship = EnemyShip(enemy_name)
                local ship_caption =
                    (ship:name() or "?")
                    .. " (" .. (ship:api_id() or "?") .. "): "
                    .. (ship:armor() or "?") .. " Armor, " .. (ship:hp() or "?") .. " HP"
                table.insert(enemy_images, ShipBattleCardKai:get{ship = ship, caption = ship_caption, link = ship:link(), flagship = j == 1})
                local enemy_air_power = ship:air_power()
                if enemy_air_power then
                    enemy_fleet_air_power = enemy_fleet_air_power + enemy_air_power
                else
                    air_power_complete = false
                end
            end
            local fleet_string = table.concat(enemy_images, "")

            local air_parity = (air_power_complete or enemy_fleet_air_power > 0) and string.format("%.1d", math.ceil((2./3.) * enemy_fleet_air_power)) or "??"
            local air_superiority = (air_power_complete or enemy_fleet_air_power > 0) and string.format("%.1d", math.ceil(enemy_fleet_air_power * (3 / 2))) or "??"
            local air_supremacy = (air_power_complete or enemy_fleet_air_power > 0) and tostring(enemy_fleet_air_power * 3) or "??"
            local air_string = not air_power_complete and enemy_fleet_air_power > 0 and (air_parity .. "+<br />" .. air_superiority .. "+<br />" .. air_supremacy .. "+")
                or (air_parity .. "<br />" .. air_superiority .. "<br />" .. air_supremacy)

            table.insert(rows, format{
                templates.node_pattern_row,
                node_label = (pattern_data.final and "'''F" or "") .. (node_data.label or "?") .. (pattern_data.final and "'''" or ""),
                pattern_id = i,
                formations_string = formations_string,
                fleet_string = fleet_string,
                air_string = air_string,
                exp = pattern_data.exp or "?",
                hq = pattern_data.hq or "?",
                background_color = type_style and type_style.background_color or "",
                color = pattern_data.final and "red" or "",
            })
        end
        end
    end
    return format{templates.table_header, map_id = map_id} .. table.concat(rows, "\n") .. templates.table_footer
end

local MapNodesTable = {}
 
function MapNodesTable.format(frame, args_)
    local args = args_ or getArgs{frame = frame:getParent()}
    local map_id = args[1]
    local map_nodes = require(string.format('Module:Map %s/Nodes', map_id))
    return formatTable(map_id, map_nodes)
end

-- MapNodesTable.t = MapNodesTable.format(nil, { "6-5" })
-- print(p.t)

return MapNodesTable