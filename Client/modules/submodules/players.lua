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
  player[name].arm_head = "None"
  player[name].arm_chest = "None"
  player[name].arm_legs = "None"
  player[name].wep = "Legendary Sword"
  player[name].hp = 0
  player[name].state = "fight"
  player[name].spell = "None"
  player[name].buddy = "None"
  player[name].online = "false"
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
  if player[name] and player[name][a] then
    player[name][a] = value
  else
    if player[name] and player[name].name then
      print("ERROR: attempt to update player['"..name.."']."..a.." to "..value..", but that attribute doesn't exist.")
      player[name][a] = value
    else
      print("ERROR","ERROR: attempt to update player['"..name.."']."..a.." to "..value..", but that player doesn't exist.")
      player[name] = {}
      player[name][a] = value
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
  if player[name] and player[name][a] then
    return player[name][a]
  else
    return 0
  end
end

function drawPlayer(name,x,y,option,scale)

  if player[name] and player[name].online == "true" then
    if option == "buddy" then
      drawBuddy(name)
    end

    love.graphics.draw(item["Naked"].img,x,y,0,scale,scale)
    if player[name].arm_legs ~= "None" then love.graphics.draw(item[player[name].arm_legs].img,x,y,0,scale,scale) end
    if player[name].arm_chest ~= "None" then love.graphics.draw(item[player[name].arm_chest].img,x,y,0,scale,scale) end
    if player[name].arm_head ~= "None" then love.graphics.draw(item[player[name].arm_head].img,x,y,0,scale,scale) end
    love.graphics.draw(item[player[name].wep].img,x-(item[player[name].wep].img:getWidth()-32),y-(item[player[name].wep].img:getHeight()-32),0,scale,scale)
    --[[
    if player[name].x - player[name].tx > 1  then --rotation: THIS NEEDS TO BE REDONE ONCE THE CLIENT IS SENT TARGET INFO
      love.graphics.draw(item.img[player[name].arm],x,y,0,-1,1,32,0)
    else
      love.graphics.draw(item.img[player[name].arm],x,y)
    end]]

    if player[name].spell ~= "None" then
      drawSpell(player[name].spell,x,y)
    end
  end
end

function drawNamePlate(name,x,y,option)
  if not player[name] or player[name].online == "true" then --so that <npc> shop still works
    if option == "enemy" and string.sub(world[pl.t].fight,1,7) == "Gather:" or option == "gather" then
      love.graphics.setColor(0,0,0,200)
      love.graphics.rectangle("fill",16+x-(round(sFont:getWidth(name)/2)),y-14,sFont:getWidth(name)+4,sFont:getHeight()+2)
      love.graphics.setColor(100,100,255)
    elseif option == "enemy" then
      love.graphics.setColor(0,0,0,50)
      love.graphics.rectangle("fill",16+x-(round(sFont:getWidth(name)/2)),y-14,sFont:getWidth(name)+4,sFont:getHeight()+2)
      love.graphics.setColor(255,0,0)
    elseif option == "ally" then
      love.graphics.setColor(0,0,0,100)
      love.graphics.rectangle("fill",16+x-(round(sFont:getWidth(name)/2)),y-14,sFont:getWidth(name)+4,sFont:getHeight()+2)
      love.graphics.setColor(0,255,0)
    elseif option == "dungeon" then
      love.graphics.setColor(0,0,0,200)
      love.graphics.rectangle("fill",16+x-(round(sFont:getWidth(name)/2)),y-14,sFont:getWidth(name)+4,sFont:getHeight()+2)
      love.graphics.setColor(255,0,0)
    else
      love.graphics.setColor(0,0,0,200)
      love.graphics.rectangle("fill",16+x-(round(sFont:getWidth(name)/2)),y-14,sFont:getWidth(name)+4,sFont:getHeight()+2)
      love.graphics.setColor(255,255,255,255)
    end
    love.graphics.setFont(sFont)
    love.graphics.printf(name,17+x-(round(sFont:getWidth(name)/2)),y-12,sFont:getWidth(name),"center")
  end
  love.graphics.setColor(255,255,255,255)
end

function getArmourValue(name)
  return (item[player[name].arm_head].val + item[player[name].arm_chest].val + item[player[name].arm_legs].val)
end
