love.graphics.setDefaultFilter("nearest", "nearest", 1) --set rendering scale style

--load data
require "data/items"
require "data/audio"
require "data/world"
require "data/ui"
require "data/mobs"
--load libraries
inspect = require("libraries/inspect")
--load modules
require "modules/music" --this is a data/module hybrid, so it must be first
require "modules/interface"
require "modules/user"
require "modules/game"
require "modules/settings"
--connect
require "client"


utf8 = require("utf8")

version = "Alpha 0.1"
phase = "login"

isMouseDown = false
cox = 0
coy = 0

scale = 1

selT = 0

screenW,screenH = love.graphics.getDimensions()

function love.load()

  --local ipadd = "37.59.126.91"
  local ipadd = "127.0.0.1"
  netConnect(ipadd, "26650", 0.2)

  font = love.graphics.newFont("img/fonts/Pixel Digivolve.otf",14)
  sFont = love.graphics.newFont(9)
  bFont = love.graphics.newFont("img/fonts/Pixel Digivolve.otf",26)

  ui.selected = "username" --used by the login phase

  worldCanvas = love.graphics.newCanvas(32*101,32*101)
  fightCanvas = love.graphics.newCanvas(800,600)
  createLoginCanvas()

  loadMusic()
  bindKeys()
end

function love.draw()
  drawPhase(phase)
end

function love.update(dt)
  netUpdate(dt)
  updatePhase(phase,dt)
  updateMusic(dt)
end

function love.mousepressed(button)
  isMouseDown = true
  cox, coy = love.mouse.getPosition()
end

function love.mousereleased(button, x, y)
  isMouseDown = false

  if phase == "game" then
    if pl.state == "world" then
      useItem(pl.selItem)
    end
  end
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

function round(x)
  if x%2 ~= 0.5 then
    return math.floor(x+0.5)
  end
  return x-0.5
end

function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end
