local Utils = require("Module:Core")
local format = require("Module:Core").format

local templates = {
    header = [[{| class="wikitable toggle-target-ship-quotes" style="width:100%"
!style="width:10%;"|Event
!Japanese
!English
!Note]],
    footer = "|}",
    row = [=[|-
|nowrap="nowrap"|[[Seasonal/${season}|${season}]]<br><span class="audio-button click-parent">[[Media:${ship} ${season}.ogg|Play]]</span>
|lang="ja"|${ja}
|${en}
|${note}]=],
    as_ship = [[''As ${ship}'']]
}

local seasons = require("Module:Collection/Seasons")

local ShipSeasonalQuotes = {}

function addRow(result, seasonData, season, ship, note_prefix)
    local shipData = seasonData.ships[ship]
    if shipData then
        for _, lineData in ipairs(shipData) do
            table.insert(result, format{
                templates.row,
                ship = ship,
                season = season,
                ja = lineData.ja,
                en = lineData.en,
                note = (note_prefix or "") .. (note_prefix and lineData.note and "<br>" or "") .. (lineData.note or ""),
            })
        end
     end
end

-- Template:ShipSeasonalQuotes
function ShipSeasonalQuotes.format(frame, args)
    args = args or Utils.getTemplateArgs(frame)
    local ship = args.explicit["1"] or args.implicit.pagename
    local ship2 = args.explicit["2"]
    local result = {}
    table.insert(result, templates.header)
    for _, season in ipairs(seasons) do
        local seasonData = require(string.format("Module:Data/Season/%s", season))
        if ship2 then
            addRow(result, seasonData, season, ship, format{templates.as_ship, ship = ship})
            addRow(result, seasonData, season, ship2, format{templates.as_ship, ship = ship2})
        else
            addRow(result, seasonData, season, ship)
        end
    end
    table.insert(result, templates.footer)
    return table.concat(result, "\n")
end

return ShipSeasonalQuotes