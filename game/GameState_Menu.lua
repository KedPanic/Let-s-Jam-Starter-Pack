require "conf"
require "GameState_Game"
require "sprites"

GameState_Menu = {}

function GameState_Menu:new()
	local state = {
		maps = {},
		devmaps = {},
		selected_map = 1,
		waiting_to_play = false,
		buttons = {},
		selected_button = 1,
		sprite = sprites.menu
	}
	setmetatable(state, {__index = GameState_Menu})
	return state
end

function GameState_Menu:begin()
	-- find all the maps.
	local files = love.filesystem.getDirectoryItems("assets/maps")
	for k, file in ipairs(files) do
		for i=1, #file do
			if file:sub(i, i) == "." then
				if file:sub(i, i + 4) == ".lua" then
					table.insert(self.devmaps, file)
				end
				break
			end
		end
	end
	table.insert(self.devmaps, "quit")

	-- game map.
	table.insert(self.maps, "demo.lua")
	table.insert(self.buttons, sprites.play)
	table.insert(self.buttons, sprites.quit)

	Music:play(1)
end

function GameState_Menu:finish()
end

function GameState_Menu:keypressed(key)
	if self.waiting_to_play then
		return
	end

	if debug.dev_menu == true then
		if key == "up" then
			play_validate()
			self.selected_map = self.selected_map - 1

			if self.selected_map < 1 then
				self.selected_map = #self.devmaps
			end

		elseif key == "down" then
			play_validate()
			self.selected_map = self.selected_map + 1

			if self.selected_map > #self.devmaps then
				self.selected_map = 1
			end

		elseif key == "return" then
			if self.selected_map == #self.devmaps then
				love.event.quit(0)
			else
				-- music fade out.
				Music:stop(3)
				self.waiting_to_play = true
			end
		end
	else
		if key == "up" then
			play_validate()
			self.selected_button = self.selected_button - 1

			if self.selected_button < 1 then
				self.selected_button = #self.buttons
			end

		elseif key == "down" then
			play_validate()
			self.selected_button = self.selected_button + 1

			if self.selected_button > #self.buttons then
				self.selected_button = 1
			end

		elseif key == "return" then
			if self.selected_button == 1 then
				-- music fade out.
				Music:stop(3)
				self.waiting_to_play = true
			else
				love.event.quit(0)
			end
		end
	end
end

function GameState_Menu:update(dt)
	if self.waiting_to_play then
		if Music:isPlaying() == false then
			if debug.dev_menu == true then
				load_map(self.devmaps[self.selected_map])
			else
				load_map(self.maps[self.selected_button])
			end

			setGameState(GameState_Game:new())
		end
	end

	self.sprite:update(dt)
end

function GameState_Menu:draw_ui()
end

function GameState_Menu:draw()
	love.graphics.push()
	love.graphics.translate(0, 0)

	-- draw map.
	love.graphics.setColor(1, 1, 1)
	self.sprite:draw(0, 0)

	if debug.dev_menu == true then
		local button_height = 20
		local y = render_target.height * 0.5 - (#self.devmaps * 0.5) * button_height
		for i = 1, #self.devmaps do
			local file = self.devmaps[i]
			local x = render_target.width * 0.5 - love.graphics.getFont():getWidth(file) * 0.5

			if i == self.selected_map then
				love.graphics.setColor(0.2, 0.8, 0.2)
			else
				love.graphics.setColor(1, 1, 1)
			end

			love.graphics.print(file, math.floor(x + 0.5), math.floor(y + 0.5))
			y = y + button_height
		end
	else
		local button_space = 10
		local y = render_target.height * 0.5 + 40
		for i = 1, #self.buttons do
			local x = render_target.width * 0.5 - self.buttons[i]:getWidth() * 0.5

			if i == self.selected_button then
				love.graphics.setColor(1, 1, 1)
			else
				love.graphics.setColor(0.5, 0.5, 0.8)
			end

			love.graphics.draw(self.buttons[i], math.floor(x + 0.5), math.floor(y + 0.5))
			y = y + self.buttons[i]:getHeight() + button_space
		end
	end

	if self.waiting_to_play == true then
		love.graphics.setColor(0, 0, 0, 1.0 - Music:getFadeOut())
		love.graphics.rectangle("fill", 0, 0, render_target.width, render_target.height)
	end

	love.graphics.pop()
end
