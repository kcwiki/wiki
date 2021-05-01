-- [[Category:Todo]]: have Module:Logger to expose syntax warnings, similarly to Module:DropList (use it there as well).

local getArgs = require("Module:GetArgs")
local Utils = require("Module:Core")
local format = Utils.format
local BaseData = require("Module:BaseData")

local MapBranchingTable = BaseData{

    _grammar = {
        split = "^%s*(.+)%s*->%s*(.+)%s*$",
        comma_list = "[^,]+",
        node_and_colors = "^%s*([%a%d]+)%s*/%s*(%S+)%s*$",
        node = "^%s*([%a%d]+)%s*$",
        digit_node = "^%s*%d%s*$",
    },

    _id = "mapbranchingtable", -- not supporting unique ids for now
    _title = "Branching Rules",
    _width = "auto",
    _start = "'''Start'''",

    -- .branching-table is defined in MediaWiki:Common.css
    _template = [[{| class="wikitable typography-xl-optout branching-table" style="width:${width};"
|- class="mw-customtoggle-${id}" style="cursor:pointer;"
!colspan="3"|${title}
|- class="mw-collapsible ${collapsed}" id="mw-customcollapsible-${id}"
!colspan="2"|Nodes||Rules
${rows}
|}]],

    _row_start_template = [[|- class="mw-collapsible ${collapsed}"  id="mw-customcollapsible-${id}"
|rowspan="${rowspan}" style="text-align:center;vertical-align:middle;width:50px;"|${from}]],

    _row_separator_template = [[|- class="mw-collapsible ${collapsed}" id="mw-customcollapsible-${id}"
]],

    _row_template = [[${separator}|class="mw-collapsible ${collapsed}" id="mw-customcollapsible-${id}" style="text-align:center;width:50px;"|${to}${rules}]],

    _rules = "\n|rowspan=\"${span}\" style=\"padding:10px;\"|\n${rules}",

    -- .kcRoute is defined in MediaWiki:Common.css
    _node_template = [[<div class="maproute" style="vertical-align:middle"><div class="${class}" style="${style}">${label}</div></div>]],
    
    _node_color1 = [[background: ${color};]],

    _node_color2 = [[background: linear-gradient(90deg, ${color1} 50%, ${color2} 50%)]],

    _node_color3 = [[background: linear-gradient(-30deg, transparent 60%, ${color1} 60%) 0% 100%, linear-gradient(30deg, transparent 60%, ${color2} 60%) 100% 100%, linear-gradient(${color3}, ${color3}) 0% 100%, linear-gradient(${color3}, ${color3}) 100% 100%, linear-gradient(${color1}, ${color1}) 0% 0%, linear-gradient(${color2}, ${color2}) 100% 0%; background-repeat: no-repeat; background-size: 50% 50%;]],

    _node_color4 = [[background: linear-gradient(${color1}, ${color1}) 0% 0%, linear-gradient(${color2}, ${color2}) 100% 0%, linear-gradient(${color3}, ${color3}) 100% 100%, linear-gradient(${color4}, ${color4}) 0% 100%; background-size: 50% 50%; background-repeat: no-repeat;]],

    _node_colors = {
        grey = "grey",
        battle = "#FF1744", -- Red A400
        resource = "#64DD17", -- Light Green A700
        storm = "#EA80FC", -- Purple A100
        empty = "#40C4FF", -- Light Blue A200
        night = "#7E57C2", -- Deep Purple 400
        nightday_night = { "battle", "night", "night", "night" },
        night_battle_empty = { "night", "battle", "empty" },
        ambush = { "battle", "orange", "battle", "orange" },
    },

}

function make_id_from_title(title)
    return title:gsub("%s", ""):lower()
end

function MapBranchingTable:parse_node(node_string)
    local node, colors = node_string:match(self._grammar.node_and_colors)
    if not node then
        node = node_string:match(self._grammar.node)
    else
        colors = mw.text.split(colors, "%s*/%s*")
    end
    return node, colors
end

function MapBranchingTable:parse(args)
    self._vars = {
        id = args.id or args.title and make_id_from_title(args.title) or self._id,
        title = args.title or self._title,
        width = args.width or self._width,
        branching = { index = {} },
        collapsed = args.expand and "" or "mw-collapsed",
    }
    local branching = self._vars.branching
    for route, rules in pairs(args) do
        if type(route) ~= "number" then
            local from_node, to_nodes = route:match(self._grammar.split)
            if from_node and to_nodes then
                local from_node_colors
                from_node, from_node_colors = self:parse_node(from_node)
                local first_node = nil
                for to_node in string.gmatch(to_nodes, self._grammar.comma_list) do
                    local to_node_colors
                    to_node, to_node_colors = self:parse_node(to_node)
                    if from_node and to_node then
                        Utils.insertNew(branching.index, from_node)
                        if not branching[from_node] then
                            branching[from_node] = {
                                colors = from_node_colors,
                                index = {},
                                indexes = { index = {}, groups = {} }
                            }
                        end
                        if not first_node then
                        	first_node = to_node
                        	branching[from_node][to_node] = {
                        	    colors = to_node_colors,
                        	    rules = rules,
                        	    span = 1
                            }
                            if not branching[from_node].indexes.groups[first_node] then
                                table.insert(branching[from_node].indexes.index, first_node)
                                branching[from_node].indexes.groups[first_node] = { first_node }
                            end
                        else
                        	branching[from_node][first_node].span = branching[from_node][first_node].span + 1
                        	branching[from_node][to_node] = { colors = to_node_colors }
                        	if branching[from_node].indexes.groups[first_node] then
                        	    Utils.insertNew(branching[from_node].indexes.groups[first_node], to_node)
                            end
                        end
                    end
                end
            end
        end
    end
    local sorting
    if args.order then
        local order_nodes = mw.text.split(args.order, "%s*,%s*")
        sorting = function(a, b)
            local ai = Utils.ifind(order_nodes, a)
            local bi = Utils.ifind(order_nodes, b)
            if ai and bi then
                return ai < bi
            else
                return a < b
            end
        end
    else
        sorting = function(a, b)
            return a < b
        end
    end
    table.sort(branching.index, sorting)
    for _, from in ipairs(branching.index) do
        table.sort(branching[from].indexes.index, sorting)
        for _, first_node in ipairs(branching[from].indexes.index) do
            for _, node in ipairs(branching[from].indexes.groups[first_node]) do
                table.insert(branching[from].index, node)
            end
        end
    end
end

function MapBranchingTable:format_color(color)
    return self._node_colors[color] or color or self._node_colors.battle
end

function MapBranchingTable:format_node(label, colors)
    local style
    if label:match(self._grammar.digit_node) then
        style = format{self._node_color1, color = self._node_colors.grey}
    elseif not colors or #colors == 0 then
        style = format{self._node_color1, color = self._node_colors.battle}
    elseif #colors == 1 then
        if type(self._node_colors[colors[1]]) == "table" then
            return self:format_node(label, self._node_colors[colors[1]])
        end
        style = format{self._node_color1, color = self:format_color(colors[1])}
    elseif #colors == 2 then
        style = format{
            self._node_color2,
            color1 = self:format_color(colors[1]),
            color2 = self:format_color(colors[2]),
        }
    elseif #colors == 3 then
        style = format{
            self._node_color3,
            color1 = self:format_color(colors[1]),
            color2 = self:format_color(colors[2]),
            color3 = self:format_color(colors[3]),
        }
    elseif #colors >= 4 then
        style = format{
            self._node_color4,
            color1 = self:format_color(colors[1]),
            color2 = self:format_color(colors[2]),
            color3 = self:format_color(colors[3]),
            color4 = self:format_color(colors[4]),
        }
    end
    return label == "0" and self._start or format{
        self._node_template,
        label = label,
        class = #label > 1 and "mapnodewide" or "mapnode",
        style = style
    }
end

function MapBranchingTable:format_rows()
    local branching = self._vars.branching
    local rows = {}
    for _, from_node in ipairs(branching.index) do
        table.insert(rows, format{
            self._row_start_template,
            rowspan = #branching[from_node].index,
            from = self:format_node(from_node, branching[from_node].colors),
            id = self._vars.id,
            collapsed = self._vars.collapsed,
        })
        local first = true
        for _, to_node in ipairs(branching[from_node].index) do
            table.insert(rows, format{
                self._row_template,
                separator = first and "" or format{
                    self._row_separator_template,
                    id = self._vars.id,
                    collapsed = self._vars.collapsed,
                },
                to = self:format_node(to_node, branching[from_node][to_node].colors),
                rules = branching[from_node][to_node].rules and format{
                    self._rules,
                    rules = branching[from_node][to_node].rules,
                    span = branching[from_node][to_node].span,
                } or "",
                id = self._vars.id,
                collapsed = self._vars.collapsed,
            })
            first = false
        end
    end
    self._vars.rows = table.concat(rows, "\n")
end

function MapBranchingTable:format(args)
    self:parse(args)
    self:format_rows()
    return format(self._template, self._vars)
end

function MapBranchingTable.Table(frame, args)
    return MapBranchingTable:format(args or getArgs{frame = frame:getParent()})
end

Utils.registerTableTests(MapBranchingTable, {
    {
        ["0 -> 1"] = "Fixed route",
        ["1 -> C/empty, D"] = "Random",
        ["1 -> A, B/battle, X/empty"] = "Random",
        ["C -> F, G/battle/empty"] = "...",
        ["B -> D/red/green/blue, E/red/green/blue/yellow"] = "...",
        ["X -> Y/nightday_night, Z/night_battle_empty"] = "...",
        ["Z1 -> Z2, Z3"] = "...",
        ["ZZ1 -> ZZ2, ZZ3"] = "...",
        ["title"] = "A Custom Title",
        ["order"] = "C, A, 1, B",
        "?",
    }
})
-- p.run_table_tests()

return MapBranchingTable