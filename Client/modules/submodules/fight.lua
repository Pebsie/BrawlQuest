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
updateTime = {}
updateTime[1] = 0.1 --fight info
updateTime[2] = 2 --world info
updateTime[3] = 0.2 --player info

function createFightCanvas(t)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setCanvas(fightCanvas)
  love.graphics.clear()

  local x = 0
  local y = 0

  for i = 1, 30*18 do
    love.graphics.draw(worldImg[world[t].bg],x,y)
    x = x + 32
    if x > 30*32 then
      x = 0
      y = y + 32
    end

--    love.graphics.draw(worldImg[world[t].tile],300,200,0,4,4) <== will be cool but needs some work and thought
  end

  love.graphics.setCanvas()
end

function drawFight()
--  love.graphics.setBackgroundColor(0,0,0)
 love.graphics.push()


love.graphics.scale(scale,scale)

  xoff = sw/2 - (stdSH/2)
  yoff = sh/2 - (stdSW/2)

  for i = 1, sw/64 do
    love.graphics.draw(loginImg["cloud"],lclouds.x[i],lclouds.y[i])
  end

  love.graphics.draw(fightCanvas,xoff,yoff)
  --love.graphics.print("FIGHT!")

  for i = 1, #bones do
    love.graphics.setColor(255,255,255,bones[i].a)
    if bones[i].t == "Player" then
      love.graphics.setColor(100,0,0,bones[i].a)
      love.graphics.rectangle("line",bones[i].x+xoff,bones[i].y+yoff,2,2)
    else
      love.graphics.draw(mb.img[bones[i].t], bones[i].x+xoff, bones[i].y+yoff, math.rad(bones[i].rotation), 0.25, 0.25)
    end
  end

  love.graphics.setColor(255,255,255,255)--reset colour

  for i = 1, countMobs() do
    if mb.img[mob[i].type] then
      if getMob(i,"hp") > 0 then

        if mob[i].x > 0 and mob[i].x < stdSH and mob[i].y > 0 then
          if mob[i].tx > mob[i].x then --rotation: THIS NEEDS TO BE REDONE ONCE THE CLIENT IS SENT TARGET INO
            love.graphics.draw(mb.img[mob[i].type], mob[i].x+xoff, mob[i].y+yoff)
          else --if mob[i].tx < mob[i].x then
            love.graphics.draw(mb.img[mob[i].type], mob[i].x+mb.img[mob[i].type]:getWidth()/2+xoff, mob[i].y+mb.img[mob[i].type]:getHeight()/2+yoff,0,-1,1,mb.img[mob[i].type]:getWidth()/2,mb.img[mob[i].type]:getHeight()/2)
          end

          if getMob(i,"hp") > 0 then
            love.graphics.setColor(255,0,0)
            love.graphics.rectangle("fill",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getWidth()+yoff,(mob[i].hp/mb.hp[mob[i].type])*mb.img[mob[i].type]:getWidth(),4)
            love.graphics.setColor(100,0,0)
            love.graphics.rectangle("line",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getWidth()+yoff,mb.img[mob[i].type]:getWidth(),4)
          end
        end
      end


      love.graphics.setColor(255,255,255)
    else
      love.graphics.draw(uiImg["error"], mob[i].x+xoff, mob[i].y+yoff)
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

      drawPlayer(playerName,x+xoff,y+yoff)
    --  drawPlayer(playerName,getPlayer(playerName,"tx"),getPlayer(playerName,"ty"))
    --  love.window.showMessageBox("Debug","Player #"..i..": "..playerName.." at position "..getPlayer(playerName,"tx")..","..getPlayer(playerName,"ty"))
      love.graphics.setColor(0,255,0)
      love.graphics.rectangle("fill",x+xoff,y+32+yoff,(getPlayer(playerName,"hp")/100)*32,6)
      love.graphics.setColor(100,0,0)
      love.graphics.rectangle("line",x+xoff,y+32+yoff,32,6)

      if pl.name == playerName then --energy
        love.graphics.setColor(255,216,0)
        love.graphics.rectangle("fill",x+xoff,y+32+8+yoff,(pl.en/100)*32,6)
        love.graphics.setColor(205,166,0)
        love.graphics.rectangle("line",x+xoff,y+32+8+yoff,32,6)
      end

      love.graphics.setColor(255,255,255)
    end
  end
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("line",xoff,yoff,stdSH,stdSW)
  love.graphics.setColor(255,255,255)
  drawFightUI(sw/2 - 320,sh-94)
 love.graphics.pop()
  love.graphics.print(love.timer.getFPS().." FPS")

end

function requestFightInfo()
  netSend("fight",pl.name..","..round(pl.x)..","..round(pl.y))
end

function updateFight(dt)
  --addBones("Boar",pl.x,pl.y)

  for i = 1, #updateTime do
    updateTime[i] = updateTime[i] - 1*dt
  end

  if updateTime[1] < 0 then
    requestFightInfo()
    updateTime[1] = 0.1
  end

  if updateTime[2] < 0 then
    requestWorldInfo()
    updateTime[2] = 5
  end

  if updateTime[3] < 0 then
    requestUserInfo()
    updateTime[3] = 1
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

  if pl.x > stdSH-32 then pl.x = stdSH-32 end
  if pl.x < 0 then pl.x = 0 end
  if pl.y > stdSW-32 then pl.y = stdSW-32 end
  if pl.y < 0 then pl.y = 0 end


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

  if pl.en < 100 then
    pl.en = pl.en + 25*dt
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

    if bones[i].t ~= "Player" then
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
      end

    elseif #bones == 1 then
      bones = {}
    end
  --  bones[i].rotation = bones[i].rotation + bones[i].xv
  end

  for i = 1, sw/64 do
    if not lclouds.x[i] or not lclouds.y[i] then
      lclouds.x[i] = love.math.random(1, screenW)
      lclouds.y[i] = love.math.random(1, screenH)
    end

    lclouds.x[i] = lclouds.x[i] + math.random(1,8)*dt
    if lclouds.x[i] > sw then
      lclouds.x[i] = love.math.random(-400,-200)
    end
  end
end

function addBones(mobType, x, y, amount)
  if not amount then amount = 32 end
  for i = #bones+1, #bones+amount do
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
  if atkCooldown < 0 and pl.en > 20 then
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
    pl.en = pl.en - 20
    atkCooldown = 0.2
  end
end

function drawFightUI(x,y)
  --boxes
  love.graphics.setColor(51,51,51)
  love.graphics.rectangle("fill",x,y,640,94) --main background
  love.graphics.setColor(0,0,0) --item backgrounds
  love.graphics.rectangle("fill",x+10,y+60,24,24) --wep image
  love.graphics.rectangle("fill",x+43,y+60,24,24) --potion image
  love.graphics.rectangle("fill",x+464,y+16,64,64) --spell 1
  love.graphics.rectangle("fill",x+559,y+16,64,64) --spell 2
  love.graphics.rectangle("fill",x+6,y+6,32,32) --character portrait
  love.graphics.setColor(43,43,43)
  love.graphics.rectangle("fill",x+173,y+7,268,79)

  --stats
  love.graphics.setColor(0,255,0)
  love.graphics.rectangle("fill",x+40,y+12,(pl.hp/100)*63,6)
  love.graphics.setColor(255,216,0)
  love.graphics.rectangle("fill",x+40,y+24,(pl.en/100)*63,6)
  love.graphics.setColor(0,100,0)
  love.graphics.rectangle("line",x+40,y+12,63,6)
  love.graphics.setColor(205,166,0)
  love.graphics.rectangle("line",x+40,y+24,63,6)

  love.graphics.setColor(255,255,255)
  love.graphics.draw(item.img[pl.wep],x+9,y+56)
  love.graphics.draw(item.img[pl.pot],x+43,y+56)
  love.graphics.draw(item.img[pl.arm],x+6,y+6)
  love.graphics.draw(uiImg["itemportrait"],x+6,y+56)
  love.graphics.draw(uiImg["itemportrait"],x+39,y+56)
  love.graphics.draw(uiImg["smallportrait"],x+6,y+6)

  love.graphics.draw(item.img[pl.s1],x+464,y+16,0,2,2)
  love.graphics.draw(item.img[pl.s2],x+559,y+16,0,2,2)

  love.graphics.draw(uiImg["lvtmp"],x+13,y+37)
  love.graphics.draw(uiImg["atkdef"],x+139,y+49)

  --text
  love.graphics.setFont(font)
  love.graphics.setColor(76,255,0)
  love.graphics.printf(item.val[pl.wep],x+114,y+52,24,"center")
  love.graphics.printf(item.val[pl.arm],x+114,y+72,24,"center")

  --border
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("line",x,y,640,94)

  love.graphics.setColor(255,255,255)
end
