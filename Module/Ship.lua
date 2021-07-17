local U = require("Module:Core")
local BaseData = require('Module:BaseData')

local Ship = BaseData{
  _ships = {},
  _data_class = false,
}

function Ship:_prepareShipData()
  self._data_class = self._data_class or require('Module:ShipData')
end

function Ship:get(stat, name, model)
  return self:create(name, model)[stat]()
end

function Ship:create(name, model)
  self:_prepareShipData()
  if name == nil then
    return self._data_class()
  end
  if model == nil then
    name, model = self:process_ship_key(name)
  end
  if not model then
    model = ""
  end
  -- check if we already have it
  if self._ships[name] and self._ships[name][model] then
    return self._ships[name][model]
  else
    local ship = self._data_class(self:get_table(name, model))
    if not self._ships[name] then
      self._ships[name] = {}
    end
    self._ships[name][model] = ship
    return ship
  end
end

function Ship:process_ship_key_as_reference(reference, base)
  name, model = self:process_ship_key(reference)
  if #name == 0 then
    name = base
  end
  return name, model
end

function Ship:create_from_reference(reference, base)
  name, model = self:process_ship_key(reference)
  if #name == 0 then
    name = base:base_name()
  end
  return self(name, model)
end

function Ship:get_table(name, model)
  local success, ship_table = Ship.requireModule(name, self._enemy)
  local ship_form_table
  if success then
    ship_form_table = ship_table[model]
    if not ship_form_table and ship_table.seasonals then
      ship_form_table = ship_table.seasonals[model] or U.ifindBy(
        ship_table.seasonals,
        function(data)
          return data._suffix == model and (not data._name or data._name == name)
        end
      )
      if ship_form_table and type(ship_form_table) ~= "string" then
        ship_form_table._seasonal = true
      end
    end
    if type(ship_form_table) == "string" then
      ship_form_table = self:get_table(self:process_ship_key_as_reference(ship_form_table, name))
    end
  end
  local id = tonumber(name)
  if not ship_form_table then
    ship_form_table = {
        _name = not id and name or nil,
        _suffix = not id and model or nil,
        _api_id = id or nil,
        _dummy = true
    }
  end
  if ship_form_table._name == nil then
    ship_form_table._name = name
  end
  if ship_form_table._suffix == nil then
    ship_form_table._suffix = model
  end
  ship_form_table._key = model
  if not id and name:sub(1, 5) == 'Vita:' then
    ship_form_table._vita = true
  end
  return ship_form_table
end

function Ship:process_ship_key(ship_key)
  local split = mw.ustring.find(ship_key, '/')
  local ship_base_name, ship_suffix
  if split == nil then
    ship_base_name = ship_key
  else
    ship_base_name = split - 1 > 0 and mw.ustring.sub(ship_key, 1, split - 1) or ''
    ship_suffix = mw.ustring.sub(ship_key, split + 1, -1)
  end
  return ship_base_name, ship_suffix
end

function Ship:get_module(name, isEnemy)
  if not name then
    return nil
  end
  name = self:process_ship_key(name)
  return string.format('Module:Data/%s/%s', isEnemy and 'Enemy' or 'Ship', name)
end

function Ship.requireModule(name, is_enemy)
  local success, ship_table
  if not is_enemy then
	success, ship_table = U.requireModule('Data/Ship/' .. name)
  end
  if not success then
    success, ship_table = U.requireModule('Data/Enemy/' .. name)
  end
  return success, ship_table
end

function Ship:extend(data)
  data = data or {}
  setmetatable(data, data)
  data.__index = self
  data.__call = self.__call
  return data
end

Ship.__call = Ship.create
setmetatable(Ship, Ship)

return Ship