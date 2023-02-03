--[[
The sound manager handler the sound emitter instances and the room
]]
SoundManager = {}
local instance = nil

local audioDistanceModel =
{
    "none",
    "inverse",
    "inverseclamped",
    "linear",
    "linearclamped",
    "exponent",
    "exponentclamped"
}

local currentAudioDistanceModel = 5

function SoundManager:init()
    if instance == nil then
        instance = {}
        setmetatable(instance, {__index = SoundManager})

        instance.emitters = {}
        instance.rooms = {}
        instance.update_sources = {}

        currentAudioDistanceModel = 5
        love.audio.setDistanceModel(audioDistanceModel[currentAudioDistanceModel])

        bindKeypressed(instance)
    end
end 

function SoundManager:registerRoom(room)
    table.insert(instance.rooms, room)
end

function SoundManager:registerSoundEmitter(emitter)
    table.insert(instance.emitters, emitter)
end

function SoundManager:update(dt)
    -- update the sound emitters which have moved and need to update there effect.
    local latestIndex = #instance.emitters
    local i = 1
    while i <= latestIndex do
        local emitter = instance.emitters[i]
        if emitter.source == nil then
            if i ~= latestIndex then
                instance.emitters[i] = instance.emitters[latestIndex]
            end
            
            instance.emitters[latestIndex] = nil
            latestIndex = latestIndex - 1
        elseif emitter.hasMoved then
            for _, room in ipairs(instance.rooms) do
                if room:isSourceInside(emitter) then
                    emitter.hasMoved = false
                    break
                end
            end
        end

        i = i + 1
    end
end 

function SoundManager:draw()
    love.graphics.setColor(1, 1, 1)

    for i=#instance.emitters, 1, -1 do
        local emitter = instance.emitters[i]
        if emitter ~= nil then
            if emitter.source:isPlaying() then
                if emitter.type.is3D then
                    local x, y = emitter.source:getPosition()
                    local min, max = emitter.source:getAttenuationDistances()
                    love.graphics.circle("line", x, y, min)
                    love.graphics.circle("line", x, y, max)
                end
            end
        end
    end
end 

function SoundManager:keypressed(key)
    if key == "pageup" then
        currentAudioDistanceModel = currentAudioDistanceModel + 1
        if currentAudioDistanceModel > #audioDistanceModel then
            currentAudioDistanceModel = 1
        end
        
        love.audio.setDistanceModel(audioDistanceModel[currentAudioDistanceModel])
    elseif key == "pagedown" then
        currentAudioDistanceModel = currentAudioDistanceModel - 1
        if currentAudioDistanceModel < 1 then
            currentAudioDistanceModel = #audioDistanceModel
        end
        
        love.audio.setDistanceModel(audioDistanceModel[currentAudioDistanceModel])
    end
end 