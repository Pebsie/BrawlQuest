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

  fightScript = atComma(fs[fscript], ";") --break down fight script, data/fights
  local v = 1 --THIS IS WHERE WE'RE LEAVING THIS OFF. THIS NEEDS TO BE MADE INTO A TWO DIMENSIONAL ARRAY FOR STORING FIGHT AND CURRENT. HAVE FUN.
  for k = 1,#fightScript,2 do
    ft.queue[i][v] = fightScript[k]
    ft.queue.amount[i][v] = tonumber(fightScript[k+1])
  --  addMsg("Added "..ft.queue.amount[i][v].." "..ft.queue[i][v].." to fight #"..i)
    v = v + 1
  end
  ft.queue.current[i] = 1

  addMsg("A new fight has started on tile #"..tile.." running script '"..fscript.."'")
end

function addPlayerToFight(fight, name)
  if findFightPlayerIsIn(name) then --check that player isn't somehow already in a fight
    addMsg(name.." tried to join a fight even though they're already in one. How odd!")
  else
    local id = getPlayerID(name)
    pl.state[name] = "fight"
    pl.x[name] = love.math.random(1, 800)
    pl.y[name] = love.math.random(1, 600)
    pl.s1t[name] = 0
    pl.s2t[name] = 0
  --  addMsg(name.." has joined fight #"..fight)
    ft.pl[fight] = ft.pl[fight]..id..";" --semicolon at end to prevent repeat errors
  end
end

function removePlayerFromFight(name)
  --step 1: find out what fight the player is in
  pl.s1t[name] = 0
  pl.s2t[name] = 0
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
    pl.state[getPlayerName(name)] = "world"
  --  addMsg(getPlayerName(name).." left fight #"..id)

    local curPlayers = listPlayersInFight(id)
    if #curPlayers < 1 then endFight(id) end
  else
    addMsg("ERROR: can't remove "..getPlayerName(name).." from the fight that they're in, as we can't find what fight it is tha they're in!")
  end
end

function endFight(fight)
  addMsg("Fight #"..fight.." ended!")
  ft.done[fight] = true
  world[ft.tile[fight]].isFight = false

  local playersInFight = listPlayersInFight(fight)
  for i = 1, #playersInFight do
    local thisPlayerName = getPlayerName(tonumber(playersInFight[i]))
  --  pl.msg[thisPlayerName] = ""
   rwds = atComma(fs.rewards[ft.title[fight]]) --give loot to players
   if not pl.fightsPlayed[thisPlayerName][pl.t[thisPlayerName]] then
     rwdsRoll = {}
    for k = 1, #rwds, 3 do
      local trr = #rwdsRoll + 1
      rwdsRoll[trr] = love.math.random(1,100)
      if rwdsRoll[trr] < tonumber(rwds[k+2]) then
        givePlayerItem(getPlayerName(tonumber(playersInFight[i])),rwds[k],tonumber(rwds[k+1]))
      end
      --pl.msg = rwdsRoll[trr].."% / "..rwds[k+2].."\n"
    end
  end

    pl.fightsPlayed[getPlayerName(tonumber(playersInFight[i]))][pl.t[getPlayerName(tonumber(playersInFight[i]))]] = true --set this fight to complete for today

    removePlayerFromFight(getPlayerName(tonumber(playersInFight[i])))
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
      if string.sub(mob,1,5) == "speak" then
        ft.mb[fight] = ft.mb[fight]..mob..";"..love.math.random(1, stdSW)..";-129;"..mb.hp["speak"]..";320,240,"..freshTarget..";"..mb.sp1t["speak"]..";"..mb.sp2t["speak"]..";"..love.math.random(1,9999)..";"
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

        if mob.hp[v] > 0 and string.sub(mob[v],1,5) ~= "speak"  then
          if not mb.friend[mob[v]] and mb.spd[mob[v]] ~= 0 then
            hasFightEnded = false
          end
          --movement
          local width = mb.img[mob[v]]/2
          if distanceFrom(mob.x[v]+width, mob.y[v]+width, mob.target.x[v], mob.target.y[v]) > mb.rng[mob[v]] then
            local speed = mb.spd[mob[v]]*dt
            if mob.target.x[v] > mob.x[v]+width then mob.x[v] = mob.x[v] + speed end
            if mob.target.y[v] > mob.y[v]+width then mob.y[v] = mob.y[v] + speed end
            if mob.target.x[v] < mob.x[v]+width then mob.x[v] = mob.x[v] - speed end
            if mob.target.y[v] < mob.y[v]+width then mob.y[v] = mob.y[v] - speed end
          end

          if mob.target.t[v] ~= "static" then
            if pl.state[mob.target.t[v]] == "fight" and pl.spell[mob.target.t[v]] ~= "Phase Shift" and mb.friend[mob[v]] == false then
              mob.target.x[v] = pl.x[mob.target.t[v]]+16
              mob.target.y[v] = pl.y[mob.target.t[v]]+16
            else --player is dead!
              if mb.friend[mob[v]] then --this is a friendly mob who will attack other mobs
                local curMaxDist = 1000 --for changing targets
                for k = 1,#mobInfo/8 do
                  if k ~= v and not mb.friend[mob[k]] and string.sub(mob[k],1,5) ~= "speak" then --we don't want to attack ourselves nor other friends
                    --addMsg("Is "..distanceFrom(mob.x[k], mob.y[k], mob.x[v], mob.y[v]).." < "..curMaxDist)
                    if curMaxDist > distanceFrom(mob.x[k], mob.y[k], mob.x[v], mob.y[v]) then
                      mob.target.x[v] = mob.x[k]+mb.img[mob[k]]/2
                      mob.target.y[v] = mob.y[k]+mb.img[mob[k]]/2
                    --  addMsg("Mob #"..v.." switched target.")
                      curMaxDist = distanceFrom(mob.x[k], mob.y[k], mob.x[v], mob.y[v])
                    end

                    if distanceFrom(mob.x[k], mob.y[k], mob.x[v], mob.y[v]) < mb.rng[mob[v]] then
                      mob.hp[k] = mob.hp[k] - mb.atk[mob[v]]*dt
                      mob.hp[v] = mob.hp[v] - mb.atk[mob[k]]*dt
                    end
                  end
                end
              else
                local freshTarget = listPlayersInFight(i)
                freshTarget = freshTarget[love.math.random(#freshTarget)]

                freshTarget = getPlayerName(tonumber(freshTarget))
                if freshTarget then
                  mob.target.t[v] = freshTarget
                  mob.target.x[v] = pl.x[mob.target.t[v]]+16
                  mob.target.y[v] = pl.y[mob.target.t[v]]+16
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
            local atkInfo = pl.at[thisPlayer]
            --addMsg(thisPlayer.." is "..tostring(atkInfo))

            if tostring(atkInfo) == "true" then
              if distanceFrom(pl.x[thisPlayer]+16, pl.y[thisPlayer]+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < mb.img[mob[v]] and not mb.friend[mob[v]] then
                local pdmg = item.val[pl.wep[thisPlayer]] + pl.str[thisPlayer]
                mob.hp[v] = mob.hp[v] - pdmg
                if mob.hp[v] < 0 then pl.kills[thisPlayer] = pl.kills[thisPlayer] + 1 end
              --  addMsg(thisPlayer.." dealth "..pdmg.." to "..mob[v]..", who is now on "..mob.hp[v].." HP.")
              --  pl.msg[thisPlayer] = pl.msg[thisPlayer].."dmg,"..pdmg..","..mob.x[v]..","..mob.y[v]..";" --feedback for the player to see damage they've done
              end
            elseif distanceFrom(pl.x[thisPlayer]+16, pl.y[thisPlayer]+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < mb.rng[mob[v]] and not mb.friend[mob[v]] then --this has to be separate because of mob range
              local pdmg = (mb.atk[mob[v]]/2)*dt
              --print("A "..mob[v].." dealt "..pdmg.." damage to "..thisPlayer.."!")
              if isPlayerDead(thisPlayer) == false then
                damagePlayer(thisPlayer, pdmg)
              end
            end

            if pl.spell[thisPlayer] == "Enrage" then
              if distanceFrom(pl.x[thisPlayer]+16, pl.y[thisPlayer]+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 320 then
                mob.target.t[v] = thisPlayer
                mob.target.x[v] = pl.x[mob.target.t[v]]+16
                mob.target.y[v] = pl.y[mob.target.t[v]]+16
              end
            elseif pl.spell[thisPlayer] == "Slam" then
              if distanceFrom(pl.x[thisPlayer]+16, pl.y[thisPlayer]+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 32*5 then
                mob.hp[v] = mob.hp[v] - (item.val[pl.wep[thisPlayer]]*4)*dt
              end
            elseif pl.spell[thisPlayer] == "Polymorph" then
              if distanceFrom(pl.x[thisPlayer]+16, pl.y[thisPlayer]+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 32*3 and item.val[pl.wep[thisPlayer]]+1 > mob.hp[v] then
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
              mob.spell1time[v] = mb.sp1t[mob[v]]
              isCast = true
              spellCast = mb.sp1[mob[v]]
            elseif (mob.spell2time[v] < 0) then
              mob.spell2time[v] = mb.sp2t[mob[v]]
              isCast = true
              spellCast = mb.sp2[mob[v]]
            end

              --cast spell here
              if spellCast == "suicide" then
                mob.hp[v] = 0
              elseif string.sub(spellCast,1,6) == "spawn:" or string.sub(spellCast,1,6) == "spawn," then
                spawnMob(i,string.sub(spellCast,7),mob.x[v],mob.y[v])
              elseif string.sub(spellCast,1,10) == "spawnFeet," then
                for k = 1, #playersInThisFight do
                  local thisPlayer = getPlayerName(tonumber(playersInThisFight[k]))
                  spawnMob(i,string.sub(spellCast,11),pl.x[thisPlayer],pl.y[thisPlayer])
                end
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
        pl.at[getPlayerName(v)] = false
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
  --addMsg("Getting data for "..thisPlayer)
  pdata = {}
  pdata["name"] = thisPlayer
  pdata["hp"] = pl.hp[thisPlayer]
  pdata["en"] = pl.en[thisPlayer]
  pdata["s1"] = pl.s1[thisPlayer]
  pdata["s2"] = pl.s2[thisPlayer]
  pdata["x"] = pl.x[thisPlayer]
  pdata["y"] = pl.y[thisPlayer]
  pdata["t"] = pl.t[thisPlayer]
  pdata["wep"] = pl.wep[thisPlayer]
  pdata["arm"] = pl.arm[thisPlayer]
  pdata["lvl"] = pl.lvl[thisPlayer]
  pdata["at"] = pl.at[thisPlayer]
  pdata["online"] = pl.online[thisPlayer]
  pdata["spell"] = pl.spell[thisPlayer]
  pdata["bud"] = pl.bud[thisPlayer]

  return pdata
end
