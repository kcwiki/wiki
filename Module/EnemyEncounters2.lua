local p = {}
local remiLib = require("Module:RemiLib")
-- Module for enemy encounter tables written by
-- Remi_Scarlet
-- I fucking hate lua.

-- 10/24/15 Added colorful blue button as per Wsewo's request.

-- 11/22/17 Modified by がか

-- checks if data is in the array as a key

function valid(data, array)
    local valid = {}
    if array ~= nil then
        for i = 1, #array do
            valid[array[i]] = true
        end
        if valid[data] then
            return true
        else
            return false
        end
    end
end

-- returns a string representation of a table.
-- cannot do recursive tables. Eg, only single dimensional tables will work
-- should a multi-dimensional table be given, it will simply put "table" as the value
function table.dictConcat(dict,sep)
    if sep == nil then sep = " | " end
    local final = ""
    for k,v in pairs(dict) do
        if k ~= nil then
            if v ~= nil then
                final = final .. k .. "=" .. tostring(v) .. sep
            else
                final = final .. k .. "= nil" .. sep
            end
        else
            if v ~= nil then
                final = final .. tostring(v) .. sep 
            else
                final = final .. "nil" .. sep
            end
        end
    end
    return final
end

-- takes a string and returns string with first letter capitalized
function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

-- "info" should be higher level table of information with eg 
-- {["A"] = {["1"] = {["xp"]="120", ["main_info"] = "ta-class etc"}
--           ["2"] = {["xp"]="150", etc}
--          },
--  ["B"] = etc etc
-- }
-- "headers" should be a table with which params are used
-- "bossNode" should be a single char with which node is the boss node
function p.renderEncounterTable(info,headers, bossNode, collapsed)
    function getRowSize(table, recurse)
        if recurse == nil then recurse = false end
        local size = 0
        for k,v in pairs(table) do
            if type(v) == "table" and recurse then
                size = size+getRowSize(v)
            elseif v ~= "" and k ~= "label" then
                size = size+1
            end
        end
        return size
    end


    local numCols = 0
    for _,bool in pairs(headers) do
        if bool then numCols = numCols + 1 end
    end
    
    -- Will be used to uniquely identify each table with the "button" and the "table content". Normally
    -- this would be done with like mw-customtoggle-1-1-enemy or whatnot, but since I can't
    -- actually discern what "map" it's being used on, I'm just using a hash function on the time of
    -- rendering to replace the map identifier.
    local uniqueID = remiLib.timeHash(info)
    
    local classString = "mw-customtoggle-" .. tostring(uniqueID)
    local idString = "mw-customcollapsible-" .. tostring(uniqueID)
    
    local button = mw.html.create('div')
    button
    	:addClass(classString)
    	:addClass("globalbutton")
    	:wikitext("Show/Hide Nodes and Enemy Encounters")
   
    local encounterTable = mw.html.create("table")
    encounterTable
        :addClass("mw-collapsible")
        :addClass("wikitable")
        :addClass("mw-collapsed")
        :attr("id",idString)
    -- if collapsed then
    --     encounterTable:addClass("mw-collapsed")
    -- end
    local titleRow = mw.html.create("tr")
    local th = mw.html.create("th")
    th
        :attr("colspan",numCols+2)
        :wikitext("Nodes and Enemy Encounters")
        :css("font-weight","bold")
    titleRow:node(th)
    encounterTable:node(titleRow)
    local headerRow = mw.html.create("tr")
    th = mw.html.create("th")
    th:wikitext("Node")
    headerRow:node(th)
    th = mw.html.create("th")
    th:wikitext("Pattern")
    headerRow:node(th)
    local paramOrder = {"Xp","Lv","Node Info","Form"}
    for i,param in pairs(paramOrder) do
        if param == "Xp" and info["map_xp"] ~= nil then
            th = mw.html.create("th")
            th:wikitext("Xp")
            headerRow:node(th)
        elseif headers[param] then
            th = mw.html.create("th")
            th:wikitext(param)
            if param == "Node Info" then
                th:css("width","330")
            end
            headerRow:node(th)
        end
    end
    -- Air superiority is a bit different so account for it
    if headers["Enemy Air Power"] then
        th = mw.html.create("th")
        th:wikitext("Air")
        headerRow:node(th)
    end
    encounterTable:node(headerRow)
    local letterOrder = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","O1","O2","O3","P","P1","P2","P3","Q","Q1","Q2","Q3","R","S","T","U","V","W","X","Y","Z","Z1", "Z2", "Z3", "Z4", "Z5", "Z6", "Z7", "Z8", "Z9", "ZZ1", "ZZ2", "ZZ3"}
    for _,nodeLetter in pairs(letterOrder) do
        local values = info[nodeLetter]
        if values ~= nil then
            local firstRow = mw.html.create("tr")
            local firstCol = mw.html.create("td")
            local nodeName = nodeLetter
            if values["label"] ~= nil then
                nodeName = nodeName .. "<br>" .. values["label"]
            end

            firstCol
                    :wikitext(nodeName)
                    :css("text-align","center")
                    :css("font-weight","bold")
                    :attr("rowspan",tostring(getRowSize(values)))
            if nodeLetter == bossNode then
                firstCol:css("color","red")
                firstCol:css("font-weight","bold")
            end
            firstRow:node(firstCol)
            local text = "Pattern 1"
            if values[1] and values[1]["isFinalForm"] ~= nil then 
                text = "<span style='color:red'>" .. text .."<br>" .. "Final Form</span>"
            end
            if values[1] and values[1]["isSecondPhase"] ~= nil then 
                text = "<span style='color:blue'>" .. text .."<br>" .. "Second Phase</span>"
            end
            if values[1] and values[1]["isPostFinalForm"] ~= nil then 
                text = "<span style='color:blue'>" .. text .."<br>" .. "Post-Clear Only Form</span>"
            end
            firstRow:node(mw.html.create("td"):wikitext(text)):css("text-align","center")
            
            -- since first row with rowspan is handled differently, just
            -- do it separately
            if type(values[1]) == "table" then
                for _,param in pairs(paramOrder) do
                    if headers[param] then
                        local col = mw.html.create("td")
                        if param == "Xp" and info["map_xp"] ~= nil then
                            col:wikitext(info["map_xp"])
                            col:css("text-align","center")
                        elseif values[1][param] ~= nil then
                            local text = values[1][param]
                            col:wikitext(p.replaceWordWithWikicode(text .. " "))
                            if param == "Node Info" and nil ~= string.find(string.lower(text),"class") then
                                col:css("text-align","left")
                            else
                                col:css("text-align","center")
                            end
                        end
                        firstRow:node(col)
                    end
                end
                if headers["Enemy Air Power"] == true then
                    td = mw.html.create("td")
                    td:css("font-weight","bold")
                    td:css("text-align","center")
                    if values[1]["Enemy Air Power"] == "0" then
                        td
                            :wikitext("AS/AS+")
                            :wikitext("<br>")
                            :wikitext("Automatic")
                    end
                    if values[1]["Enemy Air Power"] == "?" then
                        td
                            :wikitext("Unknown")
                    end
                    if values[1]["Enemy Air Power"] ~= "" and values[1]["Enemy Air Power"] ~= "0" and values[1]["Enemy Air Power"] ~= "?" and values[1]["Enemy Air Power"] ~= nil then
                        td
                            :wikitext("AS:")
                            :wikitext(math.ceil(1.5 * values[1]["Enemy Air Power"]))
                            :wikitext("<br>")
                            :wikitext("AS+:")
                            :wikitext(3 * values[1]["Enemy Air Power"])
                    end
                    firstRow:node(td)
                end
            end
            encounterTable:node(firstRow)
            -- Keep note that values is the table of node A
            -- Eg, {["1"]={
            --              ["xp"] = "",
            --              ["lv"] = "" etc
            --          },
            --      ["2"]={
            --              ["xp"] = "", etc
            --          }
            --      }   
            for i=2,#values do
                if type(values[i]) == "table" then
                    local row = mw.html.create("tr")
                    local text = "Pattern " .. i
                     if values[i]["isSecondPhase"] ~= nil then
                        text = "<span style='color:red'>" .. text .."<br>" .. "Second Phase</span>"
                    end
                    if values[i]["isFinalForm"] ~= nil then
                        text = "<span style='color:red'>" .. text .."<br>" .. "Final Form</span>"
                    end
                    if values[i]["isPostFinalForm"] ~= nil then
                        text = "<span style='color:blue'>" .. text .."<br>" .. "Post-Clear Only Form</span>"
                    end
                    row:node(mw.html.create("td"):wikitext(text)):css("text-align","center")
                    for _,param in pairs(paramOrder) do
                        if headers[param] then
                            local col = mw.html.create("td")
                        if param == "Xp" and info["map_xp"] ~= nil then
                            col:wikitext(info["map_xp"])
                            col:css("text-align","center")
                        elseif values[i][param] ~= nil then
                                local text = values[i][param]
                                col:wikitext(p.replaceWordWithWikicode(text .. " "))
                                if param == "Node Info" and nil ~= string.find(string.lower(text),"class") then
                                    col:css("text-align","left")
                                else
                                    col:css("text-align","center")
                                end
                            end
                            row:node(col)
                        end
                    end
                    if headers["Enemy Air Power"] == true then
                        td = mw.html.create("td")
                        td:css("font-weight","bold")
                        td:css("text-align","center")
                        if values[i]["Enemy Air Power"] == "0" then
                            td
                                :wikitext("AS/AS+")
                                :wikitext("<br>")
                                :wikitext("Automatic")
                        end
                    	if values[i]["Enemy Air Power"] == "?" then
                        	td
                            	:wikitext("Unknown")
                    	end
                        if values[i]["Enemy Air Power"] ~= "" and values[i]["Enemy Air Power"] ~= "0" and values[i]["Enemy Air Power"] ~= "?" then
                            td
                                :wikitext("AS:")
                                :wikitext(math.ceil(1.5 * values[i]["Enemy Air Power"]))
                                :wikitext("<br>")
                                :wikitext("AS+:")
                                :wikitext(3 * values[i]["Enemy Air Power"])
                        end
                        row:node(td)
                    end

                    encounterTable:node(row)
                end
            end
        end
    end
    return tostring(button) .. "\n" .. tostring(encounterTable)
end

function splitAndCapitalize(s, split, join)
    split = split or "_"
    join = join or " "
    local parts = mw.text.split(s, split)
    local result = {}
    for _, part in ipairs(parts) do
        table.insert(result, capitalize(part))
    end
    return table.concat(result, join)
end

-- 1.1. new type pattern parameter: <node>-<pattern number>_<parameter name>
-- 1.2. old type pattern parameter: <node letter><pattern number>_<parameter name>
-- 2. label parameter: <node>_label
-- 3. map parameters: boss_node, final_form, post_final_form, second_phase
function parseParameter(param)
    local node, pattern, name
    node = param:match('^(%w+)_label$')
    if node then
        return { label = true, node = node }
    end
    node, pattern, name = param:match('^(%w+)-(%d)_(.+)$')
    if not node then
         node, pattern, name = param:match('^(%a)(%d)_(.+)$')
    end
    if node then
        return { pattern = true, node = node, pattern = tonumber(pattern), name = name, title = splitAndCapitalize(name) }
    end
    return { map = true, name = param }
end

function parsePattern(param)
    local node, number = param:match('^(%w+)-(%d)$')
    if not node then
         node, number = param:match('^(%a)(%d)$')
    end
    return node and { node = node, number = tonumber(number) }
end

function markNodes(mapEncounterTable, list, name)
    if list then
        local patterns = mw.text.split(list, " ")
        for _, pattern in ipairs(patterns) do
            pattern = parsePattern(pattern)
            if pattern and mapEncounterTable[pattern.node] and mapEncounterTable[pattern.node][pattern.number] then
                mapEncounterTable[pattern.node][pattern.number][name] = true
            end
        end
    end
end

function debugPrint(x, i)
    i = i or 0
    if type(x) == "table" then
        for k, v in pairs(x) do
            mw.log(
                string.rep("  ", i) .. tostring(k) .. " : " .. type(k) .. " = " ..
                (type(v) == "table" and "table" or tostring(v) .. " : " .. type(v))
            )
            if type(v) == "table" then
                debugPrint(v, i + 1)
            end
        end
    else
        mw.log(tostring(x) .. " : " .. type(x))
    end
end

function p.encounterTemplate(frame)

    local bossNode
    local usedParams = {}
    local mapEncounterTable = {}

    for param, value in pairs(frame.args) do
        if type(param) == "string" then
            param = parseParameter(param)
            if param.pattern then
                if not bossNode or bossNode < param.node then
                    bossNode = param.node
                end
                if not mapEncounterTable[param.node] then
                    mapEncounterTable[param.node] = {}
                end
                if not mapEncounterTable[param.node][param.pattern] then
                    mapEncounterTable[param.node][param.pattern] = {}
                end
                mapEncounterTable[param.node][param.pattern][param.title] = value
                usedParams[param.title] = true
            elseif param.label then
                if not mapEncounterTable[param.node] then
                    mapEncounterTable[param.node] = {}
                end
                mapEncounterTable[param.node].label = value
            end
        end
    end

    markNodes(mapEncounterTable, frame.args.final_form, "isFinalForm")
    markNodes(mapEncounterTable, frame.args.post_final_form, "isPostFinalForm")
    markNodes(mapEncounterTable, frame.args.second_phase, "isSecondPhase")

    if frame.args.map_xp then
        mapEncounterTable.map_xp = frame.args.map_xp
        usedParams["Xp"] = true
    end

    debugPrint(mapEncounterTable)
    debugPrint(usedParams)
    debugPrint(bossNode)

    return p.renderEncounterTable(mapEncounterTable, usedParams, bossNode or frame.args.boss_node, true)

end

function p.replaceWordWithWikicode(str)
    local nodeInfoImageTable = {
        ["fuel"] = '[[File:Fuel.png|Fuel|25px]]',
        ["ammo"] = '[[File:Ammunition.png|Ammo|25px]]',
        ["steel"] = '[[File:Steel.png|Steel|25px]]',
        ["bauxite"] = '[[File:Bauxite.png|Bauxite|25px]]',
        ["daihatsu"] = '[[File:LandingCraft.png|Landing Craft|30px]]',
        ["anchor"] = '[[File:Transport-drop-off.png|Transport drop-off|40px]]',
        ["instantconstruction"] = '[[File:Instant_construction.jpg|Instant Construction|50px]]',
        ["instantrepair"] = '[[File:Instant_repair.jpg|Instant Repair|50px]]',
        ["devmat"] = '[[File:Development_material.jpg|Development Material|50px]]',
        ["smallfurniture"] = '[[File:Furniture box small.png|Small Furniture Box|50px]]',
        ["mediumfurniture"] = '[[File:Furniture_box_medium.png|Medium Furniture Box|50px]]',
        ["largefurniture"] = '[[File:Furniture_box_large.jpg|Large Furniture Box|50px]]'
    }
    local formTable = {
        ["line_ahead"] = "[[file:LineAhead.png|Formation 1: Line Ahead|40px|center]]",
        ["double_line"] = "[[file:DoubleLine.png|Formation 2: Double Line|40px|center]]",
        ["diamond"] = "[[file:Diamond.png|Formation 3: Diamond|40px|center]]",
        ["echelon"] = "[[file:Echelon.png|Formation 4: Echelon|40px|center]]",
        ["line_abreast"] = "[[file:LineAbreast.png|Formation 5: Line Abreast|40px|center]]",
        ["vanguard"] = "[[file:Vanguard.png|Formation 6: Vanguard|40px|center]]",
        ["none"] = "None<br>Displayed",
        ["cruising_form_1"] = "[[file:Formation_1.png|Cruising Formation 1: Anti-sub|50px|center|link=Combined_Fleet]]",
        ["cruising_form_2"] = "[[file:Formation_2.png|Cruising Formation 2: Forward Alert|50px|center|link=Combined_Fleet]]",
        ["cruising_form_3"] = "[[file:Formation_3.png|Cruising Formation 3: Ring Formation|50px|center|link=Combined_Fleet]]",
        ["cruising_form_4"] = "[[file:Formation_4.png|Cruising Formation 4: Battle Formation|50px|center|link=Combined_Fleet]]"
    }
    local enemyShipTable = {
        ["dd_i%-class[%s$]"] = '[[File:Seikan501Banner.png|2|160px|Destroyer I-Class|link=Destroyer I-Class]]',
        ["dd_i%-class_elite[%s$]"] = '[[File:Seikan514Banner.png|2|160px|Destroyer I-Class elite|link=Destroyer I-Class]]',
        ["dd_i%-class_flagship[%s$]"] = '[[File:Seikan564Banner.png|2|160px|Destroyer I-Class flagship|link=Destroyer I-Class]]',
        ["dd_i%-class_late_model[%s$]"] = '[[File:Seikan575Banner.png|2|160px|Destroyer I-Class Late Model|link=Destroyer I-Class]]',
        ["dd_i%-class_late_model_elite[%s$]"] = '[[File:Seikan621Banner.png|2|160px|Destroyer I-Class Late Model elite|link=Destroyer I-Class]]',
        ["dd_ro%-class[%s$]"] = '[[File:Seikan502Banner.png|2|160px|Destroyer Ro-Class|link=Destroyer Ro-Class]]',
        ["dd_ro%-class_elite[%s$]"] = '[[File:Seikan515Banner.png|2|160px|Destroyer Ro-Class elite|link=Destroyer Ro-Class]]',
        ["dd_ro%-class_flagship[%s$]"] = '[[File:Seikan552Banner.png|2|160px|Destroyer Ro-Class flagship|link=Destroyer Ro-Class]]',
        ["dd_ro%-class_late_model[%s$]"] = '[[File:Seikan576Banner.png|2|160px|Destroyer Ro-Class Late Model|link=Destroyer Ro-Class]]',
        ["dd_ro%-class_late_model_elite[%s$]"] = '[[File:Seikan622Banner.png|2|160px|Destroyer Ro-Class Late Model elite|link=Destroyer Ro-Class]]',
        ["dd_ha%-class[%s$]"] = '[[File:Seikan503Banner.png|2|160px|Destroyer Ha-Class|link=Destroyer Ha-Class]]',
        ["dd_ha%-class_elite[%s$]"] = '[[File:Seikan516Banner.png|2|160px|Destroyer Ha-Class elite|link=Destroyer Ha-Class]]',
        ["dd_ha%-class_flagship[%s$]"] = '[[File:Seikan553Banner.png|2|160px|Destroyer Ha-Class flagship|link=Destroyer Ha-Class]]',
        ["dd_ha%-class_late_model[%s$]"] = '[[File:Seikan577Banner.png|2|160px|Destroyer Ha-Class Late Model|link=Destroyer Ha-Class]]',
        ["dd_ha%-class_late_model_elite[%s$]"] = '[[File:Seikan623Banner.png|2|160px|Destroyer Ha-Class Late Model elite|link=Destroyer Ha-Class]]',
        ["dd_ni%-class[%s$]"] = '[[File:Seikan504Banner.png|2|160px|Destroyer Ni-Class|link=Destroyer Ni-Class]]',
        ["dd_ni%-class_elite[%s$]"] = '[[File:Seikan517Banner.png|2|160px|Destroyer Ni-Class elite|link=Destroyer Ni-Class]]',
        ["dd_ni%-class_late_model[%s$]"] = '[[File:Seikan578Banner.png|2|160px|Destroyer Ni-Class Late Model|link=Destroyer Ni-Class]]',
        ["dd_ni%-class_late_model_elite[%s$]"] = '[[File:Seikan624Banner.png|2|160px|Destroyer Ni-Class Late Model elite|link=Destroyer Ni-Class]]',
        ["dd_ni%-class_kai[%s$]"] = '[[File:Seikan1858Banner.png|2|160px|Destroyer Ni-Class Kai|link=Destroyer Ni-Class]]',
        ["dd_ni%-class_kai_late_model[%s$]"] = '[[File:Seikan1859Banner.png|2|160px|Destroyer Ni-Class Kai Late Model|link=Destroyer Ni-Class]]',
        ["dd_ni%-class_kai_late_model_elite[%s$]"] = '[[File:Seikan1860Banner.png|2|160px|Destroyer Ni-Class Kai Late Model elite|link=Destroyer Ni-Class]]',
        ["dd_ni%-class_kai_late_model_flaghip[%s$]"] = '[[File:Seikan1861Banner.png|2|160px|Destroyer Ni-Class Kai Late Model flagship|link=Destroyer Ni-Class]]',
        ["dd_na%-class[%s$]"] = '[[File:Seikan1739Banner.png|2|160px|Destroyer Na-Class|link=Destroyer Na-Class]]',
        ["dd_na%-class_elite[%s$]"] = '[[File:Seikan1740Banner.png|2|160px|Destroyer Na-Class elite|link=Destroyer Na-Class]]',
        ["dd_na%-class_flagship[%s$]"] = '[[File:Seikan1741Banner.png|2|160px|Destroyer Na-Class flagship|link=Destroyer Na-Class]]',
        ["dd_na%-class_late_model[%s$]"] = '[[File:Seikan1742Banner.png|2|160px|Destroyer Na-Class Late Model|link=Destroyer Na-Class]]',
        ["dd_na%-class_late_model_elite[%s$]"] = '[[File:Seikan1743Banner.png|2|160px|Destroyer Na-Class Late Model elite|link=Destroyer Na-Class]]',
        ["dd_na%-class_late_model_flagship[%s$]"] = '[[File:Seikan1744Banner.png|2|160px|Destroyer Na-Class Late Model flagship|link=Destroyer Na-Class]]',
        ["cl_ho%-class[%s$]"] = '[[File:Seikan505Banner.png|2|160px|Light Cruiser Ho-Class|link=Light Cruiser Ho-Class]]',
        ["cl_ho%-class_elite[%s$]"] = '[[File:Seikan518Banner.png|2|160px|Light Cruiser Ho-Class elite|link=Light Cruiser Ho-Class]]',
        ["cl_ho%-class_flagship[%s$]"] = '[[File:Seikan554Banner.png|2|160px|Light Cruiser Ho-Class flagship|link=Light Cruiser Ho-Class]]',
        ["cl_he%-class[%s$]"] = '[[File:Seikan506Banner.png|2|160px|Light Cruiser He-Class|link=Light Cruiser He-Class]]',
        ["cl_he%-class_elite[%s$]"] = '[[File:Seikan519Banner.png|2|160px|Light Cruiser He-Class elite|link=Light Cruiser He-Class]]',
        ["cl_he%-class_flagship[%s$]"] = '[[File:Seikan555Banner.png|2|160px|Light Cruiser He-Class flagship|link=Light Cruiser He-Class]]',
        ["cl_to%-class[%s$]"] = '[[File:Seikan507Banner.png|2|160px|Light Cruiser To-Class|link=Light Cruiser To-Class]]',
        ["cl_to%-class_elite[%s$]"] = '[[File:Seikan520Banner.png|2|160px|Light Cruiser To-Class elite|link=Light Cruiser To-Class]]',
        ["cl_tsu%-class[%s$]"] = '[[File:Seikan591Banner.png|2|160px|Light Cruiser Tsu-Class|link=Light Cruiser Tsu-Class]]',
        ["cl_tsu%-class_elite[%s$]"] = '[[File:Seikan592Banner.png|2|160px|Light Cruiser Tsu-Class elite|link=Light Cruiser Tsu-Class]]',
        ["cl_tsu%-class_flagship[%s$]"] = '[[File:Seikan1862Banner.png|2|160px|Light Cruiser Tsu-Class flagship|link=Light Cruiser Tsu-Class]]',
        ["clt_chi%-class[%s$]"] = '[[File:Seikan508Banner.png|2|160px|Torpedo Cruiser Chi-Class|link=Torpedo Cruiser Chi-Class]]',
        ["clt_chi%-class_elite[%s$]"] = '[[File:Seikan521Banner.png|2|160px|Torpedo Cruiser Chi-Class elite|link=Torpedo Cruiser Chi-Class]]',
        ["clt_chi%-class_flagship[%s$]"] = '[[File:Seikan559Banner.png|2|160px|Torpedo Cruiser Chi-Class flagship|link=Torpedo Cruiser Chi-Class]]',
        ["ca_ri%-class[%s$]"] = '[[File:Seikan509Banner.png|2|160px|Heavy Cruiser Ri-Class|link=Heavy Cruiser Ri-Class]]',
        ["ca_ri%-class_elite[%s$]"] = '[[File:Seikan522Banner.png|2|160px|Heavy Cruiser Ri-Class elite|link=Heavy Cruiser Ri-Class]]',
        ["ca_ri%-class_flagship[%s$]"] = '[[File:Seikan527Banner.png|2|160px|Heavy Cruiser Ri-Class flagship|link=Heavy Cruiser Ri-Class]]',
        ["ca_ri%-class_flagship_kai[%s$]"] = '[[File:Seikan566Banner.png|2|160px|Heavy Cruiser Ri-Class Kai|link=Heavy Cruiser Ri-Class]]',
        ["ca_ne%-class[%s$]"] = '[[File:Seikan594Banner.png|2|160px|Heavy Cruiser Ne-Class|link=Heavy Cruiser Ne-Class]]',
        ["ca_ne%-class_elite[%s$]"] = '[[File:Seikan595Banner.png|2|160px|Heavy Cruiser Ne-Class elite|link=Heavy Cruiser Ne-Class]]',
        ["ca_ne%-class_flagship[%s$]"] = '[[File:Seikan1761Banner.png|2|160px|Heavy Cruiser Ne-Class flagship|link=Heavy Cruiser Ne-Class]]',
        ["cvl_nu%-class[%s$]"] = '[[File:Seikan510Banner.png|2|160px|Light Carrier Nu-Class|link=Light Carrier Nu-Class]]',
        ["cvl_nu%-class_elite[%s$]"] = '[[File:Seikan523Banner.png|2|160px|Light Carrier Nu-Class elite|link=Light Carrier Nu-Class]]',
        ["cvl_nu%-class_flagship[%s$]"] = '[[File:Seikan560Banner.png|2|160px|Light Carrier Nu-Class flagship|link=Light Carrier Nu-Class]]',
        ["cv_wo%-class[%s$]"] = '[[File:Seikan512Banner.png|2|160px|Standard Carrier Wo-Class|link=Standard Carrier Wo-Class]]',
        ["cv_wo%-class_elite[%s$]"] = '[[File:Seikan525Banner.png|2|160px|Standard Carrier Wo-Class elite|link=Standard Carrier Wo-Class]]',
        ["cv_wo%-class_flagship[%s$]"] = '[[File:Seikan528Banner.png|2|160px|Standard Carrier Wo-Class flagship|link=Standard Carrier Wo-Class]]',
        ["cv_wo%-class_flagship_2[%s$]"] = '[[File:Seikan528Banner.png|2|160px|Standard Carrier Wo-Class flagship|link=Standard Carrier Wo-Class]]',
        ["cv_wo%-class_flagship_kai[%s$]"] = '[[File:Seikan565Banner.png|2|160px|Standard Carrier Wo-Class Kai flagship|link=Standard Carrier Wo-Class]]',
        ["bb_ru%-class[%s$]"] = '[[File:Seikan511Banner.png|2|160px|Battleship Ru-Class|link=Battleship Ru-Class]]',
        ["bb_ru%-class_elite[%s$]"] = '[[File:Seikan524Banner.png|2|160px|Battleship Ru-Class elite|link=Battleship Ru-Class]]',
        ["bb_ru%-class_flagship[%s$]"] = '[[File:Seikan529Banner.png|2|160px|Battleship Ru-Class flagship|link=Battleship Ru-Class]]',
        ["bb_ru%-class_flagship_kai[%s$]"] = '[[File:Seikan567Banner.png|2|160px|Battleship Ru-Class Kai flagship|link=Battleship Ru-Class]]',
        ["bb_ta%-class[%s$]"] = '[[File:Seikan541Banner.png|2|160px|Battleship Ta-Class|link=Battleship Ta-Class]]',
        ["bb_ta%-class_elite[%s$]"] = '[[File:Seikan542Banner.png|2|160px|Battleship Ta-Class elite|link=Battleship Ta-Class]]',
        ["bb_ta%-class_flagship[%s$]"] = '[[File:Seikan543Banner.png|2|160px|Battleship Ta-Class flagship|link=Battleship Ta-Class]]',
        ["bbv_re%-class[%s$]"] = '[[File:Seikan561Banner.png|2|160px|Battleship Re-Class|link=Battleship Re-Class]]',
        ["bbv_re%-class_elite[%s$]"] = '[[File:Seikan562Banner.png|2|160px|Battleship Re-Class elite|link=Battleship Re-Class]]',
        ["transport_wa%-class[%s$]"] = '[[File:Seikan513Banner.png|2|160px|Transport Ship Wa-Class|link=Transport Ship Wa-Class]]',
        ["transport_wa%-class_elite[%s$]"] = '[[File:Seikan526Banner.png|2|160px|Transport Ship Wa-Class elite|link=Transport Ship Wa-Class]]',
        ["transport_wa%-class_flagship[%s$]"] = '[[File:Seikan558Banner.png|2|160px|Transport Ship Wa-Class flagship|link=Transport Ship Wa-Class]]',
        ["ss_ka%-class[%s$]"] = '[[File:Seikan530Banner.png|2|160px|Submarine Ka-Class|link=Submarine Ka-Class]]',
        ["ss_ka%-class_elite[%s$]"] = '[[File:Seikan532Banner.png|2|160px|Submarine Ka-Class elite|link=Submarine Ka-Class]]',
        ["ss_ka%-class_flagship[%s$]"] = '[[File:Seikan534Banner.png|2|160px|Submarine Ka-Class flagship|link=Submarine Ka-Class]]',
        ["ss_yo%-class[%s$]"] = '[[File:Seikan531Banner.png|2|160px|Submarine Yo-Class|link=Submarine Yo-Class]]',
        ["ss_yo%-class_elite[%s$]"] = '[[File:Seikan533Banner.png|2|160px|Submarine Yo-Class elite|link=Submarine Yo-Class]]',
        ["ss_yo%-class_flagship[%s$]"] = '[[File:Seikan535Banner.png|2|160px|Submarine Yo-Class flagship|link=Submarine Yo-Class]]',
        ["ss_so%-class[%s$]"] = '[[File:Seikan570Banner.png|2|160px|Submarine So-Class|link=Submarine So-Class]]',
        ["ss_so%-class_elite[%s$]"] = '[[File:Seikan571Banner.png|2|160px|Submarine So-Class elite|link=Submarine So-Class]]',
        ["ss_so%-class_flagship[%s$]"] = '[[File:Seikan572Banner.png|2|160px|Submarine So-Class flagship|link=Submarine So-Class]]',
        ["armored_carrier_demon[%s$]"] = '[[File:Seikan544Banner.png|2|160px|Armored Carrier Demon|link=Armored Carrier Demon]]',
        ["armored_carrier_princess[%s$]"] = '[[File:Seikan545Banner.png|2|160px|Armored Carrier Princess|link=Armored Carrier Princess]]',
        ["floating_fortress_1[%s$]"] = '[[File:Seikan536Banner.png|2|160px|Floating Fortress|link=Floating Fortress]]',
        ["floating_fortress_2[%s$]"] = '[[File:Seikan537Banner.png|2|160px|Floating Fortress|link=Floating Fortress]]',
        ["floating_fortress_3[%s$]"] = '[[File:Seikan538Banner.png|2|160px|Floating Fortress|link=Floating Fortress]]',
        ["anchorage_demon[%s$]"] = '[[File:Seikan539Banner.png|2|160px|Anchorage Demon|link=Anchorage Demon]]',
        ["anchorage_princess[%s$]"] = '[[File:Seikan540Banner.png|2|160px|Anchorage Princess|link=Anchorage Princess]]',
        ["escort_fortress_1[%s$]"] = '[[File:Seikan536Banner.png|2|160px|Escort Fortress|link=Escort Fortress]]',
        ["escort_fortress_2[%s$]"] = '[[File:Seikan537Banner.png|2|160px|Escort Fortress|link=Escort Fortress]]',
        ["escort_fortress_3[%s$]"] = '[[File:Seikan538Banner.png|2|160px|Escort Fortress|link=Escort Fortress]]',
        ["southern_demon[%s$]"] = '[[File:Seikan546Banner.png|2|160px|Southern Demon|link=Southern Demon]]',
        ["southern_war_demon[%s$]"] = '[[File:Seikan547Banner.png|2|160px|Southern War Demon|link=Southern War Demon]]',
        ["southern_war_princess[%s$]"] = '[[File:Seikan548Banner.png|2|160px|Southern War Princess|link=Southern War Princess]]',
        ["airfield_princess[%s$]"] = '[[File:Seikan556Banner.png|2|160px|Airfield Princess|link=Airfield Princess]]',
        ["battleship_princess[%s$]"] = '[[File:Seikan557Banner.png|2|160px|Battleship Princess|link=Battleship Princess]]',
        ["harbor_princess[%s$]"] = '[[File:Seikan573Banner.png|2|160px|Harbor Princess|link=Harbor Princess]]',
        ["harbor_princess_damaged[%s$]"] = '[[File:Seikan613Banner.png|2|160px|Harbor Princess Final Form|link=Harbor Princess]]',
        ["isolated_island_demon[%s$]"] = '[[File:Seikan574Banner.png|2|160px|Isolated Island Demon|link=Isolated Island Demon]]',
        ["isolated_island_princess[%s$]"] = '[[File:Seikan668Banner.png|2|160px|Isolated Island Princess|link=Isolated Island Princess]]',
        ["northern_princess[%s$]"] = '[[File:Seikan587Banner.png|2|160px|Northern Princess|link=Northern Princess]]',
        ["northern_princess_final_form[%s$]"] = '[[File:Seikan582Banner.png|2|160px|Northern Princess Final Form|link=Northern Princess]]',
        ["northern_princess_3%-5[%s$]"] = '[[File:Seikan587Banner.png|2|160px|Northern Princess Weaken Form|link=Northern Princess]]',
        ["northern_princess_3%-5_final_form[%s$]"] = '[[File:Seikan582Banner.png|2|160px|Northern Princess Weaken Final Form|link=Northern Princess]]',
        ["aircraft_carrier_demon[%s$]"] = '[[File:Seikan585Banner.png|2|160px|Aircraft Carrier Demon|link=Aircraft Carrier Demon]]',
        ["midway_princess[%s$]"] = '[[File:Seikan583Banner.png|2|160px|Midway Princess|link=Midway Princess]]',
        ["midway_princess_final_form[%s$]"] = '[[File:Seikan584Banner.png|2|160px|Midway Princess Final Form|link=Midway Princess]]',
        ["aircraft_carrier_princess[%s$]"] = '[[File:Seikan586Banner.png|2|160px|Aircraft Carrier Princess|link=Aircraft Carrier Princess]]',
        ["destroyer_princess[%s$]"] = '[[File:Seikan597Banner.png|2|160px|Destroyer Princess|link=Destroyer Princess]]',
        ["aircraft_carrier_water_demon[%s$]"] = '[[File:Seikan599Banner.png|2|160px|Aircraft Carrier Water Demon|link=Aircraft Carrier Water Demon]]',
        ["aircraft_carrier_water_demon_final_form[%s$]"] = '[[File:Seikan599Banner.png|2|160px|Aircraft Carrier Water Demon Final Form|link=Aircraft Carrier Water Demon]]',
        ["light_cruiser_demon[%s$]"] = '[[File:Seikan601Banner.png|2|160px|Light Cruiser Demon|link=Light Cruiser Demon]]',
        ["light_cruiser_demon_final_form[%s$]"] = '[[File:Seikan602Banner.png|2|160px|Light Cruiser Demon Final Form|link=Light Cruiser Demon]]',
        ["battleship_water_demon[%s$]"] = '[[File:Seikan603Banner.png|2|160px|Battleship Water Demon|link=Battleship Water Demon]]',
        ["battleship_water_demon_final_form[%s$]"] = '[[File:Seikan604Banner.png|2|160px|Battleship Water Demon Final Form|link=Battleship Water Demon]]',
        ["anchorage_water_demon[%s$]"] = '[[File:Seikan609Banner.png|2|160px|Anchorage Water Demon|link=Anchorage Water Demon]]',
        ["harbor_water_demon[%s$]"] = '[[File:Seikan605Banner.png|2|160px|Harbor Water Demon|link=Harbor Water Demon]]',
        ["air_defense_princess[%s$]"] = '[[File:Seikan628Banner.png|2|160px|Air Defense Princess|link=Air Defense Princess]]',
        ["pt_imp[%s$]"] = '[[File:Seikan637Banner.png|2|160px|PT Imp Group|link=PT Imp Group]]',
        ["light_cruiser_princess[%s$]"] = '[[File:Seikan641Banner.png|2|160px|Light Cruiser Princess|link=Light Cruiser Princess]]',
        ["submarine_princess[%s$]"] = '[[File:Seikan644Banner.png|2|160px|Submarine Princess|link=Submarine Princess]]',
        ["destroyer_water_demon[%s$]"] = '[[File:Seikan647Banner.png|2|160px|Destroyer Water Demon|link=Destroyer Water Demon]]',
        ["seaplane_tender_princess[%s$]"] = '[[File:Seikan625Banner.png|2|160px|Seaplane Tender Princess|link=Seaplane Tender Princess]]',
        ["artillery_imp[%s$]"] = '[[File:Seikan665Banner.png|2|160px|Artillery Imp|link=Artillery Imp]]',
        ["supply_depot_princess[%s$]"] = '[[File:Seikan653Banner.png|2|160px|Supply Depot Princess|link=Supply Depot Princess]]',
        ["supply_depot_princess_damaged[%s$]"] = '[[File:Seikan656Banner.png|2|160px|Supply Depot Princess Damage Form|link=Supply Depot Princess]]',
        ["heavy_cruiser_princess[%s$]"] = '[[File:Seikan659Banner.png|2|160px|Heavy Cruiser Princess|link=Heavy Cruiser Princess]]',
        ["heavy_cruiser_princess_final_form[%s$]"] = '[[File:Seikan662Banner.png|2|160px|Heavy Cruiser Princess Final Form|link=Heavy Cruiser Princess]]',
        ["central_princess[%s$]"] = '[[File:Seikan684Banner.png|2|160px|Central Princess|link=Central Princess]]',
        ["central_princess_damaged[%s$]"] = '[[File:Seikan687Banner.png|2|160px|Central Princess Damaged Form|link=Central Princess]]',
        ["lycoris_princess[%s$]"] = '[[File:Seikan679Banner.png|2|160px|Lycoris Princess|link=Lycoris Princess]]',
        ["old_destroyer_demon[%s$]"] = '[[File:Seikan673Banner.png|2|160px|Old Destroyer Demon|link=Old Destroyer Demon]]',
        ["old_destroyer_princess[%s$]"] = '[[File:Seikan690Banner.png|2|160px|Old Destroyer Princess|link=Old Destroyer Princess]]',
        ["summer_submarine_princess[%s$]"] = '[[File:Seikan693Banner.png|2|160px|Submarine Summer Princess|link=Submarine Princess]]',
        ["summer_battleship_princess[%s$]"] = '[[File:Seikan696Banner.png|2|160px|Battleship Summer Princess|link=Battleship Princess]]',
        ["summer_harbor_princess[%s$]"] = '[[File:Seikan699Banner.png|2|160px|Harbor Summer Princess|link=Harbor Princess]]',
        ["summer_harbor_princess_damaged[%s$]"] = '[[File:Seikan702Banner.png|2|160px|Harbor Summer Princess Damaged Form|link=Harbor Princess]]',
        ["summer_heavy_cruiser_princess[%s$]"] = '[[File:Seikan705Banner.png|2|160px|Heavy Cruiser Summer Princess|link=Heavy Cruiser Princess]]',
        ["seaplane_tender_water_princess[%s$]"] = '[[File:Seikan708Banner.png|2|160px|Seaplane Tender Water Princess|link=Seaplane Tender Water Princess]]',
        ["abyssal_jellyfish_princess[%s$]"] = '[[File:Seikan711Banner.png|2|160px|Abyssal Jellyfish Princess|link=Abyssal Jellyfish Princess]]',
        ["abyssal_twin_princesses[%s$]"] = '[[File:Seikan716Banner.png|2|160px|Abyssal Twin Princesses|link=Abyssal Twin Princesses]]',
        ["abyssal_twin_princesses_damaged[%s$]"] = '[[File:Seikan719Banner.png|2|160px|Abyssal Twin Princesses Damaged Form|link=Abyssal Twin Princesses]]',
        ["escort_princess[%s$]"] = '[[File:Seikan1722Banner.png|2|160px|Escort Princess|link=Escort Princess]]',
        ["escort_princess_damaged[%s$]"] = '[[File:Seikan1722BannerDmg.png|2|160px|Escort Princess Damaged Form|link=Escort Princess]]',
        ["northernmost_landing_princess[%s$]"] = '[[File:Seikan1725Banner.png|2|160px|Northernmost Landing Princess|link=Northernmost Landing Princess]]',
        ["northern_water_princess[%s$]"] = '[[File:Seikan1728Banner.png|2|160px|Northern Water Princess|link=Northern Water Princess]]',
        ["northern_water_princess_damaged[%s$]"] = '[[File:Seikan1731Banner.png|2|160px|Northern Water Princess Damaged Form|link=Northern Water Princess]]',
        ["new_submarine_princess_a[%s$]"] = '[[File:Seikan1736Banner.png|2|160px|New Submarine Princess Flagship (A)|link=New Submarine Princess]]',
        ["new_submarine_princess_b[%s$]"] = '[[File:Seikan1737Banner.png|2|160px|New Submarine Princess Flagship (B)|link=New Submarine Princess]]',
        ["new_submarine_princess_c[%s$]"] = '[[File:Seikan1738Banner.png|2|160px|New Submarine Princess Flagship (C)|link=New Submarine Princess]]',
        ["new_submarine_princess_d[%s$]"] = '[[File:Seikan1736Banner.png|2|160px|New Submarine Princess Flagship (D)|link=New Submarine Princess]]',
        ["french_battleship_hime[%s$]"] = '[[File:Seikan1745Banner.png|2|160px|French Battleship Princess|link=French Battleship Princess]]',
        ["french_battleship_hime_damaged[%s$]"] = '[[File:Seikan1748Banner.png|2|160px|French Battleship Princess - Damaged|link=French Battleship Princess]]',
        ["aircraft_carrier_summer_demon[%s$]"] = '[[File:Seikan1751Banner.png|2|160px|Aircraft Carrier Summer Demon|link=Aircraft Carrier Summer Demon]]',
        ["supply_depot_summer_princess[%s$]"] = '[[File:Seikan1753Banner.png|2|160px|Supply Depot Summer Princess|link=Supply Depot Summer Princess]]',
        ["aircraft_carrier_summer_hime[%s$]"] = '[[File:Seikan1752Banner.png|2|160px|Aircraft Carrier Summer Princess|link=Aircraft Carrier Summer Princess]]',
        ["european_princess[%s$]"] = '[[File:Seikan1755Banner.png|2|160px|European Princess|link=European Princess]]',
        ["european_princess_damaged[%s$]"] = '[[File:Seikan1758Banner.png|2|160px|European Princess - Damaged|link=European Princess]]',
        ["night_strait_princesses[%s$]"] = '[[File:Seikan1767Banner.png|2|160px|Night Strait Princesses|link=Night Strait Princesses]]',
        ["night_strait_princesses_damaged[%s$]"] = '[[File:Seikan1770Banner.png|2|160px|Night Strait Princesses - Damaged|link=Night Strait Princesses]]',
        ["entombed_aa_guardian_princess[%s$]"] = '[[File:Seikan1773Banner.png|2|160px|Entombed Anti-Air Guardian Princess|link=Entombed Anti-Air Guardian Princess]]',
        ["escort_water_princess[%s$]"] = '[[File:Seikan1783Banner.png|2|160px|Escort Water Princess|link=Escort Water Princess]]',
        ["escort_water_princess_damaged[%s$]"] = '[[File:Seikan1786Banner.png|2|160px|Escort Water Princess - Damaged|link=Escort Water Princess]]',
        ["battleship_princess_kai[%s$]"] = '[[File:Seikan1790Banner.png|2|160px|Battleship Princess Kai|link=Battleship Princess Kai]]',
        ["battleship_water_demon_kai[%s$]"] = '[[File:Seikan1793Banner.png|2|160px|Battleship Water Demon Kai|link=Battleship Water Demon Kai]]',
        ["battleship_water_demon_kai_damaged[%s$]"] = '[[File:Seikan1796Banner.png|2|160px|Battleship Water Demon Kai - Damaged|link=Battleship Water Demon Kai]]',
        ["abyssal_crane_princess[%s$]"] = '[[File:Seikan1799Banner.png|2|160px|Abyssal Crane Princess|link=Abyssal Crane Princess]]',
        ["abyssal_crane_princess_damaged[%s$]"] = '[[File:Seikan1802Banner.png|2|160px|Abyssal Crane Princess - Damaged|link=Abyssal Crane Princess]]',
        ["new_submarine_hime_vacation[%s$]"] = '[[File:Seikan1805Banner.png|2|160px|New Submarine Princess - Vacation Mode|link=New Submarine Princess - Vacation Mode]]',
        ["supply_depot_hime_vacation[%s$]"] = '[[File:Seikan1809Banner.png|2|160px|Supply Depot Princess - Vacation Mode|link=Supply Depot Princess - Vacation Mode]]',
        ["supply_depot_hime_vacation_damaged[%s$]"] = '[[File:Seikan1812Banner.png|2|160px|Supply Depot Princess - Vacation Mode - Damaged|link=Supply Depot Princess - Vacation Mode]]',
        ["anchorage_water_demon_vacation_form1[%s$]"] = '[[File:Seikan1815Banner.png|2|160px|Anchorage Water Demon - Vacation Mode|link=Anchorage Water Demon - Vacation Mode]]',
        ["anchorage_water_demon_vacation_form2[%s$]"] = '[[File:Seikan1818Banner.png|2|160px|Anchorage Water Demon - Vacation Mode|link=Anchorage Water Demon - Vacation Mode]]',
        ["german_escort_hime[%s$]"] = '[[File:Seikan1821Banner.png|2|160px|German Escort Princess|link=German Escort Princess]]',
        ["german_escort_hime_damaged[%s$]"] = '[[File:Seikan1824Banner.png|2|160px|German Escort Princess - Damaged|link=German Escort Princess]]',
        ["dock_princess[%s$]"] = '[[File:Seikan1827Banner.png|2|160px|Dock Princess|link=Dock Princess]]',
        ["dock_princess_damaged[%s$]"] = '[[File:Seikan1830Banner.png|2|160px|Dock Princess - Damaged|link=Dock Princess]]',
        ["french_battleship_princess_vacation[%s$]"] = '[[File:Seikan1834Banner.png|2|160px|French Battleship Princess - Vacation Mode|link=French Battleship Princess - Vacation Mode]]',
        ["french_battleship_princess_vacation_damaged[%s$]"] = '[[File:Seikan1837Banner.png|2|160px|French Battleship Princess - Vacation Mode - Damaged|link=French Battleship Princess - Vacation Mode]]',
        ["european_water_princess[%s$]"] = '[[File:Seikan1840Banner.png|2|160px|European Water Princess|link=European Water Princess]]',
        ["european_water_princess_damaged[%s$]"] = '[[File:Seikan1843Banner.png|2|160px|European Water Princess - Damaged|link=European Water Princess]]',
        ["abyssal_nimbus_princess[%s$]"] = '[[File:Seikan1846Banner.png|2|160px|Abyssal Nimbus Princess|link=Abyssal Nimbus Princess]]',
		["abyssal_nimbus_princess_damaged[%s$]"] = '[[File:Seikan1849Banner.png|2|160px|Abyssal Nimbus Princess - Damaged|link=Abyssal Nimbus Princess]]',
		["abyssal_sun_princess[%s$]"] = '[[File:Seikan1852Banner.png|2|160px|Abyssal Sun Princess|link=Abyssal Sun Princess]]',
        ["abyssal_sun_princess_damaged[%s$]"] = '[[File:Seikan1855Banner.png|2|160px|Abyssal Sun Princess - Damaged|link=Abyssal Sun Princess]]',
        ["blue_heavy_cruiser_hime[%s$]"] = '[[File:Seikan1863Banner.png|2|160px|Heavy Cruiser Princess|link=Heavy Cruiser Princess]]',
        ["blue_heavy_cruiser_hime_final_form[%s$]"] = '[[File:Seikan1864Banner.png|2|160px|Heavy Cruiser Princess|link=Heavy Cruiser Princess]]',
        ["northern_little_sister[%s$]"] = '[[File:Seikan1865Banner.png|2|160px|Nothern Little Sister|link=Nothern Little Sister]]',
        ["northern_little_sister_damaged[%s$]"] = '[[File:Seikan1868Banner.png|2|160px|Nothern Little Sister - Damaged|link=Nothern Little Sister]]',
    }

    if str ~= nil then

        local originalString = str
        str = string.lower(str)

        for vesselName,wikicode in pairs(enemyShipTable) do
            str = str:gsub(vesselName,wikicode)
        end
        local i = 0
        local count = 0
        while i ~= nil do
            _, i = string.find(str,"]]",i)
            if i ~= nil then
                count = count + 1
                if count % 6 == 0 and str ~= nil then
                	str = str:sub(0,i) .. "<br>" .. str:sub(i+1,#str)
                end
            end
        end
        if count == 0 or string.find(string.lower(str),"maelstrom") ~= nil then
            str = originalString
        end
        for word,replacement in pairs(nodeInfoImageTable) do
            str = str:gsub(word,replacement)
        end
        for form,wikicode in pairs(formTable) do
            str = str:gsub(form,wikicode)
        end
        return str
    else
        return "Nil was passed instead of a string"
    end
end

function p.test1()
    return p.encounterTemplate({
        args = {
            ["C_label"] = "C_label",
            ["C1_node_info"] = "C1_node_info",
            ["C1_form"] = "C1_form",
            ["C1_xp"] = "C1_xp",
            ["C1_enemy_air_power"] = "123",
            ["C2_node_info"] = "C2_node_info",
            ["C2_form"] = "C2_form",
            ["C2_xp"] = "C2_xp",
            ["C2_enemy_air_power"] = "123",
            ["ZZ3_label"] = "ZZ3-label",
            ["ZZ3-1_node_info"] = "ZZ3-1_node_info",
            ["ZZ3-1_form"] = "ZZ3-1_form",
            ["ZZ3-1_xp"] = "ZZ3-1_xp",
            ["ZZ3-1_enemy_air_power"] = "123",
            ["ZZ3-2_node_info"] = "ZZ3-2_node_info",
            ["ZZ3-2_form"] = "ZZ3-2_form",
            ["ZZ3-2_xp"] = "ZZ3-2_xp",
            ["ZZ3-2_enemy_air_power"] = "123",
        }
    })
end

function p.test2()
    return p.encounterTemplate({
        args = {
            ["A1_xp"] = "900",
            ["A1_lv"] = "< 80",
            ["A1_node_info"] = "...",
            ["A1_form"] = "line_ahead",
            "",
            ["A2_xp"] = "9000",
            ["A2_lv"] = "> 80",
            ["A2_node_info"] = "fuel +50 75 100 125",
            ["A2_enemy_air_power "] = "33",
            "",
            ["B1_xp"] = "900",
            ["B1_node_info"] = "Maelstrom fuel -50",
            ["B_label"] = "敵前衛警戒部隊 <br> <span style=\"color:yellow\">Day Battle</span>",
            ["final_form "] = "A2",
            ["post_final_form "] = "A1",
        }
    })
end

function p.test3()
    return p.encounterTemplate({
        args = {
            ["Z1_label"] = "深海任務部隊 艦載機空襲",
            ["Z1-1_node_info"] = "1",
            ["Z1-1_form"] = "diamond",
            ["Z1-1_xp"] = "1",
            ["Z1-1_enemy_air_power"] = "151",
            ["Z1-2_node_info"] = "2",
            ["Z1-2_form"] = "diamond",
            ["Z1-2_xp"] = "1",
            ["Z1-2_enemy_air_power"] = "226",
            ["Z1-3_node_info"] = "3",
            ["Z1-3_form"] = "diamond",
            ["Z1-3_xp"] = "1",
            ["Z1-3_enemy_air_power"] = "123",
            "",
            ["final_form"] = "Z1-3",
            ["boss_node"] = "Z1",
        }
    })
end

function p.tests()
    mw.log(p.test1())
    mw.log(p.test2())
    mw.log(p.test3())
end

return p