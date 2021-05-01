-- lua port of [[Template:Navbox]]
-- by DennouNeko

-- == Helper functions ==
--[[ libraries ]]
local U = require("Module:Core")

local colors = U.main_colors

if mw.text == nil then mw.text = require("Module:MW.text") end

--[[ Retrieve a full list of 'list#', 'list#style', 'group#' and 'group#style' arguments
     as a table of objects with 'index', 'list', 'liststyle', 'group' and 'groupstyle' fields,
     where 'index' is the number in 'list#' argument name.
     Only 'list' and 'index' are always defined. Elements that weren't specified will be empty.
     If 'list#' wasn't defined, rest of elements for that given index will be ignored.
     Key of argument matches the number in arguments name. ]]
local function scan_lists(frame)
  local idx = {}
  local list = {}
  local group = {}
  local liststyle = {}
  local groupstyle = {}

  local ret = {}

  local s,e,t

  for k,v in frame:argumentPairs() do
    -- accept only parameters without leading zeros
    s,e,t = string.find(k, '^group([1-9]%d*)style$')
    if s ~= nil then groupstyle[tonumber(t)] = v end

    s,e,t = string.find(k, '^list([1-9]%d*)style$')
    if s ~= nil then liststyle[tonumber(t)] = v end

    s,e,t = string.find(k, '^group([1-9]%d*)$')
    if s ~= nil then group[tonumber(t)] = v end

    s,e,t = string.find(k, '^list([1-9]%d*)$')
    if s ~= nil then
      list[tonumber(t)] = v
      idx[#idx+1] = tonumber(t)
    end
  end

  table.sort(idx)

  for k,v in pairs(idx) do
    local tmp = {}
    tmp['index'] = v
    tmp['list'] = list[v]
    if U.isset(group[v]) then tmp['group'] = group[v] end
    if U.isset(liststyle[v]) then tmp['liststyle'] = liststyle[v] end
    if U.isset(groupstyle[v]) then tmp['groupstyle'] = groupstyle[v] end
    ret[#ret+1] = tmp
  end

  return ret
end


-- == Functions generating the document elements ==

--[[ Generates the beginning of box, based on specified 'ttype' and 'border'. ]]
local function start_box(frame, border, ttype)
  local ret = {}
  if border == "subgroup" or border == "child" then
    -- since we're in a cell of parent navbox, we have to close its <div> element
    ret[#ret+1] = '</div>'
  elseif border == "none" then
    -- nothing to do
  else
    -- new, independent navbox - create a frame around it
    ret[#ret+1] = '<table class="navbox'
    if U.isset(frame.args['bodyclass']) then ret[#ret+1] = " " .. frame.args['bodyclass'] end
    ret[#ret+1] = '" cellspacing="0" style="'
    if U.isset(colors[ttype]) then ret[#ret+1] = 'background:' .. colors[ttype]['background'] .. ';' end
    -- ret[#ret+1] = 'border:1px solid #aaa; padding:1px;width:100%;vertical-align:middle;margin:auto;clear:both;font-size:88%;text-align:center;'
    U.addStyle(ret, frame.args['bodystyle'])
    U.addStyle(ret, frame.args['style'])
    ret[#ret+1] = '"><tr><td style="padding: 2px;">'
  end

  -- The actual navbox table starts here
  ret[#ret+1] = '<table cellspacing="0" class="nowraplinks'
  if U.isset(frame.args['title']) and frame.args['state'] ~= "plain" and frame.args['state'] ~= "off" then
    --TODO: If there is support for collapsible and autocollapse, swap comments here
    --ret[#ret+1] = ' collapsible '
    ret[#ret+1] = ' mw-collapsible '
    if U.isset(frame.args['state']) then
      ret[#ret+1] = frame.args['state']
    else
      --ret[#ret+1] = 'autocollapse'
      ret[#ret+1] = 'mw-collapsed'
    end
  end
  if border == "subgroup" or border == "child" or border == "none" then
    ret[#ret+1] = ' navbox-subgroup" style="'
    if U.isset(colors[ttype]) then table.insert(ret, 'background:' .. colors[ttype]['background'] .. ';') end
    -- ret[#ret+1] = 'margin:auto;clear:both;font-size:88%;text-align:center;width:100%;vertical-align:middle;'
    ret[#ret+1] = 'width: 100%;'
    U.addStyle(ret, frame.args['bodystyle'])
    U.addStyle(ret, frame.args['style'])
    ret[#ret+1] = '">'
  else
    ret[#ret+1] = '" style="width:100%;background:transparent;color:inherit;">'
  end

  return table.concat(ret)
end

--[[ Finalizes the box, based on specified 'ttype' and 'border' ]]
local function end_box(frame, border, ttype)
  local ret = {""}
  ret[#ret+1] = '</table>'
  if border == "subgroup" or border == "child" then
    -- open a <div>, since we closed one when starting this child navbox
    ret[#ret+1] = '<div>'
  elseif border == "none" then
    -- nothing to do
  else
    -- close the table we started as a frame
    ret[#ret+1] = '</td></tr></table>'
  end
  return table.concat(ret)
end

--[[ Generates the title row: 'v(iew) • d(iscuss) • e(dit)' + title + '[Expand]'/'[Collapse]' buttons. ]]
local function build_title(frame, border, ttype)
  local ret = {""}
  if not U.isset(frame.args['title']) then return '' end

  table.insert(ret, '<tr>')
  if U.isset(frame.args['titlegroup']) then
    -- in case that there's a group for title
    ret[#ret+1] = '<td class="navbox-group" style="'
    if U.isset(colors[ttype]) then ret[#ret+1] = 'background:' .. colors[ttype]['group'] .. ';' end
    ret[#ret+1] = 'padding-left:1em;padding-right:1em;white-space:nowrap;text-align:right;'
    U.addStyle(ret, frame.args['basestyle'])
    U.addStyle(ret, frame.args['groupstyle'])
    U.addStyle(ret, frame.args['titlegroupstyle'])
    ret[#ret+1] = '">\n'
    ret[#ret+1] = frame.args['titlegroup']
    ret[#ret+1] = '</td>'

    ret[#ret+1] = '<th style="border-left:2px solid '
    ret[#ret+1] = U.cv(U.isset(colors[ttype]), colors[ttype]['background'], '#fdfdfd')
    ret[#ret+1] = ';width:100%;'
  else
    -- no group for title
    table.insert(ret, '<th style="')
  end
  if U.isset(colors[ttype]) then ret[#ret+1] = 'background:' .. colors[ttype]['title'] .. ';' end
  ret[#ret+1] = 'text-align:center;'
  U.addStyle(ret, frame.args['basestyle'])
  U.addStyle(ret, frame.args['titlestyle'])
  ret[#ret+1] = '"'

  -- calculate the colspan for title
  local cs = 2 -- 2 because each list element with group occupies 2 columns
  if U.isset(frame.args['imageleft']) then cs = cs + 1 end
  if U.isset(frame.args['image']) then cs = cs + 1 end
  if U.isset(frame.args['titlegroup']) then cs = cs - 1 end -- if there was a titlegroup, it occupies one cell already
  ret[#ret+1] = ' colspan = "' .. cs .. '"'
  ret[#ret+1] = ' class="navbox-title">'

  -- add navbars and/or padding when needed
  if frame.args['navbar'] == "plain" or frame.args['navbar'] == "off" or border == "subgroup" or border == "child" or border == "none" then
    if frame.args['navbar'] == "off" then
      if frame.args['state'] == "plain" then ret[#ret+1] = '<div style="float:right;width:6em;">&nbsp;</div>' end
    else
      if frame.args['state'] ~= "plain" then ret[#ret+1] = '<div style="float:left; width:6em;text-align:left;">&nbsp;</div>' end
    end
  else
    if frame.args['state'] == "plain" then ret[#ret+1] = '<div style="float:right;width:6em;">&nbsp;</div>' end

    ret[#ret+1] = '<div style="float:left; width:6em;text-align:left;">'
    if frame.args['name'] ~= nil then
      local args = {}
      args[#args+1] = frame.args['name']
      args['mini'] = '1'

      -- TODO: Build the navbar without using external template?
      local q = {""}
      q[#q+1] = 'text-align:left;'
      U.addStyle(q, frame.args['basestyle'])
      U.addStyle(q, frame.args['titlestyle'])
      q[#q+1] = 'border:none;'
      args['fontstyle'] = table.concat(q)

      ret[#ret+1] = frame:expandTemplate{title = 'Navbar', args = args}
    else
      ret[#ret+1] = '&nbsp;'
      ret[#ret+1] = '[[Category:Navboxes without name]]'
    end
    ret[#ret+1] = '</div>'
  end

  -- the title starts here
  ret[#ret+1] = '<span'
  if U.isset(frame.args['titleclass']) then ret[#ret+1] = ' class="' .. frame.args['titleclass'] .. '"' end
  ret[#ret+1] = ' style="font-size:' .. U.cv((border == "subgroup" or border == "child" or border == "none"), '100%', '110%') .. ';">\n'

  ret[#ret+1] = frame.args['title']
  
  ret[#ret+1] = '</span>'
  ret[#ret+1] = '</th></tr>'
  return table.concat(ret)
end

--[[ Generates the 'above' and 'below' rows.
     Returns the generated row and updated 'sep' value (if separation is going to be needed). ]]
local function build_above_below(frame, border, ttype, text, rstyle, sep)
  local ret = {''}
  if U.isset(text) then
    if sep then -- if separation is needed
      table.insert(ret, '<tr style="height: 2px;"><td></td></tr>')
    end

    -- start the 'above' or 'below' row
    ret[#ret+1] = '<tr>'
    ret[#ret+1] = '<td class="navbox-abovebelow" style="'
    if U.isset(colors[ttype]) then
      -- both above and below share same default color from 'colors' table
      ret[#ret+1] = 'background:' .. U.cv((border ~= "subgroup" and border ~= "child"), colors[ttype]['above'], colors[ttype]['group']) .. ';'
    end
    ret[#ret+1] = 'padding-left:1em;padding-right:1em;text-align:center;'
    U.addStyle(ret, frame.args['basestyle'])
    U.addStyle(ret, rstyle)
    ret[#ret+1] = '"'

    -- calculate and add the colspan (always full table width)
    local cs = 2
    if U.isset(frame.args['imageleft']) then cs = cs + 1 end
    if U.isset(frame.args['image']) then cs = cs + 1 end
    ret[#ret+1] = ' colspan="' .. cs .. '">\n'

    -- row content
    ret[#ret+1] = text

    ret[#ret+1] = '</td></tr>'
    sep = true -- now we're going to need separation
  end
  return table.concat(ret),sep
end

--[[ Generates a single row of the list. ]]
local function build_row(frame, border, ttype, k, group, list, groupstyle, liststyle)
  local ret = {""}
  if U.isset(group) then
    -- there's a group name for current list, so add a cell for it
    ret[#ret+1] = '<td class="navbox-group" style="'
    if U.isset(colors[ttype]) then 
      ret[#ret+1] = 'background:' .. U.cv((border ~= "subgroup" and border ~= "child"), colors[ttype]['group'], colors[ttype]['subgroup']) .. ';'
    end
    ret[#ret+1] = 'padding-left:1em; padding-right:1em; white-space:nowrap; text-align:right;'
    U.addStyle(ret, frame.args['basestyle'])
    if U.isset(frame.args['groupwidth']) then ret[#ret+1] = 'width:' .. frame.args['groupwidth'] .. ';' end
    U.addStyle(ret, frame.args['groupstyle'])
    U.addStyle(ret, groupstyle)
    ret[#ret+1] = '">'
    ret[#ret+1] = '<div style="padding:0;">\n'
    ret[#ret+1] = group
    ret[#ret+1] = '</div></td>'

    -- start the content cell
    ret[#ret+1] = '<td style="text-align:left;border-left-width:2px;border-left-style:solid;'
  else
    -- no group name, start the content already
    ret[#ret+1] = '<td colspan=2 style="'
  end
  -- a bit tricky, but this works as XOR
  if (frame.args['evenodd'] == "swap") ~= ((k % 2) == 0) then
    if U.isset(colors[ttype]) then ret[#ret+1] = 'background:' .. colors[ttype]['dark'] .. ';' end
  else
    ret[#ret+1] = 'background:transparent;'
  end
  if not U.isset(frame.args['groupwidth']) then ret[#ret+1] = 'width:100%;' end
  ret[#ret+1] = 'padding: 0;'
  U.addStyle(ret, frame.args['liststyle'])
  U.addStyle(ret, U.cv((frame.args['evenodd'] == "swap") ~= ((k % 2) == 0), frame.args['evenstyle'], frame.args['oddstyle']))
  U.addStyle(ret, liststyle)
  ret[#ret+1] = '" class="navbox-list ' .. U.cv((frame.args['evenodd'] == "swap") ~= ((k % 2) == 0), 'navbox-even', 'navbox-odd') .. '">'

  -- add the <div> with content (same <div> that child navbox has to close when starting table)
  ret[#ret+1] = '<div style="padding:'
  if U.isset(frame.args['list' .. k .. 'padding']) then
    ret[#ret+1] = frame.args['list' .. k .. 'padding']
  elseif U.isset(frame.args['listpadding']) then
    ret[#ret+1] = frame.args['listpadding']
  else
    ret[#ret+1] = '0em 0.25em'
  end
  ret[#ret+1] = ';">\n'
  ret[#ret+1] = list
  ret[#ret+1] = '</div></td>'
  return table.concat(ret)
end

--[[ Generates the "body" of table (everything below title) ]]
local function build_body(frame, border, ttype, lists)
  local ret = {}
  local sep = U.isset(frame.args['title']) -- if there was a title, we have to add separation for first row
  local imgs = true -- add images if present
  local irows = U.cv( (#lists > 0), (2 * #lists - 1), 1 )

  -- aff the 'above' row
  ret[#ret+1],sep = build_above_below(frame, border, ttype, frame.args['above'], frame.args['abovestyle'], sep)
  
  for k,v in pairs(lists) do
    if sep then -- add separation if needed
      ret[#ret+1] = '<tr style="height: 2px;"><td></td></tr>'
    end

    table.insert(ret, '<tr>')

    -- add left image (if wasn't added yet and is present)
    if imgs then
      if U.isset(frame.args['imageleft']) then
        ret[#ret+1] = '<td style="width:0%;padding:0px 2px 0px 0px;'
        U.addStyle(ret, frame.args['imageleftstyle'])
        ret[#ret+1] = '" rowspan="' .. irows .. '">' .. frame.args['imageleft'] .. '</td>'
      end
    end

    -- add the list content
    ret[#ret+1] = build_row(frame, border, ttype, v['index'], v['group'], v['list'], v['groupstyle'], v['liststyle'])

    -- add right image (if wasn't added yet and is present)
    if imgs then
      if U.isset(frame.args['image']) then
        ret[#ret+1] = '<td style="width:0%;padding:0px 0px 0px 2px;'
        U.addStyle(ret, frame.args['imagestyle'])
        ret[#ret+1] = '" rowspan="' .. irows .. '">' .. frame.args['image'] .. '</td>'
      end

      -- mark that images were added already
      imgs = false
    end

    ret[#ret+1] = '</tr>'
    sep = true -- now the separation is going to be needed for sure
  end

  ret[#ret+1],sep = build_above_below(frame, border, ttype, frame.args['below'], frame.args['belowstyle'], sep)

  return table.concat(ret)
end

-- == Exported functions ==
--[[ Generates and returns the whole navbox table. ]]
local function buildNavbox(frame)
  local template = {}
  local border = ""
  local ttype = ""

  if U.isset(frame.args['border']) then
    border = frame.args['border']
  elseif U.isset(frame.args[1]) then
    border = mw.text.trim(frame.args[1])
  end

  if U.isset(frame.args['type']) then
    ttype = frame.args['type']
  end

  -- TODO: filtering of border and type values?

  -- prepare the data first
  local lists = scan_lists(frame)

  -- build the content  
  template[#template+1] = start_box(frame, border, ttype)
  template[#template+1] = build_title(frame, border, ttype)
  template[#template+1] = build_body(frame, border, ttype, lists)
  template[#template+1] = end_box(frame, border, ttype)

  return table.concat(template)
end

-- [[ Workaround for the "Navbox subgroup" template ]]
local function buildNavboxSubgroup(frame)
  if not U.isset(frame.args['border']) then frame.args['border'] = 'child' end

  -- TODO: add/modify/remove other params?

  -- call the main function
  return buildNavbox(frame)
end

--[[ Mostly for debugging, generates and returns a table of sets of colors
     and the values in cells with colors used as backgrounds. ]]
local function buildColorTable(frame)
  local ret = {""}
  table.insert(ret, '<table class="wikitable" style="text-align: center;">')
  table.insert(ret, '<caption>List of colors in order from darkest to brigthest one</caption>')
  table.insert(ret, '<tr><th>"type"</th><th>title</th><th>above, below</th><th>group,<br/>sub-above/below</th><th>sub-group</th><th>dark background</th><th>background</th></tr>')
  for k,v in pairs(colors) do
    table.insert(ret, '<tr>')
    table.insert(ret, '<td>' .. k .. '</td>')
    table.insert(ret, '<td style="background:' .. v['title'] .. '">' .. v['title'] .. '</td>')
    table.insert(ret, '<td style="background:' .. v['above'] .. '">' .. v['above'] .. '</td>')
    table.insert(ret, '<td style="background:' .. v['group'] .. '">' .. v['group'] .. '</td>')
    table.insert(ret, '<td style="background:' .. v['subgroup'] .. '">' .. v['subgroup'] .. '</td>')
    table.insert(ret, '<td style="background:' .. v['dark'] .. '">' .. v['dark'] .. '</td>')
    table.insert(ret, '<td style="background:' .. v['background'] .. '">' .. v['background'] .. '</td>')
    table.insert(ret, '</tr>')
  end
  table.insert(ret, '</table>')
  return table.concat(ret)
end

-- export local functions
return {
  ['buildNavbox'] = buildNavbox,
  ['buildNavboxTemplate'] = function(frame) return buildNavbox(frame:getParent()) end, -- for wrappers
  ['buildNavboxSubgroup'] = buildNavboxSubgroup,
  ['buildNavboxSubgroupTemplate'] = function(frame) return buildNavboxSubgroup(frame:getParent()) end, -- for wrappers
  ['buildColorTable'] = buildColorTable
}

-- [[Category:Lua Scripts|{{PAGENAME}}]]