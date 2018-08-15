require "data/items"
require "data/mobs"
require "data/fights"

ft = {}
ft.t = {} --time ALSO USED FOR COUNTING NUMBER OF FIGHTS
ft.pl = {} --players, semicolon separated list
ft.mb = {} --current mobs, name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
ft.xp = {} --current XP pool
ft.queue = {} --mob list
ft.queue.current = {}
ft.queue.amount = {} --mob list amount
ft.tile = {} --tile in the world the fight is taking place
ft.done = {} --Has the fight finished?
ft.nextSpawn = {}
ft.title = {} --title of fight

function newFight(tile, fscript)
  local i = #ft.t + 1

  ft.t[i] = 0
  ft.pl[i] = ""
  ft.mb[i] = ""
  ft.xp[i] = 1
  ft.tile[i] = tile
  ft.queue[i] = {}
  ft.queue.amount[i] = {}
  ft.done[i] = false
  ft.nextSpawn[i] = 1.5
  ft.title[i] = fscript

  if not fs[fscript] then fscript = "default" end
  fightScript = atComma(fs[fscript], ";") --break down fight script, data/fights
  local v = 1 --THIS IS WHERE WE'RE LEAVING THIS OFF. THIS NEEDS TO BE MADE INTO A TWO DIMENSIONAL ARRAY FOR STORING FIGHT AND CURRENT. HAVE FUN.
  for k = 1,#fightScript,2 do
    ft.queue[i][v] = fightScript[k]
    ft.queue.amount[i][v] = tonumber(fightScript[k+1])
  --  addMsg("Added "..ft.queue.amount[i][v].." "..ft.queue[i][v].." to fight #"..i)
    v = v + 1
  end
  ft.queue.current[i] = 1

--  addMsg("A new fight has started on tile #"..tile.." running script '"..fscript.."'")
end

function addPlayerToFight(fight, name)
  if findFightPlayerIsIn(name) then --check that player isn't somehow already in a fight
    addMsg(name.." tried to join a fight even though they're already in one. How odd!")
  else
    local id = getPlayerID(name)
    pl[name].state = "fight"
    pl[name].x = love.math.random(1, 800)
    pl[name].y = love.math.random(1, 600)
    pl[name].s1t = 0
    pl[name].stt = 0
    pl[name].score = 0
    pl[name].combo = 0
    --ALPHA TEMP
    if ft.title[fight] == "Shipwreck" then
      pl[name].arm_head = "Boat"
      pl[name].arm_chest = "None"
      pl[name].arm_legs = "None"
      pl[name].t = 819
    end
  --  addMsg(name.." has joined fight #"..fight)
    ft.pl[fight] = ft.pl[fight]..id..";" --semicolon at end to prevent repeat errors
  end
end

function removePlayerFromFight(name, isDead)
  --step 1: find out what fight the player is in
  pl[name].s1t = 0
  pl[name].stt = 0
  name = getPlayerID(name)

  local id = findFightPlayerIsIn(name)

  if id then

    plsif = atComma(ft.pl[id],";") --players in fight
    local ftpls = "" --fight players string

    for i = 1, #plsif do
      if tonumber(plsif[i]) ~= tonumber(name) then
        ftpls = ftpls..plsif[i]..";"
      end
    end

    ft.pl[id] = ftpls

    if not isDead then
      pl[getPlayerName(name)].state = "afterfight"
    else
      pl[getPlayerName(name)].state = "world"
    end

    if ft.title[id] == "Shipwreck" then
      pl[getPlayerName(name)].arm_head = "None"
      pl[getPlayerName(name)].arm_chest = "None"
      pl[getPlayerName(name)].arm_legs = "None"
    end
  --  addMsg(getPlayerName(name).." left fight #"..id)

    local curPlayers = listPlayersInFight(id)
    if #curPlayers < 1 then endFight(id) world[ft.tile[id]].spawned = true end
  else
    addMsg("ERROR: can't remove "..getPlayerName(name).." from the fight that they're in, as we can't find what fight it is tha they're in!")
  end
end

function endFight(fight)
  if ft.done[fight] == false then
  --  addMsg("Fight #"..fight.." ended!")
    ft.done[fight] = true
    world[ft.tile[fight]].isFight = false

    local playersInFight = listPlayersInFight(fight)
    for i = 1, #playersInFight do
      local thisPlayerName = getPlayerName(tonumber(playersInFight[i]))



     if pl[thisPlayerName].owed == "reset" then pl[thisPlayerName].owed = "" end
     rwds = atComma(fs.rewards[ft.title[fight]]) --give loot to players
     if not pl[thisPlayerName].fightsPlayed[pl[thisPlayerName].t] then
       rwdsRoll = {}
      for k = 1, #rwds, 3 do
        local trr = #rwdsRoll + 1
        rwdsRoll[trr] = love.math.random(1,99)
        if rwdsRoll[trr] < tonumber(rwds[k+2]) and  playerHasBuddy(thisPlayerName,rwds[k]) == false then
          if not playerHasBlueprint(thisPlayerName, string.sub(rwds[k],12)) then
            pl[thisPlayerName].owed = pl[thisPlayerName].owed..rwds[k]..","..tonumber(rwds[k+1]).."," --givePlayerItem(thisPlayerName,rwds[k],tonumber(rwds[k+1]))
          end
        end
      end
    end
      if hs[ft.title[fight]] then
        if pl[thisPlayerName].score > hs[ft.title[fight]].score then
          addMsg(thisPlayerName.." got a new high score for fight "..fight.."!")
          hs[ft.title[fight]].score = pl[thisPlayerName].score
          hs[ft.title[fight]].player = thisPlayerName
        end
      else
        hs[ft.title[fight]] = {}
        hs[ft.title[fight]].score = pl[thisPlayerName].score
        hs[ft.title[fight]].player = thisPlayerName
      end

      pl[thisPlayerName].fightsPlayed[pl[thisPlayerName].t] = true --set this fight to complete for today
      removePlayerFromFight(thisPlayerName)
    end
  end
end

function findFightPlayerIsIn(name)
  local fightID = -1
  for i = 1, countFights() do
    local pls = listPlayersInFight(i)
    for k = 1, #pls do
      --addMsg("Does "..tonumber(name).." = "..tonumber(pls[k]).."?") -- There was once a time when solving this particular bug would've taken me hours, but no more!!
      if tonumber(name) == tonumber(pls[k]) then fightID = i end
    end
  end

  if fightID == -1 then return nil else return fightID end
end

function listPlayersInFight(fight)
  --print("Requested list of players in fight #"..fight..", "..ft.pl[fight])
  return atComma(ft.pl[fight], ";")
end

function listFightsOnTile(tile)
  local fightsOnTile = {} --id;first player;time;

  for i = 1, #ft.t do
    if ft.tile[i] == tile and ft.done[i] == false then
      fightsOnTile[#fightsOnTile + 1] = i
    end
  end

  return fightsOnTile
end

function spawnMob(fight, mob, x, y)
    stdSW = 1920/2
    stdSH = 1080/2
     --name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
    --print("Creating mob "..mob.." in fight #"..fight)
    local freshTarget = listPlayersInFight(fight)
    if freshTarget then
      freshTarget = freshTarget[love.math.random(#freshTarget)]
      --print("Target is "..freshTarget)
      freshTarget = getPlayerName(tonumber(freshTarget))
    --  addMsg(string.sub(mob,1,5))
    if not freshTarget then freshTarget = "static" end

      if string.sub(mob,1,5) == "speak" then
        ft.mb[fight] = ft.mb[fight]..mob..";"..love.math.random(1, stdSW)..";-129;"..mb.hp["speak"]..";320,240,"..freshTarget..";"..mb.sp1t["speak"]..";"..mb.sp2t["speak"]..";"..love.math.random(1,9999)..";"
      elseif mobHasAttribute(mob,"spawnRandom") then
        ft.mb[fight] = ft.mb[fight]..mob..";"..love.math.random(100,stdSW-100)..";"..love.math.random(100,stdSH-200)..";"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"..love.math.random(1,9999)..";"
      else
        if not x and freshTarget then
          local side = love.math.random(1, 3)

          if side == 1 then --top
            ft.mb[fight] = ft.mb[fight]..mob..";"..love.math.random(1, stdSW)..";-129;"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"..love.math.random(1,9999)..";"
          elseif side == 2 then --left
            ft.mb[fight] = ft.mb[fight]..mob..";-129;"..love.math.random(1, stdsH)..";"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"..love.math.random(1,9999)..";"
          elseif side == 3 then --right
            ft.mb[fight] = ft.mb[fight]..mob..";"..(stdSW+129)..";"..love.math.random(1, stdSH)..";"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"..love.math.random(1,9999)..";"
          end
        elseif freshTarget then
          ft.mb[fight] = ft.mb[fight]..mob..";"..x..";"..y..";"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"..love.math.random(1,9999)..";"
        end
      end
    end
      return true
  --print(ft.mb[fight])
end

function countMobs(fight)
  if fight then
    return #atComma(ft.mb[fight],";")/8
  end
end

function getMobData(fight,id)
  local mob = {}
  local cid = 1
  local mobInfo = atComma(ft.mb[fight], ";") --get mob info
  for i = 1,#mobInfo,8 do
    if cid == id then
      mob.type = mobInfo[i]
      mob.x = tonumber(mobInfo[i+1])
      mob.y = tonumber(mobInfo[i+2])
      mob.hp = tonumber(mobInfo[i+3])
      mob.target = mobInfo[i+4]
      mob.spell1time = mobInfo[i+5]
      mob.spell2time = mobInfo[i+6]
      mob.id = mobInfo[i+7]

      local targetInfo = atComma(mob.target)
    --[[  mob.target = {}
      mob.target.x = tonumber(targetInfo[1])
      mob.target.y = tonumber(targetInfo[2])
      mob.target.t = targetInfo[3] ]]
    end

    cid = cid + 1
  end

  return mob
end

function countPlayersInFight(fight)
  return #listPlayersInFight(fight)
end

function updateFights(dt) --the big one!!
  --print("Updating fights...")
  for i = 1, #ft.t do
    if ft.done[i] == false then

      local hasFightEnded = true

      --print(ft.mb[i])
      --spawn new mobs
      local current = ft.queue.current[i]
      ft.nextSpawn[i] = ft.nextSpawn[i] - 1*dt
      if (ft.queue.amount[i][current]) then
        if (ft.queue.amount[i][current] > 0) then


          if ft.nextSpawn[i] < 0 and countMobs(i) < 100 then
          --print("Spawning a mob")
        --  addMsg(ft.queue[i][current])
            if spawnMob(i,ft.queue[i][current]) then

              if string.sub(ft.queue[i][current],1,5) == "speak" then
                ft.nextSpawn[i] = ft.queue.amount[i][current]--set to speak timer
                ft.queue.current[i] = ft.queue.current[i] + 1
              else
                ft.queue.amount[i][current] = ft.queue.amount[i][current] - 1
                ft.nextSpawn[i] = fs.spawnTime[ft.title[i]]
              end
            end
          end
        else
          ft.queue.current[i] = ft.queue.current[i] + 1
        end
      end

      --do mob stuff
      local mobInfo = atComma(ft.mb[i], ";") --get mob info
      ft.mb[i] = ""
      local mob = {}
      mob.x = {}
      mob.y = {}
      mob.hp = {}
      mob.target = {}
      mob.target.x = {}
      mob.target.y = {}
      mob.target.t = {}
      mob.spell1time = {}
      mob.spell2time = {}
      mob.id = {}

      local v = 1
      --print("\n\nWe've got "..(#mobInfo/7).." mobs to cycle through!\n\n")
      for k = 1,#mobInfo,8 do --break it down

        if mobInfo[k] then
          --print("Gathering information on this "..mobInfo[k])
          mob[v] = mobInfo[k]

          mob.x[v] = tonumber(mobInfo[k+1])
          mob.y[v] = tonumber(mobInfo[k+2])
          mob.hp[v] = tonumber(mobInfo[k+3])
          mob.target[v] = mobInfo[k+4]
          mob.spell1time[v] = mobInfo[k+5]
          mob.spell2time[v] = mobInfo[k+6]

          local targetInfo = atComma(mob.target[v])
          mob.target.x[v] = tonumber(targetInfo[1])
          mob.target.y[v] = tonumber(targetInfo[2])
          mob.target.t[v] = targetInfo[3]
          mob.id[v] = mobInfo[k+7]

          --print("Mob #"..v.." is a "..mob[v].." at "..mob.x[v]..","..mob.y[v].." and "..mob.hp[v].."HP. They're targetting "..mob.target.t[v].." which is currently at "..mob.target.x[v]..","..mob.target.y[v]..". They'll be casting spell 1 in "..mob.spell1time[v].." seconds and spell 2 in "..mob.spell2time[v].." seconds.")
          v = v + 1
        else
          addMsg("\n\nTHERE WAS AN ERROR WITH MOB "..v.."!!\n\n")
        end
      end

      for v = 1,#mobInfo/8 do --this mob

        if mob.hp[v] > 0 and string.sub(mob[v],1,5) ~= "speak" then --if mobs are speak mobs or dead then they don't need any logic action
          if not mb.friend[mob[v]] and mb.spd[mob[v]] ~= 0 then --entities that can't move (e.g traps) and friends don't count towards the fight ending
            hasFightEnded = false
          end
          --movement
          local width = mb.img[mob[v]]/2
          if distanceFrom(mob.x[v]+width, mob.y[v]+width, mob.target.x[v], mob.target.y[v]) > mb.rng[mob[v]] then --if we're further away from our target than our attacking range
            local speed = mb.spd[mob[v]]*dt --move towards the target
            if mob.target.x[v] > mob.x[v]+width then mob.x[v] = mob.x[v] + speed end
            if mob.target.y[v] > mob.y[v]+width then mob.y[v] = mob.y[v] + speed end
            if mob.target.x[v] < mob.x[v]+width then mob.x[v] = mob.x[v] - speed end
            if mob.target.y[v] < mob.y[v]+width then mob.y[v] = mob.y[v] - speed end
          end

          if mob.target.t[v] ~= "static" then --if our target isn't a static point
            if pl[mob.target.t[v]] and pl[mob.target.t[v]].state == "fight" and pl[mob.target.t[v]].spell ~= "Phase Shift" and mb.friend[mob[v]] == false then --if our target is in fight mode, isn't using Phase Shift (which is a de-aggro spell) and we aren't a friend
              mob.target.x[v] = pl[mob.target.t[v]].x+16 --set new x and y co-ords
              mob.target.y[v] = pl[mob.target.t[v]].y+16
            else --player is dead!
              if mb.friend[mob[v]] then --this is a friendly mob who will attack other mobs
                local curMaxHP = 1000000 --for changing targets
                local hasFoundTarget = false

                for k = 1,#mobInfo/8 do --cycle through every mob for each mob
                  if k ~= v and not mb.friend[mob[k]] and string.sub(mob[k],1,5) ~= "speak" and mob.target.t[v] ~= "spread" then --we don't want to attack ourselves nor other friends
                    --addMsg("Is "..distanceFrom(mob.x[k], mob.y[k], mob.x[v], mob.y[v]).." < "..curMaxDist)
                    if curMaxHP > mob.hp[k] then
                      mob.target.x[v] = mob.x[k]+mb.img[mob[k]]/2
                      mob.target.y[v] = mob.y[k]+mb.img[mob[k]]/2
                      mob.target.t[v] = "mob"
                    --  addMsg("Mob #"..v.." switched target.")
                      hasFoundTarget = true
                      curMaxHP = mob.hp[k]
                    end
                  end

                   if distanceFrom(mob.x[k], mob.y[k], mob.x[v], mob.y[v]) < mb.rng[mob[v]] and mob.target.t[v] == "mob" and k ~= v and not mb.friend[mob[k]] then
                     mob.hp[k] = mob.hp[k] - mb.atk[mob[v]]*dt
                     mob.hp[v] = mob.hp[v] - mb.atk[mob[k]]*dt
                      if not mb.friend[mob[k]] and love.math.random(1,10) == 1 then
                        mob.target.t[v] = "spread"
                        mob.target.x[v] = mob.x[v] + love.math.random(-50,50)
                        mob.target.y[v] = mob.y[v] + love.math.random(-50,50)
                        hasFoundTarget = false
                      end
                    end
                end

                if hasFoundTarget == false and mob.target.t[v] ~= "rnd" then
                  mob.target.x[v] = love.math.random(1, stdSW)
                  mob.target.y[v] = love.math.random(1, stdSH)
                  mob.target.t[v] = "rnd"
                elseif mob.target.t[v] == "rnd" and distanceFrom(mob.target.x[v],mob.target.y[v],mob.x[v],mob.y[v]) < 128 and love.math.random(1,10000) == 1 then
                  mob.target.t[v] = "unset" --this will reset targetting
                elseif mob.target.t[v] == "spread" then

                end
              else
                local freshTarget = listPlayersInFight(i)
                freshTarget = freshTarget[love.math.random(#freshTarget)]

                freshTarget = getPlayerName(tonumber(freshTarget))
                if freshTarget then
                  mob.target.t[v] = freshTarget
                  mob.target.x[v] = pl[mob.target.t[v]].x+16
                  mob.target.y[v] = pl[mob.target.t[v]].y+16
                end
              end
            end
          end

          --take damage / give damage
          local playersInThisFight = listPlayersInFight(i)
          --print("There are "..#playersInThisFight.." players in this fight.")
          for k = 1, #playersInThisFight do --cycle through plkayers
            --print("Player #"..k.." ID of "..playersInThisFight[k])
            local thisPlayer = getPlayerName(tonumber(playersInThisFight[k])) --get username
            local atkInfo = pl[thisPlayer].at
            --addMsg(thisPlayer.." is "..tostring(atkInfo))

            if tostring(atkInfo) == "true" then
              if distanceFrom(pl[thisPlayer].x+16, pl[thisPlayer].y+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < mb.img[mob[v]] and not mb.friend[mob[v]] then
                local pdmg = item.val[pl[thisPlayer].wep] + pl[thisPlayer].str
                mob.hp[v] = mob.hp[v] - pdmg
                pl[thisPlayer].score = pl[thisPlayer].score + (pdmg*(round(pl[thisPlayer].combo)+1))/item.val[pl[thisPlayer].wep]
                if mob.hp[v] < 1 then pl[thisPlayer].kills = pl[thisPlayer].kills + 1 pl[thisPlayer].combo = pl[thisPlayer].combo + 1.1 end

              end
            elseif distanceFrom(pl[thisPlayer].x+16, pl[thisPlayer].y+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < mb.rng[mob[v]] and not mb.friend[mob[v]] then --this has to be separate because of mob range
              local pdmg = (mb.atk[mob[v]]/2)*dt
          --    if love.math.random(1,250) == 1 then inflictAspect(thisPlayer,"Bleeding") end
              --print("A "..mob[v].." dealt "..pdmg.." damage to "..thisPlayer.."!")
              if isPlayerDead(thisPlayer) == false then
                damagePlayer(thisPlayer, pdmg)
              end
            end

            if pl[thisPlayer].spell == "Enrage" then
              if distanceFrom(pl[thisPlayer].x+16, pl[thisPlayer].y+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 320 then
                mob.target.t[v] = thisPlayer
                mob.target.x[v] = pl[mob.target.t[v]].x+16
                mob.target.y[v] = pl[mob.target.t[v]].y+16
              end
            elseif pl[thisPlayer].spell == "Slam" then
              if distanceFrom(pl[thisPlayer].x+16, pl[thisPlayer].y+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 32*5 then
                mob.hp[v] = mob.hp[v] - (item.val[pl[thisPlayer].wep]*16)*dt
              end
            elseif pl[thisPlayer].spell == "Polymorph" then
              if distanceFrom(pl[thisPlayer].x+16, pl[thisPlayer].y+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 32*3 and item.val[pl[thisPlayer].wep]+1 > mob.hp[v] then
                mob.hp[v] = 0
                spawnMob(i, "Angry Chicken", mob.x[v], mob.y[v])
              end
            end
          end

            --spell casting
            mob.spell1time[v] = mob.spell1time[v] - 1*dt
            mob.spell2time[v] = mob.spell2time[v] - 1*dt
            local isCast = false
            local spellCast = ""

            if (mob.spell1time[v] < 0) then
              if string.sub(mb.sp1[mob[v]],1,7) == "doOnce:" then
                mob.spell1time[v] = 9999999
                spellCast = string.sub(mb.sp1[mob[v]],8)
              else
                mob.spell1time[v] = mb.sp1t[mob[v]]
                spellCast = mb.sp1[mob[v]]
              end
              isCast = true
            elseif (mob.spell2time[v] < 0) then
              if string.sub(mb.sp2[mob[v]],1,7) == "doOnce:" then
                mob.spell2time[v] = 9999999
                spellCast = string.sub(mb.sp2[mob[v]],8)
              else
                mob.spell2time[v] = mb.sp2t[mob[v]]
                spellCast = mb.sp2[mob[v]]
              end
              isCast = true
            end

              --cast spell here
              --mb.sp2[tm] = "stat;hp;6000;evolve,Red Dragon"
            if string.sub(spellCast,1,5) == "stat;" then --this must come first so that we don't have to write a different version of each spell for a stat cast result
              local statCast = atComma(spellCast,";")

              if statCast[2] == "hp" then
                if tonumber(statCast[3]) >= mob.hp[v] then
                  spellCast = statCast[4]
                end
              end
            end

              if spellCast == "suicide" then
                mob.hp[v] = 0
              elseif string.sub(spellCast,1,6) == "spawn:" or string.sub(spellCast,1,6) == "spawn," then
                if string.sub(spellCast,7) == "randomMob" then
                  spawnMob(i,mobSet[love.math.random(1,#mobSet)],mob.x[v],mob.y[v])
                else
                  spawnMob(i,string.sub(spellCast,7),mob.x[v],mob.y[v])
                end
              elseif string.sub(spellCast,1,7) == "evolve," then
                spawnMob(i,string.sub(spellCast,8),mob.x[v],mob.y[v])
                mob.hp[v] = 0
              elseif string.sub(spellCast,1,10) == "spawnFeet," then
                for k = 1, #playersInThisFight do
                  local thisPlayer = getPlayerName(tonumber(playersInThisFight[k]))
                  spawnMob(i,string.sub(spellCast,11),pl[thisPlayer].x,pl[thisPlayer].y)
                end
              elseif string.sub(spellCast,1,12) == "spawnRandom," then
                spawnMob(i,string.sub(spellCast,13),love.math.random(1, stdSW),love.math.random(1,stdSH))
              elseif string.sub(spellCast,1,4) == "dmg," then
                for k = 1, #playersInThisFight do --cycle through plkayers
                  --print("Player #"..k.." ID of "..playersInThisFight[k])
                  local thisPlayer = getPlayerName(tonumber(playersInThisFight[k])) --get username
                  damagePlayer(thisPlayer,love.math.random(1,tonumber(string.sub(spellCast,5))))
                end
              end
        elseif string.sub(mob[v],1,5) == "speak" then
          hasFightEnded = false
          mob.spell1time[v] = mob.spell1time[v] - 1*dt
          if mob.spell1time[v] < 0 then mob.hp[v] = 0 end
        end
        --rebuild mob string  name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
        if mob.hp[v] > 0 then
          ft.mb[i] = ft.mb[i]..mob[v]..";"..mob.x[v]..";"..mob.y[v]..";"..mob.hp[v]..";"..mob.target.x[v]..","..mob.target.y[v]..","..mob.target.t[v]..";"..mob.spell1time[v]..";"..mob.spell2time[v]..";"..mob.id[v]..";"
        end

      end

      for v = 1, #listPlayersInFight(i) do
        local thisPlayer = getPlayerName(v)
        pl[thisPlayer].at = false
        pl[thisPlayer].combo = pl[thisPlayer].combo - 1*dt
        if pl[thisPlayer].combo < 0 then pl[thisPlayer].combo = 0 end
        if string.sub(pl[thisPlayer].spell,1,7) == "Summon " then
          for k = 1, tonumber(string.sub(pl[thisPlayer].spell,8,8)) do
            spawnMob(i,string.sub(pl[thisPlayer].spell,10),pl[thisPlayer].x + love.math.random(-64,64), pl[thisPlayer].y + love.math.random(-64,64))
          end

          pl[thisPlayer].spell = "None"
          pl[thisPlayer].spellT = 0
        end
      end
      if hasFightEnded == true and ft.queue.current[i] > #ft.queue[i] and ft.nextSpawn[i] < 0 then
        endFight(i)
      end

    end
  end --fight loop end
end --function end

function countFights()
  return #ft.t
end

function getPlayerData(fight, id)
  local playersInThisFight = listPlayersInFight(fight)
  local thisPlayer = getPlayerName(tonumber(playersInThisFight[id])) --get username
  pl[thisPlayer].name = thisPlayer
  return pl[thisPlayer]
end

function getFirstMob(fscript)
  local firstMob = "unknown"
  if fs[fscript] then
    fightScript = atComma(fs[fscript], ";") --break down fight script, data/fights
    local k = 1
    while firstMob == "unknown" do
      if string.sub(fightScript[k],1,5) ~= "speak" then
        firstMob = fightScript[k]
      else
        k = k + 2
      end
    end
  end

  return firstMob
end
