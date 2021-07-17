local U = require("Module:Core")

local Self = {}

Self.groups = {
    {
        {
            [1] = 3,
            [2] = 5,
            [3] = 3,
            [4] = 3,
            [5] = 1,
            [6] = 1,
            [11] = 3,
            [12] = 1,
            [13] = 1,
            [14] = 2,
            [15] = 1,
            [16] = 1,
            [19] = 1,
            [20] = 1,
            [23] = 1,
            [25] = 1,
            [27] = 2,
            [28] = 1,
            [29] = 1,
            [33] = 2,
            [34] = 1,
            [37] = 2,
            [38] = 1,
            [39] = 2,
            [44] = 1,
            [49] = 2,
            [65] = 2,
            [66] = 2,
            [75] = 2,
        },
        {
            [1] = 1,
            [2] = 2,
            [3] = 2,
            [4] = 2,
            [5] = 2,
            [6] = 1,
            [7] = 1,
            [10] = 2,
            [11] = 2,
            [12] = 1,
            [13] = 1,
            [14] = 2,
            [15] = 1,
            [16] = 2,
            [17] = 1,
            [23] = 2,
            [24] = 1,
            [27] = 1,
            [28] = 1,
            [29] = 1,
            [33] = 2,
            [34] = 2,
            [35] = 1,
            [37] = 1,
            [38] = 1,
            [39] = 2,
            [40] = 1,
            [41] = 1,
            [44] = 6,
            [45] = 1,
            [49] = 1,
            [65] = 2,
        },
        {
            [1] = 1,
            [2] = 1,
            [3] = 1,
            [4] = 1,
            [5] = 1,
            [7] = 1,
            [10] = 2,
            [16] = 3,
            [17] = 1,
            [19] = 2,
            [20] = 2,
            [21] = 1,
            [23] = 2,
            [24] = 2,
            [25] = 5,
            [26] = 2,
            [27] = 1,
            [28] = 1,
            [29] = 1,
            [33] = 1,
            [34] = 1,
            [35] = 1,
            [38] = 1,
            [39] = 1,
            [40] = 1,
            [41] = 1,
            [44] = 5,
            [45] = 1,
            [46] = 4,
            [47] = 1,
            [163] = 0,
            [181] = 1,
        },
    },
    {
        {
            [1] = 2,
            [2] = 1,
            [3] = 1,
            [4] = 3,
            [5] = 2,
            [6] = 3,
            [10] = 1,
            [11] = 4,
            [12] = 2,
            [13] = 2,
            [14] = 2,
            [25] = 1,
            [27] = 1,
            [29] = 1,
            [30] = 1,
            [31] = 1,
            [32] = 1,
            [33] = 2,
            [34] = 1,
            [35] = 2,
            [36] = 2,
            [37] = 4,
            [38] = 3,
            [39] = 2,
            [40] = 1,
            [49] = 1,
            [72] = 2,
            [73] = 1,
        },
        {
            [4] = 1,
            [5] = 2,
            [6] = 3,
            [7] = 5,
            [8] = 4,
            [9] = 2,
            [10] = 3,
            [11] = 4,
            [12] = 2,
            [13] = 2,
            [14] = 2,
            [16] = 1,
            [17] = 1,
            [23] = 1,
            [24] = 1,
            [28] = 1,
            [29] = 1,
            [33] = 2,
            [34] = 2,
            [35] = 2,
            [36] = 1,
            [37] = 1,
            [38] = 1,
            [39] = 2,
            [40] = 1,
            [41] = 1,
            [49] = 1,
        },
        {
            [4] = 1,
            [5] = 1,
            [6] = 1,
            [7] = 5,
            [8] = 4,
            [9] = 2,
            [10] = 4,
            [16] = 2,
            [17] = 2,
            [18] = 1,
            [19] = 2,
            [20] = 3,
            [21] = 2,
            [22] = 1,
            [23] = 3,
            [24] = 1,
            [25] = 3,
            [26] = 2,
            [28] = 1,
            [29] = 1,
            [33] = 1,
            [34] = 1,
            [35] = 1,
            [36] = 1,
            [39] = 1,
            [40] = 1,
            [41] = 1,
            [49] = 1,
            [163] = 0,
        },
    },
    {
        {
            [1] = 1,
            [2] = 1,
            [3] = 4,
            [10] = 5,
            [19] = 2,
            [20] = 3,
            [21] = 2,
            [25] = 6,
            [26] = 2,
            [27] = 1,
            [28] = 1,
            [29] = 1,
            [30] = 1,
            [31] = 1,
            [32] = 1,
            [33] = 3,
            [34] = 2,
            [37] = 2,
            [38] = 3,
            [40] = 1,
            [41] = 3,
            [49] = 2,
            [59] = 1,
            [181] = 1,
        },
        {
            [1] = 1,
            [2] = 1,
            [3] = 4,
            [10] = 1,
            [16] = 3,
            [17] = 5,
            [18] = 2,
            [20] = 1,
            [21] = 1,
            [23] = 4,
            [24] = 3,
            [25] = 6,
            [26] = 4,
            [35] = 3,
            [37] = 2,
            [38] = 3,
            [40] = 1,
            [41] = 1,
            [49] = 1,
            [52] = 1,
            [57] = 1,
            [60] = 1,
            [168] = 0,
        },
        {
            [16] = 3,
            [17] = 5,
            [18] = 2,
            [19] = 2,
            [20] = 5,
            [21] = 4,
            [22] = 1,
            [23] = 5,
            [24] = 3,
            [25] = 4,
            [26] = 3,
            [27] = 1,
            [30] = 1,
            [35] = 3,
            [52] = 1,
            [54] = 2,
            [55] = 1,
            [57] = 1,
            [60] = 1,
            [61] = 1,
            [168] = 0,
            [181] = 1,
        }
    }
}

Self.typeGroups = {
    [[<span class="explain" data-group="1" title="DE/DD/CL/CLT/SS/CT/AO">G1</span>]], -- { "DE", "DD", "CL", "CLT", "SS", "AP", "CT", "AO" },
    [[<span class="explain" data-group="2" title="CA/FBB/BB/AR">G2</span>]], -- { "CA", "FBB", "BB", "XBB", "AR" },
    [[<span class="explain" data-group="3" title="CAV/CVL/BBV/CV/SSV/AV/LHA/CVB/AS">G3</span>]], -- { "CAV", "CVL", "BBV", "CV", "SSV", "AV", "LHA", "CVB", "AS" },
}

--[[
Self.resourceGroups = {
    { "Fuel", "Steel" },
    { "Ammo" },
    { "Bauxite" },
}
--]]

function ensureResourceGroup(fuel, ammo, steel, bauxite, resourceGroup)
    local main = math.max(unpack({fuel, ammo, steel, bauxite}))
    function fix(x)
        return x < main and main + 1 or x
    end
    if resourceGroup == 1 then
        return fix(fuel), ammo, fix(steel), bauxite
    elseif resourceGroup == 2 then
        return fuel, fix(ammo), steel, bauxite
    elseif resourceGroup == 3 then
        return fuel, ammo, steel, fix(bauxite)
    end
end

function Self.formatResources(eq, rates)
    if eq:buildable() then
        local result = {}
        local id = eq:id()
        local fuel = (eq:scrap().fuel or 1) * 10
        local ammo = (eq:scrap().ammo or 1) * 10
        local steel = (eq:scrap().steel or 1) * 10
        local bauxite = (eq:scrap().bauxite or 1) * 10
        local maxRate
        for typeGroup, resourceGroups in ipairs(Self.groups) do
            for resourceGroup, equipment in ipairs(resourceGroups) do
                if equipment[id] and equipment[id] > 0 then
                    local fuel, ammo, steel, bauxite = ensureResourceGroup(fuel, ammo, steel, bauxite, resourceGroup)
                    local recipe = U.format{
                        "${fuel}/${ammo}/${steel}/${bauxite}",
                        fuel = fuel,
                        ammo = ammo,
                        steel = steel,
                        bauxite = bauxite,
                    }
                    result[recipe] = result[recipe] or {
                        fuel = fuel,
                        ammo = ammo,
                        steel = steel,
                        bauxite = bauxite,
                        resourceGroup = resourceGroup,
                        types = {},
                    }
                    local rate = U.round(100 * equipment[id] / 50)
                    result[recipe].types[Self.typeGroups[typeGroup]] = result[recipe].types[Self.typeGroups[typeGroup]] or {
                        rate = rate,
                    }
                    if not maxRate or rate > maxRate then
                        maxRate = rate
                    end
                    break
                end
            end
        end
        return U.ijoin(
            U.imap(
                U.isort(U.keys(result)),
                function(recipe)
                    local types = U.isort(U.keys(result[recipe].types))
                    local resourceGroup = result[recipe].resourceGroup
                    return U.format{
                        rates and "${rates}" or "${recipe} (${types})",
                        recipe = U.format{
                           "${fuel}/${ammo}/${steel}/${bauxite}",
                            fuel = (resourceGroup == 1 and U.red or U.id)(result[recipe].fuel),
                            ammo = (resourceGroup == 2 and U.red or U.id)(result[recipe].ammo),
                            steel = (resourceGroup == 1 and U.red or U.id)(result[recipe].steel),
                            bauxite = (resourceGroup == 3 and U.red or U.id)(result[recipe].bauxite),
                        },
                        types = U.ijoin(U.imap(types, function(type)
                            local rate = result[recipe].types[type].rate
                            return (rate == maxRate and U.red or U.id)(type)
                        end), "/"),
                        rates = U.ijoin(U.imap(types, function(type)
                            local rate = result[recipe].types[type].rate
                            return (rate == maxRate and U.red or U.id)(tostring(rate) .. "%")
                        end), "/"),
                    }
                end
            ),
            "<br>"
        )
    else
        return "-"
    end
end

function Self.formatRates(eq)
    return Self.formatResources(eq, true)
end

function Self.formatHQ(eq)
    if eq:buildable() then
        return math.max(math.max((eq:rarity() or 0) - 2, 0) * 10, 1)
    else
        return "-"
    end
end

function Self.test()
    local Equipment = require("Module:Equipment")
    return
        Self.formatResources(Equipment("46cm Triple Gun Mount")) ..
        "\n" ..
        Self.formatRates(Equipment("46cm Triple Gun Mount")) ..
        "\n" ..
        Self.formatResources(Equipment("12cm Single Gun Mount"))
end
-- print(p.test())

return Self