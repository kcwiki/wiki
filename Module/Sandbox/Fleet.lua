local U = require('Module:Core')
local getArgs = require('Module:GetArgs')
local Ship = require('Module:Ship')
local Equipment = require('Module:Equipment')

local function getShipCard(ship)
  local s = Ship(ship)
  -- local i = s:id() or s:true_id()
  -- local is = i and (i < 10 and '00' .. i or i < 100 and '0' .. i or i) or '?'
  return '[[File:Ship Banner ' .. s:name() .. '.png|160px|link=' .. s:base_name() .. ']]<br>[[' .. s:base_name() .. '|' .. s:name() .. ']]'
end

local function getEquipmentCard(eq)
  local e = Equipment(eq)
  return '[[File:Equipment Card ' .. e:name():gsub("/", " ") .. '.png|100px|link=' .. e:name() .. ']]'
end

local function getFleetName(fleet, event)
  local names = require('Module:FleetNames')[event] or {}
  if names == 'flagship' then
    return Ship(fleet[1].ship):base_name() .. ' FS'
  elseif names[1] then
    for _, f in ipairs(names) do
      for i, ship in ipairs(f.ships) do
        for j, e in ipairs(fleet) do
          if f.flagship then
            if i == 1 and j == 1 and string.sub(e.ship, 1, string.len(ship)) == ship then
              return f.name
            end
          else
            if string.sub(e.ship, 1, string.len(ship)) == ship then
              return f.name
            end
          end
        end
      end
    end
  else
    for name, ships in pairs(names) do
      for _, ship in ipairs(ships) do
        for _, e in ipairs(fleet) do
          if string.sub(e.ship, 1, string.len(ship)) == ship then
            return name
          end
        end
      end
    end
  end
  return 'Unassorted'
end

local function formatHp(hps, maxHp)
  local minHp = U.imin(hps)
  if minHp / maxHp <= 0.5 then
    return string.format('{{color|red|{{tooltip|~/%s|%s}}}}', maxHp, U.ijoin(hps, ', '))
  elseif minHp / maxHp <= 0.75 then
    return string.format('{{color|coral|{{tooltip|~/%s|%s}}}}', maxHp, U.ijoin(hps, ', '))
  else
    return string.format('{{tooltip|~/%s|%s}}', maxHp, U.ijoin(hps, ', '))
  end
end

local function formatVoice(e)
  if type(e.voice) == 'number' and e.voice < 10 then
    return string.format('{{audio|file=Ship Voice %s Spring 2019 Event Friend Fleet %s.mp3}}', e.ship, e.voice)
  else
     return string.format('{{audio|file=Ship Voice %s %s.mp3}}', e.ship, e.voice)
  end
end

local tableStart =
  [=[{|class="wikitable mw-collapsible mw-collapsed" style="text-align:center;min-width:700px"
|-
!colspan="11"|%s]=]

local tableHeader = [=[|-
!Ship
!Lv.
!Equipment
![[File:Icon HP.png]]
![[File:Icon Gun.png]]
![[File:Icon Torpedo.png]]
![[File:Icon AA.png]]
![[File:Icon Armor.png]]]=]

local function render(args)
    local success, data = U.requireModule('Data/FriendFleet/' .. args.friend)
    if not success then
        return "''No data''"
    end
  local groups = {}
  for _, e in pairs(data) do
    if not args.map and not args.node or U.ifind(e.maps, args.map) or U.ifind(e.notes, args.node) then
      local fleetType = getFleetName(e.fleet, args.friend)
      groups[fleetType] = groups[fleetType] or {}
      table.insert(groups[fleetType], e)
    end
  end
  local result = {}
  local first = true
  for _, fleetType in ipairs(U.isort(U.keys(groups))) do
    local fleets = groups[fleetType]
    table.sort(
      fleets,
      function(a, b)
        local l1 = table.getn(a.fleet)
        local l2 = table.getn(b.fleet)
        local ships1 =
          U.ijoin(
          U.imap(
            a.fleet,
            function(e)
              return e.ship
            end
          ),
          ', '
        )
        local ships2 =
          U.ijoin(
          U.imap(
            b.fleet,
            function(e)
              return e.ship
            end
          ),
          ', '
        )
        if ships1 == ships2 then
          return l1 < l2
        end
        return ships1 < ships2
      end
    )
    for i, fleet in ipairs(fleets) do
      if first then
        table.insert(result, string.format(tableStart, U.ijoin(fleet.notes, ', ')))
        first = false
      end
      local fleetNote = U.ijoin(fleet.notes, ', ') .. ' : ' ..fleetType .. ' (Variant ' .. i .. ', ' .. (fleet.date or '??') .. '~)'
      if fleet.f2p and fleet.f2p > 0 then
        fleetNote = fleetNote .. " '''{{color|green|{{tooltip|Regular|"  .. fleet.f2p ..  " samples}}}}'''"
      end
      if fleet.p2w and fleet.p2w > 0 then
        fleetNote = fleetNote .. " '''{{color|red|{{tooltip|Powerful|"  .. fleet.p2w ..  " samples}}}}'''"
      end
      if table.getn(fleet.voices or {}) > 0 then
        fleetNote = fleetNote .. ' ' .. U.ijoin(U.imap(fleet.voices[1], formatVoice), ' ')
      end
      table.insert(result, string.format('|-\n!colspan="11"|%s', fleetNote))
      table.insert(result, tableHeader)
      for _, ship in ipairs(fleet.fleet) do
        table.insert(
          result,
          string.format(
            '|-\n|%s||%s||style="text-align:left;white-space:nowrap"|%s%s%s%s%s||%s||%s||%s||%s||%s',
            getShipCard(ship.ship),
            ship.level,
            ship.equipment[1] and getEquipmentCard(ship.equipment[1]) or '',
            ship.equipment[2] and getEquipmentCard(ship.equipment[2]) or '',
            ship.equipment[3] and getEquipmentCard(ship.equipment[3]) or '',
            ship.equipment[4] and getEquipmentCard(ship.equipment[4]) or '',
            ship.equipment[5] and getEquipmentCard(ship.equipment[5]) or '',
            type(ship.hp) == 'table' and formatHp(ship.hp, ship.maxHp) or ship.hp ~= ship.maxHp and string.format('%s/%s', ship.hp, ship.maxHp) or
              ship.maxHp,
            ship.firepower,
            ship.torpedo,
            ship.aa,
            ship.armor
          )
        )
      end
    end
  end
  table.insert(result, '|}')
  return table.concat(result, '\n')
end

return {
  render = function(frame)
    return frame:preprocess(render(getArgs {frame = frame:getParent()}))
  end
}