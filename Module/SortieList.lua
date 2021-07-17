local getArgs = require("Module:GetArgs")
local format = require("Module:Core").format
local ResourceIcons = require("Module:Data/Asset")

local templates = {

    header = [[{| class="article-table" style="width:100%;"]],

    footer = "|}",

    map_rows = [=[|-
! colspan="2" style="text-align:center;width:40%;" | [[${link}|World ${id}: ${name}]]<br />${name_en}
| rowspan="4" style="text-align:center;width:60%;" | <div style="position:absolute;right:5px;">&#91;[[Module:${module_link}|Edit]]&#93;</div>${banner}
|-
! Difficulty
| ${difficulty}
|-
! Exp/node
| ${ship_exp}
|-
! Items
| ${items_string}
|-
! Fluff text
| ${strategy_name}
| ${strategy_info}]=],

    eo_map_rows = [=[|-
| colspan="4" style="text-align:center;" | ${banner}
|-
! colspan="4" style="text-align:center;" | <div style="position:absolute;right:5px;">&#91;[[Module:${module_link}|Edit]]&#93;</div>[[${link}|World ${id}: ${name}]]<br />${name_en}
|-
! style="width:10%;" | Difficulty
| style="width:25%;" | ${difficulty}
! rowspan="3" style="width:11%;" | Fluff text
| style="width:54%;" | ${strategy_name}
|-
! Exp/node
| ${ship_exp}
| rowspan="2" | ${strategy_info}
|-
! Items
| ${items_string}]=],

}

local item_names = {
    "fuel", "ammo", "steel", "bauxite",
    "bucket", "devmat", "conmat",
    "furniture_box_small", "furniture_box_medium", "furniture_box_large",
}

function formatItems(items)
    if items == nil then
        return "?"
    end
    if items == false then
        return "None"
    end
    local images = {}
    for _, item_name in ipairs(item_names) do
        if items[item_name] then
            local image = ResourceIcons[item_name] and string.format("[[File:%s|18px]]", ResourceIcons[item_name]) or item_name
            table.insert(images, image)
        end
    end
    return table.concat(images, " ")
end

function formatDifficulty(api_stars, banner_stars)
    if not api_stars and not banner_stars then
        return "?"
    end
    local stars = banner_stars or api_stars
    api_stars = api_stars or "?"
    local stars_string
        = stars > 10
        and [[<span style="font-size:150%">'''☆'''</span>]] .. string.rep("☆", stars - 10)
        or string.rep("☆", stars)
    if banner_stars then
        return string.format('<span class="explain" title="API value: %d">%s (%d)</span>', api_stars, stars_string, stars)
    else
        return string.format("%s (%d)", stars_string, stars)
    end
end

function formatShipExp(exp)
    return exp == false and "Variable" or exp or "?"
end

function loadMapData(world_id, id)
    local success, table = pcall(function() return require(string.format("Module:Data/Map/%s", id)) end)
    return success and table or {}
end

function formatTable(maps)
    local rows = {}
    table.insert(rows, templates.header)
    for _, id in ipairs(maps) do
        local world_id = string.match(id, "%d") or "?"
        local map_data = loadMapData(world_id, id)
        table.insert(rows, format{
            map_data.eo and templates.eo_map_rows or templates.map_rows,
            id = id,
            link = string.format("World %d#/%s", world_id, id),
            module_link = string.format("Data/Map/%s", id),
            banner = string.format("[[File:%s Banner.png|%s]]", id, map_data.eo and '600px' or '400px'),
            name = map_data.name or "?",
            name_en = map_data.name_en or "?",
            difficulty = formatDifficulty(map_data.stars, map_data.banner_stars),
            ship_exp = formatShipExp(map_data.ship_exp),
            items_string = formatItems(map_data.items),
            strategy_name = map_data.strategy_name or "?",
            strategy_info = map_data.strategy_info or "?",
            -- strategy_name_en
            -- strategy_info_en
            -- hp
            -- kills_required
            -- hq_non_boss_exp
            -- hq_boss_exp
            -- eo
        })
    end
    table.insert(rows, templates.footer)
    return table.concat(rows, "\n")
end

local SortieList = {}

function SortieList.format(frame, args)
    args = args or getArgs{frame = frame:getParent()}
    return formatTable(args)
end

return SortieList