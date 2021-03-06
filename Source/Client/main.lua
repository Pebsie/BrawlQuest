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
require "modules/joystick"
--connect
require "client"


utf8 = require("utf8")

version = "Beta 0.1"
newChatMsg("SERVER","Welcome to BrawlQuest!",1)
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

dev = false -- this variable turns certain features on and off so that it's easier to dev the game

local joysticks = love.joystick.getJoysticks()
--error(love.joystick.getJoystickCount())
joystick = joysticks[1]


function love.load()

  love.filesystem.setIdentity( "bq" )

  if dev then
    ipadd = "127.0.0.1"
  else
   -- ipadd = "manager.brawlquest.com"
  end

  ipadd =  "178.128.37.14"--"127.0.0.1"  -- override

  netConnect(ipadd, "26655", 0.1)
  love.mouse.setVisible(false)
  if not dev then b, c, h = http.request("http://brawlquest.com/dl/news.txt") end
  if b then
    love.filesystem.write("news.txt", b)
    local i = 1
    for line in love.filesystem.lines("news.txt") do
      news = news..line.."\n"
    end
  else
    news = "UNABLE TO UPDATE NEWS\nAre you connected to the internet?"
  end

  rFont = love.graphics.newFont(18)
  font = love.graphics.newFont("img/fonts/Pixel Digivolve.otf",14)
  sFont = love.graphics.newFont(9)
  bFont = love.graphics.newFont("img/fonts/Pixel Digivolve.otf",26)

  --ui.selected = "username" --used by the login phase

  worldCanvas = love.graphics.newCanvas(32*101,32*101)
  fightCanvas = love.graphics.newCanvas(stdSH,stdSW)
  createLoginCanvas()
  createWeather()

  downloadMobs()
  loadMobs()
  downloadItems()
  loadItems()
  loadMusic()
  bindKeys()
  loadCharacters()
  loadTutorial()
  initJoystick()
--  saveMobList("mobs.txt")

  scaleX = round(love.graphics.getWidth()/(1920/2))
  scaleY = round(love.graphics.getHeight()/(1080/2))
  love.resize(love.graphics.getWidth(),love.graphics.getHeight())
end

function love.draw()
  drawPhase(phase)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(uiImg["cursor"],cx,cy)
  --if pl.state ~= "fight" then --this appeared to cause a strange flickering when on a fight. Bodge fix, UPDATE AFTER ALPHA EVENT!!!
    drawTooltips()
--  end

--[[  if dev == true then
    love.graphics.setFont(bFont)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",0,0,bFont:getWidth("DEV MODE"),bFont:getHeight())
    love.graphics.setColor(200,0,0)
    love.graphics.printf("DEV MODE",0,0,bFont:getWidth("DEV MODE"),"center")
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(sFont)
  end]]
  
--  drawMenu(100,200)
end


function love.update(dt)
  cx, cy = love.mouse.getPosition()
  netUpdate(dt)
  updatePhase(phase,dt)
  updateMusic(dt)
  updateSpells(dt)
  updateFloats(dt)
  updateFog(dt)
  updateTutorial() --triggers for tutorial window

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
      if world[pl.t].tile == "Blacksmithh" then --temporarily disabled for this Alpha
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
              local itemCost = atComma(item[titem].price)
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
      elseif pl.cp > 0 and gameUI[9].isVisible then --saveCharacterster point allocation
        local y = gameUI[9].y
        local x = gameUI[9].x
        local ty = y+64+font:getHeight()*4+sFont:getHeight()+40

        if isMouseOver(x,128,ty,font:getHeight()) then
          netSend("skill",pl.name..",str")
          pl.str = pl.str + 1
        end
        ty = ty + font:getHeight()

        if isMouseOver(x,128,ty,font:getHeight()) then
          netSend("skill",pl.name..",int")
          pl.int = pl.int + 1
        end
        ty = ty + font:getHeight()


        if isMouseOver(x,128,ty,font:getHeight()) then
          netSend("skill",pl.name..",sta")
          pl.sta = pl.sta +1
        end
        ty = ty + font:getHeight()


        if isMouseOver(x,128,ty,font:getHeight()) then
          netSend("skill",pl.name..",agl")
          pl.agl = pl.agl + 1
        end
        ty = ty + font:getHeight()
      elseif world[pl.t].tile == "Anvil" then
        --crafting menu
        if craftingMenu.scrn == "menu" then
          local x = 0 + craftingMenu.x
          local y = 4 + craftingMenu.y
          for i = 1, 5 do
            if isMouseOver(x,32*3,y,sFont:getHeight()) == true then
                if i == 1 then craftingMenu.scrn = "wep"
                elseif i == 2 then craftingMenu.scrn = "Spell"
                elseif i == 3 then craftingMenu.scrn = "head armour"
                elseif i == 4 then craftingMenu.scrn = "chest armour"
                elseif i == 5 then craftingMenu.scrn = "leg armour" end
            end
            y = y + sFont:getHeight()
          end
          y = 4 + craftingMenu.y
        else
          local x = 0
          local y = 0
          for i, v in pairs(atComma(pl.blueprints,";")) do
            if item.type[v] == craftingMenu.scrn then
              if canPlayerCraft(v) then

                if isMouseOver(craftingMenu.x+x,32,craftingMenu.y+y,32) then
                  netSend("craft",pl.name..","..v)
                  --craftingMenu.scrn = "crafting"
                  frequentlyUpdate = true
                end
              end
              x = x + 32
              if x > (32*2) then
                x = 0
                y = y + 32
              end
            end
          end
        end
      --[[elseif gameUI[7].visible == true and isMouseOver(gameUI[7].x,gameUI[7].width,gameUI[7].y,gameUI[7].height) then --buddy panel
        local chy = gameUI[7].y + sFont:getHeight() + 8 --checky
        local chx = gameUI[7].x
        for i, v in pairs(buddy) do
          if playerHasItem(i,1) or pl.buddy == i then
            if isMouseOver(chx,32,chy,32) then
              useItem(i)
            end
            chx = chx + 32
            if chx-gameUI[7].x > 32*4 then
              chx = gameUI[7].x
              chy = chy + 32
            end
          end
        end]]
      end
        if pl.selItem ~= "None" then
          useItem(pl.selItem)
          local i = getInventorySlot(pl.selItem)
          pl.inv[i].amount = pl.inv[i].amount - 1
          if pl.inv[i].amount < 1 then pl.inv[i] = nil end
          love.audio.play(sfx["hit"])
          frequentlyUpdate = true
        end

    end
  end
end

function love.quit()
  if phase == "game" then
    saveFog("fog.txt")
    saveTutorial()
  end
end
