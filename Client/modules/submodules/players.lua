player = {}
pli = {}
players = 0

function addPlayer(name)
  player[name] = {}
  player[name].name = name --ew
  player[name].x = 0
  player[name].tx = 0
  player[name].y = 0
  player[name].ty = 0
  player[name].t = 0
  player[name].arm = "Old Cloth"
  player[name].hp = 0
  player[name].state = "fight"
  player[name].spell = "None"
  player[name].buddy = "None"
  players = players + 1
  pli[players] = name
end

function playerExists(name)
  local found = false
  for i = 1, countPlayers() do
    if pli[i] == name then
      found = true
    end
  end

  return found
end

function updatePlayer(name,a,value) --where a is attribute (x/y/t/arm/hp)
  if player[name][a] then
    player[name][a] = value
  else
    if player[name].name then
      love.window.showMessageBox("ERROR","ERROR: attempt to update player['"..name.."']."..a.." to "..value..", but that attribute doesn't exist.")
    else
      love.window.showMessageBox("ERROR","ERROR: attempt to update player['"..name.."']."..a.." to "..value..", but that player doesn't exist.")
    end
  end
end

function updatePlayers(dt,pls) --not to be confused with updatePlayer, above
  if not pls then pls = 64 end
  pls = pls*dt
  for i = 1, countPlayers() do
    name = getPlayerName(i)
    if player[name].x > player[name].tx then player[name].x = player[name].x - pls end
    if player[name].x < player[name].tx then player[name].x = player[name].x + pls end
    if player[name].y > player[name].ty then player[name].y = player[name].y - pls end
    if player[name].y < player[name].ty then player[name].y = player[name].y + pls end

    if distanceFrom(player[name].x, player[name].y, player[name].tx, player[name].ty) > 128 then
      player[name].x = player[name].tx
      player[name].y = player[name].ty
    end
  end
end

function countPlayers()
  return players
end

function getPlayerName(id)
  return pli[id]
end

function getPlayer(name,a) --where a is attribute
  return player[name][a]
end

function drawPlayer(name,x,y)
  if player[name] and item.img[player[name].arm] then
    love.graphics.draw(item.img[player[name].arm],x,y)

    if player[name].spell ~= "None" then
      drawSpell(player[name].spell,x,y)
    end
  end

  drawBuddy(name)

  love.graphics.setColor(0,0,0,200)
  love.graphics.rectangle("fill",16+x-(round(sFont:getWidth(name)/2)),y-14,sFont:getWidth(name)+4,sFont:getHeight()+2)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(sFont)
  love.graphics.printf(name,17+x-(round(sFont:getWidth(name)/2)),y-12,sFont:getWidth(name),"center")

end
