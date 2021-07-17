-- Example how to not write modules.

local U = require('Module:Core')
local loadData = require('Module:Data').load
local getArgs = require('Module:GetArgs')
local Ship = require('Module:Ship')
local ShipBattleCardKai = require('Module:ShipBattleCardKai')
local EquipmentCardKai = require('Module:EquipmentCardKai')
local ShipsByApiId = require('Module:Collection/ShipsByApiId')
local EquipmentByApiId = require('Module:Collection/EquipmentByApiId')

local function getShipCard(ship, hp, maxHp)
    maxHp = maxHp or 999
    local minHp = type(hp) == 'table' and U.imin(hp) or hp or maxHp or 999
    local id = tonumber(ship)
    if id then
        ship = ShipsByApiId[id]
    end
    return ShipBattleCardKai:Asset({
        ship,
        hd = true,
        size = '160px',
        damaged = minHp / maxHp <= 0.5 and 'true' or 'false',
        layers = minHp / maxHp <= 0.5 and 'smudge_medium status_medium_damage' or minHp / maxHp <= 0.75 and 'status_light_damage' or '',
    })
end

local function getEquipmentCard(eq, cardSize)
    local id = tonumber(eq)
    if id then
        eq = EquipmentByApiId[id]
    end
    return EquipmentCardKai:Asset({ eq, size = cardSize or '100px' })
end

local function fromModule(name)
    local result = ''

    return result
end

local tableHeaderFriend = [=[{|class="wikitable" style="text-align:center"
!Ship
!Lv.
!Equipment
![[File:Icon HP.png]]
![[File:Icon Gun.png]]
![[File:Icon Torpedo.png]]
![[File:Icon AA.png]]
![[File:Icon Armor.png]]]=]

local tableHeaderSimple = [=[{|class="wikitable" style="text-align:center"
!Ship
!colspan="4"|Equipment
]=]

local fleetNames = require('Module:FleetNames')

local function getFleetName(fleet, event)
    local names = fleetNames[event] or {}
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
  local file = type(e.voice) == 'number' and e.voice < 10 and
    string.format('Ship Voice %s Spring 2019 Event Friend Fleet %s.ogg', e.ship, e.voice) or
    string.format('Ship Voice %s %s.ogg', e.ship, e.voice)
  return string.format('<span data-voice="%s">{{audio|file=%s}}</span>', file, file)
end

local function renderFriend(args, frame)
    -- local data = loadData('Fleet/Friend/' .. args.friend)
    local success, data = U.requireModule('Data/FriendFleet/' .. args.friend)
    if not success then
        return "''No data''"
    end
    local groups = {}
    for i, e in pairs(data) do
        if not args.map and not args.node or U.ifind(e.maps, args.map) or U.ifind(e.notes, args.node) then
            local fleetType = getFleetName(e.fleet, args.friend)
            groups[fleetType] = groups[fleetType] or {}
            table.insert(groups[fleetType], e)
        end
    end
    local result = {}
    table.insert(result, '{{#tag:tabber|')
    for i, fleetType in ipairs(U.isort(U.keys(groups))) do
        local fleets = groups[fleetType]
        table.sort(fleets, function(a, b)
            local node1 = U.ijoin(a.notes, ', ')
            local node2 = U.ijoin(b.notes, ', ')
            local l1 = table.getn(a.fleet)
            local l2 = table.getn(b.fleet)
            local ships1 = U.ijoin(U.imap(a.fleet, function (e) return e.ship end), ', ')
            local ships2 = U.ijoin(U.imap(b.fleet, function (e) return e.ship end), ', ')
            if node1 == node2 then
                if ships1 == ships2 then
                    return l1 < l2
                end
                return ships1 < ships2
            end
            return node1 < node2
        end)
        table.insert(result, string.format('{{!}}-{{!}} %s =', fleetType))
        table.insert(result, '<tabber>')
        for i, fleet in ipairs(fleets) do
            table.insert(result, string.format('|-| %s =', 'Variant ' .. i))
            local fleetNote = ''
            if table.getn(fleet.notes) > 0 then
                fleetNote = fleetNote .. U.ijoin(fleet.notes, ', ')
            end
            if fleet.f2p and fleet.f2p > 0 then
                fleetNote = fleetNote .. ", '''{{color|green|{{tooltip|Regular|"  .. fleet.f2p ..  " samples}}}}'''"
            end
            if fleet.p2w and fleet.p2w > 0 then
                fleetNote = fleetNote .. ", '''{{color|red|{{tooltip|Powerful|"  .. fleet.p2w ..  " samples}}}}'''"
            end
            if table.getn(fleet.voices or {}) > 0 then
                fleetNote = fleetNote .. ' ' .. U.ijoin(U.imap(fleet.voices[1], formatVoice), ' ')
            end
            table.insert(result, fleetNote)
            table.insert(result, tableHeaderFriend)
            local maxSlots = U.imax(U.imap(fleet.fleet, function(ship) return #ship.equipment end))
            local cardSize = maxSlots == 5 and '60px' or maxSlots == 4 and '80px' or '100px'
            for j, ship in ipairs(fleet.fleet) do
                 table.insert(result, string.format(
                    '|-\n|%s||%s||style="text-align:left;white-space:nowrap"|%s||%s||%s||%s||%s||%s',
                    getShipCard(ship.ship, ship.hp, ship.maxHp),
                    ship.level,
                    U.ijoin(U.imap(ship.equipment, function(eq) return getEquipmentCard(eq, cardSize) end)),
                    type(ship.hp) == 'table' and formatHp(ship.hp, ship.maxHp) or ship.hp ~= ship.maxHp and string.format('%s/%s', ship.hp, ship.maxHp) or ship.maxHp,
                    ship.firepower,
                    ship.torpedo,
                    ship.aa,
                    ship.armor
                ))
            end
            table.insert(result, '|}')
        end
        table.insert(result, '</tabber>')
    end
    table.insert(result, '}}')
    return table.concat(result, '\n')
end

local function render(args, frame)
    if args.friend then
        return renderFriend(args, frame)
    end
    local result = {}
    local firstCell = true
    local openTab = false
    local openSubtab = false
    for _, arg in ipairs(args) do
        if arg:sub(0, 2) == '!!' then
            if openSubtab then
                table.insert(result, string.format('|}\n|-| %s =\n' .. tableHeaderSimple, arg:sub(3)))
            else
                table.insert(result, string.format('<tabber>\n|-| %s =\n' .. tableHeaderSimple, arg:sub(3)))
                openSubtab = true
            end
        elseif arg:sub(0, 1) == '!' then
            if openSubtab then
                table.insert(result, '|}\n</tabber>')
                openSubtab = false
            end
            if openTab then
                table.insert(result, string.format('{{!}}-{{!}} %s =', arg:sub(2)))
            else
                table.insert(result, string.format('{{#tag:tabber|\n{{!}}-{{!}} %s =', arg:sub(2)))
                openTab = true
            end
        elseif arg:sub(0, 1) == '~' then
            table.insert(result, fromModule(arg:sub(2)))
        elseif arg == '-' then
            table.insert(result, '|-')
            firstCell = true
        else
            if firstCell then
                table.insert(result, '|' .. getShipCard(arg))
                firstCell = false
            else
                table.insert(result, '|' .. getEquipmentCard(arg))
            end
        end
    end
    if openSubtab then
        table.insert(result, '|}\n</tabber>')
        openSubtab = false
    end
    if openTab then
        table.insert(result, '}}')
        openTab = false
    end
    return table.concat(result, '\n')
end

return {
    render = function(frame)
    	return frame:preprocess(render(getArgs{ frame = frame:getParent() }))
    end,
    test1 = render({
        '!1 DD',
        '!!Example 1',
        '-', '1', 'Type 3 Active Sonar',
        '!!Example 2',
        '-', 'Yuudachi/Kai Ni', '282', '282',
        '!2 DD',
        '!!Example 1',
        '-', 'Yuudachi/Kai Ni', 'Type 3 Active Sonar',
        '-', 'Shigure/Kai Ni', 'Type 3 Active Sonar',
        '!!Example 2',
        '-', 'Yuudachi/Kai Ni', 'Type 3 Active Sonar', 'Type 3 Active Sonar',
        '-', 'Shigure/Kai Ni', 'Type 3 Active Sonar', 'Type 3 Active Sonar',
    }),
    test2 = render({
        friend = 'Early Fall 2018 Event',
    }),
    test3 = render({
        friend = 'Early Fall 2018 Event',
        map = 'E-5',
    }),
}

-- print(p.test1)
-- print(p.test2)
-- print(p.test3)