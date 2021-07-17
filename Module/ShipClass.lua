local U = require('Module:Core')
local ShipClassData = require('Module:ShipClassData')

local ShipClass = {}

local ship_classes = {}

local function requireShipClassModule(name)
  local success, data = U.requireModule('Data/ShipClass/' .. name)
  if not success then
    success, data = U.requireModule('Data/Ship/' .. name)
  end
  if not success or not data.class then
    data = {class = {_name = name}}
  end
  return data.class
end

function ShipClass:create(name)
  if not name then
    return ShipClassData()
  end
  if not ship_classes[name] then
    ship_classes[name] = ShipClassData(requireShipClassModule(name))
  end
  return ship_classes[name]
end

ShipClass.__call = ShipClass.create
setmetatable(ShipClass, ShipClass)

return ShipClass