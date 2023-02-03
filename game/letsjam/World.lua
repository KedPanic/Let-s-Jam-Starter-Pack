-- World
World = {}
local worldInstance

function World:new()
    if worldInstance == nil then
        
        worldInstance = {
            -- Registered type of objects
            registeredObjects = {},

            -- list of created game objects. 
            objects = {},
        }
        
        setmetatable(worldInstance, {__index = World})
    end
    
    return worldInstance
end

function World:registerObjectType(type, name)
    self.registeredObjects[name] = type
end

function World:createObject(object)
    -- find the object type.
    local type = self.registeredObjects[object.class]
    if type == nil then
        print(object.class.." not registered")
        return
    end

    -- create a new object.
    local obj = type:new(object)
    obj.type = type
    obj.x = object.x
    obj.y = object.y

    -- create rigid body
    if type.physic ~= nil then
        type.physic(obj)
    end

    if obj.type ~= Player then
        table.insert(self.objects, obj)
    end

    return obj
end

-- Destroy the given object.
function World:destroyObject(object)
    if object.type.release ~= nil then
        object:release(objects[i])
    end

    table.remove(self.objects, object.id)
end

-- Destroy all the created object.
function World:clear()
    for i=1, #self.objects do
        if self.objects[i].type.release ~= nil then
            self.objects[i]:release()
        end
    end

    self.objects = {}
end

function World:update(dt)
    for i=1, #self.objects do
        if self.objects[i].type.update ~= nil then
            self.objects[i]:update(dt)
        end
    end
end

function World:draw()
    for i=1, #self.objects do
        if self.objects[i].type.draw ~= nil then
            self.objects[i]:draw()
        end
    end
end 