--[[
Simpler bussed to ease the mixe of the game.
Add any other bus you need for the mix.

final volume = master * group * source volume

Make sure the 
]]
mixer =
{
  master = 1.0,
  
  amb = 1,
  music = 0.5,
  sfx = 0.65,
  ui = 1.0
}
-- Bus IDs
BUS_AMB = "amb"
BUS_MUSIC = "music"
BUS_SFX = "sfx"
BUS_UI = "ui"


--[[
List of effect assigned on the Room.

see https://love2d.org/wiki/love.audio.setEffect
]]
effects = 
{
  auditorium = love.audio.setEffect("auditorium", {type = "reverb", decaytime=4.32}),
  cave_small = love.audio.setEffect("cave_small", {type = "reverb", decaytime=1.00}),
  cave_medium = love.audio.setEffect("cave_medium", {type = "reverb", decaytime=1.80}),
  cave_large = love.audio.setEffect("cave_large", {type = "reverb", decaytime=2.50}),
  corridor = love.audio.setEffect("corridor", {type = "reverb", decaytime=2.00}),
  
  echo = love.audio.setEffect("echo", {type = "echo"})
}

--[[
List of source audio with there settings.
Add any new source here.
]]
sources = 
{
  ui_validate =
  {
    data =
    {
      love.sound.newSoundData("assets/audio/UI_Use_01.ogg"),
      love.sound.newSoundData("assets/audio/UI_Use_01.ogg"),
      love.sound.newSoundData("assets/audio/UI_Use_01.ogg"),
      love.sound.newSoundData("assets/audio/UI_Use_01.ogg"),
    },
    -- "stream"
    -- "static" 
    type = "static",
    group = BUS_SFX,
    volume = 1.0,
    pitch = 1.0,
    loop = false,
    autoplay = false,
    enable_effect = false, -- allow room effect
    is3D = false,
  },

  -- Musics
  mus_celestal =
  {
    data = love.sound.newSoundData("assets/audio/JetPackMan_Celestal.ogg"),
    -- "stream"
    -- "static" 
    type = "stream",
    group = BUS_MUSIC,
    volume = 1.0,
    pitch = 1.0,
    loop = false,
    autoplay = false,
    enable_effect = false,
    is3D = false,
  },
}
