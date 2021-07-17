local resource = {
    6657, 5699, 3371, 8909, 7719, 6229, 5449, 8561, 2987, 5501, 3127, 9319, 4365, 9811, 9927, 2423, 3439, 1865, 5925, 4409, 5509, 1517, 9695, 9255, 5325, 3691, 5519, 6949, 5607, 9539, 4133, 7795, 5465, 2659, 6381, 6875, 4019, 9195, 5645, 2887, 1213, 1815, 8671, 3015, 3147, 2991, 7977, 7045, 1619, 7909, 4451, 6573, 4545, 8251, 5983, 2849, 7249, 7449, 9477, 5963, 2711, 9019, 7375, 2201, 5631, 4893, 7653, 3719, 8819, 5839, 1853, 9843, 9119, 7023, 5681, 2345, 9873, 6349, 9315, 3795, 9737, 4633, 4173, 7549, 7171, 6147, 4723, 5039, 2723, 7815, 6201, 5999, 5339, 4431, 2911, 4435, 3611, 4423, 9517, 3243
}

local function key(s)
    local r = 0
    for i = 1, #s do
        r = r + string.byte(s, i)
    end
    return r
end

local function create(id, t)
    return 17 * (id + 7) * resource[1 + (key(t) + id * #t) % 100] % 8973 + 1000
end

local function pad(id)
    return id < 10 and '000' .. id or id < 100 and '00' .. id or id < 1000 and '0' .. id or tostring(id)
end

local function url(id, t)
    return 'http://203.104.209.71/kcs2/resources/ship/' .. t .. '/' .. pad(id) .. '_' .. create(id, 'ship_' .. t) .. '.png'
end

return {
    
    banner = function(ship)
        return ship._api_id and url(ship._api_id, 'banner') or ''
    end,

    banner_dmg = function(ship)
        return ship._api_id and url(ship._api_id, 'banner_dmg') or ''
    end,

    card = function(ship)
        return ship._api_id and url(ship._api_id, 'card') or ''
    end,

    card_dmg = function(ship)
        return ship._api_id and url(ship._api_id, 'card_dmg') or ''
    end,

    full = function(ship)
        return ship._api_id and url(ship._api_id, 'full') or ''
    end,

    full_dmg = function(ship)
        return ship._api_id and url(ship._api_id, 'full_dmg') or ''
    end,

}

-- print(p.card_url({ _api_id = 156 }))
-- http://203.104.209.71/kcs2/resources/ship/card/0156_6982.png