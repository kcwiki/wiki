local U = require("Module:Core")
local format = require('Module:Core').format
local BaseTable = require("Module:BaseTable")
local EnemyShip = require("Module:EnemyShip")
local Formatting = require('Module:Formatting')
local ShipBattleCardKai = require("Module:ShipBattleCardKai")
local ShipsByApiId = require('Module:Collection/ShipsByApiId')
local VitaShipsByApiId = require('Module:Collection/VitaShipsByApiId')
local mapNodeTranslations = require('Module:Data/Map/Translation')

local NodeInfo = BaseTable({
    _item_class = EnemyShip,
    _table_start = [[{|class="wikitable" style="width:690px"]],
    _table_start_style = [[{|class="wikitable" style="width:690px;margin-bottom:%spx !important"]],
    _header_template = [[!#
!Formation
!${node_type}
!AD/AP<br>AS/AS+]],
    _header_template_simple = [[!#
!colspan="3"|${node_type}]],
	_header_template_basexp = [[!#
!Enemy<br>Form.
!Base EXP
!${node_type}
!AD/AP<br>AS/AS+]],
    _column_cell_templates = {
        node = [[|colspan="${colspan}" rowspan="${rowspan}" style="text-align:center;color:${color};background-color:${bg_color}"|${values.node}]],
        formation = [[|style="text-align:center;background-color:${bg_color};color:${color}"|${values.formation}]],
        fleet = [[|style="width:485px;padding-left:8px;background-color:${bg_color};"|<div style="display:table-row;font-size:0px">${values.fleet}</div>]],
        as = [[|style="text-align:center;background-color:${bg_color};color:${color};"|${values.as}]],
    },
    _column_cell_templates_basexp = {
        node = [[|colspan="${colspan}" rowspan="${rowspan}" style="text-align:center;color:${color};background-color:${bg_color}"|${values.node}]],
        formation = [[|style="text-align:center;background-color:${bg_color};color:${color}"|${values.formation}]],
        basexp = [[|style="text-align:center;background-color:${bg_color};color: ${color}"|${values.basexp}]],
        fleet = [[|style="width:485px;padding-left:8px;background-color:${bg_color}"|<div style="display:table-row;font-size:0px">${values.fleet}</div>]],
        as = [[|style="text-align:center;background-color:${bg_color};color: ${color}" |${values.as}]],
    },

    _simple_node_template = [[|style="text-align:center"|${node}
|colspan="3" style="text-align:center"|<span lang="ja">${ja}</span><br>${en}]],

    _empty_node_en = 'Must be my imagination./No enemy spotted./Calm seas./Calm straits./Be alert./Peaceful seas.',
    _empty_node_ja = '気のせいだった。/敵影を見ず。/穏やかな海です。/穏やかな海峡です。/警戒が必要です。/静かな海です。',

    _select_node_en = 'You can decide the fleet\'s course. Admiral, which heading should we take?',
    _select_node_ja = '艦隊の針路を選択できます。提督、どちらの針路をとられますか？',

    _resource_node_template = [[|style="text-align:center;background-color:${values.bg_color};color:${values.color}"|${values.node}
|colspan="3" style="text-align:center;background-color:${values.bg_color};color:${values.color}"|${values.text}]],

    _collapser_template = [[<div class="mw-customtoggle-${toggle_id} wikia-menu-button">${button_display}</div>
<div class="mw-collapsible mw-collapsed" id="mw-customcollapsible-${toggle_id}">]],

    _collapser_end = [[</div>]],
    _columns = {
        "node",
        "formation",
        "fleet",
        "as",
    },
    _columns_basexp = {
        "node",
        "formation",
	    "basexp",
        "fleet",
        "as",
    },
    _day_battle_color = "gold",
    _night_battle_color = "blue",
    _night_battle_bg_color = "lightblue", -- #BBDEFB
    _aerial_battle_bg_color = "lightgreen", -- #C8E6C9
    _defense_battle_bg_color = "#81C784",
    _raid_battle_bg_color = "#81C784",
    -- _ha_raid_battle_bg_color = "#43A047",
    _boss_battle_color = "red",
    _clear_battle_color = "blue",
    _ambush_battle_bg_color = "#FFB74D",
})
 
function NodeInfo:node(row)
    local color, bg_color = "initial", "initial"
    if row.tags.boss then
        color = self._boss_battle_color
    end
    if row.tags.aerial then
        bg_color = self._aerial_battle_bg_color
    end
    if row.tags.defense then
        bg_color = self._defense_battle_bg_color
    end
    if row.tags.dogfight then
        bg_color = self._defense_battle_bg_color
    end
    if row.tags.raid then
        bg_color = self._raid_battle_bg_color
    end
    if row.tags.night then
        bg_color = self._night_battle_bg_color
    end
    if row.tags.nighttoday then
        bg_color = self._night_battle_bg_color
    end
    if row.tags.ambush then
        bg_color = self._ambush_battle_bg_color
    end
    return { values = { node = row.node }, color = color, bg_color = bg_color }
end

function NodeInfo:formation(row)
    if row.tags.final then
        row.formation = row.formation .. "<br /><div style='font-weight:bold; color:red;'>(Final)</div>"
    end
    if row.tags.clear then
        row.formation = row.formation .. "<br /><div style='font-weight:bold; color:blue;'>(Clear)</div>"
    end
    if row.tags.has_lbas_ha_bomber then
        row.formation = row.formation .. '<br /><span class="explain" title="High Altitude Air Raid, 2-3 Rocket Interceptors are recommended">(HA)</span>'
    end
    return {
        values = { formation = row.formation },
        color = row.tags.boss and self._boss_battle_color or 'initial',
        -- bg_color = row.tags.has_lbas_ha_bomber and self._ha_raid_battle_bg_color or 'initial',
    }
end
 
function NodeInfo:basexp(row)
    return {
        values = { basexp = row.basexp },
        color = row.tags.boss and self._boss_battle_color or 'initial',
    }
end
 
function NodeInfo:fleet(row)
    return {
        values = { fleet = row.fleet },
        -- bg_color = row.tags.has_lbas_ha_bomber and self._ha_raid_battle_bg_color or 'initial',
    }
end
 
function NodeInfo:create_as_string(as, as_complete, oneline)
    local air_denial_string = "?"
    local air_parity_string = "?"
    local air_superiority_string = "?"
    local air_supremacy_string = "?"
    if as_complete then
        local air_denial = as > 0 and math.floor(as / 3 + 1) or 0
        local air_parity = as > 0 and math.floor(as * 2 / 3 + 1) or 0
        local air_superiority = math.ceil(as * 3 / 2)
        local air_supremacy = as * 3
        air_denial_string = string.format("%.1d", air_denial)
        air_parity_string = string.format("%.1d", air_parity)
        air_superiority_string = string.format("%.1d", air_superiority)
        air_supremacy_string = string.format("%.1d", air_supremacy)
    end
    local air_string = air_denial_string .. "/" .. air_parity_string .. "<br>" .. air_superiority_string .. "/" .. air_supremacy_string
    if oneline then
        air_string = air_string:gsub("<br>", "/")
    end
    return air_string
end

function NodeInfo:as(row)
    return {
        values = { as = row.as },
        color = row.tags.boss and self._boss_battle_color or 'initial',
        -- bg_color = row.tags.has_lbas_ha_bomber and self._ha_raid_battle_bg_color or 'initial',
    }
end

function NodeInfo:upcase(str)
    str = str:gsub("(%s)(%l)", function(a, b) return a .. string.upper(b) end)
    str = str:gsub("^(%l)", function(a) return string.upper(a) end)
    return str
end
 
function NodeInfo:insert_item(node, formation, basexp, fleet, as, tags, as_complete, aslb)
    local as_string = self:create_as_string(as, as_complete, false)
    local air_string =  as_string
    if tags.showlb then
       local aslb_string = self:create_as_string(aslb, as_complete, true)
       air_string = "<span class='explain' title='LBAS: " .. aslb_string .. "'>" .. as_string .. "</span>"
    end
    self._number_of_formations = self._number_of_formations + 1
	table.insert(self._items, {
		node = node,
		formation = formation,
		basexp = basexp ~= 0 and basexp or false,
		fleet = fleet,
		as = air_string,
		tags = tags,
	})
end

function NodeInfo:create_table_prep()
	self._number_of_formations = 0
end
 
function NodeInfo:create_items()
    --Modes are as follows:
    --1 = Node
    --2 = Tag processing
    --3 = Resource type
    --4 = Amount of resources
    --5 = Formation
    --6 = Base node exp
    --7 = Fleet building
    local mode = 1
 
    local node, formation, basexp = nil, nil, 0
    local fleet = {}
    local as_rating, as_rating_lb, as_complete = 0, 0, true
 
    local tags = {}
    local resource
    
    local i = 0
	
	for index, item_key in ipairs(self._args) do
        if item_key == "-" then
            i = 0
            if mode == 7 then --We're at a break and have built a full row; time to insert it
                self:insert_item(node, formation, basexp, table.concat(fleet, " "), as_rating, tags, as_complete, as_rating_lb)
            end
            table.insert(self._items, "break")
            fleet, as_rating, as_rating_lb, as_complete = {}, 0, 0, true
            tags = {}
            mode = 1
		else
		    if mode == 1 then
		        i = 0
		        --First item should always be the node
		        node = item_key
		        mode = 2
		    elseif mode == 2 then
		        i = 0
		        self._node_type = string.lower(string.match(item_key, "(.-)/") or item_key)
		        if mw.ustring.find(string.lower(item_key), "resource") or string.lower(item_key) == "storm" then
		            local split = mw.ustring.find(item_key, '/')
		            if split then
		                tags[string.lower(mw.ustring.sub(item_key, 1, split - 1))] = true
		                item_key = mw.ustring.sub(item_key, split + 1)
		            end
		            tags[string.lower(item_key)] = true
		            mode = 3
		        elseif string.lower(item_key) == "empty" then
		            table.insert(self._items, node .. "/empty")
		            mode = 1
		        elseif string.lower(item_key) == "select" then
		            table.insert(self._items, node .. "/select")
		            mode = 1
		        else
		            while mw.ustring.find(item_key, '/') do
		                local split = mw.ustring.find(item_key, '/')
		                tags[string.lower(mw.ustring.sub(item_key, 1, split - 1))] = true
		                item_key = mw.ustring.sub(item_key, split + 1)
		            end
		            tags[string.lower(item_key)] = true
		            if tags.basexp then
		                -- used to communicate the need to account for node xp while building rows\
		                self._is_basexp = true
		            end
		            mode = 5
		        end
		    elseif mode == 3 then
		        i = 0
		        resource = self:upcase(item_key)
		        mode = 4
		    elseif mode == 4 then
		        i = 0
		        local amount = item_key
		        if tags["storm"] and mw.ustring.sub(amount, 1, 1) ~= "-" then
		            amount = "-" .. amount
		        end
		        local boss = tags["boss"] and "true" or "false"
		        local string = node .. "/" .. resource .. "/" .. amount .. "/" .. boss
		        table.insert(self._items, string)
		        mode = 1
		    elseif mode == 5 then
		        i = 0
		        formation = self:upcase(item_key)
		        mode = 6
		    else
		        -- Only add basexp to the list of values if included as a tag
		        if mode == 6 and tags.basexp then
		            i = 0
		            basexp = item_key
		            mode = 7
		        else
		            i = i + 1
		            --Fleets are of variable size, so we append onto a string until we hit the next node declaration
		            local id = tonumber(item_key)
		            local isVita = self._params.fullpagename:sub(1, 13) == 'KanColle Kai:'
		            if id then
		                if isVita then
		                    local vitaName = VitaShipsByApiId[id]
		                    if id >= 501 and id < 700 then
		                        id = id + 1000
		                    end
		                    item_key = vitaName and ('Vita:' .. vitaName) or ShipsByApiId[id] or item_key
		                else
		                    item_key = ShipsByApiId[id] or item_key
		                end
		            end
		            
		            local split = mw.ustring.find(item_key, '/')
		            local ship_name, ship_suffix
		            if split then
		                ship_name = mw.ustring.sub(item_key, 1, split - 1)
		                ship_suffix = mw.ustring.sub(item_key, split + 1)
		            else
		                ship_name = item_key
		                ship_suffix = ""
		            end

		            local ship = EnemyShip(ship_name, ship_suffix)
		            local ship_air_power = ship:air_power(tags.raid)
		            local ship_air_power_lb = ship:air_power(true)

		            if not tags.has_lbas_ha_bomber and ship:has_lbas_ha_bomber() then
		                tags.has_lbas_ha_bomber = true
                    end

		            local ship_caption =
		                (ship:name() or "?")
		                .. " (" .. Formatting:format_enemy_stat(ship:api_id(), isVita) .. "): "
		                .. (ship:armor() or "?") .. " Armor, " .. (ship:hp() or "?") .. " HP"
		                .. (ship_air_power ~= 0 and ", " .. (ship_air_power or "?") .. " AP" or "")
		                
		            table.insert(fleet, ShipBattleCardKai:get{
		                ship = ship,
		                caption = ship_caption,
		                link = ship:link(),
		                flagship = #fleet == 0,
		            })
		        
		            if i % 6 == 0 then
		                table.insert(fleet, "<br>")
		            end

		            if ship_air_power then
		                as_rating = as_rating + ship_air_power
		                as_rating_lb = as_rating_lb + ship_air_power_lb
		            else
		                as_complete = false
		            end
		            if mode == 6 then
		                mode = 7
		            end
		        end
		    end
		end
    end
    if mode == 7 then
        self:insert_item(node, formation, basexp, table.concat(fleet, " "), as_rating, tags, as_complete, as_rating_lb)
    end
end
 
function NodeInfo:create_data_rows()
    for index, item in ipairs(self._items) do
		local row_values
		if type(item) == "string" then
		    row_values = item
		else
		    local columnuse = nil
		    if item.tags.basexp then
		        columnuse = self._columns_basexp
		    else
		        columnuse = self._columns
		    end
		    
		    row_values = {}
		    for _, column in ipairs(columnuse) do
		        row_values[column] = self[column](self, item)
		    end
		    if index > 1 then
		        for _, column in ipairs(columnuse) do
		            for i = index - 1, 1, -1 do
		                if column == "node" then
		                    local previous_cell = self._data_rows[i][column]
		                    if previous_cell then
		                        if row_values[column].values.node == previous_cell.values.node then
		    				    	previous_cell.rowspan = previous_cell.rowspan and previous_cell.rowspan + 1 or 2
		    				    	row_values[column] = nil
		    				    else
		    				        row_values[column].rowspan = 1
		    				        row_values[column].colspan = 1
		    				    end
		    				    break
		    				end
		    			end
		            end
		        end
		    else
		        for _, column in ipairs(columnuse) do
		            row_values[column].rowspan = 1
		            row_values[column].colspan = 1
		        end
		    end
		end
		table.insert(self._data_rows, row_values)
	end
end
 
function NodeInfo:format_node_type()
    local node_types = {
        normal = 'Normal Battle Node',
        boss = 'Boss Battle Node',
        resource = 'Resource Node',
        landing = 'Landing Node',
        storm = 'Maelstrom Node',
        empty = 'Empty Node',
        repair = 'Repair Node',
        select = 'Selection Node',
        night = 'Night Battle Node',
        aerial = 'Aerial Battle Node',
        defense = 'Air Defense Node',
        nighttoday = 'Night to Day Battle Node',
        raid = 'Air Raids',
        ambush = 'Ambush Battle Node',
        
        -- older node type names (required to make older event pages work)
        medium = 'Normal Battle Node',
        dogfight = 'Air Defense Node',
    }
    local prefix = self._args.ha and string.format(
        "[[%s/High Altitude Raids|High Altitude]] ",
        U.split(self._params.fullpagename, '/')[1]
    ) or ""
    return self._args["comment"] or (prefix .. node_types[self._node_type]) or "Fleet"
end
 
function NodeInfo:is_simple_node_type()
    return self._node_type == 'resource' or self._node_type == 'storm' or self._node_type == 'empty' or self._node_type == 'select' or self._node_type == 'landing' or self._node_type == 'repair'
end
 
function NodeInfo:create_header()
	local header_string = nil
	if self:is_simple_node_type() then
		header_string = format{
		    self._header_template_simple,
		    node_type = self:format_node_type()
		}
	elseif self._is_basexp then
		header_string = format{
		    self._header_template_basexp,
		    node_type = self:format_node_type()
		}
	else
		header_string = format{
		    self._header_template,
		    node_type = self:format_node_type()
		}
	end
    self._header = header_string
    self._header_bottom = header_string
end
 
function NodeInfo:start_rows()
    self._rows = {}
 
    if self._args["toggle_id"] then
        table.insert(self._rows, format{self._collapser_template,
            toggle_id = self._args["toggle_id"],
            button_display = self._args["button_display"] or "Show/Hide Formation Table",
        })
    end
 
	if self._args.margin then
		local bottom_margin = 500 - (50 * 2 + 50 * self._number_of_formations + 15 * 2 + 30)
		table.insert(self._rows, string.format(self._table_start_style, bottom_margin))
	else
		table.insert(self._rows, self._table_start)
	end

    table.insert(self._rows, self._header)
end
 
function NodeInfo:process_resource_node(resource, amount)
    --Amount may or may not be just numbers
    local action, units, node_type, bg_color = "Gained", "", "Resource", self._resource_node_bg_color
 
    if mw.ustring.sub(amount, 1, 1) == "-" then
        action = "Lost"
        amount = mw.ustring.sub(amount, 2)
        node_type = "Storm"
        bg_color = self._maelstrom_node_bg_color
    end
 
    if mw.ustring.find(amount, " ") then
        local split = mw.ustring.find(amount, " ")
        units = mw.ustring.sub(amount, split + 1)
        amount = mw.ustring.sub(amount, 1, split - 1)
    end
 
    local text = action .. " " .. amount .. " " .. resource .. " " .. units
    return text, node_type, bg_color
end

function NodeInfo:build_rows()
    local bg_color
    for index, row_values in ipairs(self._data_rows) do
        if row_values ~= "break" then
            table.insert(self._rows, self._row_starter)
            if row_values == "header" then
			    table.insert(self._rows, self._header)
			elseif type(row_values) == "table" then
			    if row_values["node"] then
			        bg_color = row_values["node"].bg_color
			    elseif bg_color == nil then
			        bg_color = "initial"
			    end
			    if self._is_basexp then
			        for _, column in ipairs(self._columns_basexp) do
			            if row_values[column] then
			                row_values[column].bg_color = bg_color
			            end
			            if row_values[column] then
			                table.insert(self._rows, format(self._column_cell_templates_basexp[column] or self._cell, row_values[column]))
			            end
			        end
			    else
			        for _, column in ipairs(self._columns) do
			            if row_values[column] then
			                row_values[column].bg_color = bg_color
			            end
			            if row_values[column] then
			                table.insert(self._rows, format(self._column_cell_templates[column] or self._cell, row_values[column]))
			            end
			        end
			   end
    	    elseif mw.ustring.find(row_values, '/') then
    	        --node/resource/amount/boss
    	        local values = {}
    	        while mw.ustring.find(row_values, '/') do
    	            local split = mw.ustring.find(row_values, '/')
    	            if split then
    	                table.insert(values, mw.ustring.sub(row_values, 1, split - 1))
    	                row_values = mw.ustring.sub(row_values, split + 1)
    	            end
	            end
	            table.insert(values, row_values)
	            local world = self._args.world or self._params.world
	            local map = self._args.map or self._params.map
	            local node = values[1]
	            local nodeString = string.format("%s %s %s", world, map, node)
	            local kind = values[2] == "select" and 2 or self._args.kind
	            local nodeText = mapNodeTranslations[kind]
	            local nodeFlavorText = mapNodeTranslations[nodeString]
	            local enText = nodeText and nodeText.en
	            local jaText = nodeText and nodeText.ja
	            if nodeFlavorText then
	                enText = enText and (enText .. '<br>' .. nodeFlavorText.en) or nodeFlavorText.en
	                jaText = jaText and (jaText .. '<br>' .. nodeFlavorText.ja) or nodeFlavorText.ja
	            end
	            if values[2] == "empty" then
	                table.insert(self._rows, format{
	                    self._simple_node_template,
	                    node = node,
	                    en = enText or self._empty_node_en,
	                    ja = jaText or self._empty_node_ja,
	                })
	            elseif values[2] == "select" then
	                table.insert(self._rows, format{
	                    self._simple_node_template,
	                    node = node,
	                    en = enText or self._select_node_en,
	                    ja = jaText or self._select_node_ja,
	                })
    	        else
	                local resource = Formatting:format_image{values[2] .. ".png", caption = self:upcase(values[2]), size = "22x22px"}
	                local text, node_type, bg_color = self:process_resource_node(resource, values[3])
	                local color = "initial"
	                if values[4] == "true" then
	                    color = self._boss_battle_color
	                end
    	            table.insert(self._rows, format{self._resource_node_template, values = {
    	                node = node,
    	                text = text,
    	                color = color,
    	                bg_color = bg_color,
    	            }})
	            end
	         end
	   end
    end
end
 
function NodeInfo:finish_rows()
    table.insert(self._rows, self._row_starter)
	table.insert(self._rows, self._header_bottom or self._header)
	table.insert(self._rows, self._table_end)
	if self._args["toggle_id"] then
	    table.insert(self._rows, self._collapser_end)
    end
end

U.registerTableTests(NodeInfo, {
    { "A", "Normal/Clear", "Line Ahead", "Northern Princess" }
})
-- p.run_table_tests()

return NodeInfo