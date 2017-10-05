require "modules/submodules/fog"

world = {}

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


    love.graphics.pop()

  drawUICharInfo(gameUI.x["char"], gameUI.y["char"])
  drawUIDebugInfo(gameUI.x["deb"], gameUI.y["deb"])

  love.graphics.setFont(bFont)
  love.graphics.setColor(255,255,255,areaTitleAlpha)
  love.graphics.printf(world[pl.t].name, 0,10,sw,"center")
  love.graphics.setFont(font)

end

--UI elements
function drawUICharInfo(x,y)
  --shapes
  love.graphics.setColor(50,50,50)
  love.graphics.rectangle("fill", x, y, 160, 300)
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", 48+x, 16+y, 64, 64)
  love.graphics.setColor(255,0,0)
  love.graphics.rectangle("fill", 38+x, 104+y, (pl.hp/100)*84, 16)
  love.graphics.setColor(150,0,0)
  love.graphics.rectangle("line", 38+x, 104+y, 84, 16)
  love.graphics.setColor(0,0,255)
  love.graphics.rectangle("fill", 38+x, 124+y, (pl.xp/100)*84, 16)
  love.graphics.setColor(0,0,150)
  love.graphics.rectangle("line", 38+x, 124+y, 84, 16)
  love.graphics.setColor(200,200,200)
  love.graphics.rectangle("fill", 32+x, 148+y, 32, 32)
  love.graphics.rectangle("fill", 96+x, 148+y, 32, 32)
  love.graphics.rectangle("fill", 32+x, 194+y, 32, 32)
  love.graphics.rectangle("fill", 96+x, 194+y, 32, 32)
  love.graphics.draw(uiImg["atk"], 45+x, 230+y)
  love.graphics.draw(uiImg["def"], 45+x, 264+y)

  --objects
  love.graphics.setColor(255,255,255)
  love.graphics.draw(worldImg["Grass"],48+x,16+y,0,2,2)
  love.graphics.draw(item.img[pl.arm],48+x,16+y,0,2,2) --player avatar image
  love.graphics.draw(uiImg["portrait"],48+x,16+y)
  love.graphics.draw(item.img[pl.s1],32+x,148+y)
  love.graphics.draw(item.img[pl.s2],96+x,148+y)
  love.graphics.draw(item.img[pl.wep],32+x, 194+y)
  if item.img[pl.pot] then love.graphics.draw(item.img[pl.pot],96+x,194+y) end

  --text
  love.graphics.printf(pl.name,x,84+y,160,"center")
  love.graphics.print("Q", 58+x, 176+y)
  love.graphics.print("E", 90+x, 176+y)
  love.graphics.setColor(0,180,0)
  love.graphics.setFont(bFont)
  love.graphics.print(item.val[pl.wep], 85+x, 230+y)
  love.graphics.print(item.val[pl.arm], 85+x, 264+y)
  love.graphics.setFont(font)
  love.graphics.setColor(255,255,255)

  --border
  love.graphics.setColor(150,150,150)
  love.graphics.rectangle("line",x, y, 160, 300)
end

function drawUIDebugInfo(x,y)
  love.graphics.setColor(50,50,50)
  love.graphics.rectangle("fill", x, y, 160, 46)

  love.graphics.setColor(255,255,255)
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()).."\nCam: "..mx..", "..my.."\nST: "..selT, x, y)

  --border
  love.graphics.setColor(150,150,150)
  love.graphics.rectangle("line",x, y, 160, 46)
end

function updateGameUI(dt, ud)
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

    local cx, cy = love.mouse.getPosition()

  if isMouseDown then
    if cy < gameUI.y[ud]+12 and cy > gameUI.y[ud] and cx > gameUI.x[ud] and cx < gameUI.x[ud]+160 then
      gameUI.isDrag[ud] = true
    end
  else
    gameUI.isDrag[ud] = false
  end
  if gameUI.isDrag[ud] == true then
    gameUI.x[ud] = cx
    gameUI.y[ud] = cy
  end

  if   gameUI.x[ud]+160 > sw+1 then --avoid leaving boundaries of the window
      gameUI.x[ud] = sw-160
  end
  if   gameUI.y[ud]+300 > sh+1 then
    gameUI.y[ud] = sh-300
  end
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
            elseif world[i].isFight == true then
              love.graphics.draw(uiImg["fight"], x, y)
            end
          else
            love.graphics.setColor(255,255,255,50)
            love.graphics.draw(worldImg["Cloud"], x, y)
            love.graphics.setColor(255,255,255,255)
          end

          for k = 1,countPlayers() do --THIS IS BAD, OPTIMISE THIS WHEN YOU AREN'T ILL
            local name = getPlayerName(k)
            if getPlayer(name,"t") == i then
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
