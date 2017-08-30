require "client"
require "modules/interface"
require "modules/user"
require "modules/game"
require "data/items"

utf8 = require("utf8")

version = "Alpha 0.1"
phase = "login"

function love.load()
  local ipadd = "127.0.0.1"
  netConnect(ipadd, "26650", 0.2)
  initItems()

  ui.selected = "username" --used by the login phase
end

function love.draw()
  drawPhase(phase)
end

function love.update(dt)
  netUpdate(dt)
  updatePhase(phase)
end


function atComma(str, md)
  if not md then md = "," end
	local word = {}
	local thisWord = 1
	for wordd in string.gmatch(str, '([^'..md..']+)') do
    	word[thisWord] = wordd
    	thisWord = thisWord + 1
    end

    return word
end
