require "sprites"

GameState_Credits = {}

function GameState_Credits:new()
	local state = {
		sprite = sprites.credits
	}
	setmetatable(state, {__index = GameState_Credits})
	
	return state
end

function GameState_Credits:begin()
end

function GameState_Credits:finish()
end

function GameState_Credits:keypressed(key)
	love.event.quit(0)
end

function GameState_Credits:update(dt)
	self.sprite:update(dt)
end

function GameState_Credits:draw()
	love.graphics.push()
	love.graphics.translate(0, 0)

	love.graphics.setColor(1, 1, 1)
	self.sprite:draw(0, 0)

	love.graphics.pop()
end

function GameState_Credits:draw_ui()
end
