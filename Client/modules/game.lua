mx = 0
my = 0

gameUI = {}
gameUI.x = {}
gameUI.y = {}
gameUI.isDrag = {}

function drawGame()
  if ui.selected == "map" then
    local x = 0
    local y = 0


    --background
    for i = 1, 25*25 do
      love.graphics.draw(worldImg["Grass"], x, y)
      love.graphics.draw(worldImg["Mountain"], x, y)
      x = x + 32
      if x > 800 then x = 0 y = y + 32 end
    end

    x = 0
    y = 0
    for i = 1, 100*100 do
        love.graphics.draw(worldImg[world.bg[i]], x-mx, y-my)
        love.graphics.draw(worldImg[world[i]], x-mx, y-my)

        if pl.t == i then
          love.graphics.draw(item.img[pl.arm],x-mx,y-my)
          --love.graphics.rectangle("fill", i*16, k*16, 16, 16)
        else
          love.graphics.setColor(255,255,255)
        end

        x = x + 32
        if x > 32*100 then
          y = y + 32
          x = 0
        end
        --love.graphics.print(i*k, i*32, k*132)
      end

  end

  if not item.val[pl.wep] and not item.val[pl.arm] then
    love.graphics.print("Awaiting character info...")
  end

  drawUICharInfo(gameUI.x["char"], gameUI.y["char"])
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
  love.graphics.draw(item.img[pl.s1],32+x,148+y)
  love.graphics.draw(item.img[pl.s2],96+x,148+y)
  love.graphics.draw(item.img[pl.wep],32+x, 194+y)

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

function updateUI(dt)
      local cx, cy = love.mouse.getPosition()
  if isMouseDown then
    if cy < gameUI.y["char"]+12 and cy > gameUI.y["char"] and cx > gameUI.x["char"] and cx < gameUI.x["char"]+160 then
      gameUI.isDrag["char"] = true
    end
  else
    gameUI.isDrag["char"] = false
  end
  if gameUI.isDrag["char"] == true then
    if cx+160 < 801 then --avoid leaving boundaries of the window
      gameUI.x["char"] = cx
    else
      gameUI.x["char"] = 800-160
    end
    if cy+300 < 601 then
      gameUI.y["char"] = cy
    else
      gameUI.y["char"] = 600-300
    end
  end
end
