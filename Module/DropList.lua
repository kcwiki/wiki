local find = require('Module:Core').includes
local format = require('Module:Core').format
local getArgs = require('Module:GetArgs')
local Ship = require('Module:Ship')
local Formatting = require('Module:Formatting')
local SortId = require('Module:DropList/Sort')

-- * Rarity definitions.

local rare_ships = {
	'Agano', 'Akashi', 'Akitsu Maru', 'Akitsushima', 'Akizuki', 'Amagi', 'Amagiri', 'Amatsukaze', 'Arashi', 
	'Ark Royal', 'Asagumo', 'Asakaze', 'Asashimo', 'Aquila', 'Bismarck', 'Colorado', 'Commandant Teste', 'Daitou', 
	'Etorofu', 'Fletcher', 'Fujinami', 'Fukae', 'Gambier Bay', 'Gangut','Giuseppe Garibaldi', 'Gotland', 
	'Graf Zeppelin', 'Hachijou', 'Hagikaze', 'Hamanami', 'Harukaze', 'Harusame', 'Hatakaze', 'Hatsukaze', 
	'Hatsuzuki', 'Hayanami', 'Hayashimo', 'Hayasui', 'Hiburi', 'I-13', 'I-14', 'I-26', 'I-400', 'I-401', 'Intrepid', 
	'Ishigaki',  'Iowa', 'Isokaze', 'Jervis', 'Johnston', 'Kamikaze', 'Kamoi', 'Kashima', 'Kasuga Maru', 'Katsuragi', 
	'Kawakaze', 'Kazagumo', 'Kishinami', 'Kiyoshimo', 'Kunashiri', 'Libeccio', 'Littorio', 'Luigi Torelli', 'Maikaze', 
	'Maestrale', 'Matsuwa', 'Maruyu', 'Matsukaze', 'Mikuma', 'Minazuki', 'Minegumo', 'Mizuho', 'Musashi', 'Nelson', 
	'Nisshin', 'Noshiro', 'Nowaki', 'Okinami', 'Ooyodo', 'Oyashio', 'Pola', 'Prinz Eugen', 'Richelieu', 'Roma', 'Sado', 
	'Sagiri', 'Sakawa', 'Samuel B. Roberts', 'Saratoga', 'Shimushu', 'Shinyou', 'Suzutsuki', 'Taigei', 'Taihou', 
	'Takanami', 'Tanikaze', 'Tashkent', 'Teruzuki', 'Tokitsukaze', 'Tsushima', 'U-511', 'Umikaze', 'Unryuu', 
	'Uranami', 'Uzuki', 'Warspite', 'Yahagi', 'Yamakaze', 'Yamato', 'Z1', 'Z3', 'Zara',

	'Mikura', 'Grecale', 'Duca degli Abruzzi', 'Janus',
	
	'Houston', 'De Ruyter', 'Perth', 'Shinshuu Maru',
	
	'Akishimo', 'Hirato', 'Atlanta',
	
	'Usugumo', 'I-47', 'Matsu', 'Jingei', 'Kaiboukan No.4',
	
	'Ariake', 'Helena', 'Yashiro', 'South Dakota', 'Hornet',
	
	'Scirocco', 'Sheffield', 'Washington', 'Take',
	
	'Momo', 'I-203', 'Northampton', 'Makinami',
	
	'Honolulu', 'Suzunami', 'Souya',
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

-- * Definitions for formatter.

local diff_colors = {
    ['Casual']  = 'E8F5E9',
	['Easy']    = 'C8E6C9',
	['Medium']  = 'FFE0B2',
	['Hard']    = 'FFCDD2',
	['?']       = 'BBDEFB',
	['Regular'] = 'C8E6C9', -- (default color)
}

local diff_names = {
    ['Casual']  = 'Casual+',
	['Easy']    = 'Easy+',
	['Medium']  = 'Medium+',
	['Hard']    = 'Hard+',
	['?']       = '?',
	['Regular'] = '✓',
}

local rarity_colors = {
	[true] = {
		[false] = '',      -- ignored, non-rare (default color)
		[true]  = '',      -- ignored, rare (default color)
	},
	[false] = {
		[false] = 'green', -- non-ignored, non-rare
		[true]  = 'red',   -- non-ignored, rare
	},
}

local table_format = {
	-- header           = '{| class="article-table sortable center ${classes}" width="100%" style="text-align:center; line-height:15px;"\n!Type\n!<span style="border-bottom:1px dotted;">Ship<sup>[[Template:DropList/doc|?]]</sup></span>\n',
    header           = '{|class="wikitable mw-collapsible mw-collapsed" width="50%" style="text-align:center"\n!colspan="100"|Ship drops\n|-\n!Type\n!Ship\n',
	header_node      = '!${node}\n',
	header_boss_node = '!style="background-color:#FFCDD2;color:red"|\'\'\'${node}\'\'\'\n',
	row              = '|-\n', -- class="toggle-target-droplist-non-rare-ship" style="display:none;"
	rare_row         = '|-\n',
	type_cell        = '|${type}\n',
	-- TODO: japanese tooltips
	ship_cell        = '|[[${ship}|<span style="color:${color}">${ship}</span>]]\n',
	none_cell        = '|None\n',
	node_cell        = '|style="background-color:#${background_color}${color}"|${diff}\n',
	empty_cell       = '|\n',
	footer           = '|}\n',
	debugger         = [[{|style="width:100%" align="center" cellspacing="0" class="article-table mw-collapsible mw-collapsed"
!Notes
|-
|<pre>${debug}</pre>
|}]]
}

-- * Definitions for parser.

local args_grammar = {
	node = '^%s*(%w-)%s*$',
	comma_list = '[^,]+',
	ship_and_nodes = '^%s*(.-)%s*:%s*(.-)%s*$',
	just_node = '^%s*(%w-)%s*$',
	node_and_diff = '^%s*(%w-)%s*/%s*(%S-)%s*$',
	node_diff_tooltip = '^%s*(%w-)%s*/%s*(%S-)%s*{(.-)}%s*$',
	node_diff_tooltip_s = '^%s*(%w-)%s*/%s*(%S-)%s*{(.-)}%s*S%s*$',
	just_node_diff = '^%s*(%w-)%s*/%s*(%S-)%s*$',
	just_node_diff_s = '^%s*(%w-)%s*/%s*(%S-)%s*S%s*$',
	-- TODO:
	-- * just_node_tooltip
	-- * Add battle ranks:
	-- node_diff_rank = '^%s*(%a)%s*/%s*(%S-)%s*/%s*(%a)%s*$',
	-- * Hide difficulty:
	-- node_rank = '^%s*(%a)%s*//%s*(%a)%s*$',
	-- * Tooltips with extra info?
}

-- * Parser.

function parseArgs(args)

	local tbl = { nodes = {}, rows = {}, debug = '', classes = args.classes }

	function log(message, value)
		tbl.debug = tbl.debug .. string.format('%s: %s\n', message, value)
	end

	local regular = args.regular

	if not args.nodes then
		log('info', 'empty table')
		return tbl
	end

	local boss_nodes = {}
	for boss_node_ in string.gmatch(args.boss or "", args_grammar.comma_list) do
		local boss_node = boss_node_:match(args_grammar.node)
		if boss_node then
			local boss_node = string.upper(boss_node)
			if find(boss_nodes, boss_node) then
				log('boss node duplicate', boss_node)
			else
				table.insert(boss_nodes, boss_node)
			end
		else
			log('boss node syntax error', boss_node_)
		end
	end
	if #boss_nodes == 0 then
		log('warning', 'no boss node(s) specified')
	end

	for node_ in string.gmatch(args.nodes, args_grammar.comma_list) do
		local node = node_:match(args_grammar.node)
		if node then
			local node = string.upper(node)
			if find(tbl.nodes, node, 'name') then
				log('node duplicate', node)
			else
				local is_boss = find(boss_nodes, node)
				table.insert(tbl.nodes, { name = node, boss = is_boss })
			end
		else
			log('node syntax error', node_)
		end
	end
	for _, boss_node in pairs(boss_nodes) do
		if not find(tbl.nodes, boss_node, 'name') then
			log('boss node ignored', boss_node)
		end
	end

	-- ship args
	for arg_name, ship_and_nodes in pairs(args) do
		if tonumber(arg_name) then
			local ship, nodes = ship_and_nodes:match(args_grammar.ship_and_nodes)
			if ship and nodes then
				local ship_table = ship == 'None' and { _type = '' } or Ship:get_table(ship, '')
				if ship_table and ship_table._type then
					local ignored, rare = find(ignored_ships, ship), find(rare_ships, ship)
					if find(tbl.rows, ship, 'ship') then
						log('ship duplicate', ship)
					elseif not regular and ignored then
						log('ship ignored', ship)
					else
						table.insert(tbl.rows, {
							ship = ship,
							rare = rare,
							ignored = ignored,
							regular = regular,
							ship_color = rarity_colors[ignored][rare],
							type = Formatting:format_ship_code(ship_table._type) or '?',
							type_id = ship_table._type or 0,
							sort_id = SortId[ship_table._api_id] or 0,
							nodes = {},
						})
						local row = tbl.rows[#tbl.rows]
						for _, node in pairs(tbl.nodes) do
							row.nodes[node.name] = nil
						end
						for node_arg in string.gmatch(nodes, args_grammar.comma_list) do
						    local s_only = false
							local node, diff, tooltip = node_arg:match(args_grammar.node_diff_tooltip_s)
							if not node then
							    node, diff, tooltip = node_arg:match(args_grammar.node_diff_tooltip)
							else
							    s_only = true
							end
                            if not node then
                                node, diff = node_arg:match(args_grammar.just_node_diff_s)
							    if not node then
							        node, diff = node_arg:match(args_grammar.just_node_diff)
							    else
    							    s_only = true
							    end
                            end
							if not node then
								node, diff = node_arg:match(args_grammar.node_and_diff)
							end
							if not node then
								node = node_arg:match(args_grammar.just_node)
							end
							diff = regular and 'Regular' or diff_names[diff] and diff or '?'
							if node and diff then
								local node = string.upper(node)
								if row.nodes[node] then
									log('ship node duplicate', string.format('%s for %s', node, ship))
								elseif not find(tbl.nodes, node, 'name') then
									log('node ignored', string.format('%s for %s', node, ship))
								else
									row.nodes[node] = {
										color = diff_colors[diff],
										diff = diff_names[diff],
										tooltip = tooltip,
										s_only = s_only,
									}
								end
							else
								log('ship node syntax error', string.format('%s for %s', node_arg, ship))
							end
						end
					end
				else
					log('ship ignored', ship)
				end
			else
				log('ship syntax error', ship_and_nodes)
			end
		end
	end

	return tbl

end

-- * Formatter.

function showTable(tbl)

	local res = format{table_format.header, classes = tbl.classes or ''}

	function add(str)
		res = res .. str
	end

	function add_row(row)
		add(row.rare and table_format.rare_row or table_format.row)
		add(format{table_format.type_cell, type = row.type})
		add(row.ship == 'None' and table_format.none_cell or format{table_format.ship_cell, color = row.ship_color, ship = row.ship})
		for _, node in pairs(tbl.nodes) do
			local node = row.nodes[node.name]
			add(node and format{
				table_format.node_cell,
				background_color = node.color,
				color = node.s_only and ';color:red' or '',
				diff = node.tooltip and Formatting:tooltip2(node.diff, node.tooltip:gsub("@", " / @@"), " / ", "@") or node.diff
			} or table_format.empty_cell)
		end
	end

	-- header
	for _, node in pairs(tbl.nodes) do
		add(format{
			node.boss and table_format.header_boss_node or table_format.header_node,
			node = node.name
		})
	end
	
    -- true when the first is less than the second (so that not comp(a[i+1],a[i]) will be true after the sort). If comp is not given, then the standard Lua operator < is used instead.
	
	table.sort(tbl.rows, function(a, b)
		if a.type_id < b.type_id then
			return true
		elseif a.type_id == b.type_id then
			return a.sort_id < b.sort_id
		else
			return false
		end
	end)

	for _, row in pairs(tbl.rows) do
		if row.rare then
			add_row(row)
		end
	end
	for key, row in pairs(tbl.rows) do
		if not row.rare and not row.ignored then
			add_row(row)
		end
	end
	for key, row in pairs(tbl.rows) do
		if row.ignored then
			add_row(row)
		end
	end

	add(table_format.footer)

	if tbl.debug ~= '' and tbl.log then
		add(format{table_format.debugger, debug = tbl.debug})
	end

	return res

end

local DropList = {}

function DropList.show(frame, args_)
	local args = args_ or getArgs{frame = frame:getParent()}
	return showTable(parseArgs(args))
end

return DropList