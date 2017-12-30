lootQueue = {}
LQalpha = 0
LQaction = "off"
LQcurrent = 0

function newLoot(title,amount)
  local cLootQueue = #lootQueue + 1 --get current loot queue item here
  lootQueue[cLootQueue] = {}
  lootQueue[cLootQueue].title = title
  lootQueue[cLootQueue].amount = amount
end

function drawLootBox(x,y)
  if LQaction ~= "off" then
    love.graphics.setColor(50,50,50,LQalpha)
    love.graphics.rectangle("fill", x, y, 200, 72)
    love.graphics.setFont(font)
    love.graphics.setColor(255,255,255,LQalpha)
    love.graphics.printf("Earned loot",x,y,200,"center")
    y = y + font:getHeight()+6

    love.graphics.setColor(255,255,255,LQalpha)
    drawItem(lootQueue[LQcurrent].title,lootQueue[LQcurrent].amount,x+4,y,LQalpha)
    love.graphics.printf(lootQueue[LQcurrent].title,x+32,y+6,200-32,"center")

    --border
    love.graphics.setColor(150,150,150,LQalpha)
    love.graphics.rectangle("line",x,y-(font:getHeight()+6), 200, 72)

    love.graphics.setColor(255,255,255,255)
    if cx > x and cx < x+200 and cy > y and cy < y+72 then
      LQalpha = 255
    end
  end
end

function updateLootBox(dt)
  local rate = 200*dt

  if LQcurrent < #lootQueue then --if we've got more loot to cycle through
    if LQaction == "off" then LQaction = "up" LQcurrent = LQcurrent + 1 end --let's get that box showing!
  end

  if LQaction == "up" then
    LQalpha = LQalpha + rate
    if LQalpha > 600 then
      LQaction = "down"
    end

  elseif LQaction == "down" then
    LQalpha = LQalpha - rate
    if LQalpha < 0 then
      LQaction = "off"
      --LQcurrent = LQcurrent + 1
    end
  end
end
