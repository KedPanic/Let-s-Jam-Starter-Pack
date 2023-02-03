require "letsjam/world"

-- camera position
local camera =
{
	x = 0,
	y = 0,
	target = nil,
	offset =
	{
		x = 160,
		y = 90
	}
}

GameState_Game = {}

function GameState_Game:new()
	local state = {
		gameover = false,
	}
	setmetatable(state, {__index = GameState_Game})

	return state
end

function GameState_Game:begin()
end

function GameState_Game:finish()
	world:clear()
end

function GameState_Game:keypressed(key)
	if key == "escape" then
		setNextGameState(GameState_Credits:new())
	end
end

function GameState_Game:update(dt)
	world:update(dt)

	if love.keyboard.isDown("up")  then
		camera.y = camera.y + 50 * dt
	elseif love.keyboard.isDown("down")  then
		camera.y = camera.y - 50 * dt
	end
	
	if love.keyboard.isDown("left") then
		camera.x = camera.x + 50 * dt
	elseif love.keyboard.isDown("right") then
		camera.x = camera.x - 50 * dt
	end
end

function GameState_Game:draw()
	-- draw background
	love.graphics.setColor(1, 1, 1)

	love.graphics.push()
	love.graphics.translate(math.floor(camera.x + 0.5), math.floor(camera.y + 0.5))

	-- draw map.
	love.graphics.setColor(1, 1, 1)
	map:draw(math.floor(camera.x + 0.5), math.floor(camera.y + 0.5))

	if debug.draw_physics then
		map:box2d_draw()
	end

	-- draw objects.
	love.graphics.setColor(1, 1, 1)
	world:draw()

	if debug.draw_audio then
		SoundManager:draw()
	end

	love.graphics.pop()
end

function GameState_Game:draw_ui()
end
