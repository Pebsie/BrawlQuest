----What interface elements do we need during a fight?
-- * My player INFO (HP/XP/Spell 1/Spell 2/ATK/DEF)
-- * Fight INFO (XP pool/Gold pool/Enemies remaining/Amount of players VS player cap)
----What gameplay elements do we need during a fight?
-- * All player info (X,Y,Armour,HP)
-- * All spell info (X,Y,Type)
-- * All mob info (X,Y,Type,HP)
----What does the client then need to receive from the server with each update?
-- * Number of players, mobs and spells in fight
-- * Player X,Y,Armour and HP
-- * Spell X,Y and type
-- * Mob X,Y,Type and HP
----NOTE: My player info will be requested with each update. This will be displayed on the UI, but for the sake of accuracy we'll use server side player movement (at least for testing)

updateFightTime = 0.2

fight = {}
mob = {}

function createFightCanvas(t)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setCanvas(fightCanvas)
  love.graphics.clear()

  local x = 0
  local y = 0

  for i = 1, 25*20 do
    love.graphics.draw(worldImg[world[t].bg],x,y)
    x = x + 32
    if x > 800 then
      x = 0
      y = y + 32
    end
  end

  love.graphics.setCanvas()
end

function drawFight()
--  love.graphics.setBackgroundColor(0,0,0)
  love.graphics.draw(fightCanvas)
  --love.graphics.print("FIGHT!")

  for i = 1, countMobs() do
    if mb.img[mob[i].type] then
      love.graphics.draw(mb.img[mob[i].type], mob[i].x, mob[i].y)
    else
      love.graphics.draw(uiImg["error"], mob[i].x, mob[i].y)
    end
  end

  for i = 1, countPlayers() do
      local playerName = getPlayerName(i)
    if getPlayer(playerName,"t") == pl.t then
      if pl.name == playerName then --we want to draw us client side to reduce jankiness
        x = pl.x
        y = pl.y
      else
        x = getPlayer(playerName,"x")
        y = getPlayer(playerName,"y")
      end

      drawPlayer(playerName,x,y)
    --  drawPlayer(playerName,getPlayer(playerName,"tx"),getPlayer(playerName,"ty"))
    --  love.window.showMessageBox("Debug","Player #"..i..": "..playerName.." at position "..getPlayer(playerName,"tx")..","..getPlayer(playerName,"ty"))
      love.graphics.setColor(255,0,0)
      love.graphics.rectangle("fill",x,y+32,(getPlayer(playerName,"hp")/100)*32,6)
      love.graphics.setColor(100,0,0)
      love.graphics.rectangle("line",x,y+32,32,6)
      love.graphics.setColor(255,255,255)
    end
  end

  love.graphics.print(love.timer.getFPS().." FPS")
end

function requestFightInfo()
  netSend("fight",pl.name..","..round(pl.x)..","..round(pl.y))
end

function updateFight(dt)
  updateFightTime = updateFightTime - 1*dt

  if updateFightTime < 0 then
    requestFightInfo()
    requestUserInfo()
    requestWorldInfo()
    updateFightTime = 0.1
  end

  local speed = 128*dt
  if love.keyboard.isDown(KEY_UP) then
    pl.y = pl.y - speed
  elseif love.keyboard.isDown(KEY_DOWN) then
    pl.y = pl.y + speed
  end
  if love.keyboard.isDown(KEY_LEFT) then
    pl.x = pl.x - speed
  elseif love.keyboard.isDown(KEY_RIGHT) then
    pl.x = pl.x + speed
  end

  updatePlayers(dt,128) --move players to correct position

  for i = 1, countMobs() do
    local pls = mb.spd[mob[i].type]*dt
    if mob[i].x >  mob[i].tx then  mob[i].x =  mob[i].x - pls end
    if  mob[i].x <  mob[i].tx then  mob[i].x =  mob[i].x + pls end
    if  mob[i].y >  mob[i].ty then  mob[i].y =  mob[i].y - pls end
    if  mob[i].y <  mob[i].ty then  mob[i].y =  mob[i].y + pls end

    if distanceFrom( mob[i].x,  mob[i].y,  mob[i].tx,  mob[i].ty) > 128 then
       mob[i].x =  mob[i].tx
       mob[i].y =  mob[i].ty
    end

    if love.math.random(1, 2500) == 1 then
      love.audio.play(mb.sfx[mob[i].type][love.math.random(1,#mb.sfx[mob[i].type])])
    end
  end
end

function countMobs()
  return #mob
end

function killMobs()
  mob = {}
end

function addMob(id)
  mob[id] = {}
  mob[id].tx = 0
  mob[id].x = 0
  mob[id].ty = -32
  mob[id].y = -32
  mob[id].type = "Boar"
end

function doesMobExist(id)
  if mob[id] then
    return true
  else
    return false
  end
end

function updateMob(id,a,value)
  mob[id][a] = value
end
