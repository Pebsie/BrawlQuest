love.graphics.setDefaultFilter("nearest", "nearest", 1) --set rendering scale style

--load data
require "data/items"
require "data/audio"
require "data/world"
require "data/ui"
require "data/mobs"
require "data/spells"
--load libraries
inspect = require("libraries/inspect")
require "libraries/tools"
--load modules
require "modules/music" --this is a data/module hybrid, so it must be first
require "modules/interface"
require "modules/user"
require "modules/game"
require "modules/settings"
--connect
require "client"


utf8 = require("utf8")

version = "Shipwrecked v1.0"
newChatMsg("SERVER","Welcome to BrawlQuest: Shipwrecked",1)
phase = "splash"

isMouseDown = false
cox = 0
coy = 0

scale = 1

cx, cy = love.mouse.getPosition()

selT = 0

stdSH = 1920/2
stdSW = 1080/2

screenW,screenH = love.graphics.getDimensions()

realScreenWidth = screenW
realScreenHeight = screenH

news = ""

dev = true--This variable just turns certain features on and off so that it's easier to dev the game

function love.load()

  love.filesystem.setIdentity( "bq" )

  local ipadd = "127.0.0.1"
  --local ipadd = "eu.brawlquest.com"
  netConnect(ipadd, "26657", 0.1)
  love.mouse.setVisible(false)
  b, c, h = http.request("http://brawlquest.com/dl/news-4.txt")
  love.filesystem.write("news.txt", b)
  local i = 1
  for line in love.filesystem.lines("news.txt") do
    news = news..line.."\n"
  end

  font = love.graphics.newFont("img/fonts/Pixel Digivolve.otf",14)
  sFont = love.graphics.newFont(9)
  bFont = love.graphics.newFont("img/fonts/Pixel Digivolve.otf",26)

  --ui.selected = "username" --used by the login phase

  worldCanvas = love.graphics.newCanvas(32*101,32*101)
  fightCanvas = love.graphics.newCanvas(stdSH,stdSW)
  createLoginCanvas()

  loadMusic()
  bindKeys()
  loadCharacters()
end

function love.draw()
  drawPhase(phase)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(uiImg["cursor"],cx,cy)
  if pl.state ~= "fight" then --this appeared to cause a strange flickering when on a fight. Bodge fix, UPDATE AFTER ALPHA EVENT!!!
    drawTooltips()
  end

  if dev == true then
    love.graphics.setFont(bFont)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",0,0,bFont:getWidth("DEV MODE"),bFont:getHeight())
    love.graphics.setColor(200,0,0)
    love.graphics.printf("DEV MODE",0,0,bFont:getWidth("DEV MODE"),"center")
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(sFont)
  end
end


function love.update(dt)
  cx, cy = love.mouse.getPosition()
  netUpdate(dt)
  updatePhase(phase,dt)
  updateMusic(dt)
  updateSpells(dt)
  updateFloats(dt)
  updateFog(dt)
end

function love.mousepressed(button)
  isMouseDown = true
  cox, coy = love.mouse.getPosition()
end

function love.mousereleased(button, cx, cy)
  isMouseDown = false
  cx, cy = love.mouse.getPosition()
  if phase == "game" then
    if pl.state == "world" then
      if world[pl.t].tile == "Blacksmith" then
        cy = cy - 32
        local sw,sh = love.graphics.getDimensions()
        x = sw/2-75
        y = sh/2-125
          x = x + 2
        for k = 1, 4 do
          if k == 1 then titype = "Armour"
          elseif k == 2 then titype = "Weapons"
          elseif k == 3 then titype = "Spells"
          elseif k == 4 then titype = "Misc" end
          for i = 1, #shop[titype] do
        --    love.window.showMessageBox("debug",shop[titype][i].." at "..x.." ("..(x+32).."),"..y.." ("..(y+32).."), cursor at "..cx..","..cy)
            if cx > x and cx < x+32 and cy > y and cy < y+32 then
              titem = shop[titype][i]
              local itemCost = atComma(item.price[titem])
              if playerHasItem(itemCost[2],itemCost[1]-1) then
                  netSend("buy",pl.name..","..shop[titype][i])
                  frequentlyUpdate = true
                  love.audio.play(sfx["hit"])
              else
                gameUI[4].isVisible = true
                gameUI[4].msg = "You don't have enough "..itemCost[2].."!"
              end
            end

            x = x + 34
          end
          x = (sw/2-75)+2
          y = y + 34 + font:getHeight()
        end
      elseif world[pl.t].tile == "Graveyard" then
        netSend("pray",pl.name)
        frequentlyUpdate = true
        love.audio.play(sfx["hit"])
      end
        if pl.selItem ~= "None" then
          useItem(pl.selItem)

          love.audio.play(sfx["hit"])
          frequentlyUpdate = true
        end

    end
  end
end

function love.quit()
  if phase == "game" then
    saveFog("fog.txt")
  end
end
