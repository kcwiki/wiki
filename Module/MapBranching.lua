local p = {}

-- Module for map branching written by
-- Remi_Scarlet
-- I fucking hate lua.

-- 10/24/15 Added colorful blue button thing
-- 5/5/16 Added multiple start location support

local remiLib = require("Module:RemiLib")

function p.renderBranchingTable(graph, collapsed)
	
    local uniqueID = remiLib.timeHash(graph)
    local classString = "mw-customtoggle-" .. tostring(uniqueID)
    local idString = "mw-customcollapsible-" .. tostring(uniqueID)
    
    local button = mw.html.create('div')
    button
    	:addClass(classString)
    	:addClass("globalbutton")
    	:wikitext("Show/Hide Branching Rules")

    local body = mw.html.create("table")
    body
        :addClass("mw-collapsible")
        :addClass("wikitable")
        :addClass("mw-collapsed")
        :attr("id",idString)
        :css("width","300px")
        
    local titleRow = mw.html.create("tr")
    local th = mw.html.create("th")
    th
        :attr("colspan",3) -- "from" node, "to" node, requirement text
        :wikitext("Branching Rules")
        :css("font-weight","bold")
        :css("text-align","center")
    titleRow:node(th)
    body:node(titleRow)
    local headerRow = mw.html.create("tr")
    th = mw.html.create("th")
    th
        :wikitext("Node")
        :css("font-size","15px")
        :css("text-align","center")
    headerRow:node(th)
    th = mw.html.create("th")
    th
        :wikitext("Split")
        :css("font-size","15px")
        :css("text-align","center")
    headerRow:node(th)
    th = mw.html.create("th")
    th
        :wikitext("Condition")
        :css("font-size","15px")
        :css("text-align","center")
    headerRow:node(th)
    body:node(headerRow)
    --
    -- graph should be something like
    -- graph = { ["A"] = {
    --                      ["B"] = "This is branching information from node A to node B",
    --                      ["C"] = "And this from A to C",}
    --           ["B"] = {
    --                      ["D"] = "This one from B to D"}
    --         }
    --
    -- toTable is a table of all the to's
    --
    local possibleNodes = remiLib.mergeArrays({"START", "START-1", "START-2", 
    										    "START-3", "START-4", "START-5"}
    										   ,remiLib.uppercase)
    -- 5/5/16
    -- Since multiple start paths are possible (Eg, starting from two different places)
    -- adding the ability to specify multiple start points. Assuming no more than 5 start points ever lol.
    -- Yeah yeah I get that it's bad code design. Shut up, I don't care enough to put more than 5 minutes of thought into this.
    for _,from in pairs(possibleNodes) do
        if graph[from] ~= nil then
            local toTable = graph[from]
            local tableRow = mw.html.create("tr")
            local col = mw.html.create("td")
            local rowHeight = remiLib.getTableSize(toTable)
            col
                :attr("rowspan",rowHeight)
                :wikitext(from)
                :css("text-align","center")
            tableRow:node(col)
            -- isFirstTo checks if we're on the first alphabetically sorted
            -- instance of the "to" node connecting to a "from" node
            local isFirstTo = true
            for _,toNode in pairs(possibleNodes) do
                if toTable[toNode] ~= nil then
                    if not isFirstTo then
                        tableRow = mw.html.create("tr")
                    end
                    col = mw.html.create("td")

                    col
                        :wikitext(toNode)
                        :css("text-align","center")
                    tableRow:node(col)
                    col = mw.html.create("td")
                    col
                        :wikitext(toTable[toNode])
                        :css("text-align","center")
                    tableRow:node(col)
                    body:node(tableRow)
                    isFirstTo = false
                end
            end
        end
    end
    return tostring(button) .. "\n" .. tostring(body)
end 

function p.branchingTemplate(frame)
    -- implementing graph as an adjacency list
    local mapGraph = {}
    local collapsed = true
    if frame.args["collapsed"] ~= nil and string.lower(frame.args["collapsed"]) == "false" then
        collapsed = false
    end

    for param,value in pairs(frame.args) do
        local split = mw.text.split(param,"_")
        -- length is 3, eg A_to_B or B_to_C
        -- second val in split is "to" as above
        -- first and third should be length 1 cuz they should be singular letters
        if #split == 3 and 
           string.lower(split[2]) == "to" and 
           (#split[1] == 1 or (string.find(string.lower(split[1]),"start") ~= nil)) and 
           (#split[3] == 1 or (string.find(string.lower(split[3]),"start") ~= nil))then
            local from = string.upper(split[1])
            local to = string.upper(split[3])
            if (remiLib.valid(from,remiLib.letters) or (string.find(string.lower(split[1]),"start") ~= nil)) and 
               (remiLib.valid(to,remiLib.letters) or (string.find(string.lower(split[3]),"start") ~= nil))then
                if mapGraph[from] == nil then
                    mapGraph[from] = {}
                end
                mapGraph[from][to] = value
            end
        end
    end
    --local html = remiLib.dictConcat(table.getKeys(mapGraph["START-4"]),"|")
    local html = p.renderBranchingTable(mapGraph,collapsed)

    return html

end

return p