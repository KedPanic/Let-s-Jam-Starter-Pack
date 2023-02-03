-- rendering settings.
window = { width = 1280, height = 720 }
render_target = { width = 320, height = 180 }

-- debug settings
console_enabled = false

-- Love2D Config
-- See https://love2d.org/wiki/Config_Files
function love.conf(t)
  t.console = console_enabled
  t.window.title = "My Game"
  t.window.icon = "assets/sprites/icon.png"
  t.window.width = window.width
  t.window.height = window.height
end