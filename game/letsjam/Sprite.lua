require "AudioBanks"

--[[
Sprite.
it will play the default animation

Tiled Properties:
Class = sprite
Name = sprite to draw @see sprites.lua
]]
Sprite = {}

function Sprite:new(object)
	local obj = {}
	setmetatable(obj, {__index = Sprite})
	
	obj.sprite = sprites[object.name]

	return obj
end

function Sprite:update(dt)
	self.sprite:update(dt)
end
function Sprite:draw()
	self.sprite:draw(math.floor(self.x + 0.5), math.floor(self.y + 0.5))
end
