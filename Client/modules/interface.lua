require "modules/ui/login"
require "modules/submodules/tooltip"
require "modules/ui/master"
require "modules/ui/chat"
require "modules/ui/floats"
require "modules/ui/crafting"
require "modules/ui/menu"
require "modules/ui/character"
require "modules/ui/tutorial"

--ui variables, use as you wish
ui = {}
ui.selected = 0 --default username
ui.window = {}
ui.window.x = 0
ui.window.y = 0
ui.window.content = "up"

sw,sh = love.graphics.getDimensions()

newScale = 1

function drawPhase(phase)
  if phase == "splash" then
    if ui.window.content == "down" then
      drawLogin()
    end
    love.graphics.setColor(0,0,0,ui.selected)
    love.graphics.rectangle("fill",0,0,sw,sh)
    love.graphics.setColor(255,255,255,ui.selected)
  --  love.graphics.print("PEB.SI",sw/2-(bFont:getWidth("PEB.SI")/2),sh/4)
    love.graphics.rectangle("fill",round(sw/2-(uiImg["freshplay"]:getWidth()/2)),sh/2-200,uiImg["freshplay"]:getWidth(),uiImg["freshplay"]:getHeight())
    love.graphics.draw(uiImg["freshplay"],sw/2-(uiImg["freshplay"]:getWidth()/2),sh/2-200)
    love.graphics.draw(uiImg["enhost"],sw/2-(uiImg["enhost"]:getWidth()/2),sh/2)
    love.graphics.setFont(font)
    love.graphics.printf("POWERED BY",sw/2-(uiImg["enhost"]:getWidth()/2),sh/2,uiImg["enhost"]:getWidth(),"right")
  elseif phase == "login" then
    drawLogin()
  elseif phase == "game" then
    drawGame()
    drawUI()
  else
    love.graphics.print("ERROR: Unknown phase '"..phase.."'. Please report this error message.")
  end
end

function updatePhase(phase, dt)
  if phase == "splash" then
    if ui.window.content == "up" then
      ui.selected = ui.selected + 300*dt
      if ui.selected > 600 then ui.window.content = "down" end
    elseif ui.window.content == "down" then
      ui.selected = ui.selected - 400*dt
      if ui.selected < 1 then
        love.keypressed()
      end
    end
    updateLogin(dt)
  elseif phase == "login" then
    updateLogin(dt)
  elseif phase == "game" then
    updateGame(dt)
    updateUI(dt)

    if newScale ~= scale then
      if newScale > scale+0.01 then scale = scale + 1*dt love.resize(love.graphics.getWidth(),love.graphics.getHeight())
      elseif newScale < scale-0.01 then scale = scale - 1*dt love.resize(love.graphics.getWidth(),love.graphics.getHeight())
      elseif newScale ~= scale then scale = newScale love.resize(love.graphics.getWidth(),love.graphics.getHeight())
      else  newScale = scale love.resize(love.graphics.getWidth(),love.graphics.getHeight()) end
    end
  end
end

function love.textinput(t)
  if t ~= "," then --as this is used for server commands
    pl.cinput = pl.cinput..t
  end

  if phase == "login" then
    if ui.selected == "username" then
      pl.name = pl.cinput
    elseif ui.selected == "password" then
      --pl.cinput = pl.cinput..t
    end
  end

end

function love.keypressed(key)
  if key == "backspace" then
       -- get the byte offset to the last UTF-8 character in the string.
       local byteoffset = utf8.offset(pl.cinput, -1)

       if byteoffset then
           -- remove the last UTF-8 character.
           -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
           pl.cinput = string.sub(pl.cinput, 1, byteoffset - 1)
       end
  elseif key == "return" then
      if phase == "login" and loginI.status == "create" then
        if ui.selected == "username" then pl.cinput = "" ui.selected = "password"
        elseif ui.selected == "password" then addLoginCharacter() end--login() end
      elseif phase == "read" then
        phase = "game"
      elseif phase == "game" then
        if ui.selected == "chat" then ui.selected = 0 love.keyboard.setTextInput(false) sendChat(pl.cinput) else pl.cinput = "" ui.selected = "chat" love.keyboard.setTextInput(true) end
      end
  elseif key == "u" then
    if phase == "game" and ui.selected ~= "chat" then
      requestUserInfo()
      requestWorldInfo()
    end
  elseif key == "z" and ui.selected ~= "chat" then
    newScale = newScale + 1
    love.resize(love.graphics.getWidth(),love.graphics.getHeight())
  elseif key == "x" and ui.selected ~= "chat" then
    newScale = newScale - 1
    if newScale < 0.25 then newScale = 1 end
    love.resize(love.graphics.getWidth(),love.graphics.getHeight())
  elseif key == "left" then
    if phase == "login" then
      biome = 1
    end
  elseif key == "r" and ui.selected ~= "chat" then
    if phase == "game" or phase == "fight" then
      netSend("potion", pl.name)
    end
  elseif key == "q" and ui.selected ~= "chat" then
    if phase == "game" then
      vals = atComma(item.val[pl.s1])
      if pl.s1 ~= "None" and pl.s1t < 0 and pl.en+1 > tonumber(vals[2]) then --HEY, changing this won't alter when you can and can't use spells, it'll only mess up the UI, so, stop.
        netSend("spell1", pl.name)
        pl.en = pl.en - tonumber(vals[2])
        pl.s1t = vals[1]
        pl.spell = pl.s1
      end
    end
  elseif key == "e" and ui.selected ~= "chat" then
    if phase == "game" then
      vals = atComma(item.val[pl.s2])
      if pl.s1 ~= "None" and pl.s2t < 0 and pl.en+1 > tonumber(vals[2]) then
        netSend("spell2", pl.name)
        pl.en = pl.en - tonumber(vals[2])
        pl.s2t = vals[1]
        pl.spell = pl.s2
      end
    end
  elseif key == "escape" then
  --[[  fullscreen, fstype = love.window.getFullscreen( )
    if fullscreen == true then
      love.window.setFullscreen(false)
    else
      love.window.setFullscreen(true,"desktop")
    end]]
    if love.window.highdpi == true then
      love.window.highdpi = false
    else
      love.window.highdpi = true
    end
--  elseif key == "c" then
  --  if gameUI[6].visible == true then gameUI[6].visible = false else gameUI[6].visible = true end
  end

   if phase == "splash" then
     phase = "login"
     ui.selected = "username"
   end
end


function drawGraveyard(tx,ty)
  x = tx
  y = ty
  love.graphics.setColor(50,50,50)
  love.graphics.rectangle("fill", x, y, 140+32, 72)
  love.graphics.setFont(font)
  love.graphics.setColor(255,255,255)
  love.graphics.printf("Graveyard",x,y,140+32,"center")
  y = y + font:getHeight()+6
  love.graphics.setFont(sFont)
  love.graphics.printf("Praying here will set this Graveyard to be your respawn point.",x,y,140+32,"center")
  y = y + 36
  love.graphics.setFont(font)
  if cx > x and cx < x+140+32 and cy > y-1 and cy < y+font:getHeight() then
    love.graphics.setColor(100,100,100)
  else
    love.graphics.setColor(0,0,0)
  end
  love.graphics.rectangle("fill",x,y,140+32,font:getHeight())
  love.graphics.setColor(255,255,255)
  love.graphics.printf("Pray",x,y,140+32,"center")

  --border
  love.graphics.setColor(150,150,150)
  love.graphics.rectangle("line",tx,ty, 140+32, 72)
end

function drawShop(tx,ty)
  x = tx
  y = ty
  love.graphics.setColor(50,50,50)
  love.graphics.rectangle("fill", x, y, 140+32, 240)
  love.graphics.setFont(font)
  love.graphics.setColor(255,255,255)
  love.graphics.printf("Shop",x,y,140+32,"center")
  y = y + font:getHeight()+2
  love.graphics.setFont(font)

  x = x + 2

  for k = 1, 4 do

    if k == 1 then titype = "Armour"
    elseif k == 2 then titype = "Weapons"
    elseif k == 3 then titype = "Spells"
    elseif k == 4 then titype = "Misc" end
    love.graphics.print(titype,x,y)
    y = y + font:getHeight()
    for i = 1, #shop[titype] do
      drawItem(shop[titype][i],-1,x,y)
      x = x + 34
    end
    x = tx+2
    y = y + 34

  end


  --border
  love.graphics.setColor(150,150,150)
  love.graphics.rectangle("line",tx,ty, 140+32, 240)
end

--UI elements
function drawUIWindow(i)


  if gameUI[i].isVisible == true then
    local x = gameUI[i].x
    local y = gameUI[i].y

    if i == 4 then
      local wid = font:getWidth(gameUI[i].msg)+32
      if wid < 128 then
        wid = 128
      end
      width, wrappedText = font:getWrap(gameUI[i].msg,wid)
      gameUI[i].width = wid
      gameUI[i].height = font:getHeight()*(#wrappedText+2)
    end

    love.graphics.setColor(50,50,50)
    love.graphics.rectangle("fill", x, y, gameUI[i].width, gameUI[i].height)
    love.graphics.setFont(font)
    love.graphics.setColor(255,255,255)
    love.graphics.printf(gameUI[i].label,x,y,gameUI[i].width,"center")
    y = y + font:getHeight()+2
    love.graphics.setFont(font)
    if i == 1 then
      drawActionBar(x,y)
    elseif i == 2 then

      love.graphics.setColor(255,255,255)
      love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()).."\nCam: "..mx..", "..my.."\nST: "..selT, x, y)

    elseif i == 3 then

      local inv = atComma(pl.inv,";")

      pl.selItem = "None"
      local tx = 4
      local ty = 4
      love.graphics.setFont(sFont)
      for i = 1, #inv, 2 do
        love.graphics.setColor(255,255,255)
        if item.img[inv[i]] and item.type[inv[i]] ~= "buddy" then

          --display tooltip
          drawItem(inv[i],inv[i+1],x+tx, y+ty)
          if cx > x+tx and cx < x+tx+32 and cy > y+ty and cy < y+ty+32 then
            pl.selItem = inv[i]
          end

          tx = tx + 36
          if tx > (36*4) then
            tx = 2
            ty = ty + 36
          end
        end
      end
    elseif i == 4 then
      love.graphics.print(gameUI[4].msg,x+1,y)
      --close button
      love.graphics.setColor(100,0,0)
      love.graphics.rectangle("fill",x+gameUI[i].width-16,y-font:getHeight()-2,16,16)

    elseif i == 5 then
      local tx = 0
      local ty = 0
      for i = 1, 100*100 do
        setWColour(i)
        love.graphics.rectangle("fill",x+tx,y+ty,1,1)
        tx = tx + 1
        if tx > 100 then
          ty = ty + 1
          tx = 0
        end
      end

      love.graphics.setColor(255,255,255)
      love.graphics.line(15+x+(mx)/32,y,15+x+(mx)/32,y+100) --xpos crossover
      love.graphics.line(x,9+y+(my)/32,x+100,9+y+(my)/32)

      if uiImg["weather-"..weather.condition] then
        love.graphics.draw(uiImg["weather-"..weather.condition],x,y+100)
      end
      if weather.time > 21 or weather.time < 4 then love.graphics.draw(uiImg["time-night"],x,y+110)
      elseif weather.time > 3 and weather.time < 9 then love.graphics.draw(uiImg["time-sunset"],x,y+110)
      elseif weather.time > 8 and weather.time < 16 then love.graphics.draw(uiImg["time-day"],x,y+110)
      elseif weather.time > 15 and weather.time < 19 then love.graphics.draw(uiImg["time-sunset"],x,y+110)
      elseif weather.time > 18 and weather.time < 22 then love.graphics.draw(uiImg["time-moonrise"],x,y+110) end
      love.graphics.setFont(sFont)
      love.graphics.print(weather.condition.." ("..weather.temperature.." C)\nHour: "..weather.time,x+10,y+98)
    elseif i == 6 then
      drawCraftingMenu(gameUI[i].x,gameUI[i].y+font:getHeight())
    elseif i == 7 then
      drawBuddyWindow(gameUI[i].x,gameUI[i].y+font:getHeight())
    elseif i == 8 then
      love.graphics.setFont(sFont)
      love.graphics.printf(tutorialContent,gameUI[i].x,gameUI[i].y+font:getHeight(),gameUI[i].width,"left")
    end

    --close button
    if gameUI[i].closeButton then
      if isMouseOver(gameUI[i].x+gameUI[i].width-16,16,gameUI[i].y,16) then
        love.graphics.setColor(255,0,0)
        if isMouseDown then
          gameUI[i].isVisible = false
        end
      else
        love.graphics.setColor(100,0,0)
      end

      love.graphics.rectangle("fill",gameUI[i].x+gameUI[i].width-16,gameUI[i].y,16,16)
    end
    --border
    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",x, y-font:getHeight()-2, gameUI[i].width, gameUI[i].height)
  end
end

function love.resize(w,h) --reset sw and sh
  sw = w/scale
  sh = h/scale
  screenW = sw
  screenH = sh
  realScreenWidth = w
  realScreenHeight = h
--  stdSH = love.graphics.getWidth()/(1920/2)
  --stdSW = love.graphics.getHeight()/(1080/2)

  if phase == "login" or phase == "read" then
    createLoginCanvas()
  elseif phase == "game" then
  --  createWorldCanvas()
    createWeather()
  end
end

function centerCamera()
   --my = round((pl.t/101)-((sh/32)/2))*32 mx = round(tonumber(string.sub(tostring(pl.t/101),3))*3200)-((sw/32)/2)*32
   mx = round(pl.x - 1920/4)
   my = round(pl.y - 1080/4)

  -- if playerExists(pl.name) then
--     mx = round(getPlayer(pl.name, "x") - sw/2)
  --   my = round(getPlayer(pl.name, "y") - sh/2)
--   end
end
