-- 
--[[
Simple trigger with optional onDamage.

Tiled Properties:
Class = trigger
Name = SFX name in the audio banks
damage = value
]]
Trigger = {}

-- Constructor.
function Trigger:new(object)
    local obj = {}
    setmetatable(obj, {__index = Trigger})
    
    obj.body = love.physics.newBody(physics_world, object.x + object.width * 0.5, object.y + object.height * 0.5, "static")
    obj.shape = love.physics.newRectangleShape(object.width, object.height)
    obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
    obj.fixture:setSensor(true)
    obj.fixture:setUserData(obj)
    --self.fixture:setGroupIndex(GROUP_TRIGGER)
    --self.fixture:setMask(GROUP_MAP)

    if object.properties["damage"] ~= nil then
        obj.damage = object.properties["damage"]
    end
    
    return obj
end

-- 
function Trigger:onContact(other)
  if self.damage ~= nil then
    if other.type.onDamage ~= nil then
      other:onDamage(self.damage)
    end
  end
end