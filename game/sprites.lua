local peachy = require("peachy/peachy")

-- Simple Sprites Banks
sprites = 
{
  --[[
  Example:
  hero = peachy.new("assets/sprites/hero.json", love.graphics.newImage("assets/sprites/hero.png"), "idle_loop"),
  ]]
  menu = peachy.new("assets/sprites/Title_Intro.json", love.graphics.newImage("assets/sprites/Title_Intro.png"), "Loop"),
  credits = peachy.new("assets/sprites/Title_End.json", love.graphics.newImage("assets/sprites/Title_End.png"), "Loop"),

  play = love.graphics.newImage('assets/sprites/Play.png'),
  quit = love.graphics.newImage('assets/sprites/Quit.png'),
}
