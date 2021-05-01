local _ = require('Module:Core')
-- local Data = require('Module:Data')
-- local View = require('Module:View')

local p = {}

p.cache = {}

-- [[Category:Todo]]:
-- * Support render : Args -> UI tree in Module:View, currently Args -> String
-- * Module:View/Table for table UI tree construction

local table_header = [=[{|style="width:100%;text-align:center" cellspacing="0"
|style="width:4%"|ID
|style="width:35%"|Requirements
|style="width:0.5%"|
|style="width:20%"|[[File:Fuel.png|30px|link=Tutorial: FAQ#How do resources work in this game?]][[File:Ammunition.png|30px|link=Tutorial: FAQ#How do resources work in this game?]][[File:Steel.png|30px|link=Tutorial: FAQ#How do resources work in this game?]][[File:Bauxite.png|30px|link=Tutorial: FAQ#How do resources work in this game?]]
|style="width:0.5%"|
|style="width:20%"|Rewards
|style="width:0.5%"|
|style="width:30%"|Note<span style="float:right;margin-top:-2em">[[https://en.kancollewiki.net/Module:Data/Quest/${category}?action=edit Edit]]</span>
|-]=]

local table_footer = '|}'

local table_row = [=[|- id="${label}" class="q${letter}"
|rowspan="2"|'''${label}'''
|colspan="11"|'''<span lang="ja">${title}</span>'''<br>''${title_en}''
|- class="qd${letter}"
|${detail_en}
|
|${reward_fuel} / ${reward_ammo} / ${reward_steel} / ${reward_bauxite}
|
|''${reward_other}''
|
|${note}]=]

local table_row_alias = [=[|- id="${label}" class="q${letter}" style="height:50px"
|rowspan="1"|'''${label}'''
|colspan="11"|See [[#${alias_of}|${alias_of}]].
]=]

local function render(args, frame)
  -- Filter term ([1] = pattern to match, [2] = data element to match)
  local filter = { (args.explicit['filterMatch'] or nil), (args.explicit['filterGroup'] or nil) }
  local idsList = nil
  if(args.explicit['filterIDs']) then
      idsList = mw.text.split(args.explicit['filterIDs'], '%s')
  end
  local result = {}
  for i, category in ipairs(args.explicit) do
  	if not p.cache[category] then
  		p.cache[category] = mw.loadData('Module:Data/Quest/' .. category)
	end
	local data = p.cache[category]
    table.insert(result, _.format(table_header, { category = category }))
    for i, q in ipairs(data) do
      local proceed = false
      if(idsList) then
         for j, qid in ipairs(idsList) do
           if(q.label == qid) then
              proceed = true
              table.remove(idsList, j)
              break
           end
         end
      end
      if (proceed or (not idsList and not filter[1] and not filter[2]) or (filter[1] and filter[2] and q[filter[2]] and string.match(q[filter[2]], filter[1]))) then
         if(q.alias_of) then
            table.insert(result, _.format(table_row_alias, {
                label = q.label,
                letter = q.letter or q.label:sub(1, 1),
                alias_of = q.alias_of
            }))
         else
            -- table.insert(result, _.format(table_row, q))
            table.insert(result, _.format(table_row, {
              label = q.label,
              title = q.title or '?',
              title_en = q.title_en or '?',
              detail_en = q.detail_en or '?',
              reward_fuel = q.reward_fuel or '?',
              reward_ammo = q.reward_ammo or '?',
              reward_steel = q.reward_steel or '?',
              reward_bauxite = q.reward_bauxite or '?',
              reward_other = q.reward_other or '?',
              note = q.note or '?',
              letter = q.letter or q.label:sub(1, 1)
            }))
        end
      end 
    end
    table.insert(result, table_footer)
  end
  local s = _.join(result, '\n')
  s = s:gsub("{{Audio|file=([^}]+)}}", '<span class="audio-button">[[Media:%1|Play]]</span>')
  s = s:gsub("{{ShipLink|([^|^}]+)}}", function(e) return string.format('[[%s]]', e:gsub('/', ' ')) end)
  s = s:gsub("{{ShipLink|([^|^}]+)|kai=x}}", function(e) return string.format('[[%s]] (Kai)', e:gsub('/', ' ')) end)
  s = s:gsub("{{ShipLink|([^|^}]+)|kai=x|kai_ni=x}}", function(e) return string.format('[[%s]] (Kai, Kai Ni)', e:gsub('/', ' ')) end)
  
  s = s:gsub("{{ShipLink|[^|^}]+|text=([^|^}]+)|link_class=([^|^}]+)}}", function(text, class) return string.format('[[:Category:%s Class|%s]]', class, text) end)
  s = s:gsub("{{ShipLink|[^|^}]+|[^|^}]+|text=([^|^}]+)|link_class=([^|^}]+)}}", function(text, class) return string.format('[[:Category:%s Class|%s]]', class, text) end)
  s = s:gsub("{{ShipLink|[^|^}]+|[^|^}]+|[^|^}]+|text=([^|^}]+)|link_class=([^|^}]+)}}", function(text, class) return string.format('[[:Category:%s Class|%s]]', class, text) end)

  s = s:gsub("{{EquipmentLink|([^|^}]+)}}", "[[%1]]")
  s = s:gsub("{{EquipmentLink|([^|^}]+)|text=true|image=30px}}", "[[%1]]")
  s = s:gsub("{{EquipmentLink|([^|^}]+)|image=30px|text=true}}", "[[%1]]")
  s = s:gsub("{{EquipmentLink|text=true|image=30px|([^|^}]+)}}", "[[%1]]")
  s = s:gsub("{{ItemLink|text=true|image=30px|([^|^}]+)}}", "[[%1]]")
  s = s:gsub("{{color|red|([^}]+)}}", '<span style="color:red">%1</span>')
  return s
end

p.render = function(frame)
    return render(frame and _.getTemplateArgs(frame) or {}, frame)
end

return p