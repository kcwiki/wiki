local ShipPage = require('Module:ShipPage')

function Gallery(ship)
    return ShipPage.Gallery(nil, { explicit = { ship = ship }, implicit = {} })
end

function GalleryTabber(ship)
    return ShipPage.GalleryTabber({ explicit = { ship = ship }, implicit = {} })
end

local Tests = {}

function Tests.GalleryAll(frame)
    local ShipIterator = require('Module:ShipIterator')
    local result = {}
    for _, ship in ShipIterator.base() do
        table.insert(result, '=[[' .. ship .. '/Gallery|' .. ship .. ']]=')
        table.insert(result, Gallery(ship))
    end
    return frame:preprocess(table.concat(result, '\n'))
end

function Tests.GalleryTabberAll(frame)
    local ShipIterator = require('Module:ShipIterator')
    local result = {}
    for _, ship in ShipIterator.base() do
        table.insert(result, '===[[' .. ship .. '/Gallery|' .. ship .. ']]===')
        table.insert(result, '<div class="ship-page-gallery" data-name="' .. ship .. '">')
        table.insert(result, GalleryTabber(ship))
        table.insert(result, '</div>')
    end
    return frame:preprocess(table.concat(result, '\n'))
end

return Tests