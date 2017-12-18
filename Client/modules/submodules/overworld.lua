require "modules/submodules/fog"

world = {}
world.weather = "snow"
world.weatherX = 0
world.weatherY = 0

areaTitleAlpha = 255
curAreaTitle = "The Great Plains"

function loadOverworld()
  if love.filesystem.exists("map.txt") then
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
      world[i].i = i --I don't like this, but I couldn't do A* pathfinding myself so this is it :'(
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
    love.graphics.draw(loginImg["cloud"],lclouds.x[i],lclouds.y[i])
  end

  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.draw(worldCanvas, -mx, -my) --draw world
  love.graphics.setBlendMode("alpha")
  if playerExists(pl.name) then
    drawPlayer(pl.name,pl.x-mx,pl.y-my)
  end

  for i = 1, countPlayers() do
    name = getPlayerName(i)
    if name ~= pl.name then
      drawPlayer(name,getPlayer(name,"x")-mx,getPlayer(name,"y")-my)
    end
  end

  if not item.val[pl.wep] and not item.val[pl.arm] then
    love.graphics.print("Awaiting character info...")
  end

  love.graphics.draw(weatherImg[world.weather],world.weatherX,world.weatherY)

    love.graphics.pop()

    for i = 1, 4 do
      drawUIWindow(i)
    end

      local sw,sh = love.graphics.getDimensions()
      if pl.t == 3352 then
        drawShop(sw/2-75,sh/2-125)
      elseif world[pl.t].tile == "Graveyard" then
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
    elseif k == 4 then titype = "Potions" end
    love.graphics.print(titype,x,y)
    y = y + font:getHeight()
    for i = 1, #shop[titype] do

      love.graphics.draw(item.img[shop[titype][i]],x,y)
      if cx > x and cx < x+32 and cy > y and cy < y+32 then
        --get phonetic item type name
        local pit = "unknown"
        local cit = item.type[shop[titype][i]]
        local piv = "None"
        local civ = item.val[shop[titype][i]]
        if cit == "wep" then pit = "Weapon" piv = "Deals up to "..civ.." damage."
        elseif cit == "arm" then pit = titype piv = "Defends for "..civ.." damage."
        elseif cit == "hp" then pit = "Health Potion" piv = "Recovers "..civ.." health over 3 seconds."
        elseif cit == "en" then pit = "Energy Potion" piv = "Instantly recovers "..civ.." energy."
        elseif cit == "Craftable" then pit = "Craftable" piv = "Can be used in crafting."
        elseif cit == "Spell" then
          pit = "Spell"
          piv = '"'..item.desc[shop[titype][i]]..'."'
          local stats = atComma(item.val[shop[titype][i]])
          piv = piv.."\n"..stats[1].." second cooldown.\nRequires "..stats[2].." energy."
        elseif cit == "Letter" then
          pit = "Letter" piv = "A letter. Want to read it?"
        end
        addTT(shop[titype][i],"Level "..item.lvl[shop[titype][i]].." "..pit..".\n"..piv.."\nCosts "..item.price[shop[titype][i]].." gold.",cx,cy)
      end

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
          if cx > x+tx and cx < x+tx+32 and cy > y+ty and cy < y+ty+32 then
            --get phonetic item type name
            local pit = "unknown"
            local cit = item.type[inv[i]]
            local piv = "None"
            local civ = item.val[inv[i]]
            if cit == "wep" then pit = "Weapon" piv = "Deals up to "..civ.." damage."
            elseif cit == "arm" then pit = "Armour" piv = "Defends for "..civ.." damage."
            elseif cit == "hp" then pit = "Health Potion" piv = "Recovers "..civ.." health over 3 seconds."
            elseif cit == "en" then pit = "Energy Potion" piv = "Instantly recovers "..civ.." energy."
            elseif cit == "Craftable" then pit = "Craftable" piv = "Can be used in crafting."
            elseif cit == "Key" then pit = "Key" piv = "Opens doors."
            elseif cit == "buddy" then pit = "Buddy" piv = "Your new best friend. "..item.desc[inv[i]]
            elseif cit == "Spell" then
              pit = "Spell"
              piv = '"'..item.desc[inv[i]]..'."'
              local stats = atComma(item.val[inv[i]])
              piv = piv.."\n"..stats[1].." second cooldown.\nRequires "..stats[2].." energy."
            elseif cit == "Letter" then
              pit = "Letter" piv = "A letter. Want to read it?"
            end


            addTT(inv[i],"Level "..item.lvl[inv[i]].." "..pit..".\n"..piv.."\nWorth "..item.price[inv[i]].." gold.",cx,cy)
            pl.selItem = inv[i]
            love.graphics.setColor(150,150,150)
          else
            love.graphics.setColor(0,0,0)
          end
          love.graphics.rectangle("fill",x+tx,y+ty,32,32)
          love.graphics.setColor(255,255,255)
          love.graphics.draw(item.img[inv[i]],x+tx,y+ty)
        else
          love.graphics.draw(uiImg["error"],x+tx,y+ty)
        end
        love.graphics.print("x"..inv[i+1],x+tx+20,y+ty+20)

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
--if not worldCanvas then worldCanvas = love.graphics.newCanvas(32*101,32*101) end
  love.graphics.setCanvas(worldCanvas)
    love.graphics.clear()
    --love.graphics.setBlendMode("alpha")

    for i = 1, 100*100 do
        if not checkFog(i) then love.graphics.setColor(210,210,210) else love.graphics.setColor(255,255,255) end

        x = world[i].x
        y = world[i].y
        if x-mx > -64 and x-mx < screenW+64 and y-my > -64 and y-my < screenH+64 then
          love.graphics.draw(worldImg[world[i].bg], x, y)
          if checkFog(i) or fog.ignore[world[i].tile] == true then
            love.graphics.draw(worldImg[world[i].tile], x, y)
            if checkFog(i) == false then
              love.graphics.setColor(255,255,255,50)
              love.graphics.draw(worldImg["Cloud"], x, y)
              love.graphics.setColor(255,255,255,255)
            else
              if world[i].isFight == true then
                love.graphics.draw(uiImg["fight"], x, y)
              end
              if world[i].fightc == "100" then
                love.graphics.draw(mb.img["Sorcerer"],x,y)
              else
              --  love.graphics.print(world[i].fightc,x,y)
              end
              if tonumber(pl.dt) == i then
                love.graphics.draw(worldImg["DT"],x,y)
              end
            end
          else
            love.graphics.setColor(255,255,255,50)
            love.graphics.draw(worldImg["Cloud"], x, y)
            love.graphics.setColor(255,255,255,255)
          end

          for k = 1,countPlayers() do --THIS IS BAD, OPTIMISE THIS WHEN YOU AREN'T ILL
            local name = getPlayerName(k)
            if getPlayer(name,"t") == i and getPlayer(name,"state") == "world" then
              player[name].tx = x
              player[name].ty = y
            end
          end
        --  if i == selT then love.graphics.draw(uiImg["target"],x,y) end
      --  love.graphics.setFont(sFont)
      --  love.graphics.print(i, x, y)
      end
    end

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",0,0,(100*100)*32,(100*100)*32)
    love.graphics.setColor(255,255,255)
    love.graphics.setCanvas()
end
