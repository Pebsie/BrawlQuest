player = {}
pli = {}
players = 0

function addPlayer(name)
  player[name] = {}
  player[name].name = name --ew
  player[name].x = 0
  player[name].y = 0
  player[name].t = 0
  player[name].arm = "Old Cloth"
  player[name].hp = 0
  players = players + 1
  pli[players] = name
end

function playerExists(name)
  if player[name].name then
    return true
  else
    return false
  end
end

function updatePlayer(name,a,value) --where a is attribute (x/y/t/arm/hp)
  if player[name][a] then
    player[name][a] = value
  else
    print("ERROR: attempt to update player['"..name.."']."..a.." to "..value..", but that doesn't exist.")
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
  love.graphics.draw(item.img[player[name].arm],x,y)
end
