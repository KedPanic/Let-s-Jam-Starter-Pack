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
            
            pendingDestroyObjects = {}
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
    obj.isPendingDestroy = false

    -- create rigid body
    if type.physic ~= nil then
        type.physic(obj)
    end

    table.insert(self.objects, obj)
    obj.id = #self.objects

    return obj
end

-- Destroy the given object.
function World:destroyObject(object)
    if object.type.release ~= nil then
        object:release()
    end

    self.objects[object.id] = self.objects[#self.objects]
    self.objects[object.id].id = object.id
    self.objects[#self.objects] = nil
end

function World:addPendingDestroy(object)
    if object.isPendingDestroy == false then
        object.isPendingDestroy = true
        table.insert(self.pendingDestroyObjects, object)
    end
end

function World:spawnObject(type, x, y)
    -- create a new object.
    local obj = type:new(x, y)
    obj.type = type
    obj.x = x
    obj.y = y

    -- create rigid body
    if type.physic ~= nil then
        type.physic(obj)
    end

    table.insert(self.objects, obj)
    obj.id = #self.objects
    return obj
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
    for i=1, #self.pendingDestroyObjects do
        self:destroyObject(self.pendingDestroyObjects[i])
    end
    self.pendingDestroyObjects = {}
    
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