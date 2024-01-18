--[[
The sound emitter 
]]
SoundEmitter = {}

-- Constructor.
function SoundEmitter:new(audioData, x, y)
    local soundEmitter = { }
    setmetatable(soundEmitter, {__index = SoundEmitter})

    if audioData ~= nil then
        soundEmitter:setAudioData(audioData)
        soundEmitter:setPosition(x, y)

        -- start playing the source if requested.
        if audioData.autoplay == true then
            soundEmitter.source:play()
        end
    end

    -- register the emitter.
    SoundManager:registerSoundEmitter(soundEmitter)
    
    return soundEmitter;
end

-- Destructor.
function SoundEmitter:release()
    if self.source ~= nil then
        self.source:stop()
        self.source:release()
    end
    
    self.source = nil
end

function SoundEmitter:setAudioData(audioData)
    self.type = audioData
    self.source = nil

    -- allocate new source
    if type(audioData.data) ~="table" then
        self.source = love.audio.newSource(audioData.data, audioData.type)
    else
        self.source = love.audio.newSource(audioData.data[love.math.random(#audioData.data)], audioData.type)
    end

    -- setup
    self:setVolume(audioData.volume)
    self:setPitch(audioData.pitch)
    self.source:setLooping(audioData.loop)
    if audioData.is3D == true then
        self:setAttenuation(audioData.att_min, audioData.att_max)
    end
end

function SoundEmitter:play(audioData)
    if audioData ~= nil then
        self:setAudioData(audioData)
    end
    
    self.source:play()
end

function SoundEmitter:stop()
    self.source:stop()
end

function SoundEmitter:setVolume(volume)
    self.source:setVolume(mixer.master * mixer[self.type.group] * volume)
end

function SoundEmitter:setPitch(pitch)
    self.source:setPitch(pitch)
end

function SoundEmitter:setPosition(x, y)
    if self.source == nil then
        return
    end
    
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

function SoundEmitter:isPlaying()
    return self.source ~= nil and self.source:isPlaying()
end
