local U = require('Module:Core')
local F = require('Module:Formatting')
local view = require('Module:View')
local data = require('Module:Data/Expedition')

local shipCodes = {
  [1] = 'DE',
  [2] = 'DD',
  [3] = 'CL',
  [4] = 'CLT',
  [5] = 'CA',
  [6] = 'CAV',
  [7] = 'CVL',
  [8] = 'FBB',
  [9] = 'BB',
  [10] = 'BBV',
  [11] = 'CV',
  [12] = 'B',
  [13] = 'SS',
  [14] = 'SSV',
  [15] = 'AP',
  [16] = 'AV',
  [17] = 'LHA',
  [18] = 'CVB',
  [19] = 'AR',
  [20] = 'AS',
  [21] = 'CT',
  [22] = 'AO',
}

local backgrounds = {
  [0] = 'EDEDED',
  [1] = 'EDEDED',
  [2] = 'EDEDD5',
  [3] = 'CFE8E8',
  [4] = 'C5E6D5',
  [5] = 'D3D3EB',
  -- [7] = '?',
}

local template = [=[|-
|style="${style}" nowrap|${id}
|style="${style}"|${name}
|style="${style}"|${time}
|style="${style}"|${hq}
|style="${style}"|${ship}
|style="${style}"|${fuel}
|style="${style}"|${ammo}
|style="${style}"|${steel}
|style="${style}"|${bauxite}
|style="${style}"|${item1}
|style="${style}"|${item2}]=]

local template2 = [=[|-
|style="${style}" nowrap|${id}
|style="${style}"|${name}
|style="${style}"|${time}
|style="${style}"|${sum}
|style="${style}"|${level}
|style="${style}"|${fleet}
|style="${style}"|${drums}
|style="${style}"|${fuel_cost}
|style="${style}"|${ammo_cost}]=]

local template3 = [=[|-
|style="${style}" nowrap|${id}
|style="${style}"|${name}
|style="${style}"|${time}
|style="${style}" colspan="10"|${desc}]=]

-- todo: use modules
local worldNames = {
  [1] = '鎮守府海域',
  [2] = '南西諸島海域',
  [3] = '北方海域',
  [4] = '西方海域',
  [5] = '南方海域',
  [6] = '中部海域',
  [7] = '南西海域',
}

local headerBackgrounds = {
  [1] = 'lightgray',
  [2] = '#cccc99',
  [3] = '#99cccc',
  [4] = '#66cc99',
  [5] = '#9999cc',
  [6] = 'lightgray',
  [7] = 'lightgray',
}

local isons = {
  [1] = 'World1icon',
  [2] = 'World2icon',
  [3] = 'World3icon',
  [4] = 'World4icon',
  [5] = 'World5icon',
  [6] = 'World6icon',
  [7] = 'World7icon',
}

local tableHeader = [=[<div style="width:90%;margin-left:20px">
{|style="width:100%"
|style="width:50px"|[[File:${icon}.png|link=]]
|<div style="background:${background};width:100%;padding-left:10px;border-top-right-radius:10px">'''${name}'''</div>
|}
</div>
<div style="position:relative;border:solid 1px lightgray;width:95%;border-radius:10px;padding:10px;margin:10px;margin-top:0px">
{|style="margin:0 auto;radius:10px;cellpadding:10px;width:100%" cellspacing="0"
!style="cellpadding:10px;width:4%;" |#
!style="cellpadding:10px;width:24%;" |Name
!style="cellpadding:10px;" |Time
!style="cellpadding:10px;width:1px;" rowspan="100" |
]=]

local tableHeader2 = [=[!style="cellpadding:10px;width:7%;" |HQ
!style="cellpadding:10px;width:7%;" |Ship
!style="cellpadding:10px;width:1px;" rowspan="100" |
!style="cellpadding:10px;width:7%;" |[[File:Fuel.png|30px|link=]]
!style="cellpadding:10px;width:7%;" |[[File:Ammunition.png|30px|link=]]
!style="cellpadding:10px;width:7%;" |[[File:Steel.png|30px|link=]]
!style="cellpadding:10px;width:7%;" |[[File:Bauxite.png|30px|link=]]
!style="cellpadding:10px;width:1px;" rowspan="100" |
!style="cellpadding:10px;width:20%;" colspan="2" |Rewards
|-
|style="background:gray;" colspan="14"|
]=]

local tableHeader2Req = [=[!style="cellpadding:10px;width:7%;"|Σ(Lv)
!style="cellpadding:10px;width:7%;" align="center"|[[File:Flagship icon.png|link=]]
!style="cellpadding:10px;width:1px;" rowspan="100"|
!style="cellpadding:10px;width:21%;" align="center"|Requirements
!style="cellpadding:10px;width:7%;" align="center"|[[File:Drum.png|30px|link=]]
!style="cellpadding:10px;width:1px;" rowspan="100"|
!style="cellpadding:10px;width:10%;" align="center"|[[File:Fuel.png|30px|link=]]
!style="cellpadding:10px;width:10%;" align="center"|[[File:Ammunition.png|30px|link=]]
]=]

local function pad(n)
  return n < 10 and '0' .. n or n
end

local function formatTime(time)
  return string.format('%s:%s', pad(math.floor(time / 60)), pad(time % 60))
end

local function tooltip(text, title)
  return string.format('<span title="%s" style="cursor:help;border-bottom:1px dotted">%s</span>', title:gsub('<br>', "&#10;"), text)
end

local itemTemplate = [=[<span style="position:relative;display:inline">[[File:${file}|35px|link=${link}|${name}]]<span style="font-size:12px;font-weight:800;position:absolute;color:#f61;right:4px;bottom:-18px;text-shadow:#fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px, #fff 0px 0px 5px">${text}</span>]=]

local itemFiles = {
  [1] = 'Item Icon Instant Repair Material.png',
  [2] = 'Item Icon Instant Construction Material.png',
  [3] = 'Item Icon Development Material.png',
  [4] = 'Item Icon Improvement Material.png',
  [10] = 'Item Icon Furniture Box (Small).png',
  [11] = 'Item Icon Furniture Box (Medium).png',
  [12] = 'Item Icon Furniture Box (Large).png',
  [59] = 'Item Icon Food Supply Ship Irako.png',
}

local itemLinks = {
  [1] = 'Tutorial:_FAQ#What_are_buckets.3F',
  [2] = 'Construction',
  [3] = 'Development',
  [4] = 'Improvement Material',
  [10] = 'Furniture/Guide#Furniture_coin',
  [11] = 'Furniture/Guide#Furniture_coin',
  [12] = 'Furniture/Guide#Furniture_coin',
  [59] = 'Fatigue#Food_Supply_Ship_.22Irako.22',
}

local itemNames = {
  [1] = 'Instant Repair',
  [2] = 'Instant Construction',
  [3] = 'Development Material',
  [4] = 'Improvement Material',
  [10] = 'Small Furniture Coin Box',
  [11] = 'Medium Furniture Coin Box',
  [12] = 'Large Furniture Coin Box',
  [59] = '"Irako"',
}

local function formatItem(id, count)
  return U.format{
    itemTemplate,
    file = itemFiles[id] or '??',
    link = itemLinks[id] or '',
    name = itemNames[id] or '??',
    text = 'x' .. count,
  }
end

local function formatAmount(n, time, reset)
  n = tonumber(n)
  if n == 0 then
    return ''
  end
  local r = not n and '??' or tostring(time and U.round(60 * n / time) or n)
  return time and reset == 1 and string.format('<span style="color:grey">%s</span>', r) or r
end

local tabberTemplate = [=[<tabber>
|-|Total yield=
${total}
|-|Hourly yield=
${hourly}
|-|Requirements=
${requirements}
</tabber>]=]

local diffs = {
  [1] = 'E',
  [2] = 'D',
  [3] = 'C',
  [4] = 'B',
  [5] = 'A',
  [6] = 'S',
  [7] = 'S',
  [8] = 'S',
  [9] = 'S+',
}

local function formatSampleFleet(xs)
  return U.ijoin(U.imap(U.ifilter(xs, function(e) return e > 0 end), function(e) return shipCodes[e] or '??' end), ' ')
end

local function formatRow(args, e, i, hourly, req, supp)
  local id = e.disp_no
  return U.format{
    (supp and template3 or req and template2 or template),
    style = string.format(
    'text-align: center; height: 35px; background: #%s; color:#000',
    i % 2 == 0 and '' or backgrounds[e.maparea_id] or backgrounds[0]
    ),
    id = tooltip(id, 'ID number as displayed in game') .. string.format(' (%s)', diffs[e.difficulty]),
    name = (e.damage_type == 2 and string.format('<span style="color:#b00000">%s</span>', tooltip(e.name, e.details)) or e.damage_type == 1 and string.format('<span style="color:red">%s</span>', tooltip(e.name, e.details)) or tooltip(e.name, e.details)) .. (e.reset_type == 1 and string.format(' (%s)', tooltip('M', 'Monthly expedtion')) or ''),
    time = tooltip(formatTime(e.time), 'Time required for expedition'),
    hq = tooltip(formatAmount(args.explicit[id .. ' hq'], hourly and e.time, e.reset_type), 'Admiral experience gained upon completion from this expedition'),
    ship = tooltip(formatAmount(args.explicit[id .. ' ship'], hourly and e.time, e.reset_type), 'Ship experience gained upon completion from this expedition'),
    fuel = e.win_mat_level[1] == 0 and '' or tooltip(formatAmount(args.explicit[id .. ' fuel'], hourly and e.time, e.reset_type), 'Base resources gain from expedition (at 100% ratio)'),
    ammo = e.win_mat_level[2] == 0 and '' or tooltip(formatAmount(args.explicit[id .. ' ammo'], hourly and e.time, e.reset_type), 'Base resources gain from expedition (at 100% ratio)'),
    steel = e.win_mat_level[3] == 0 and '' or tooltip(formatAmount(args.explicit[id .. ' steel'], hourly and e.time, e.reset_type), 'Base resources gain from expedition (at 100% ratio)'),
    bauxite = e.win_mat_level[4] == 0 and '' or tooltip(formatAmount(args.explicit[id .. ' bauxite'], hourly and e.time, e.reset_type), 'Base resources gain from expedition (at 100% ratio)'),
    item1 = e.win_item1[1] > 0 and formatItem(e.win_item1[1], e.win_item1[2]) or '',
    item2 = e.win_item2[1] > 0 and formatItem(e.win_item2[1], e.win_item2[2]) or '',
    sum = formatAmount(args.explicit[id .. ' sum']),
    level = formatAmount(args.explicit[id .. ' level']),
    fleet = (e.reset_type == 1 and 'Monthly expedtion<br>' or '') .. (e.damage_type == 2 and 'Reduces lots of HP<br>' or e.damage_type == 1 and 'Reduces some HP<br>' or '') .. (args.explicit[id .. ' fleet'] or '??') .. string.format('<br>Eg %s', formatSampleFleet(e.sample_fleet)),
    drums = formatAmount(args.explicit[id .. ' drums']),
    fuel_cost = e.use_fuel > 0 and '-' .. 10 * e.use_fuel or '',
    ammo_cost = e.use_bull > 0 and '-' .. 10 * e.use_bull or '',
    desc = string.format('%s', args.explicit[id .. ' desc'] or ''),
  }
end

local function formatTable(args, es, hourly, req)
  local world = tonumber(args.explicit.world)
  local supp = args.explicit.support
  return U.format{
    tableHeader,
    icon = isons[world],
    background = headerBackgrounds[world],
    name = worldNames[world],
  } .. (req and tableHeader2Req or tableHeader2) .. U.joinLines(U.imap(es, function(e, i)
    return formatRow(args, e, i, hourly, req, supp)
  end)) .. "\n|}\n</div>"
end

local function render(args, frame)
  local id = args.explicit.id
  if id then
    local e = U.ifilter(data, function(e) return e.disp_no == id end)[1]
    return formatRow(args, e, args.explicit.odd and 1 or 0, args.explicit.hourly, args.explicit.requirements, args.explicit.support)
  end
  local world = tonumber(args.explicit.world)
  local es = U.ifilter(data, function(e) return e.maparea_id == world end)
  return frame:preprocess(U.format{
    tabberTemplate,
    total = formatTable(args, es),
    hourly = formatTable(args, es, true),
    requirements = formatTable(args, es, false, true),
  })
end

local test = { explicit = { world = '7' } }
-- print(p.test())

return view(render, test)