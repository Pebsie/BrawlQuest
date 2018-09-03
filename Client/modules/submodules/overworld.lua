require "modules/submodules/fog"

weather = {}
weather.time = 9
weather.condition = "clear"
weather.temperature = 11
weather.day = 1
weather.weatherX = 0
weather.weatherY = 0
weather.weatherA = 0

loadedZone = "Swordbreak"

areaTitleAlpha = 255
curAreaTitle = "The Great Plains"
whiteOut = 255
titleScreen = 1200

objectCanvas = love.graphics.newCanvas(32*101,32*101)

function loadOverworld()
  b, c, h = http.request("http://brawlquest.com/dl/"..zone[pl.zone])

  world = {}
  if b then
    love.filesystem.write(zone[pl.zone], b)
  else
    print("WARNING: unable to download map!")
  end

  if love.filesystem.getInfo(zone[pl.zone]) then
    local x = 0
    local y = 0
    for line in love.filesystem.lines(zone[pl.zone]) do
      word = atComma(line)
      i = #world + 1
      world[i] = {}
      world[i].tile = word[1]
      world[i].fight = word[2]
      local fightData = atComma(word[2])
      world[i].fight = fightData[1]
      world[i].fightc = word[3]
      if word[4] == "true" then world[i].collide = true else world[i].collide = false end
      world[i].name = word[5]
      world[i].bg = word[6]
      world[i].music = word[7]
      world[i].isFight = false
      world[i].players = ""
      world[i].x = x
      world[i].y = y
      world[i].i = i
      world[i].spawned = "unknown"
      if word[8] == "true" then world[i].rest = true else world[i].rest = false end
      x = x + 32
      if x > 100*32 then
        x = 0
        y = y + 32
      end
    end
  else
    error("We couldn't find the world file. This means one of two things: 1) the Witch has successfully wiped out all of mankind or 2) the client didn't download the world properly. Either way, we need to exit. Report this to @Pebsiee!!")
  end
  if loadedZone == pl.zone then
    titleScreen = 1200
  else
    loadedZone = pl.zone
  end
  createWorldCanvas()

  --create lightmap
  createLightmap()
  updateLightmap()
  --[[for i = 1, 100*100 do
    lightmap[i] = 0
    if lightsource[world[i].tile] then lightmap[i] = lightsource[world[i].tile]
    else
      for k = -5, 5 do --5 as max lightsource value is 5
        if lightmap[i+k] and k ~= i then
          if lightmap[i+k] > lightmap[i] then
            lightmap[i] = lightmap[i+k] - math.abs(k)
            if lightmap[i] < 0 then lightmap[i] = 0 end
          end
        end
      end
]]
end


--NETWORK RELATED FUNCTIONS
function requestWorldInfo()
  netSend("world", pl.name)
end

function requestPlayersInfo()
  netSend("players", pl.name)
end

-- DRAWING RELATED FUNCTIONS
function drawOverworld()
  love.graphics.push()
  love.graphics.scale(scaleX,scaleY)

  love.graphics.setColor(255,255,255,255)

  for i = 1, sw/64 do
  --  love.graphics.draw(loginImg["cloud"],lclouds.x[i],lclouds.y[i])
  end

  --love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.draw(worldCanvas, round(-mx), round(-my)) --draw world
  --love.graphics.draw(objectCanvas, round(-mx), round(-my))
  love.graphics.setBlendMode("alpha")
  if playerExists(pl.name) then
    drawPlayer(pl.name,pl.x-mx,pl.y-my,"buddy")
    drawNamePlate(pl.name,pl.x-mx,pl.y-my)
  end

  for i = 1, countPlayers() do
    name = getPlayerName(i)
    if name ~= pl.name and fog[tonumber(getPlayer(name,"t"))] and getPlayer(name,"state") ~= "fight" then
      drawPlayer(name,getPlayer(name,"x")-mx,getPlayer(name,"y")-my,"buddy")
    end
  end

  drawFog(-mx,-my)

  for i = 1, countPlayers() do --we want nameplates to show above player sprites
    name = getPlayerName(i)
    if name ~= pl.name and fog[tonumber(getPlayer(name,"t"))] and getPlayer(name,"state") ~= "fight" then
      drawNamePlate(name,getPlayer(name,"x")-mx,getPlayer(name,"y")-my)
    end
  end

  if not item.val[pl.wep] and not item.val[pl.arm] then
    love.graphics.print("Awaiting character info...")
  end
  --weather
  love.graphics.setColor(255,255,255,weather.weatherA)
  love.graphics.draw(rain,world.weatherX,world.weatherY)
  love.graphics.setColor(255,255,255,255)
    drawFloats()
    love.graphics.pop()

    for i = 1, #gameUI do
      drawUIWindow(i)
    end

      local sw,sh = love.graphics.getDimensions()
      if world[pl.t].tile == "Blacksmith" then
      --  drawShop(sw/2-75,sh/2-125)
      elseif world[pl.t].tile == "Graveyard" and pl.dt ~= pl.t then
        drawGraveyard(sw/2-75,sh/2-(72/2))
      end

  if titleScreen < 0 then
    love.graphics.setColor(0,0,0,areaTitleAlpha)
    love.graphics.rectangle("fill",(sw/2)-(bFont:getWidth(world[pl.t].name)+10)/2,5,bFont:getWidth(world[pl.t].name)+10,bFont:getHeight()+10)
    love.graphics.setFont(bFont)
    love.graphics.setColor(255,255,255,areaTitleAlpha)
    love.graphics.printf(world[pl.t].name,0,10,sw,"center")
    love.graphics.setFont(font)
  else
    areaTitleAlpha = 0
  end

  drawMenu(love.graphics.getWidth()-gameUI[5].width-(64*4),0)

  love.graphics.setColor(255,255,255,whiteOut)
  love.graphics.rectangle("fill",0,0,sw,sh)

  love.graphics.setColor(0,0,0,titleScreen)
  love.graphics.rectangle("fill",0,0,sw,sh)
  love.graphics.setColor(255,255,255,titleScreen)
  love.graphics.setFont(bFont)
  love.graphics.printf(world[pl.t].name,0,sh/2-200,sw,"center")
  love.graphics.setFont(font)
  love.graphics.printf("Day "..weather.day.." of the year 302\n\nThe hour is "..weather.time.."\nThe weather is "..weather.condition.." and the temperature is "..weather.temperature.."C",0,sh/2,sw,"center")
  if dev then love.graphics.printf("DEV MODE",0,sh/2+200,sw,"center") end
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
  weather.weatherX = weather.weatherX + windSpeed
  weather.weatherY = weather.weatherY + windSpeed
  if weather.weatherY > 0 then --TODO: make this not an arbitrary value
    weather.weatherX = -800
    weather.weatherY = -800
  end

  if weather.condition == "rain" or weather.condition == "storm" then weather.weatherA = weather.weatherA + 100*dt end
  if weather.condition == "storm" and love.math.random(1,2500) == 1 then whiteOut = 200 love.audio.play(sfx["lightning"]) end
  if weather.condition == "clear" then weather.weatherA = weather.weatherA - 100*dt end
  if weather.weatherA > 255 then weather.weatherA = 255 elseif weather.weatherA < 0 then weather.weatherA = 0 end

  local cx, cy = love.mouse.getPosition()
  local sw,sh = love.graphics.getDimensions()

  if loadedZone ~= pl.zone then
    saveFog()
    loadOverworld()
    loadFog()
    addFog(pl.t)
  end
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
          if world[i].bg ~= world[i].tile then
            if worldImg[world[i].tile] then
              love.graphics.draw(worldImg[world[i].tile], x, y)
            end
          end
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
