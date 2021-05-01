local U = require("Module:Core")
local format = U.format
local Formatting = require("Module:Formatting")
local Equipment = require("Module:Equipment")
local Iterator = require("Module:Iterator")
local ShipIterator = require("Module:ShipIterator")
local ShipCapabilities = require("Module:ShipCapabilities")
local ShipCardKai = require("Module:ShipCardKai")
local ShipBattleCardKai = require("Module:ShipBattleCardKai")
local Combat2 = require("Module:Combat2")
local EquipmentCardKai = require("Module:EquipmentCardKai")
local EquipmentGraphicKai = require("Module:EquipmentGraphicKai")
local EquipmentCollection = require("Module:Collection/Equipment")
local AllEquipmentCollection = require("Module:Collection/EquipmentByApiId")
local Development = require("Module:Development")
local ShipsByApiId = require("Module:Collection/ShipsByApiId")

local Ship = nil

local frame = nil
local args = nil
local ship = nil
local target = nil
local shipCapabilities = {}
local equipment = nil

-- $('.calc-debug').show().appendTo('#mw-content-text')
local debug = {}

function debugLog(k, v)
    if args.debug then
        k = U.trim(tostring(k))
        v = U.trim(tostring(v))
        table.insert(debug, k .. " = " .. v)
    end
end

function debugString()
    return #debug > 0 and args.debug and ([[<pre class="calc-debug" style="text-align:left;background:transparent;display:none"><code>]] .. table.concat(debug, "\n") .. [[</code></pre>]]) or ""
end

function format_lua(lua)
    if type(lua) == "table" then
        return tostring(table.concat(lua, args.concat_value or ", "))
    else
        return tostring(lua)
    end
end

local enumerating_functions = {

    args = function()
        return mw.text.split(args.args, "%s*,%s*")
    end,

    base_names = function()
        return ShipIterator.baseForms
    end,

    all_names = function()
        return ShipIterator.allForms
    end,
    
    enemy = function()
        return ShipIterator.enemyForms
    end,

    equipment = function()
        return U.imap(EquipmentCollection, function(e) return e._name end)
    end,
    
    allEquipment = function()
        local result = {}
        for i = 1, 700 do
            if AllEquipmentCollection[i] then
                table.insert(result, AllEquipmentCollection[i])
            end
        end
        return result
    end,

    enemyEquipment = function()
        local result = {}
        for i = 501, 700 do
            if AllEquipmentCollection[i] then
                table.insert(result, AllEquipmentCollection[i])
            end
        end
        return result
    end,

}

-- TODO: have a syntax for calling Module:Formatting functions?
local formatting_functions = {

    air_power = function(ship)
        return ship:air_power() or -1
    end,

    night_battle_power = function(ship)
        return (ship:firepower_max() or 0) + (ship:torpedo_max() or 0)
    end,
    
    format_day_battle = function(ship)
        local mode, attack_power = shipCapabilities:day_battle()
        return shipCapabilities:format_day_battle(mode, attack_power)
    end,

    format_night_battle = function(ship)
        local mode, attack_power = shipCapabilities:night_battle()
        return shipCapabilities:format_night_battle(mode, attack_power)
    end,

    format_opening_torpedo = function(ship)
        return shipCapabilities:format_torpedo(shipCapabilities:opening_torpedo())
    end,

    format_closing_torpedo = function(ship)
        return shipCapabilities:format_torpedo(shipCapabilities:closing_torpedo())
    end,

    format_asw_attack = function(ship)
        local attack_power, opening, day, night, uncertain = shipCapabilities:asw_attack()
        return shipCapabilities:format_asw_attack(attack_power, opening, day, night, uncertain)
    end,

    format_opening_airstrike = function(ship)
        return shipCapabilities:format_opening_airstrike(shipCapabilities:opening_airstrike())
    end,

    slots = function(ship)
        return format_lua(U.imap(ship._equipment or {}, function (e) return e and e.size or '?' end))
    end,

    equips = function(ship)
        return 'style="text-align:left"|' .. U.ijoin(U.imap(ship._equipment or {}, function (e)
            if not e or e.equipment == nil then
                return '(?)'
            end
            if e.equipment == false then
                return '[[File:Xx_c.png]]'
            end
            local icon = type(e.equipment) == 'string' and Equipment(e.equipment):icon() or e.equipment:icon()
            local link = type(e.equipment) == 'string' and e.equipment or e.equipment:name()
            return string.format('%s [[%s]]', Formatting:format_image{Formatting:format_equipment_icon(icon), link = link }, link)
        end), "<br>")
    end,

    code = function(obj)
        return equipment and
            Formatting:format_equipment_type(obj:type()) or
            Formatting:format_ship_code(obj:type())
    end,

    -- overrides ShipData:type
    type = function(obj)
        return equipment and
            Formatting:format_equipment_type(obj:type()) or
            Formatting:format_ship_type(obj:type())
    end,

    icon = function(obj)
        if obj.hp then
            if obj:id() >= 1501 then
                return string.format("[[File:Enemy Icon %s.png|100px]]", obj:unique_name():gsub('- Damaged', 'Damaged'))
            else
                return string.format("[[File:Ship Icon %s.png|100px]]", obj:name())
            end
        else
            return obj.icon and ([[<span data-sort-value="]] .. (obj._type or '0') .. [=[">[[File:]=] .. Formatting:format_equipment_icon(obj:icon()) .. "]]</span>") or ''
        end
    end,

    icon_damaged = function(obj)
        return string.format("[[File:Ship Icon %s Damaged.png|100px]]", obj:name())
    end,

    -- overrides ShipData:link
    link = function(obj)
        if obj._dummy then
            local link = ShipsByApiId[obj._api_id]
            if link then
                link = link:gsub('/', ' ')
            end
            return link and Formatting:format_link(link) or ''
        else
            return Formatting:format_link(obj:link())
        end
    end,

    -- overrides ShipData:class
    class = function(ship)
        return ship:class() and ship:class():name() or "?"
    end,

    -- overrides ShipData:implementation_date
    implementation_date = function(ship)
        local date = ship:implementation_date()
        return not date and "??" or format{
            "${year}/${month}/${day}",
            year = date[1],
            month = date[2] < 10 and "0" .. date[2] or date[2],
            day = date[3] < 10 and "0" .. date[3] or date[3],
        }
    end,

    banner = function(obj)
        return ShipBattleCardKai:Asset({ obj:lua_name(), hd = true, size = "160px" })
    end,

    card = function(obj)
        if obj.hp then
            return ShipCardKai:Asset({ obj:lua_name(), hd = true, size = "160px" })
        else
            return EquipmentCardKai:Asset({ obj:name(), size = "75px", link = "nil" })
        end
    end,

    item = function(obj)
        return EquipmentGraphicKai:Asset({ obj:name(), size = "75px", link = "nil" })
    end,

    fairy = function(obj)
        return EquipmentGraphicKai:Asset({ obj:name(), size = "75px", fairy = "only", link = "nil" })
    end,

    full = function(obj)
        return EquipmentGraphicKai:Asset({ obj:name(), size = "75px", fairy = "true", link = "nil" })
    end,

    card_ = function(o) return string.format("[[File:%s Card.png|75px]]", o:name()) end,
    equipment_ = function(o) return string.format("[[File:%s Equipment.png|75px]]", o:name()) end,
    character_ = function(o) return string.format("[[File:%s Character.png|75px]]", o:name()) end,
    full_ = function(o) return string.format("[[File:%s Full.png|75px]]", o:name()) end,

    format_morale = function(ship)
        local morale = ship:morale() or 49
        return morale <= 19 and "Red" or morale <= 29 and "Orange" or morale <= 49 and "Normal" or "Sparkle"
    end,

    hit_rate = function(ship, target)
        local r = Combat2.hit_rate(ship, target)
        if r then
            ship.hit_rate = r
            return r .. "%"
        else
            return "nil"
        end
    end,

    critical_hit_rate = function(ship, target)
        local r = Combat2.critical_hit_rate(ship, target)
        if r then
            ship.critical_hit_rate = r
            return r .. "%"
        else
            return "nil"
        end
    end,

    scrap = function(eq)
        local scrap = eq:scrap()
        return format{
            "${fuel}/${ammo}/${steel}/${bauxite}",
            fuel = scrap.fuel or 0,
            ammo = scrap.ammo or 0,
            steel = scrap.steel or 0,
            bauxite = scrap.bauxite or 0,
        }
    end,

    development = function(eq)
        return Development.formatResources(eq)
    end,

    development_rate = function(eq)
        return Development.formatRates(eq)
    end,
    
    development_hq = function(eq)
        return Development.formatHQ(eq)
    end,
    
    backMinusRarity = function(ship)
        return ship:back() - ship:rarity()
    end,
    
    rarity_bg = function(ship)
        return string.format('style="background:%s"|%s<br>%s', Formatting:format_ship_back(ship:rarity()), ship:rarity() or '??', Formatting:format_ship_rarity(ship:rarity()))
    end,

    back_bg = function(ship)
        return string.format('style="background:%s"|%s<br>%s', Formatting:format_ship_back(ship:back()), ship:back() or '??', Formatting:format_ship_rarity(ship:back()))
    end,

}

function addFormattingFunctions(name, table)
    for k, v in pairs(table) do
        formatting_functions[name .. "." .. k] = v
    end
end

local Plugins = require("Module:Calc/Plugins")

for _, name in ipairs(Plugins) do
    local data = require("Module:Calc/Plugins/" .. name)
    addFormattingFunctions(name, data)
end

function format_value(key, ship, target)
    local formatting_function = formatting_functions[key]
    if formatting_function then
        return formatting_function(ship, target)
    end
    if shipCapabilities[key] then
        local a, b = shipCapabilities[key](shipCapabilities)
        return format_lua(b or a)
    end
    if ship then
        local lua = ship[key]
        if type(lua) == "function" then
            return format_lua(lua(ship))
        else
            return format_lua(lua)
        end
    end
end

local sequence = nil
local sequence_position = nil

function format_arg(arg)
    return args.format == "table" and ("| " .. arg .. "\n") or arg
end

local env = {}

function interpret_setter(s)
    local kv = mw.text.split(s, "%s*~%s*")
    local k = kv[1]
    local v = kv[2]
    local c = kv[3]
    if k and v and c then
        env[c] = env[c] or require("Module:" .. c)
        env[k] = env[c](v)
        if k == "_" then
            ship = env[k]
        end
        return true
    elseif k and v then
        if k == "_equipment" then
            local equipment = {}
            local accuracy = 0
            local ng = 0
            for eq in string.gmatch(v, '([^,]+)') do
                local eqObj = Equipment(eq)
                table.insert(equipment, { equipment = eqObj })
                accuracy = accuracy + (eqObj:shelling_accuracy() or 0)
                if eqObj:type() == 3 then
                    ng = ng + 1
                end
            end
            ship._equipment = equipment
            ship._accuracy = accuracy
            if ng > 0 then
                ship._ng = ng
            end
        else
            if v ~= "nil" and ship then
                ship[k] = tonumber(v)
            else
                env[k] = v
            end
        end
        return true
    else
        return false
    end
end

function interpret_arg(arg, args)
    local prefix = string.sub(arg, 1, 1)
    local prefix2 = string.sub(arg, 1, 2)
    if arg == "_" then
        return false
    elseif arg == "-" then
        return format_arg("")
    elseif prefix == "@" then
        local enumerator = string.sub(arg, 2)
        local enumerating_function = enumerating_functions[enumerator]
        if enumerating_function and not sequence then
            sequence = enumerating_function()
            sequence_position = 1
        elseif not sequence then
            local buildIterator = Iterator[enumerator]
            if buildIterator then
                sequence = {}
                sequence_position = 1
                local iterator = buildIterator(args)
                while iterator.next() do
                    table.insert(sequence, iterator.current())
                end
            end 
        end
    elseif arg == "!@" then
        local ship_key = sequence[sequence_position]
        ship_key = tonumber(ship_key) or ship_key
        sequence_position = sequence_position + 1
        ship = Ship(ship_key)
        if ship:id() then
            shipCapabilities = ShipCapabilities{ ship = ship }
        else
            ship = Equipment(ship_key)
            equipment = true
        end
    elseif prefix2 == "!!" then
        local key = string.sub(arg, 3)
        target = Ship(key)
    elseif prefix == "!" then
        local key = string.sub(arg, 2)
        if not interpret_setter(key) then
            local parts = string.gmatch(key, '([^:]+)')
            local i = 1
            for part in parts do
                if i == 1 then
                    key = part
                    ship = Ship(key)
                    if ship._dummy then
                    elseif ship:id() then
                        shipCapabilities = ShipCapabilities{ ship = ship }
                    else
                        ship = Equipment(key)
                        equipment = true
                    end
                else
                    interpret_setter(part)
                end
                i = i + 1
            end
        end
    elseif prefix == "#" and args.format == "table" then
        return "|-\n"
    elseif prefix == "?" then
        local prefix2 = string.sub(arg, 1, 2)
        if prefix2 == "??" then
            return format_arg(format_value(string.sub(arg, 3), target, ship))
        elseif prefix2 == "?#" then
            return frame:preprocess(format{string.sub(arg, 3), this = env[this] or ""})
        else
            return format_arg(format_value(string.sub(arg, 2), ship, target))
        end
    else
        return format_arg(arg)
    end
end

function interpret_args()
    Ship = args.enemy and require("Module:EnemyShip") or require("Module:Ship")
    debugLog("#args", #args)
    debugLog("type(args)", type(args))
    if args.from and args.to then
        sequence = {}
        for i = tonumber(args.from), tonumber(args.to) do
            table.insert(sequence, i)
        end
        sequence_position = 1
    end
    local i = 1
    local values = {}
    repeat
        for _, arg in ipairs(args) do
            debugLog("i", i)
            debugLog("arg", arg)
            local value = interpret_arg(arg, args)
            debugLog("value", value)
            if value then
                table.insert(values, value)
            end
            i = i + 1
        end
    until not sequence or sequence_position > #sequence
    debugLog("#values", #values)
    return table.concat(values, args.concat or "") .. debugString()
end

local Calc = {}

function Calc.format(frame_, args_)
    frame = frame_
    args = args_ or U.getTemplateArgs(frame).explicit
    for _, arg in ipairs(args) do
        debugLog("arg", arg)
    end
    return interpret_args()
end

function Calc.test()
    mw.log(
        Calc.format(nil, {
            format = "table",
            debug = "true",
            "!Nagato/Kai Ni",
            "!_equipment ~ 41cm Triple Gun Mount Kai, 41cm Triple Gun Mount Kai, Type 13 Air Radar Kai",
            "!_level ~ 99",
            "!_luck ~ nil",
            "!_morale ~ 25",
            "!!Destroyer Ro-Class",
            "!cl0 ~ 56",
            "!cl1 ~ 807",
            "!cl2 ~ 137",
            "?card",
            "?level",
            "?format_morale",
            "?accuracy",
            "?luck",
            "??card",
            "?cl0",
            "?cl1",
            "?cl2",
            "",
            "",
            "",
            "",
            "-",
            "?FitData.hit",
            "?FitData.error",
            "?FitData.crit",
            "?hit_rate",
            "?critical_hit_rate",
            "?FitData.difference",
            "?FitData.critical_difference",
            "?FitData.accuracy_value",
            "?FitData.fit",
        })
    )
end

function Calc.test2()
    mw.log(
        Calc.format(nil, {
            type = "1",
            "@equipmentByType",
            "!@",
            "?link",
        })
    )
end

-- print(p.test())

return Calc