require "modules/submodules/fog"

world = {}
world.bg = {}
world.name = {}
world.fight = {}
world.collide = {}
world.isFight = {}
world.players = {}


function loadOverworld()
  if love.filesystem.exists("map.txt") then
    for line in love.filesystem.lines("map.txt") do
      word = atComma(line)
      i = #world + 1
      world[i] = word[1]
      world.fight[i] = word[2]
      if word[4] == "true" then world.collide[i] = true else world.collide[i] = false end
      world.name[i] = word[5]
      world.bg[i] = word[6]
      world.isFight[i] = false
      world.players[i] = ""

    end
  else
    love.window.showMessageBox("World doesn't exist!", "We couldn't find the world file. This means one of two things: 1) the Witch has successfully wiped out all of mankind or 2) the client didn't download the world properly. Either way, we need to exit. Report this to @Pebsiee!!", "error")
    love.event.quit()
  end

  createWorldCanvas()
end

function drawOverworld()
  local x = 0
  local y = 0

  love.graphics.setColor(200,200,200)
  --background
  for i = 1, (sw/32)*((sh/32)+1) do
    love.graphics.draw(worldImg["Grass"], x, y)
    love.graphics.draw(worldImg["Mountain"], x, y)
    x = x + 32
    if x > sw then x = 0 y = y + 32 end
  end

  love.graphics.setColor(255,255,255,255)
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.draw(worldCanvas, -mx, -my) --draw world

      love.graphics.setBlendMode("alpha")

  if not item.val[pl.wep] and not item.val[pl.arm] then
    love.graphics.print("Awaiting character info...")
  end

  drawUICharInfo(gameUI.x["char"], gameUI.y["char"])
  drawUIDebugInfo(gameUI.x["deb"], gameUI.y["deb"])
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
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()).."\nCam: "..mx..", "..my.."\nPlayer tile: "..pl.t, x, y)

  --border
  love.graphics.setColor(150,150,150)
  love.graphics.rectangle("line",x, y, 160, 46)
end

function updateGameUI(dt, ud)

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
if not worldCanvas then worldCanvas = love.graphics.newCanvas(32*101,32*101) end
  love.graphics.setCanvas(worldCanvas)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    local x = 0
    local y = 0
    for i = 1, 100*100 do
        if not checkFog(i) then love.graphics.setColor(210,210,210) else love.graphics.setColor(255,255,255) end
        love.graphics.draw(worldImg[world.bg[i]], x, y)
        if checkFog(i) or fog.ignore[world[i]] == true then
          love.graphics.draw(worldImg[world[i]], x, y)
        else
          love.graphics.setColor(255,255,255,50)
          love.graphics.draw(worldImg["Cloud"], x, y)
          love.graphics.setColor(255,255,255,255)
        end

        if tonumber(pl.t) == tonumber(i) then
          love.graphics.draw(item.img[pl.arm],x,y)
        end
--love.graphics.setFont(sFont)
      --love.graphics.print(i, x-mx, y-my)
      x = x + 32
      if x > 32*100 then
        y = y + 32
        x = 0
      end
    end

    love.graphics.setCanvas()
end
