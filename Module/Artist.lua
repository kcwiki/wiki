local U = require('Module:Core')
local ArtistData = require('Module:ArtistData')

local Artist = {}

local artists = {}

function Artist:get(stat, name)
  return self:create(name)[stat]()
end

local function requireArtistModule(name)
  local success, data = U.requireModule('Artist/' .. name)
  if not success then
    success, data = U.requireModule('Data/Artist/' .. name)
  end
  if not success then
    data = {_name = name}
  end
  return data
end

function Artist:create(name)
  if not name then
    return ArtistData()
  end
  if not artists[name] then
    artists[name] = ArtistData(requireArtistModule(name))
  end
  return artists[name]
end

function Artist:get_module(name)
  return name and string.format('Module:Data/Artist/%s', name) or nil
end

function Artist:extend(data)
  data = data or {}
  setmetatable(data, data)
  data.__index = self
  data.__call = self.__call
  return data
end

Artist.__call = Artist.create
setmetatable(Artist, Artist)

return Artist