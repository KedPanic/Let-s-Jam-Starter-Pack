--[[
The sound manager handler the sound emitter instances and the room
]]
SoundManager = {}
local sound_manager = nil

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
    if sound_manager == nil then
        sound_manager = {}
        setmetatable(sound_manager, { __index = SoundManager})

        sound_manager.emitters = {}
        sound_manager.rooms = {}
        sound_manager.update_sources = {}

        currentAudioDistanceModel = 5
        love.audio.setDistanceModel(audioDistanceModel[currentAudioDistanceModel])

        bindKeypressed(sound_manager)
    end
end 

function SoundManager:registerRoom(room)
    table.insert(sound_manager.rooms, room)
end

function SoundManager:registerSoundEmitter(emitter)
    table.insert(sound_manager.emitters, emitter)
end

function SoundManager:update(dt)
    -- update the sound emitters which have moved and need to update there effect.
    local latestIndex = #sound_manager.emitters
    local i = 1
    while i <= latestIndex do
        local emitter = sound_manager.emitters[i]
        if emitter.source == nil then
            if i ~= latestIndex then
                sound_manager.emitters[i] = sound_manager.emitters[latestIndex]
            end
            
            sound_manager.emitters[latestIndex] = nil
            latestIndex = latestIndex - 1
        elseif emitter.hasMoved then
            for _, room in ipairs(sound_manager.rooms) do
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

    local listenerX, listenerY = love.audio.getPosition()
    love.graphics.points(listenerX, listenerY)
    
    for i=#sound_manager.emitters, 1, -1 do
        local emitter = sound_manager.emitters[i]
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

function SoundManager:keyreleased(key)
    
end 