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
require "modules/submodules/bones"

updateFightTime = 0.2
atkCooldown = 1

fight = {}
fight.highscore = 0
fight.highscorePlayer = "Unknown"
mob = {}
updateTime = {}
updateTime[1] = 0.1 --fight info
updateTime[2] = 2 --world info
updateTime[3] = 0.2 --player info
updateTime[4] = 5 --time before we can talk again
updateTime[5] = 1 --time before we can claim any more loot
lastTalk = "anonymous"

function createFightCanvas(t)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setCanvas(fightCanvas)
  love.graphics.clear()

  local x = 0
  local y = 0
  local v = 1
  extraImages = {}

  for k = -195,305,101 do
    for i = -9, -5 do
      if world[t+i+k] then
        extraImages[v] = worldImg[world[t+i+k].tile]
        v = v + 1
      end
    end
  end

  for i = 1, 30*18 do

    love.graphics.draw(worldImg[world[t].bg],x,y)
    if love.math.random(1, 8) == 1 then
      if x < 120 or x > stdSH-120 then
        if world[t].tile ~= "Dungeon" then
          love.graphics.draw(extraImages[love.math.random(1,#extraImages)],x,y)
        end
      end
    end

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


love.graphics.scale(scaleX,scaleY)

  xoff = -round(stdSH/2 - love.graphics.getWidth()/(2*scaleX))--1920/2 - (1920*(love.graphics.getWidth()/(1920/2) / scaleX))
  yoff = -round(stdSW/2 - love.graphics.getHeight()/(2*scaleY))--1080/2 - (1080*(love.graphics.getHeight()/(1080/2) / scaleY))

  for i = 1, sw/64 do
    love.graphics.draw(loginImg["cloud"],lclouds.x[i],lclouds.y[i])
  end

  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(fightCanvas,xoff,yoff)
  --love.graphics.print("FIGHT!")

  drawBones()


  for i = 1, countMobs() do
    if mb.img[mob[i].type] then
      if getMob(i,"hp") > 0 then

        if mob[i].x > -mb.img[mob[i].type]:getWidth() and mob[i].x < stdSH and mob[i].y > -mb.img[mob[i].type]:getHeight() then
          if distanceFrom(mob[i].x,mob[i].y, pl.x, pl.y)-1 < mb.rng[mob[i].type]+24 and not mb.friend[mob[i].type] then
            love.graphics.setColor(100,0,0)
            love.graphics.line(mob[i].x+xoff+mb.img[mob[i].type]:getWidth()/2,mob[i].y+yoff+mb.img[mob[i].type]:getHeight()/2,pl.x+xoff+16,pl.y+yoff+16)
            love.graphics.setColor(255,255,255)
          end

          if mob[i].tx > mob[i].x then --rotation: THIS NEEDS TO BE REDONE ONCE THE CLIENT IS SENT TARGET INFO
            love.graphics.draw(mb.img[mob[i].type], mob[i].x+xoff, mob[i].y+yoff)
          else --if mob[i].tx < mob[i].x then
            love.graphics.draw(mb.img[mob[i].type], mob[i].x+mb.img[mob[i].type]:getWidth()/2+xoff, mob[i].y+mb.img[mob[i].type]:getHeight()/2+yoff,0,-1,1,mb.img[mob[i].type]:getWidth()/2,mb.img[mob[i].type]:getHeight()/2)
          end

          if getMob(i,"hp") > 0 and mb.friend[mob[i].type] ~= true and getMob(i,"hp") < 99999 then
            love.graphics.setColor(255,0,0)
            love.graphics.rectangle("fill",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getHeight()+yoff,(mob[i].hp/getMob(i,"mhp"))*mb.img[mob[i].type]:getWidth(),4)
            love.graphics.setColor(100,0,0)
            love.graphics.rectangle("line",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getHeight()+yoff,mb.img[mob[i].type]:getWidth(),4)
            if mb.sp1[mob[i].type] ~= "None" and getMob(i,"spell1time") and mb.sp1t[mob[i].type] and mb.sp1[mob[i].type] ~= "suicide" then
              love.graphics.setColor(100,100,255)
              love.graphics.rectangle("fill",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getHeight()+yoff+5,(getMob(i,"spell1time")/mb.sp1t[mob[i].type])*mb.img[mob[i].type]:getWidth(),2)
              love.graphics.setColor(50,50,255)
              love.graphics.rectangle("line",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getHeight()+yoff+5,mb.img[mob[i].type]:getWidth(),2)
            end
            if mb.sp2[mob[i].type] ~= "None" and getMob(i,"spell2time") and mb.sp2t[mob[i].type] and mb.sp2[mob[i].type] ~= "suicide"  then
              love.graphics.setColor(100,100,255)
              love.graphics.rectangle("fill",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getHeight()+yoff+9,(getMob(i,"spell2time")/mb.sp2t[mob[i].type])*mb.img[mob[i].type]:getWidth(),2)
              love.graphics.setColor(50,50,255)
              love.graphics.rectangle("line",mob[i].x+xoff,mob[i].y+mb.img[mob[i].type]:getHeight()+yoff+9,mb.img[mob[i].type]:getWidth(),2)
            end
          end
        end
      end


      love.graphics.setColor(255,255,255)
    else
      love.graphics.draw(uiImg["error"], mob[i].x+xoff, mob[i].y+yoff)
    end
  end

  for i = 1, countMobs() do
    if mb.img[mob[i].type] then
      if getMob(i,"hp") > 0 then
        if getMob(i,"hp") > 0 and mb.friend[mob[i].type] ~= true and getMob(i,"hp") < 19999 then
          drawNamePlate(mob[i].type,mob[i].x+xoff,mob[i].y+yoff,"enemy")
        elseif mb.friend[mob[i].type] then
          drawNamePlate(mob[i].type,mob[i].x+xoff,mob[i].y+yoff,"ally")
        end
      end
    end
  end


    for i = 1, countPlayers() do
     local playerName = getPlayerName(i)

      if getPlayer(playerName,"t") == pl.t then
        if pl.name == playerName then --we want to draw us client side to reduce jankiness
          x = pl.x
          y = pl.y
          pl.spell = getPlayer(playerName,"spell")
        elseif pl.state == "afterfight" then --don't show players in the afterfight
          x = -32
          y = -32
        else
          x = getPlayer(playerName,"x")
          y = getPlayer(playerName,"y")
        end

        drawPlayer(playerName,x+xoff,y+yoff,"buddy")
        drawNamePlate(playerName,x+xoff,y+yoff)

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

  for i = 1, countPlayers() do --we want nameplates to show above player sprites
    name = getPlayerName(i)
    if name ~= pl.name and fog[tonumber(getPlayer(name,"t"))] and getPlayer(name,"state") ~= "fight" then
      drawNamePlate(name,getPlayer(name,"x")-mx,getPlayer(name,"y")-my)
    end
  end


  if pl.state == "afterfight" then
    local owedItems = atComma(pl.owed)
    xLeft = ((1920/2)/2) - ((#owedItems * 32)/2)
    for i = 1, #owedItems, 2 do
      if item.img[owedItems[i]] then
        --love.graphics.draw(item.img[owedItems[i]],xLeft+(i*32)+xoff,200+yoff)
        drawItem(owedItems[i],owedItems[i+1],xLeft+(i*32)+xoff,200+yoff,255,true)
        --love.graphics.printf("x"..owedItems[i+1],xLeft+(i*32)+xoff,200+item.img[owedItems[i]]:getHeight()+yoff,item.img[owedItems[i]]:getWidth(),"right")
      elseif string.sub(owedItems[i],1,10) == "Blueprint:" then
        love.graphics.draw(item.img["Blueprint"],xLeft+(i*32)+xoff,200+yoff)
        if item.img[string.sub(owedItems[i],12)] then
          love.graphics.draw(item.img[string.sub(owedItems[i],12)],xLeft+(i*32)+xoff,200+yoff)
        else
          love.graphics.print(owedItems[i],xLeft+(i*32)+xoff,200+yoff)
        end
      elseif owedItems[i] and owedItems[i+1] then
        love.graphics.printf(owedItems[i].." x"..owedItems[i+1],xLeft+(i*32)+xoff,200+yoff,100,"right")
      else
        error("Claim error: "..pl.owed)
      end
    end
  end

  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("line",xoff,yoff,stdSH,stdSW)
  love.graphics.setColor(255,255,255)
  love.graphics.pop()

  drawActionBar(gameUI[1].x,realScreenHeight-(gameUI[1].height-font:getHeight()))
  drawUIWindow(8) --tutorial
  --love.graphics.print(love.timer.getFPS().." FPS")
  if string.sub(world[pl.t].fight,1,7) ~= "Gather:" and pl.score and tonumber(pl.combo) and fight.highscore and fight.highscorePlayer then
    love.graphics.setColor(0,0,0,100)
    love.graphics.rectangle("fill",0,0,rFont:getWidth("Highscore: "..tostring(fight.highscore).." (earned by "..tostring(fight.highscorePlayer)..")")+12,rFont:getHeight()*2)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(rFont)
    love.graphics.print("Score: "..tostring(pl.score).." (x"..tostring(pl.combo+1)..")\nHighscore: "..tostring(fight.highscore).." (earned by "..tostring(fight.highscorePlayer)..")",0,0)
  end

  --  love.graphics.print(xoff..", "..yoff,300,300)
end

function requestFightInfo()
  netSend("fight",pl.name..","..round(pl.x)..","..round(pl.y)..","..authcode)
  requestUserInfo()
end

function updateFight(dt)
  --addBones("Boar",pl.x,pl.y)

  for i = 1, #updateTime do
    updateTime[i] = updateTime[i] - 1*dt
  end

  if updateTime[1] < 0 then
    requestFightInfo()
    updateTime[1] = 0.25
  end

  if updateTime[2] < 0 then
    requestWorldInfo()
    requestPlayersInfo()
    updateTime[2] = 5
  end

  if updateTime[3] < 0 then
  --  requestUserInfo()
    updateTime[3] = 0.25
  end

  if updateTime[5] < 0 then
    if pl.state == "afterfight" then --we're piggy backing off of this timer so as to not have to create another
      local owedItems = atComma(pl.owed)
    xLeft = ((1920/2)/2) - ((#owedItems * 32)/2)
      for i = 1, #owedItems, 2 do
      --  if item.img[owedItems[i]] then
          if distanceFrom(pl.x+16+xoff, pl.y+16+yoff, xLeft+(i*32)+xoff,200+32+yoff) < 30 then
            netSend("claim",pl.name..","..owedItems[i])
            if string.sub(owedItems[i],1,10) == "Blueprint:" then
              newLoot(owedItems[i],1)
            end
            owedItems[i] = nil
            owedItems[i+1] = nil
            love.audio.stop(sfx["loot"])
            love.audio.play(sfx["loot"])
            updateTime[1] = 2
          end
      --  else

      --  end
      end

      pl.owed = ""
      for i = 1, #owedItems, 2 do
        if owedItems[i] and owedItems[i+1] then
          pl.owed = pl.owed..owedItems[i]..","..owedItems[i+1]..","
        end
      end

      updateTime[5] = 0.1
    end
  end

  local speed = 128*dt --change this if you want but you'll find yourself running out of stamina CONSTANTLY
  if love.keyboard.isDown(KEY_RUN) then
    speed = 256*dt
  end
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

  if love.keyboard.isDown(KEY_UP) or love.keyboard.isDown(KEY_DOWN) or love.keyboard.isDown(KEY_LEFT) or love.keyboard.isDown(KEY_RIGHT) then
      pl.en = pl.en - speed*0.15
  end


  if pl.x > stdSH-32 then pl.x = stdSH-32 end
  if pl.x < 0 then pl.x = 0 end
  if pl.y > stdSW-32 then pl.y = stdSW-32 end
  if pl.y < 0 then pl.y = 0 end


  --PLAYER LOGIC
  updatePlayers(dt,128) --move players to correct position
  updateBones(dt)

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
    if not mb.spd[mob[i].type] then mb.spd[mob[i].type] = 32 mb.rng[mob[i].type] = 40 love.window.showMessageBox("ERROR","The server spawned a mob that doesn't exist: "..mob[i].type) end
    local pls = mb.spd[mob[i].type]*dt
    if mob[i].x >  mob[i].tx then  mob[i].x =  mob[i].x - pls end
    if  mob[i].x <  mob[i].tx then  mob[i].x =  mob[i].x + pls end
    if  mob[i].y >  mob[i].ty then  mob[i].y =  mob[i].y - pls end
    if  mob[i].y <  mob[i].ty then  mob[i].y =  mob[i].y + pls end

    if distanceFrom( mob[i].x,  mob[i].y,  mob[i].tx,  mob[i].ty) > mb.spd[mob[i].type]*2 or distanceFrom( mob[i].x,  mob[i].y,  mob[i].tx,  mob[i].ty) < 1 then
       mob[i].x =  mob[i].tx
       mob[i].y =  mob[i].ty
    end

    if love.math.random(1, 100) == 1 and mb.sfx[mob[i].type] and updateTime[4] < 0 and mob[i].type ~= lastTalk and dev == false then
      local sfxPlay = mb.sfx[mob[i].type][love.math.random(1,#mb.sfx[mob[i].type])]
      sfxPlay:setPitch(love.math.random(30,200)/100)
      love.audio.play(sfxPlay)
      updateTime[4] = love.math.random(1,10)
      lastTalk = "hello world"--mob[i].type
    end

    if distanceFrom(pl.x, pl.y, mob[i].x, mob[i].y) < mb.rng[mob[i].type] and mob[i].hp > 0 then
      pl.armd = pl.armd + (mb.atk[mob[i].type]/2)*dt --for smoothing purposes
      if pl.armd < 0 then pl.armd = 0 end
     end

     if mob[i].spell1time and mob[i].spell2time then
       mob[i].spell1time = mob[i].spell1time - 1*dt
       if mob[i].spell1time < 0 then mob[i].spell1time = 0 end
       mob[i].spell2time = mob[i].spell2time - 1*dt
       if mob[i].spell2time < 0 then mob[i].spell2time = 0 end
     end
  end

  --bones
  updateTime[4] = updateTime[4] - 1*dt

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



function countMobs()
  return #mob
end

function killMob(i)
--love   addBones(getMob(i,"type"),getMob(i,"x"),getMob(i,"y"),32)
  if string.sub(mob[i].type,1,5) ~= "speak" then
    love.audio.play(sfx["kill"])
    if mob[i].hp < 2 then addBones(mob[i].type, mob[i].x, mob[i].y) end
  end
  addMob(i) --reset this mob for possible reused
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
  mob[id].type = "Spider" --this line is what causes "phantom snorts" when a speak entity is spawned
  mob[id].hp = -100
  mob[id].id = -1
end

function doesMobExist(id) --id, server id
  if mob[id] then
    return true
  else
    return false
  end
end

function findMob(a,val) --find mob by attribute
  local found = false
  for i = 1, countMobs() do
    if getMob(i,a) == val then
      local found = true
      return i
    end
  end

  if found == false then
    return false
  end
end

function updateMob(id,a,value)
  if a == "hp" and mob[id][a] > 0 then
    if value < 1 then
    --  addBones(mob[id].type, mob[id].x, mob[id].y)
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
    pl.en = pl.en - 5
    atkCooldown = 0.2
  end
end
