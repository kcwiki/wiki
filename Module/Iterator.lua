-- [[Category:Todo]]:
-- more generic interface and compositions (filtering, grouping, mapping, sorting, etc.)
-- prevent clients from infinite loops
-- load modules more lazily?
-- generalize equipment/enemy iterators

local U = require('Module:Core')
local Equipment = require('Module:Equipment')
local CollectionEquipment = require('Module:Collection/Equipment')
local EnemyShip = require('Module:EnemyShip')
local CollectionEnemy = require('Module:Collection/EnemyShips')

local Iterator = {}

-- legacy, not a proper iterator
function Iterator.array(arr, i, n)
    i = i or 0
    n = n and math.min(#arr, n) or #arr
    function step(n, i)
        if i < n then
            i = i + 1
            return i, arr[i]
        end
    end
    return function()
        return step, n, i
    end
end

function stringKey(name, context, n, default)
    return context and context[name .. (n and tostring(n) or '')] or default
end

function numberKey(name, context, n, default)
    return context and tonumber(context[name .. (n and tostring(n) or '')]) or default
end

-- * Ship iterators.

function Iterator.shipsByNo(context)
    local extra = stringKey('extra', context)
    local function prefix(i)
        if extra then
            i = i + 1300
        end
        if (i - 1) % 10 == 0 then
            local key = 'key' .. i
            context['custom_row_' .. key .. '_content'] = string.format('==No.%d-%d==', i, i - 1 + 10)
            return '!' .. key
        end
    end
    local collection = U.ifilter(require('Module:Collection/ShipsByNo'), function(e)
        if extra then
            return e.no >= 1301
        else
            return e.no < 1301
        end
    end)
    local i = 0
    local current
    local prefixFlag = true
    return {
        next = function()
            i = i + 1
            local e = collection[i]
            if e then
                local prefixValue = prefix(i)
                if prefixFlag and prefixValue then
                    i = i - 1
                    current = prefixValue
                    prefixFlag = false
                else
                    current = e.name or '-'
                    prefixFlag = true
                end
                return true
            end
            return false
        end,
        current = function()
            return current
        end,
    }
end

-- * Equipment iterators.

function Iterator.equipmentBy(context, n, pred, pre, nItems)
    local predKey = stringKey('pred', context, n)
    local pred2
    if predKey then
        pred2 = function(e)
            local obj = Equipment(e._name)
            return obj[predKey](obj)
        end
    end
    local collection
    local collectionKey = stringKey('collection', context, n)
    if collectionKey then
        local _, CollectionData = U.requireModule(string.format("Collection/%s", collectionKey))
        collection = U.icopy(CollectionData)
    else
        collection = U.icopy(CollectionEquipment)
    end
    local sortKey = stringKey('sort', context, n)
    if sortKey then
        table.sort(collection, function(a, b)
            if a[sortKey] ~= b[sortKey] then
                return a[sortKey] < b[sortKey]
            else
                return a._id < b._id
            end
        end)
    end
    local i = 1
    local current = nil
    local preFlag = true
    local nCollection = nItems == true and #collection or nItems or #collection
    return {
        next = function()
            for _ = i, nCollection do
                local e
                if nItems then
                    e = U.ifindBy(collection, function(e) return e._id == i end) or { _id = i }
                else
                    e = collection[i]
                end
                if pred and not pred(e, i) or pred2 and not pred2(e, i) then
                    i = i + 1
                else
                    if pre and preFlag then
                        local value = pre(e, i)
                        if value then
                            current = value
                            preFlag = false
                            return true
                        end
                    end
                    current = e._name
                    if nItems and not current then
                        current = '-'
                    end
                    i = i + 1
                    preFlag = true
                    return true
                end
            end
            current = nil
            return false
        end,
        current = function()
            return current
        end,
    }
end

function Iterator.equipmentById(context, n)
    local from = numberKey('from', context, n, 1)
    local to = numberKey('to', context, n, 500)
    return Iterator.equipmentBy(context, n, function(e)
        return e._id >= from and e._id <= to
    end)
end

function Iterator.equipmentByIdWithHeaders(context, n)
    local from = numberKey('from', context, n, 1)
    local to = numberKey('to', context, n, 500)
    local prevMod = 0
    return Iterator.equipmentBy(
        context, n,
        function(e)
            return e._id >= from and e._id <= to
        end,
        function(e)
            local currentMod = (e._id - 1) % 10
            if currentMod <= prevMod then
                prevMod = currentMod
                local title = string.format("No. %s - %s", U.pad(e._id - currentMod, 3, "0"), U.pad(e._id - currentMod + 9, 3, "0"))
                return string.format("!#[[Equipment#%s|%s]]", title, title)
            else
                prevMod = currentMod
                return false
            end
        end
    )
end

function Iterator.equipmentByIdWithEmptyWithHeaders(context, n)
    local from = numberKey('from', context, n, 1)
    local to = numberKey('to', context, n, 500)
    local prevMod = 0
    local nItems = (math.floor(U.ilast(CollectionEquipment)._id / 10) + 1) * 10
    return Iterator.equipmentBy(
        context, n,
        function(e)
            return e._id >= from and e._id <= to
        end,
        function(e)
            local currentMod = (e._id - 1) % 10
            if currentMod <= prevMod then
                prevMod = currentMod
                local title = string.format("No. %s - %s", U.pad(e._id - currentMod, 3, "0"), U.pad(e._id - currentMod + 9, 3, "0"))
                return string.format("!#[[Equipment#%s|%s]]", title, title)
            else
                prevMod = currentMod
                return false
            end
        end,
        nItems
    )
end

function Iterator.equipmentByType(context, n)
    local type = numberKey('type', context, n)
    return Iterator.equipmentBy(context, n, function(e)
        return e._type == type
    end)
end

function Iterator.equipmentByIcon(context, n)
    return Iterator.equipmentBy(context, n, function(e)
        return e._icon == numberKey('icon', context, n)
    end)
end

function Iterator.equipmentByTypeAndIcon(context, n)
    local type = numberKey('type', context, n)
    local icon = numberKey('icon', context, n)
    return Iterator.equipmentBy(context, n, function(e)
        return e._type == type and e._icon == icon
    end)
end

-- * Enemy iterators.

function Iterator.enemiesBy(context, n, pred, pre)
    local collection = U.imap(CollectionEnemy, function(name)
        return EnemyShip(name)
    end)
    table.sort(collection, function(a, b)
        local ai = U.ifind(CollectionEnemy, a:base_name())
        local bi = U.ifind(CollectionEnemy, b:base_name())
        if ai and bi and ai ~= bi then
            return ai < bi
        else
            return a._id < b._id
        end
    end)
    local i = 1
    local current = nil
    local preFlag = true
    return {
        next = function()
            for _ = i, #collection do
                local e = collection[i]
                if pred(e, i) then
                    if pre and preFlag then
                        local value = pre(e, i)
                        if value then
                            current = value
                            preFlag = false
                            return true
                        end
                    end
                    current = e:lua_name()
                    i = i + 1
                    preFlag = true
                    return true
                end
                i = i + 1
            end
            current = nil
            return false
        end,
        current = function()
            return current
        end,
    }
end

function Iterator.enemiesByType(context, n)
    local type = numberKey('type', context, n)
    return Iterator.enemiesBy(context, n, function(e)
        return e:type() == type
    end)
end

function Iterator.enemiesByTypeAndInstallationAndBoss(context, n)
    local type = numberKey('type', context, n, 0)
    
    local selectInstallation = stringKey('installation', context, n, ''):lower()
    local predInstallation = selectInstallation == 'yes' and
        function(e) return e._speed == 0 end
        or selectInstallation == 'no' and
        function(e) return e._speed ~=0 end
        or
        function(e) return true end
    
    local selectBoss = stringKey('boss', context, n, ''):lower()
    local predBoss = selectBoss == 'yes' and
        function(e) return e._back <= -11 end
        or selectBoss == 'no' and
        function(e) return e._back >= -10 end
        or
        function(e) return true end
    
    return Iterator.enemiesBy(context, n, function(e)
        return e._hp -- skip unimplemented units
        and (e:type() == type
            or type == 0
            or type < 0 and e:type() ~= -type) -- skip SS-typed bosses
        and predInstallation(e)
        and predBoss(e)
    end)
end

-- * Tests.

function Iterator.test()
    function testIterator(name, args)
        local iterator = Iterator[name](args)
        mw.log(name)
        while iterator.next() do
            mw.log('  ' .. (iterator.current() or '?'))
        end
        mw.log()
    end
    testIterator('equipmentById', { from = '11', to = '20' })
    testIterator('equipmentByIdWithHeaders', { from = '1', to = '30' })
    testIterator('equipmentByType', { type = '2' })
    testIterator('equipmentByType', { type = '1', sort = '_icon' })
    testIterator('equipmentByTypeAndIcon', { type = '1', icon = '16' })
    testIterator('equipmentBy', { pred = 'is_large_caliber_main_gun', sort = '_type' })
    testIterator('enemiesByType', { type = '2' })
end
-- p.test()

return Iterator