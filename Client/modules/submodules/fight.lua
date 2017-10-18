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
atkCooldown = 1

fight = {}
mob = {}
bones = {}

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

--    love.graphics.draw(worldImg[world[t].tile],300,200,0,4,4) <== will be cool but needs some work and thought
  end

  love.graphics.setCanvas()
end

function drawFight()
--  love.graphics.setBackgroundColor(0,0,0)
  love.graphics.draw(fightCanvas)
  --love.graphics.print("FIGHT!")

  for i = 1, #bones do
    love.graphics.setColor(255,255,255,bones[i].a)
    if bones[i].t == "Player" then
      love.graphics.setColor(100,0,0)
      love.graphics.rectangle("line",bones[i].x,bones[i].y,2,2)
      love.graphics.setColor(255,255,255)
    else
      love.graphics.draw(mb.img[bones[i].t], bones[i].x, bones[i].y, math.rad(bones[i].rotation), 0.25, 0.25)
    end
  end

  love.graphics.setColor(255,255,255,255)--reset colour

  for i = 1, countMobs() do
    if mb.img[mob[i].type] then
      if mob[i].tx > mob[i].x then --rotation: THIS NEEDS TO BE REDONE ONCE THE CLIENT IS SENT TARGET INO
        love.graphics.draw(mb.img[mob[i].type], mob[i].x, mob[i].y)
      else --if mob[i].tx < mob[i].x then
        love.graphics.draw(mb.img[mob[i].type], mob[i].x+mb.img[mob[i].type]:getWidth()/2, mob[i].y+mb.img[mob[i].type]:getHeight()/2,0,-1,1,mb.img[mob[i].type]:getWidth()/2,mb.img[mob[i].type]:getHeight()/2)
      end

      if getMob(i,"hp") > 0 then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("fill",mob[i].x,mob[i].y+32,(mob[i].hp/mb.hp[mob[i].type])*32,4)
        love.graphics.setColor(100,0,0)
        love.graphics.rectangle("line",mob[i].x,mob[i].y+32,32,4)
      end
      love.graphics.setColor(255,255,255)
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
  --addBones("Boar",pl.x,pl.y)

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

  --PLAYER LOGIC
  updatePlayers(dt,128) --move players to correct position

  atkCooldown = atkCooldown - 1*dt

  if love.keyboard.isDown(KEY_ATK_UP) then
    attack("up")
  elseif love.keyboard.isDown(KEY_ATK_DOWN) then
    attack("down")
  elseif love.keyboard.isDown(KEY_ATK_RIGHT) then
    attack("right")
  elseif love.keyboard.isDown(KEY_ATK_LEFT) then
    attack("left")
  end

  --MOBS
  for i = 1, countMobs() do
    local pls = mb.spd[mob[i].type]*dt
    if mob[i].x >  mob[i].tx then  mob[i].x =  mob[i].x - pls end
    if  mob[i].x <  mob[i].tx then  mob[i].x =  mob[i].x + pls end
    if  mob[i].y >  mob[i].ty then  mob[i].y =  mob[i].y - pls end
    if  mob[i].y <  mob[i].ty then  mob[i].y =  mob[i].y + pls end

    if distanceFrom( mob[i].x,  mob[i].y,  mob[i].tx,  mob[i].ty) > 128 or distanceFrom( mob[i].x,  mob[i].y,  mob[i].tx,  mob[i].ty) < 1 then
       mob[i].x =  mob[i].tx
       mob[i].y =  mob[i].ty
    end

    if love.math.random(1, 1000) == 1 and mb.sfx[mob[i].type] then
      love.audio.play(mb.sfx[mob[i].type][love.math.random(1,#mb.sfx[mob[i].type])])
    end
  end

  --bones
  for i = 1, #bones do
    bones[i].x = bones[i].x + bones[i].xv*dt
    bones[i].y = bones[i].y + bones[i].yv*dt

    local resist = 128*dt

    if bones[i].xv ~= 0 then
      if bones[i].xv > 2 then bones[i].xv = bones[i].xv - resist
      elseif bones[i].xv < -2 then bones[i].xv = bones[i].xv + resist
      else bones[i].xv = 0 end
    end

    if bones[i].yv ~= 0 then
      if bones[i].yv > 2 then bones[i].yv = bones[i].yv - resist
      elseif bones[i].yv < -2 then bones[i].yv = bones[i].yv + resist
      else bones[i].yv = 0 end
    end

    bones[i].a = bones[i].a - 50*dt
    if bones[i].a < 0 and #bones > 1 then
      bones[i] = bones[#bones]
      bones[i].x = bones[#bones].x
      bones[i].y = bones[#bones].y
      bones[i].rotation = bones[#bones].rotation
      bones[i].xv = bones[#bones].xv
      bones[i].yv = bones[#bones].yv
      bones[i].a = bones[#bones].a
      bones[i].t = bones[#bones].t

    elseif #bones == 1 then
      bones = {}
    end
  --  bones[i].rotation = bones[i].rotation + bones[i].xv
  end
end

function addBones(mobType, x, y)
  for i = #bones+1, #bones+32 do
    bones[i] = {}
    bones[i].x = x + love.math.random(1, 32)
    bones[i].y = y + love.math.random(1, 32)
    bones[i].xv = love.math.random(-100, 100)
    bones[i].yv = love.math.random(-100, 100)
    bones[i].t = mobType
    bones[i].rotation = love.math.random(1, 360)
    bones[i].a = 255
  end
end

function countMobs()
  return #mob
end

function killMobs()
  mob = {}
  bones = {}
end

function addMob(id)
  mob[id] = {}
  mob[id].tx = 0
  mob[id].x = 0
  mob[id].ty = -32
  mob[id].y = -32
  mob[id].type = "Boar"
  mob[id].hp = 0
end

function doesMobExist(id)
  if mob[id] then
    return true
  else
    return false
  end
end

function updateMob(id,a,value)
  if a == "hp" and mob[id][a] > 0 then
    if value < 1 then
      addBones(mob[id].type, mob[id].x, mob[id].y)
    end
  end
  mob[id][a] = value
end

function getMob(id,a)
  return mob[id][a]
end

function attack(dir)
  if atkCooldown < 0 then
    netSend("atk",pl.name..","..dir)

    local ferocity = 30

    if dir == "up" then
      pl.y = pl.y - ferocity
    elseif dir == "down" then
      pl.y = pl.y + ferocity
    elseif dir == "left" then
      pl.x = pl.x - ferocity
    elseif dir == "right" then
      pl.x = pl.x + ferocity
    end

    atkCooldown = 0.25
  end
end