require "audiobanks"

--[[
Audio Room.
Apply effect on audio source inside the room.
@See effects in audiobanks.lua

Tiled Properties:
Class = room
Name = effect to apply on any audio source playing in the room
]]
Room = {}

function Room:new(object)
  local obj = {}
  obj.width = object.width
  obj.height = object.height
  obj.reverb = object.name

  setmetatable(obj, {__index = Room})
    
  SoundManager:registerRoom(obj)
  return obj
end
   
function Room:isSourceInside(emitter)
  local x = emitter.x
  local y = emitter.y
  if x < self.x or x > self.x + self.width or y < self.y or y > self.y + self.height then
    emitter.source:setEffect(self.reverb, false)
  else
    emitter.source:setEffect(self.reverb, true)
  end
end