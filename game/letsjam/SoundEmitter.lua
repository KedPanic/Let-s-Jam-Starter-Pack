--[[
The sound emitter 
]]
SoundEmitter = {}

-- Constructor.
function SoundEmitter:new(audioData, x, y)
    local soundEmitter = { }
    setmetatable(soundEmitter, {__index = SoundEmitter})

    soundEmitter.type = audioData
    soundEmitter.source = nil
    
    -- allocate new source
    if type(audioData.data) ~="table" then
        soundEmitter.source = love.audio.newSource(audioData.data, audioData.type)
    else
        soundEmitter.source = love.audio.newSource(audioData.data[love.math.random(#audioData.data)], audioData.type)
    end

    -- setup
    soundEmitter:setVolume(audioData.volume)
    soundEmitter:setPitch(audioData.pitch)
    soundEmitter.source:setLooping(audioData.loop)
    if audioData.is3D == true then
        soundEmitter:setAttenuation(audioData.att_min, audioData.att_max)
        soundEmitter:setPosition(x, y)
    end

    -- start playing the source if requested.
    if audioData.autoplay == true then
        soundEmitter.source:play()
    end

    -- register the emitter.
    SoundManager:registerSoundEmitter(soundEmitter)
    
    return soundEmitter;
end

-- Destructor.
function SoundEmitter:release()
    self.source:stop()
    self.source:release()
    self.source = nil
end

function SoundEmitter:setVolume(volume)
    self.source:setVolume(mixer.master * mixer[self.type.group] * volume)
end

function SoundEmitter:setPitch(pitch)
    self.source:setPitch(pitch)
end

function SoundEmitter:setPosition(x, y)
    if self.type.is3D == true then
        self.source:setPosition(x, y, 0)
    end

    if x ~= self.x or y ~= self.y then
        self.x = x
        self.y = y

        if self.type.enable_effect == true then
            self.hasMoved = true
        end
    end
end

--
function SoundEmitter:setAttenuation(att_min, att_max)
    self.source:setAttenuationDistances(att_min, att_max)
end
