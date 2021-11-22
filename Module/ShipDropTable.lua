local U = require("Module:Core")
local Ship = require("Module:Ship")
local Formatting = require("Module:Formatting")
local dropData = require("Module:Data/ShipDrop")

local worlds = {
  {world = 1, maps = 6},
  {world = 2, maps = 5},
  {world = 3, maps = 5},
  {world = 7, maps = 3},
  {world = 4, maps = 5},
  {world = 5, maps = 5},
  {world = 6, maps = 5},
}

local function formatShip(shipName)
  local ship = Ship(shipName)
  local shipDropData = dropData[shipName] or {}
  local result = {
    string.format(
      [=[<tr><td>[[%s]]</td><td%s>%s</td><td>[[%s]]</td><td>%s</td>]=],
      shipName,
      ship:back() and string.format(' style="background-color:%s;color:black"', Formatting:format_ship_back(ship:back())) or "",
      Formatting:format_ship_rarity(ship:back()),
      Formatting:format_ship_code(ship:type()),
      U.pad(ship:id() or "???", 3, "0")
    )
  }
  for _, e in ipairs(worlds) do
    for map = 1, e.maps do
      local drop = shipDropData[string.format("%d-%d", e.world, map)]
      table.insert(result, string.format("<td%s>%s</td>", drop and ' style="background-color:#c8e6c9"' or "", drop and Formatting:tooltip2("✓", drop, "; ") or ""))
    end
  end
  local remark =
    ship:buildable() and (ship:buildable_lsc() and "Buildable" or "Buildable (no LSC)") or (ship:buildable_lsc() and "LSC only" or "Unbuildable")
  table.insert(result, string.format("<td>%s</td></tr>", remark))
  return table.concat(result)
end

local function render(frame)
  local args = frame.args
  local result = {[[<div style="overflow-x:auto"><table class="wikitable sortable" style="text-align:center;width:100%">]]}
  table.insert(result, "<tr>")
  for _, cell in ipairs({"Ship", "Rarity", "Type", "No."}) do
    table.insert(result, string.format([[<th rowspan="2">%s</th>]], cell))
  end
  for _, e in ipairs(worlds) do
    table.insert(result, string.format([=[<th colspan="%s">[[World %s]]</th>]=], e.maps, e.world))
  end
  table.insert(result, [[<th rowspan="2">Remarks</th></tr><tr>]])
  for _, e in ipairs(worlds) do
    for map = 1, e.maps do
      table.insert(result, string.format([=[<th>[[%s-%s|%s]]</th>]=], e.world, map, map))
    end
  end
  table.insert(result, "</tr>")
  for _, shipName in ipairs(args[1] == "all" and U.sort(U.keys(dropData)) or args) do
    table.insert(result, formatShip(shipName))
  end
  table.insert(result, [[</table></div>]])
  return table.concat(result)
end

return { returnShipDrop = render }