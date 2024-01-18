require "AudioBanks"

--[[
Simple music player.
It will player randomly a track in the playlist. see playlist
Between each track there is a silence. see cooldown.
]]
Music = { }

local instance = nil

function Music:init()
    if instance == nil then
        instance = {
            -- silence between two playlist
            cooldown = {
                min = 12,
                max = 25,
            },

            currentEmitter = nil,
            currentCooldown = nil,
            fadeOut = 0,
            currentFadeOut = 0,
            currentTrack = 0,
            shuffle = false,

            playlist = {
                SoundEmitter:new(sources.mus_celestal)
            },

            shuffle = false
        }
        setmetatable(instance, {__index = Music})

        --instance.currentEmitter = instance.playlist[love.math.random(#instance.playlist)]
        --instance.currentCooldown = love.math.random(instance.cooldown.min, instance.cooldown.max)
    end
end

function Music:play(track)
    if instance.playlist[track] ~= instance.currentEmitter or instance.currentEmitter.source:isPlaying() == false or instance.currentFadeOut > 0 then
        if instance.currentEmitter ~= nil and instance.currentEmitter.source:isPlaying() then
            instance.currentEmitter.source:stop()
        end

        instance.currentEmitter = instance.playlist[track]
        instance.currentEmitter:setVolume(1.0)
        instance.currentEmitter.source:play()
        instance.currentTrack = track

        if instance.shuffle then
            instance.shuffle = loop
        else
            instance.shuffle = false
            instance.currentFadeOut = 0
            instance.currentCooldown = 0
            instance.fadeOut = 0
        end
    end
end

function Music:stop(fadeout)
    instance.currentFadeOut = fadeout or 0
    instance.fadeOut = instance.currentFadeOut

    if instance.shuffle then
        instance.currentCooldown = love.math.random(instance.cooldown.min, instance.cooldown.max)
    end
end

function Music:getFadeOut()
    return instance.currentFadeOut / instance.fadeOut
end

function Music:isPlaying() 
    return instance.currentEmitter.source:isPlaying()
end

function Music:update(dt)
    if instance.currentEmitter.source:isPlaying() == false and instance.shuffle then
        instance.currentCooldown = instance.currentCooldown - dt

        if instance.currentCooldown <= 0 then
            instance.currentCooldown = love.math.random(instance.cooldown.min, instance.cooldown.max)

            instance:play(love.math.random(#instance.playlist))
        end
    elseif instance.currentFadeOut > 0 then
        instance.currentFadeOut = instance.currentFadeOut - dt

        if instance.currentFadeOut <= 0 then
            instance.currentFadeOut = 0
            instance.fadeOut = 0
            instance.currentEmitter.source:stop()
        else
            instance.currentEmitter:setVolume(instance.currentFadeOut / instance.fadeOut)
        end
    end
end