local getArgs = require('Module:GetArgs')
local format = require('Module:Core').format
local Ship = require('Module:Ship')
local find = require('Module:Core').find

local rare_ships = {
    'Agano', 'Akashi', 'Akitsu Maru', 'Akitsushima', 'Akizuki', 'Amagi', 'Amatsukaze', 'Arashi', 'Asagumo', 'Asashimo', 'Aquila',
    'Bismarck', 'Graf Zeppelin', 'Hagikaze', 'Harukaze', 'Harusame', 'Hatsukaze', 'Hatsuzuki', 'Hayashimo', 'Hayasui', 'I-26', 'I-401', 'Isokaze',
    'Kashima', 'Katsuragi', 'Kawakaze', 'Kazagumo', 'Kiyoshimo', 'Libeccio', 'Littorio', 'Maikaze', 'Maruyu', 'Mikuma',
    'Mizuho', 'Musashi', 'Noshiro', 'Nowaki', 'Okinami', 'Ooyodo', 'Oyashio', 'Prinz Eugen', 'Roma', 'Sakawa', 'Taigei',
    'Taihou', 'Takanami', 'Tanikaze', 'Teruzuki', 'Tokitsukaze', 'U-511', 'Umikaze', 'Unryuu', 'Uzuki', 'Yahagi',
    'Yamato', 'Z1', 'Z3', 'Zara',
}

local ignored_ships = {
    'Akatsuki', 'Akebono', 'Aoba', 'Arare', 'Arashio', 'Asashio', 'Ashigara', 'Ayanami', 'Chitose', 'Chiyoda',
    'Choukai', 'Fubuki', 'Fumizuki', 'Furutaka', 'Haguro', 'Hatsuharu', 'Hatsushimo', 'Hatsuyuki', 'Hibiki', 'Houshou',
    'I-168', 'Ikazuchi', 'Inazuma', 'Isonami', 'Isuzu', 'Jintsuu', 'Kagerou', 'Kako', 'Kasumi', 'Kikuzuki',
    'Kisaragi', 'Kiso', 'Kuma', 'Kuroshio', 'Maya', 'Michishio', 'Mikazuki', 'Miyuki', 'Mochizuki', 'Murakumo',
    'Murasame', 'Mutsuki', 'Nachi', 'Nagatsuki', 'Naka', 'Natori', 'Nenohi', 'Oboro', 'Ooshio', 'Samidare',
    'Satsuki', 'Sazanami', 'Shigure', 'Shikinami', 'Shiranui', 'Shiratsuyu', 'Shirayuki', 'Suzukaze', 'Tama', 'Tatsuta',
    'Tenryuu', 'Ushio', 'Wakaba', 'Yura', 'Yuudachi',
}

local templates = {

    table_header = [=[{| class="wikitable mw-collapsible mw-collapsed typography-xl-optout" style="width:100%"
! colspan="9" |<span style="float:right;">&#x5b;[http://kancolle.wikia.com/wiki/Module:Map_${map_id}/Nodes Edit]&#x5d;</span><span style="float:left;padding-left:10px;">Drops</span>
|-
!Node
! style="display:${display_dd}" |[[DD]]
! style="display:${display_cl}" |[[CL]]
! style="display:${display_ca}" |[[CA]]
! style="display:${display_bb}" |[[BB]]
! style="display:${display_cv}" |[[CVL]]/[[CV]]
! style="display:${display_av}" |[[AV]]
! style="display:${display_ss}" |[[SS]]
! style="display:${display_aux}" |[[Auxiliary Ships|Others]]
]=],

    table_footer = '\n|}',
 
    node_row = [[|-
| style="text-align:center;color:${color};" |${node}
| style="display:${display_dd}" |${dd_list}
| style="display:${display_cl}" |${cl_list}
| style="display:${display_ca}" |${ca_list}
| style="display:${display_bb}" |${bb_list}
| style="display:${display_cv}" |${cv_list}
| style="display:${display_av}" |${av_list}
| style="display:${display_ss}" |${ss_list}
| style="display:${display_aux}" |${aux_list}]],

    link = "[[${target}]]",

    colored_link = '[[${target}|<span style="color:${color}">${target}</span>]]',

}

function formatShipLink(ship_name, rarity)
    local rarity_color = find(rare_ships, ship_name) and "red" -- or find(ignored_ships, ship_name) and "green"
    return
        rarity_color
        and format{templates.colored_link, target = ship_name, color = rarity_color}
        or format{templates.link, target = ship_name}
end

function formatTable(map_id, map_nodes)
    local rows = {}
    local dd, cl, ca, bb, cv, av, ss, aux
    for _, node_data in ipairs(map_nodes) do
        if node_data.drops then
            local dd_list = {}
            local cl_list = {}
            local ca_list = {}
            local bb_list = {}
            local cv_list = {}
            local av_list = {}
            local ss_list = {}
            local aux_list = {}
            for _, ship_name in ipairs(node_data.drops or {}) do
                local ship = Ship(ship_name)
                local ship_link = formatShipLink(ship_name, ship:rarity())
                if ship:type() == 2 then
                    table.insert(dd_list, ship_link)
                    dd = true
                elseif ship:type() == 3 then
                    table.insert(cl_list, ship_link)
                    cl = true
                elseif ship:type() == 5 then
                    table.insert(ca_list, ship_link)
                    ca = true
                elseif ship:type() == 8 or ship:type() == 9 then
                    table.insert(bb_list, ship_link)
                    bb = true
                elseif ship:type() == 7 or ship:type() == 11 then
                    table.insert(cv_list, ship_link)
                    cv = true
                elseif ship:type() == 16 then
                    table.insert(av_list, ship_link)
                    av = true
                elseif ship:type() == 13 or ship:type() == 14 then
                    table.insert(ss_list, ship_link)
                    ss = true
                else
                    table.insert(aux_list, ship_link)
                    aux = true
                end
            end
            table.sort(dd_list)
            table.sort(cl_list)
            table.sort(ca_list)
            table.sort(bb_list)
            table.sort(cv_list)
            table.sort(av_list)
            table.sort(ss_list)
            table.sort(aux_list)
            table.insert(rows, {
                node = node_data.label,
                color = node_data.boss and "red" or "",
                dd_list = table.concat(dd_list, ", "),
                cl_list = table.concat(cl_list, ", "),
                ca_list = table.concat(ca_list, ", "),
                bb_list = table.concat(bb_list, ", "),
                cv_list = table.concat(cv_list, ", "),
                av_list = table.concat(av_list, ", "),
                ss_list = table.concat(ss_list, ", "),
                aux_list = table.concat(aux_list, ", "),
            })
        end
    end
    local rows2 = {}
    for _, row  in ipairs(rows) do
        table.insert(rows2, format{
            templates.node_row,
            node = row.node,
            color = row.color,
            dd_list = row.dd_list,
            cl_list = row.cl_list,
            ca_list = row.ca_list,
            bb_list = row.bb_list,
            cv_list = row.cv_list,
            av_list = row.av_list,
            ss_list = row.ss_list,
            aux_list = row.aux_list,
            display_dd = dd and "" or "none",
            display_cl = cl and "" or "none",
            display_ca = ca and "" or "none",
            display_bb = bb and "" or "none",
            display_cv = cv and "" or "none",
            display_av = av and "" or "none",
            display_ss = ss and "" or "none",
            display_aux = aux and "" or "none",
        })
    end
    return
        format{
            templates.table_header,
            map_id = map_id,
            display_dd = dd and "" or "none",
            display_cl = cl and "" or "none",
            display_ca = ca and "" or "none",
            display_bb = bb and "" or "none",
            display_cv = cv and "" or "none",
            display_av = av and "" or "none",
            display_ss = ss and "" or "none",
            display_aux = aux and "" or "none",
        }
        .. table.concat(rows2, "\n")
        .. templates.table_footer
end

local MapDropsTable = {}
 
function MapDropsTable.format(frame, args_)
    local args = args_ or getArgs{frame = frame:getParent()}
    local map_id = args[1]
    local map_nodes = require(string.format('Module:Map %s/Nodes', map_id))
    return formatTable(map_id, map_nodes)
end
 
-- MapDropsTable.t = MapDropsTable.format(nil, { "6-5" })
-- print(p.t)
 
return MapDropsTable