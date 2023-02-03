require "conf"
--[[
Helper class to draw print message on screen.
]]
Print = {}
local instance = nil

function Print:get()
  if instance == nil then
    instance = {
      messages = {},
      cooldown = 5,
      fadeout_start = 2,
    }
    setmetatable(instance, {__index = Print})
  end
  
  return instance
end
  
  
function prt(msg)
  local self = Print:get()
  self.messages[#self.messages + 1] =
  {
    text = msg,
    timer = self.cooldown
  }
end
  
function Print:update(dt)
  local self = Print:get()
  for i=1, #self.messages do
    self.messages[i].timer = self.messages[i].timer - dt
    if self.messages[i].timer <= 0 then
      table.remove(self.messages, i)
      break
    end
  end
end

function Print:draw()
  local self = Print:get()
  
  if #self.messages > 0 then
    local windowHeight = #self.messages * 15 + 10
    
    local _, height = love.window.getMode()
    
    love.graphics.setColor(0.25, 0.25, 0.25, 0.8)
    love.graphics.rectangle("fill", 5, height - 5 - windowHeight, 200, windowHeight)
  
    for i=#self.messages, 1, -1 do
      if (self.cooldown - self.messages[i].timer) < self.fadeout_start then
        love.graphics.setColor(1, 1, 1, 1)
      else
        love.graphics.setColor(1, 1, 1, self.messages[i].timer / (self.cooldown - self.fadeout_start))
      end

      love.graphics.print(self.messages[i].text, 10, height - 10 - i * 15)
    end
  end
end

if console_enabled == false then
  print = prt
end