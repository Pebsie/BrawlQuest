mx = 0
my = 0

function drawGame()
  if ui.selected == "map" then
    local x = 0
    local y = 0

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

  if item.val[pl.wep] and item.val[pl.arm] then
    love.graphics.print(pl.name.." - "..item.val[pl.wep].." ATK ("..pl.wep..") - "..item.val[pl.arm].." DEF ("..pl.arm..") - Tile "..pl.t)
  else
    love.graphics.print("Awaiting character info...")
  end

  drawUICharInfo(800-160,0)
end

--UI elements
function drawUICharInfo(x,y)
  --shapes
  love.graphics.setColor(50,50,50)
  love.graphics.rectangle("fill", x, y, 160, 600)
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", 48+x, 16+y, 64, 64)
  love.graphics.setColor(250,0,0)
  love.graphics.rectangle("line", 38+x, 104+y, 84, 16)
  love.graphics.setColor(150,0,0)
  love.graphics.rectangle("fill", 38+x, 104+y, (pl.hp/100)*84, 16)

  --objects
  love.graphics.setColor(255,255,255)
  love.graphics.draw(item.img[pl.arm],48+x,16+y,0,2,2) --player avatar image

  --text
  love.graphics.printf(pl.name,x,84+y,160,"center")
end
