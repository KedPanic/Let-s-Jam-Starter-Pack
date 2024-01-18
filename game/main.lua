require "conf"

world = nil
physics_world = nil
ground = nil
debug_draw = false
currentState = nil
next_state = nil
map = nil
debug =
{
	draw_stats = false,
	dev_menu = false,
	draw_audio = false,
	draw_physics = false
}

bgWin = {r = 0, g = 209/255, b = 146/255}

require "letsjam/Keypressed"
require "letsjam/Music"
require "letsjam/Print"
require "letsjam/Room"
require "letsjam/SoundEmitter"
require "letsjam/SoundManager"
require "letsjam/SoundPoint"
require "letsjam/Trigger"
require "letsjam/World"


function beginContact(a, b, coll)
	local aa = a:getUserData()
	local bb = b:getUserData()

	if aa.type == nil or bb.type == nil then
		return
	end

	if aa.type.onContact ~= nil then
		aa:onContact(bb)
	end

	if bb.type.onContact ~= nil then
		bb:onContact(aa)
	end
end

-- rendering settings.
local bgColor = {r = 0.1412, g = 0, b = 0.0588}
canvas = nil

require "AudioBanks"
require "GameState_Menu"
require "GameState_Game"
require "GameState_GameOver"
require "GameState_Credits"
require "sprites"

local ui_validate_source = nil
function play_validate()
	ui_validate_source.source:stop()
	ui_validate_source.source:play()
end

local sti = require "sti/sti"

function setNextGameState(gameState)
	next_state  = gameState
end

function setGameState(gameState)
	next_state = nil

	if currentState ~= nil then
		currentState:finish()
	end

	currentState = gameState
	currentState:begin()
end

function load_map(mapname)
	-- clear previous map
	if map ~= nil then
		while #map.layers > 0 do
			map:removeLayer(#map.layers)
		end

		map = nil
	end

	if physics_world ~= nil then
		physics_world:destroy()
	end

	-- create a new physic world
	physics_world = love.physics.newWorld(0, 9.81*24, true)
	physics_world:setCallbacks(beginContact)

	-- load the map
	map = sti("assets/maps/"..mapname, { "box2d" })
	map:box2d_init(physics_world)
	
	-- create objects.
	for _, object in pairs(map.objects) do
		world:createObject(object)
	end
end

-- startup the game.
function love.load()
	if arg[#arg] == "-debug" then
		require("mobdebug").start()
	end

	-- setup audio
	SoundManager:init()
	Music:init()
	ui_validate_source = SoundEmitter:new(sources.ui_validate)

	-- setup windows.
	love.graphics.setDefaultFilter("nearest", "nearest")

	-- create physical world
	love.physics.setMeter(8)
	physics_world = love.physics.newWorld(0, 9.81*24, true)
	physics_world:setCallbacks(beginContact)

	-- create game world
	world = World:new()

	-- set current state
	setGameState(GameState_Menu:new())

	-- create render target
	canvas = love.graphics.newCanvas(render_target.width, render_target.height)

	-- Register the supported tiled "Class"
	-- Add your own class here.
	world:registerObjectType(Room, "room")
	world:registerObjectType(SoundPoint, "sound")
	world:registerObjectType(Trigger, "trigger")
end

-- keypressed callback
function love.keypressed( key )
	currentState:keypressed(key)

	keypressed(key)

	if key == "f1" then
		debug.draw_stats = not debug.draw_stats
	end

	if key == "f2" then
		debug.dev_menu = not debug.dev_menu
	end

	if key == "f3" then
		debug.draw_audio = not debug.draw_audio
	end

	if key == "f4" then
		debug.draw_physics = not debug.draw_physics
	end
end

-- update the game
function love.update(dt)
	SoundManager:update(dt)
	physics_world:update(dt)

	if map ~= nil then
		map:update(dt)
	end

	Music:update(dt)
	currentState:update(dt)

	if next_state ~= nil then
		setGameState(next_state)
	end

	Print:update(dt)
end

-- update the draw
function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear(bgColor.r, bgColor.g, bgColor.b, 1, true, true)

	currentState:draw()

	-- draw render target.  
	love.graphics.setCanvas()
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.draw(canvas, 0, 0, 0, 4, 4)

	currentState:draw_ui()

	-- debug stats
	if debug.draw_stats then
		local ox = 5
		local oy = 5
		local stats = love.graphics.getStats()

		love.graphics.setColor(0.25, 0.25, 0.25, 0.8)
		love.graphics.rectangle("fill", ox + 0, oy + 0, ox + 250, oy + 85)

		ox = 10
		love.graphics.setColor(0.8, 0.8, 0.8)
		love.graphics.print("FPS: "..love.timer.getFPS( ), ox, 5)
		love.graphics.print("Active audio sources: "..love.audio.getActiveSourceCount(), ox, 20)
		love.graphics.print("Draw calls: "..stats.drawcalls, ox, 35)
		love.graphics.print(string.format("Texture memory: %.2f MB", (stats.texturememory / 1024 / 1024)), ox, 50)
		love.graphics.print("Physic Bodies count: ".. physics_world:getBodyCount(), ox, 65)
		love.graphics.print("Audio Distance Model: "..love.audio.getDistanceModel(), ox, 80)
	end

	Print:draw()
end

