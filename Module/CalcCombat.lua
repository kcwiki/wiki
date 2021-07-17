local Combat2 = {}

local sqrt = math.sqrt
local floor = math.floor
local ceil = math.ceil
local min = math.min
local max = math.max

function initArgs(ship, target, context)
    return ship and ship.ship or ship or {}, target and target.ship or target or {}, context or {}
end

function target_morale_modifier(morale)
    return not morale and 1 or morale <= 20 and 1.4 or morale <= 32 and 1.2 or morale <= 52 and 1 or 0.7
end

function Combat2.evasion_value(target, context)
    _, target, context = initArgs(nil, target, context)
    local evasion = target._evasion or 0
    local target_luck = target._luck or 0
    local target_formation = context._target_formation or target._formation or 1
    local base_evasion_value = floor((evasion + sqrt(2 * target_luck)) * target_formation)
    local capped_evasion_value
        = base_evasion_value < 40
        and base_evasion_value
        or base_evasion_value < 65
        and floor(40 + 3 * sqrt(base_evasion_value - 40))
        or floor(55 + 2 * sqrt(base_evasion_value - 65))
    local evasion_value = capped_evasion_value
    return evasion_value
end

-- [[Category:Todo]]: in case of other types (torpedo, etc.), use generic functions.

-- * Shelling.

function morale_modifier(morale)
    return not morale and 1 or morale <= 20 and 0.5 or morale <= 32 and 0.8 or morale <= 52 and 1 or 1.2
end

function Combat2.accuracy_value(ship, target, context)
    ship, target, context = initArgs(ship, target, context)
    local level = ship._level or 1
    local luck = ship._luck or 0
    local accuracy = ship._accuracy or 0
    local fit = ship._fit or 0
    local as_modifier = ship._as_modifier or 1
    local ap_modifier = ship._ap_modifier or 1
    local morale = morale_modifier(ship._morale)
    local formation = context._formation or ship._formation or 1
    local accuracy_value_1 = (90 + 2 * sqrt(level) + sqrt(1.5 * luck) + accuracy) * morale * formation
    local accuracy_value_2 = accuracy_value_1 + fit
    local accuracy_value_3 = accuracy_value_2 * as_modifier * ap_modifier
    return accuracy_value_1, accuracy_value_2, accuracy_value_3
end

-- Shelling hit rate.
-- ship and target can be Ship, EnemyShip, ShipCapabilities, or a plain table.
-- [[Category:Todo]]: detection based on _equipment, fuel modifier.
function Combat2.hit_rate(ship, target, context)
    ship, target, context = initArgs(ship, target, context)
    local _, _, accuracy_value = Combat2.accuracy_value(ship, target, context)
    local evasion_value = Combat2.evasion_value(target, context)
    local base_hit_rate = floor(accuracy_value) - evasion_value
    local target_morale = target_morale_modifier(target._morale)
    local capped_hit_rate = min(96, max(10, base_hit_rate) * target_morale)
    local proficiency = ship._proficiency or 0
    return floor(capped_hit_rate) + proficiency + 1, capped_hit_rate
end

-- Shelling critical hit rate.
function Combat2.critical_hit_rate(ship, target, context)
    local _, capped_hit_rate = Combat2.hit_rate(ship, target, context)
    local proficiency = ship._proficiency or 0
    return floor(1.3 * sqrt(capped_hit_rate)) + proficiency + 1
end

function Combat2.find_fit(ship, target, context)
    ship, target, context = initArgs(ship, target, context)
    local prev_fit = ship._fit
    local hit_rate = context._hit_rate
    local ci = context._ci
    if not hit_rate or not ci then
        return
    end
    local ng = context._ng or 1
    local min_hit_rate = floor(hit_rate - ci)
    local max_hit_rate = ceil(hit_rate + ci)
    mw.log(min_hit_rate)
    mw.log(max_hit_rate)
    local fits = {}
    for fit = -10, 10 do
        ship._fit = fit * sqrt(ng)
        local hr = Combat2.hit_rate(ship, target, context)
        mw.log(fit, fit * sqrt(ng), hr, hr - hit_rate)
        if hr >= min_hit_rate and hr <= max_hit_rate then
            table.insert(fits, fit)
        end
    end
    local min_fit = math.min(unpack(fits))
    local max_fit = math.max(unpack(fits))
    local fit = (min_fit + max_fit) / 2
    ship._fit = prev_fit
    return floor(fit + 0.5), min_fit, max_fit
end

-- * Tests.

function Combat2.test()
    local Ship = require("Module:Ship")
    local ship = Ship("Nagato/Kai Ni"){
        _level = 99,
        _accuracy = 10,
        _morale = 25,
        _fit = 5 * sqrt(2),
    }
    local target = Ship("Destroyer Ro-Class")
    --mw.log(Combat2.accuracy_value(ship, target))
    --mw.log(Combat2.hit_rate(ship, target), "")
    --mw.log(Combat2.critical_hit_rate(ship, target))
    mw.log(Combat2.find_fit(ship, target, { _hit_rate = 94.4, _ci = 1.48, _ng = 2 } ))
end
-- print(p.test())

return Combat2