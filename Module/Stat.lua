
local Stat = {}

function Stat.rate(frame)
    local a = tonumber(frame.args[1])
    local b = tonumber(frame.args[2])
    local n = frame.args[3] and tonumber(frame.args[3]) or 1
    local f = frame.args["format"] and tonumber(frame.args["format"]) or 2
    if a and b and n and f then
        return string.format("%." .. f .. "f", 100 * (1 - (1 - a / b) ^ n))
    else
        return "nil"
    end
end

function Stat.trials(frame)
    local a = tonumber(frame.args[1])
    local b = tonumber(frame.args[2])
    local q = tonumber(frame.args[3])
    if a and b and q then
        return string.format("%.f", math.log(1 - q / 100) / math.log(1 - a / b))
    else
        return "nil"
    end
end

function Stat.error_(a, b, pc)
    pc = pc or 1.96
    local p = a / b
    local se = math.sqrt(p * (1 - p) / b)
    return 100 * (pc * se + 0.5 / b), 100 * p
end

function Stat.error(frame)
    local a = tonumber(frame.args[1])
    local b = tonumber(frame.args[2])
    local f = frame.args["format"] and tonumber(frame.args["format"]) or 2
    local pc = frame.args["percentile"] and tonumber(frame.args["percentile"]) or 1.96
    if a and b and f and pc then
        return string.format("%." .. f .. "f", Stat.error_(a, b, pc))
    else
        return "nil"
    end
end

function Stat.players(frame)
    local a = tonumber(frame.args[1])
    local b = tonumber(frame.args[2])
    local sh = tonumber(frame.args[3])
    if a and b and sh then
        return string.format("%.f", ( 1 / ( ( 1 - ( a / b ) ) ^ ( sh ) ) ) )
    else
        return "nil"
    end
end
return Stat