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
  love.graphics.setColor(50,50,50)
  love.graphics.rectangle("fill", x, y, 200, 72)
  love.graphics.setFont(font)
  love.graphics.setColor(255,255,255)
  love.graphics.printf("Earned loot",x,y,200,"center")
  y = y + font:getHeight()+6

  love.graphics.setColor(255,255,255)


  --border
  love.graphics.setColor(150,150,150)
  love.graphics.rectangle("line",tx,ty, 200, 72)
end

function updateLootBox(dt)
  local rate = 100*dt

  if LQcurrent < #lootQueue then --if we've got more loot to cycle through
    if LQaction == "off" then LQaction = "up" LQcurrent = LQcurrent + 1 end --let's get that box showing!

    if LQaction == "up" then
      LQalpha = LQalpha + rate
      if LQalpha > 600 then
        LQaction = "down"
      end

    elseif LQaction == "down" then
      LQalpha = LQalpha - rate
      if LQalpha < 0 then
        LQaction = "off"
      end

    end

  end

end
