require "GameState_Game"
require "sprites"

GameState_GameOver = {}

function GameState_GameOver:new()
	local state = {
		actions = {},
		selected_action = 1,
	}
	setmetatable(state, {__index = GameState_GameOver})

	return state
end

function GameState_GameOver:begin()
	self.actions = {}
	table.insert(self.actions, sprites.restart)
	table.insert(self.actions, sprites.quit)
end

function GameState_GameOver:finish()
end

function GameState_GameOver:keypressed(key)
	if key == "up" then
		play_validate()
		self.selected_action = self.selected_action - 1

		if self.selected_action < 1 then
			self.selected_action = #self.actions
		end

	elseif key == "down" then
		play_validate()
		self.selected_action = self.selected_action + 1

		if self.selected_action > #self.actions then
			self.selected_action = 1
		end

	elseif key == "return" then
		if self.selected_action == #self.actions then
			love.event.quit(0)
		else
			load_map(GameState_Menu.maps[GameState_Menu.selected_map])
			setGameState(GameState_Game:new())
		end
	end
end

function GameState_GameOver:update(dt)
	self.sprite:update(dt)
end

function GameState_GameOver:draw()
	love.graphics.push()
	love.graphics.translate(0, 0)

	local button_space = 10
	local y = render_target.height * 0.5 - self.actions[1]:getHeight() - 5
	for i=1, #self.actions do
		local x = render_target.width * 0.5 - self.actions[i]:getWidth() * 0.5

		if i == self.selected_action then
			love.graphics.setColor(1, 1, 1)
		else
			love.graphics.setColor(0.5, 0.5, 0.8)
		end

		love.graphics.draw(self.actions[i], math.floor(x + 0.5), math.floor(y + 0.5))
		y = y + self.actions[i]:getHeight() + button_space
	end

	love.graphics.pop()
end

function GameState_GameOver:draw_ui()
end
