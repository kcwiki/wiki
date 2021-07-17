local U = require('Module:Core')
local View = require('Module:View')
local Equipment = require('Module:Collection/Equipment')

local template = {
  table_header = [=[{|class="wikitable mw-collapsible mw-collapsed" style="width:100%;font-size:12px"
!colspan="4" style="font-size:14px"|${links}]=],
  table_footer = '|}',
  type = [=[|-
!rowspan="${rowspan}" width="36px"|${name}]=],
  row = [=[|-
|colspan="${colspan}"|${equips}]=]
}

local links = {
  '[[Equipment|List]]',
  '[[Equipment List (Image)|Gallery]]',
  '[[Equipment Ranking|By Stats]]',
  '[[Development]]',
  "[[Akashi's Improvement Arsenal|Improvement]]",
  '[[Combat/Overweight Penalty and Fit Gun Bonus|Overweight / Fit Gun]]',
  '[[Equipment Bonuses|Visible Bonuses]]'
}

local groups = {
  ['Main Guns'] = {
    Small = {
      _ = {type = 1, icon = 1},
      AA = {type = 1, icon = 16}
    },
    Medium = {},
    Large = {}
  }
}

local function isPred(v)
  return v.type or v.icon
end

local function applyPred(v, eq)
  return U.cv(v.type, v.type == eq._type, true) and U.cv(v.icon, v.icon == eq._icon, true)
end

local function addEquipment(data, eq)
  for _, v in pairs(data) do
    if not isPred(v) then
      if addEquipment(v, eq) then
        return true
      end
    elseif applyPred(v, eq) then
      v.equips = v.equips or {}
      table.insert(v.equips, eq._name)
      return true
    end
  end
end

local function groupEquipment()
  for _, eq in ipairs(Equipment) do
    addEquipment(groups, eq)
  end
end

local function formatEquipment(result, v)
  table.insert(
    result,
    U.format {
      template.row,
      colspan = 1,
      equips = U.ijoin(
        U.imap(
          v.equips,
          function(e)
            return U.format {'[[${name}]]', name = e}
          end
        ),
        ' · '
      )
    }
  )
end

local function render()
  groupEquipment()
  local result = {}
  table.insert(result, U.format {template.table_header, links = U.ijoin(links, ' · ')})
  for k1, v1 in pairs(groups) do
    table.insert(result, U.format {template.type, name = k1})
    if v1.equips then
      formatEquipment(result, v1)
    else
      for k2, v2 in pairs(v1) do
        table.insert(result, U.format {template.type, name = k2})
        if v2.equips then
          formatEquipment(result, v2)
        else
          for k3, v3 in pairs(v2) do
            table.insert(result, U.format {template.type, name = k3})
            formatEquipment(result, v3)
          end
        end
      end
    end
  end
  table.insert(result, template.table_footer)
  return U.ijoin(result, '\n')
end

return View(render)

-- print(p.render())