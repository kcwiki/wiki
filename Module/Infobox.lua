-- Lua port of [[Template:Infobox]]
-- by DennouNeko

local U = require("Module:Core")

local colors = U.main_colors

-- == Helper functions ==

-- retrieve param list from arguments
-- builds a table of objects with 'header', 'label', 'data', 'class', 'rclass' fields
local function scan_data_rows(frame, ttype)
  local idx = {}
  local header = {}
  local label = {}
  local data = {}
  local class = {}
  local rclass = {}

  local ret = {}

  local s,e,t

  for k,v in frame:argumentPairs() do
    -- accept only parameters without leading zeros
    s,e,t = string.find(k, '^header([1-9]%d*)$')
    if s ~= nil then
      header[tonumber(t)] = v
      idx[#idx+1] = tonumber(t)
    end

    s,e,t = string.find(k, '^label([1-9]%d*)$')
    if s ~= nil then
      label[tonumber(t)] = v
    end

    s,e,t = string.find(k, '^data([1-9]%d*)$')
    if s ~= nil then
      data[tonumber(t)] = v
      idx[#idx+1] = tonumber(t)
    end

    s,e,t = string.find(k, '^class([1-9]%d*)$')
    if s ~= nil then
      class[tonumber(t)] = v
    end

    s,e,t = string.find(k, '^rowclass([1-9]%d*)$')
    if s ~= nil then
      rclass[tonumber(t)] = v
    end
  end

  U.trunkTable(idx)

  for k,v in pairs(idx) do
    local tmp = {}
    tmp['index'] = v
    if U.isset(header[v]) then tmp['header'] = header[v] end
    if U.isset(label[v])  then tmp['label']  = label[v]  end
    if U.isset(data[v])   then tmp['data']   = data[v]   end
    if U.isset(class[v])  then tmp['class']  = class[v]  end
    if U.isset(rclass[v]) then tmp['rclass'] = rclass[v] end
    ret[#ret+1] = tmp
  end

  return ret
end

-- builds a single header row for table
local function build_header_row(ttype, class, rclass, header, hstyle)
  local ret = {''}

  if U.isset(header) then
    if U.isset(colors[ttype]) then
      hstyle = 'background-color:' .. colors[ttype]['title'] .. ';' .. U.cv(U.isset(hstyle), hstyle, '')
    end

    ret[#ret+1] = '<tr><th colspan="2"'

    if U.isset(class) then ret[#ret+1] = ' class="' .. class .. '"' end

    ret[#ret+1] = ' style="text-align:center;'
    U.addStyle(ret, hstyle)
    ret[#ret+1] = '">'

    ret[#ret+1] = header

    ret[#ret+1] = '</th></tr>'
  end

  return table.concat(ret)
end

-- builds a single regular row for table
local function build_row(ttype, class, rclass, label, lstyle, data, dstyle)
  local ret = {''}

  if U.isset(data) then
    ret[#ret+1] = '<tr'
    if U.isset(rclass) then ret[#ret+1] = ' class="' .. rclass .. '"' end
    ret[#ret+1] = '>'

    if U.isset(label) then

      ret[#ret+1] = '<th scope="row"'

      if U.isset(class) then ret[#ret+1] = ' class="' .. class .. '"' end

      ret[#ret+1] = ' style="text-align:left;'
      U.addStyle(ret, lstyle)
      ret[#ret+1] = '">'

      ret[#ret+1] = label

      ret[#ret+1] = '</th><td'
    else
      ret[#ret+1] = '<td colspan="2"'

      dstyle = 'text-align:center;' .. U.cv(U.isset(dstyle), dstyle, '')
    end

    if U.isset(class) then ret[#ret+1] = ' class="' .. class .. '"' end
    if U.isset(dstyle) then ret[#ret+1] = ' style="' .. dstyle .. '"' end

    ret[#ret+1] = '>'

    ret[#ret+1] = '\n' .. data

    ret[#ret+1] = '\n</td></tr>'
  end

  return table.concat(ret)
end


-- == Functions generating the table body ==

-- starts the infobox
local function build_start(frame, ttype)
  local ret = {}

  if frame.args['child'] ~= 'yes' then
    -- if it's not a child infobox, start a table

    ret[#ret+1] = '<table'

    ret[#ret+1] = ' class="infobox'
    if U.isset(frame.args['bodyclass']) then ret[#ret+1] = ' ' .. frame.args['bodyclass'] end
    ret[#ret+1] = '"'

    ret[#ret+1] = ' cellspacing="5"'

    ret[#ret+1] = ' style="width:22em; text-align:left; font-size:88%; line-height:1.5em;'
    if U.isset(colors[ttype]) then
      ret[#ret+1] = 'border-color:' .. colors[ttype]['border'] .. ';'
      ret[#ret+1] = 'background-color:' .. colors[ttype]['background'] .. ';'
    end
    U.addStyle(ret, frame.args['bodystyle'])
    ret[#ret+1] = '"'

    ret[#ret+1] = '>'

    -- Caption
    if U.isset(frame.args['title']) then
      ret[#ret+1] = '<caption'
      if U.isset(frame.args['titleclass']) then ret[#ret+1] = '  class="' .. frame.args['titleclass'] .. '"' end

      ret[#ret+1] = ' style="font-size:125%; font-weight:bold;'
      U.addStyle(ret, frame.args['titlestyle'])
      ret[#ret+1] = '"'

      ret[#ret+1] = '>'

      ret[#ret+1] = frame.args['title']

      ret[#ret+1] = '</caption>'
    end

    -- Header
    if U.isset(frame.args['above']) then
      local class = frame.args['aboveclass']
      local rclass = frame.args['aboverowclass']
      local text = frame.args['above']
      local style = 'text-align:center; font-size:125%; font-weight:bold;'
      if U.isset(frame.args['abovestyle']) then style = style .. ' ' .. frame.args['abovestyle'] end

      ret[#ret+1] = build_header_row(ttype, class, rclass, text, style)
    end

  else
    -- for child infobox add simple header
    if U.isset(frame.args['title']) then
      ret[#ret+1] = "'''" .. frame.args['title'] .. "'''"
    end
  end

  return table.concat(ret)
end

-- build the header part (subheaders and images)
local function build_headers(frame, ttype)
  local ret = {}

  -- Subheader1
  if U.isset(frame.args['subheader']) or U.isset(frame.args['subheader1']) then
    local text = U.cv(U.isset(frame.args['subheader']), frame.args['subheader'], frame.args['subheader1'])
    local style = frame.args['subheaderstyle']
    local class = frame.args['subheaderclass']
    local rclass = U.cv(U.isset(frame.args['subheaderrowclass']), frame.args['subheaderrowclass'], frame.args['subheaderrowclass1'])

    ret[#ret+1] = build_row(ttype, class, rclass, '', '', text, style)
  end

  -- Subheader2
  if U.isset(frame.args['subheader2']) then
    local text = frame.args['subheader2']
    local style = frame.args['subheaderstyle']
    local class = frame.args['subheaderclass']
    local rclass = frame.args['subheaderrowclass2']

    ret[#ret+1] = build_row(ttype, class, rclass, '', '', text, style)
  end

  -- Image1
  if U.isset(frame.args['image']) or U.isset(frame.args['image1']) then
    local text = {}
    text[#text+1] = U.cv(U.isset(frame.args['image']), frame.args['image'], frame.args['image1'])

    if U.isset(frame.args['caption']) or U.isset(frame.args['caption1']) then
      text[#text+1] = '<br/><span'
      if U.isset(frame.args['captionstyle']) then text[#text+1] = ' style="' .. frame.args['captionstyle'] .. '"' end
      text[#text+1] = '>'
      text[#text+1] = U.cv(U.isset(frame.args['caption']), frame.args['caption'], frame.args['caption1'])
      text[#text+1] = '</span>'
    end

    text = table.concat(text)

    local class = frame.args['imageclass']
    local dstyle = frame.args['imagestyle']
    local rclass = frame.args['imagerowclass1']

    ret[#ret+1] = build_row(ttype, class, rclass, '', '', text, dstyle)
  end

  -- Image2
  if U.isset(frame.args['image2']) then
    local text = {}
    text[#text+1] = frame.args['image2']

    if U.isset(frame.args['caption2']) then
      text[#text+1] = '<br/><span'
      if U.isset(frame.args['captionstyle']) then text[#text+1] = ' style="' .. frame.args['captionstyle'] .. '"' end
      text[#text+1] = '>'
      text[#text+1] = frame.args['caption2']
      text[#text+1] = '</span>'
    end

    text = table.concat(text)

    local class = frame.args['imageclass']
    local dstyle = frame.args['imagestyle']
    local rclass = frame.args['imagerowclass2']

    ret[#ret+1] = build_row(ttype, class, rclass, '', '', text, dstyle)
  end

  return table.concat(ret)
end

-- build the main part (all the headers and data rows below images)
local function build_body(frame, ttype, tbl)
  local ret = {''}

  local hstyle = frame.args['headerstyle']
  local lstyle = frame.args['labelstyle']
  local dstyle = frame.args['datastyle']

  for k,v in pairs(tbl) do
    -- not using U.cv, because both functions would be called
    if U.isset(v['header']) then
      ret[#ret+1] = build_header_row(ttype, v['class'], v['rclass'], v['header'], hstyle)
    else
      ret[#ret+1] = build_row(ttype, v['class'], v['rclass'], v['label'], lstyle, v['data'], dstyle)
    end
  end

  return table.concat(ret)
end

-- finalize the infobox
local function build_end(frame, ttype)
  local ret = {''}

  if frame.args['child'] ~= 'yes' then
    ret[#ret+1] = '</table>'
  end

  return table.concat(ret)
end


-- == Exported functions ==

-- the basic infobox
local function build_infobox(frame)
  local ret = {}

  -- prepare data
  local drows = scan_data_rows(frame)
  local ttype = frame.args['type']
  if ttype == nil then ttype = '' end

  -- build infobox
  ret[#ret+1] = build_start(frame, ttype)
  ret[#ret+1] = build_headers(frame, ttype)
  ret[#ret+1] = build_body(frame, ttype, drows)
  ret[#ret+1] = build_end(frame, ttype)

  return table.concat(ret)
end

return {
  ['BuildInfobox'] = build_infobox,
  ['BuildInfoboxTemplate'] = function(frame) return build_infobox(frame:getParent()) end,
}