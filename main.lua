require "client"
require "modules/interface"
require "modules/user"
utf8 = require("utf8")

version = "Alpha 0.1"
phase = "login"

function love.load()
  local ipadd = "127.0.0.1"
  netConnect(ipadd, "26650", 0.2)

  ui.selected = "username" --used by the login phase
end

function love.draw()
  drawPhase(phase)
end

function love.update(dt)
  netUpdate(dt)
  updatePhase(phase)
end
