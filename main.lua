require "client"
--load data
require "data/audio"
require "data/items"
require "data/world"
require "data/ui"
--load modules
require "modules/interface"
require "modules/user"
require "modules/game"

utf8 = require("utf8")

version = "Alpha 0.1"
phase = "login"

function love.load()
  local ipadd = "127.0.0.1"
  netConnect(ipadd, "26650", 0.2)

  ui.selected = "username" --used by the login phase
  music["title"]:play() --also used by the login phase
end

function love.draw()
  drawPhase(phase)
end

function love.update(dt)
  netUpdate(dt)
  updatePhase(phase,dt)
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
