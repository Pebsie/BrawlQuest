require "modules/submodules/fog"

world = {}
world.weather = "clear"
world.weatherX = 0
world.weatherY = 0
world.weatherA = 0

areaTitleAlpha = 255
curAreaTitle = "The Great Plains"

objectCanvas = love.graphics.newCanvas(32*101,32*101)

function loadOverworld()
  if love.filesystem.getInfo("map.txt") then
    local x = 0
    local y = 0
    for line in love.filesystem.lines("map.txt") do
      word = atComma(line)
      i = #world + 1
      world[i] = {}
      world[i].tile = word[1]
      world[i].fight = word[2]
      world[i].fightc = word[3]
      if word[4] == "true" then world[i].collide = true else world[i].collide = false end
      world[i].name = word[5]
      world[i].bg = word[6]
      world[i].isFight = false
      world[i].players = ""
      world[i].x = x
      world[i].y = y
      world[i].i = i
      x = x + 32
      if x > 100*32 then
        x = 0
        y = y + 32
      end
    end
  else
    love.window.showMessageBox("World doesn't exist!", "We couldn't find the world file. This means one of two things: 1) the Witch has successfully wiped out all of mankind or 2) the client didn't download the world properly. Either way, we need to exit. Report this to @Pebsiee!!", "error")
    love.event.quit()
  end

  createWorldCanvas()
end


--NETWORK RELATED FUNCTIONS
function requestWorldInfo()
  netSend("world", pl.name)
end

-- DRAWING RELATED FUNCTIONS
function drawOverworld()
  love.graphics.push()
  love.graphics.scale(scale, scale)   -- reduce everything by 50% in both X and Y coordinates
--  local x = 0
--  local y = 0

  --love.graphics.setColor(200,200,200)
  --background
----  for i = 1, (sw/32)*((sh/32)+1) do
---    love.graphics.draw(worldImg["Grass"], x, y)
--    love.graphics.draw(worldImg["Mountain"], x, y)
--    x = x + 32
--    if x > sw then x = 0 y = y + 32 end
--  end

  love.graphics.setColor(255,255,255,255)

  for i = 1, sw/64 do
  --  love.graphics.draw(loginImg["cloud"],lclouds.x[i],lclouds.y[i])
  end

  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.draw(worldCanvas, -mx, -my) --draw world
  love.graphics.draw(objectCanvas, -mx, -my)
  drawFog(-mx,-my)
  love.graphics.setBlendMode("alpha")
  if playerExists(pl.name) then
    drawPlayer(pl.name,pl.x-mx,pl.y-my)
  end

  for i = 1, countPlayers() do
    name = getPlayerName(i)
    if name ~= pl.name and fog[tonumber(getPlayer(name,"t"))] and getPlayer(name,"state") ~= "fight" then
      drawPlayer(name,getPlayer(name,"x")-mx,getPlayer(name,"y")-my)
    end
  end

  if not item.val[pl.wep] and not item.val[pl.arm] then
    love.graphics.print("Awaiting character info...")
  end
  --weather
  love.graphics.setColor(255,255,255,world.weatherA)
  love.graphics.draw(weatherImg["snow"],world.weatherX,world.weatherY)
  love.graphics.setColor(255,255,255,255)

    love.graphics.pop()

    for i = 1, 4 do
      drawUIWindow(i)
    end

      local sw,sh = love.graphics.getDimensions()
      if world[pl.t].tile == "Blacksmith" then
        drawShop(sw/2-75,sh/2-125)
      elseif world[pl.t].tile == "Graveyard" and pl.dt ~= pl.t then
        drawGraveyard(sw/2-75,sh/2-(72/2))
      end

  love.graphics.setColor(0,0,0,areaTitleAlpha)
  love.graphics.rectangle("fill",(sw/2)-(bFont:getWidth(world[pl.t].name)+10)/2,5,bFont:getWidth(world[pl.t].name)+10,bFont:getHeight()+10)
  love.graphics.setFont(bFont)
  love.graphics.setColor(255,255,255,areaTitleAlpha)
  love.graphics.printf(world[pl.t].name,0,10,sw,"center")
  love.graphics.setFont(font)
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
      drawFightUI(x,y)
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
        if item.img[inv[i]] then

          --display tooltip
          drawItem(inv[i],inv[i+1],x+tx, y+ty)
          if cx > x+tx and cx < x+tx+32 and cy > y+ty and cy < y+ty+32 then
            pl.selItem = inv[i]
          end
        end

        tx = tx + 36
        if tx > (36*4) then
          tx = 2
          ty = ty + 36
        end
      end
    elseif i == 4 then
      love.graphics.print(gameUI[4].msg,x+1,y)
      --close button
      love.graphics.setColor(100,0,0)
      love.graphics.rectangle("fill",x+gameUI[i].width-16,y-font:getHeight()-2,16,16)
    end

    --border
    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",x, y-font:getHeight()-2, gameUI[i].width, gameUI[i].height)
  end
end

function updateOverworld(dt)
  for i = 1, sw/64 do
    if not lclouds.x[i] or not lclouds.y[i] then
      lclouds.x[i] = love.math.random(1, screenW)
      lclouds.y[i] = love.math.random(1, screenH)
    end

    lclouds.x[i] = lclouds.x[i] + math.random(1,8)*dt
    if lclouds.x[i] > sw then
      lclouds.x[i] = love.math.random(-400,-200)
    end
  end

  areaTitleAlpha = areaTitleAlpha - 25*dt
  if areaTitleAlpha < 0 then areaTitleAlpha = 0 end

  local windSpeed = 512*dt
  world.weatherX = world.weatherX + windSpeed
  world.weatherY = world.weatherY + windSpeed
  if world.weatherY > 0 then --TODO: make this not an arbitrary value
    world.weatherX = -800
    world.weatherY = -800
  end

  if world.weather == "snow" then world.weatherA = world.weatherA + 100*dt end
  if world.weather == "clear" then world.weatherA = world.weatherA - 100*dt end
  if world.weatherA > 255 then world.weatherA = 255 elseif world.weatherA < 0 then world.weatherA = 0 end

  local cx, cy = love.mouse.getPosition()
  local sw,sh = love.graphics.getDimensions()

  for i = 1, #gameUI do
    if isMouseDown then
      if cx > gameUI[i].x+gameUI[i].width-16 and cx < gameUI[i].x+gameUI[i].width and cy > gameUI[i].y and cy < gameUI[i].y + 16 and i == 4 then
        gameUI[i].isVisible = false
      elseif cy < gameUI[i].y+12 and cy > gameUI[i].y and cx > gameUI[i].x and cx < gameUI[i].x+gameUI[i].width then
        gameUI[i].isDrag = true
      end
    else
      gameUI[i].isDrag = false
    end
    if gameUI[i].isDrag == true then
      gameUI[i].x = cx
      gameUI[i].y = cy
    end

    if gameUI[i].x+gameUI[i].width > sw+1 then --avoid leaving boundaries of the window
        gameUI[i].x = sw-gameUI[i].width
    end
    if   gameUI[i].y+gameUI[i].height > sh+1 then
      gameUI[i].y = sh-gameUI[i].height
    end
  end

  updateTT(dt)
end

function createWorldCanvas()
--  wCanvas = love.graphics.newCanvas(32*101,32*101)
 if not worldCanvas then worldCanvas = love.graphics.newCanvas(32*101,32*101) end
  love.graphics.setCanvas(worldCanvas)
  love.graphics.clear()
    --love.graphics.setBlendMode("alpha")

    for i = 1, 100*100 do
      if world[i] and world[i].bg and world[i].tile then
          x = world[i].x
          y = world[i].y
        --  if x-mx > -64 and x-mx < screenW+64 and y-my > -64 and y-my < screenH+64 then
          love.graphics.draw(worldImg[world[i].bg], x, y)
          love.graphics.draw(worldImg[world[i].tile], x, y)
          if world[i].tile == "Blacksmith" then drawPlayer("<NPC> Shop",x,y) end

        else
          love.graphics.print("error")
        end
      end

    love.graphics.setCanvas()

        --  if i == selT then love.graphics.draw(uiImg["target"],x,y) end
      --  love.graphics.setFont(sFont)
      --  love.graphics.print(i, x, y)
      --end

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",0,0,(100*100)*32,(101*101)*32)
    love.graphics.setColor(255,255,255)
    love.graphics.setCanvas()
end

function createWorldObjectCanvas() --for objects in the world
  love.graphics.setCanvas(objectCanvas)
        if world[i].isFight == true then
          love.graphics.draw(uiImg["fight"], x, y)
        end
    love.graphics.setCanvas()
end
