local U = require('Module:Core')
local VoiceActorData = require('Module:VoiceActorData')

local VoiceActor = {}

local voice_actors = {}

function VoiceActor:get(stat, name)
  return self:create(name)[stat]()
end

local function requireVoiceActorModule(name)
  local success, data = U.requireModule('VoiceActor/' .. name)
  if not success then
    success, data = U.requireModule('Data/VoiceActor/' .. name)
  end
  if not success then
    data = {_name = name}
  end
  return data
end

function VoiceActor:create(name)
  if not name then
    return VoiceActorData()
  end
  if not voice_actors[name] then
    voice_actors[name] = VoiceActorData(requireVoiceActorModule(name))
  end
  return voice_actors[name]
end

function VoiceActor:get_module(name)
  return name and mw.ustring.format('Module:Data/VoiceActor/%s', name) or nil
end

function VoiceActor:extend(data)
  data = data or {}
  setmetatable(data, data)
  data.__index = self
  data.__call = self.__call
  return data
end

VoiceActor.__call = VoiceActor.create
setmetatable(VoiceActor, VoiceActor)

return VoiceActor