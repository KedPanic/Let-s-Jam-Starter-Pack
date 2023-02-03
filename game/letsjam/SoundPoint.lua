require "audiobanks"

--[[
Simple Sound Point.
Play a sound at the position.

Tiled Properties:
Class = sound
Name = SFX name in the audio banks
]] 
SoundPoint = {}

-- Constructor.
function SoundPoint:new(object)
  local obj = {}
  setmetatable(obj, {__index = SoundPoint})

  obj.source = SoundEmitter:new(sources[object.name], object.x + object.width * 0.5, object.y + object.height * 0.5)
  return obj;
end

-- Destructor.
function SoundPoint:release()
  self.source:release()
end 