

bud = {}

function updateBuddies(dt)
  for i = 1, countPlayers() do
    local name = getPlayerName(i)
    if tostring(bud[name]) ~= "nil" then
      local dist = distanceFrom(bud[name].x, bud[name].y, getPlayer(name,"x")+16, getPlayer(name,"y")+16)
      local speed = (dist*2)*dt

      if dist > 32 then
        if bud[name].x > getPlayer(name,"x") then bud[name].x = bud[name].x - speed end
        if bud[name].x < getPlayer(name,"x") then bud[name].x = bud[name].x + speed end
        if bud[name].y > getPlayer(name,"y") then bud[name].y = bud[name].y - speed end
        if bud[name].y < getPlayer(name,"y") then bud[name].y = bud[name].y + speed end
      end

    else
      bud[name] = {}
      bud[name].owner = "set"
      bud[name].x = getPlayer(name,"x")
      bud[name].y = getPlayer(name,"y")
    end
  end
end

function drawBuddy(name)
  if bud[name] and tostring(buddy[getPlayer(name,"buddy")]) ~= "nil" and player[name].online == "true" then
    if pl.state == "world" then
      love.graphics.draw(buddy[getPlayer(name,"buddy")],bud[name].x-mx,bud[name].y-my)
    elseif pl.state == "fight" then
      love.graphics.draw(buddy[getPlayer(name,"buddy")],bud[name].x+xoff,bud[name].y+yoff)
    end
  else
  --  updatePlayer(name,"buddy","Water Elementling")
  end
end
