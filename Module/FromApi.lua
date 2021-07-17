local getArgs = require('Module:GetArgs')

local ships
local equipment

local FromApi = {}

function FromApi.ShipFromApiId(frame)
  if not ships then
    ships = require('Module:Collection/ShipsByApiId')
  end
  local args = getArgs{frame = frame:getParent()}
  local apiId = tonumber(args[1] or args.ship)
  return ships[apiId]
end

function FromApi.EquipmentFromApiId(frame)
  if not equipment then
    equipment = require('Module:Collection/EquipmentByApiId')
  end
  local args = getArgs{frame = frame:getParent()}
  local apiId = tonumber(args[1] or args.equipment)
  return equipment[apiId]
end

return FromApi