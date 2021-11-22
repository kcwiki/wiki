local U = require('Module:Core')
local NodeInfo = require('Module:NodeInfo')

local templates = {
    title = '<div id="${map} ${node}" style="width:680px;text-align:center">${map} ${node}${nameSuffix} ([https://db.kcwiki.moe/drop/map/${world_number}${map_number}/${node}-SAB.html PoiDB])</div>\n',
    title_simple = '<div id="${map} ${node}" style="width:680px;text-align:center">${map} ${node}${nameSuffix}</div>\n',
    event_title = '<div id="${map} ${node} ${diff}" style="width:680px;text-align:center">${map} ${diff} ${node}${nameSuffix} ([https://db.kcwiki.moe/drop/map/${world_number}${map_number}/${diff_number}/${node}-SAB.html PoiDB])</div>\n',
    event_title_simple = '<div id="${map} ${node} ${diff}" style="width:680px;text-align:center">${map} ${diff} ${node}${nameSuffix}</div>\n',
}

local world_numbers = {
    ["World 1"] = 1,
    ["World 2"] = 2,
    ["World 3"] = 3,
    ["World 4"] = 4,
    ["World 5"] = 5,
    ["World 6"] = 6,
    ["World 7"] = 7,
    ["Winter 2016 Event"] = 33,
    ["Spring 2016 Event"] = 34,
    ["Summer 2016 Event"] = 35,
    ["Fall 2016 Event"] = 36,
    ["Winter 2017 Event"] = 37,
    ["Spring 2017 Event"] = 38,
    ["Summer 2017 Event"] = 39,
    ["Fall 2017 Event"] = 40,
    ["Winter 2018 Event"] = 41,
    ["Early Fall 2018 Event"] = 42,
    ["Winter 2019 Event"] = 43,
    ["Spring 2019 Event"] = 44,
    ["Summer 2019 Event"] = 45,
    ["Fall 2019 Event"] = 46,
    ["Hinamatsuri 2020 Mini-Event"] = 47,
    ["Rainy-Summer 2020 Event"] = 48,
    ["Fall 2020 Event"] = 49,
    ["Spring 2021 Event"] = 50,
    ["Summer 2021 Event"] = 51,
}

local diff_numbers_legacy = {
    ["Regular"] = 0,
    ["Easy"] = 1,
    ["Normal"] = 2,
    ["Medium"] = 2,
    ["Hard"] = 3,
}

local diff_numbers = {
    ["Regular"] = 0,
    ["Casual"] = 1,
    ["Easy"] = 2,
    ["Medium"] = 3,
    ["Hard"] = 4,
}

local simple_node_types = { "Resource", "Storm", "Empty", "Select", "Raid", "Landing", "Repair" }

function formatTitle(pagename, args)

    local world, map = string.match(pagename, "([^/]+)/([^/]+)")
    world = args.world or world or '??'
    map = args.map or map or '??'

    local world_number = world_numbers[world] or "??"
    local map_number = string.match(map:sub(3, 4), "%d") or "??"

    local node = args[1] or "??"
    local node_type = args[2] or "??"
    local is_simple_node_type = node_type == "??" or U.ifind(simple_node_types, node_type)

    local diffs = (world_number == "??" or world_number >= 41) and diff_numbers or diff_numbers_legacy
    local diff = diffs[args.diff] and args.diff
    local diff_number = diffs[diff] or "??"
    local is_event_diff = diff and diff ~= 'Regular'

    local nameSuffix = args.name and ": " .. args.name or ""

    return U.format{
        (is_simple_node_type and
            (is_event_diff and templates.event_title_simple or templates.title_simple) or
            (is_event_diff and templates.event_title or templates.title)),
        map = map,
        node = node,
        diff = diff,
        nameSuffix = nameSuffix,
        world_number = world_number,
        map_number = map_number,
        diff_number = diff_number,
    }
end

return {
    Table = function(frame)
        local args = U.getTemplateArgs(frame)
        local world, map = string.match(args.implicit.pagename, "([^/]+)/([^/]+)")
        args.implicit.world = world or '??'
        args.implicit.map = map or '??'
        local table_string = NodeInfo:Table(args.explicit, args.implicit)
        if args.explicit.diff or args.implicit.pagename and args.implicit.pagename:sub(1, 5) == "World" then
            return formatTitle(args.implicit.pagename, args.explicit) .. table_string
        else
            return table_string
        end
    end
}