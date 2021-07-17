local Stat = require("Module:Stat")
local Combat = require("Module:CalcCombat")

return {

    hit = function(ship)
        return Stat.rate({ args = { ship.cl1 + ship.cl2, ship.cl0 + ship.cl1 + ship.cl2 } }) .. "%"
    end,

    crit = function(ship)
        return Stat.rate({ args = { ship.cl2, ship.cl0 + ship.cl1 + ship.cl2 } }) .. "%"
    end,

    error = function(ship)
        return Stat.error({ args = { ship.cl1 + ship.cl2, ship.cl0 + ship.cl1 + ship.cl2 } }) .. "%"
    end,

    difference = function(ship)
        if ship.hit_rate then
            local diff = 100 * (ship.cl1 + ship.cl2) / (ship.cl0 + ship.cl1 + ship.cl2) - ship.hit_rate
            return string.format("%.2f%%", diff)
        else
            return "nil"
        end
    end,

    critical_difference = function(ship)
        if ship.critical_hit_rate then
            local diff = 100 * (ship.cl2) / (ship.cl0 + ship.cl1 + ship.cl2) - ship.critical_hit_rate
            return string.format("%.2f%%", diff)
        else
            return "nil"
        end
    end,

    accuracy_value = function(ship, target)
        local accuracy_value_1, _, accuracy_value_3 = Combat.accuracy_value(ship, target)
        if accuracy_value_1 and accuracy_value_3 then
            return string.format('<span class="explain" title="Before fit: %.2f%%">%d%%</span>', accuracy_value_1, math.floor(accuracy_value_3))
        else
            return "nil"
        end
    end,

    fit = function(ship, target)
        local context = {}
        context._ng = ship._ng
        context._ci, context._hit_rate = Stat.error_(ship.cl1 + ship.cl2, ship.cl0 + ship.cl1 + ship.cl2)
        local fit, min_fit, max_fit = Combat.find_fit(ship, target, context)
        if fit and min_fit and max_fit and ship._ng then
            return string.format('<span class="explain" title="%d ~ %d">%d</span>', min_fit, max_fit, fit)
        else
            return "nil"
        end
    end,

}