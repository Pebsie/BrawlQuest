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
  --  addMsg(name.." has joined fight #"..fight)
    ft.pl[fight] = ft.pl[fight]..id..";" --semicolon at end to prevent repeat errors
  end
end

function removePlayerFromFight(name)
  --step 1: find out what fight the player is in
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
  ft.done[fight] = true
  world[ft.tile[fight]].isFight = false

  local playersInFight = listPlayersInFight(fight)
  for i = 1, #playersInFight do
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
    if ft.tile[i] == tile then
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
  freshTarget = freshTarget[love.math.random(#freshTarget)]
  --print("Target is "..freshTarget)
  freshTarget = getPlayerName(tonumber(freshTarget))
  if not x then
    local side = love.math.random(1, 3)
    if side == 1 then --top
      ft.mb[fight] = ft.mb[fight]..mob..";"..love.math.random(1, stdSW)..";-129;"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"
    elseif side == 2 then --left
      ft.mb[fight] = ft.mb[fight]..mob..";-129;"..love.math.random(1, stdsH)..";"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"
    elseif side == 3 then --right
      ft.mb[fight] = ft.mb[fight]..mob..";"..(stdSW+129)..";"..love.math.random(1, stdSH)..";"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"
    end
  else
      ft.mb[fight] = ft.mb[fight]..mob..";"..x..";"..y..";"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"
  end
  --print(ft.mb[fight])
end

function countMobs(fight)
  if fight then
    return #atComma(ft.mb[fight],";")/7
  end
end

function getMobData(fight,id)
  local mob = {}
  local cid = 1
  local mobInfo = atComma(ft.mb[fight], ";") --get mob info
  for i = 1,#mobInfo,7 do
    if cid == id then
      mob.type = mobInfo[i]
      mob.x = tonumber(mobInfo[i+1])
      mob.y = tonumber(mobInfo[i+2])
      mob.hp = tonumber(mobInfo[i+3])
      mob.target = mobInfo[i+4]
      mob.spell1time = mobInfo[i+5]
      mob.spell2time = mobInfo[i+6]

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
          hasFightEnded = false

          if ft.nextSpawn[i] < 0 then
          --print("Spawning a mob")
            spawnMob(i,ft.queue[i][current])
            ft.queue.amount[i][current] = ft.queue.amount[i][current] - 1
            ft.nextSpawn[i] = fs.spawnTime[ft.title[i]]
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

      local v = 1
      --print("\n\nWe've got "..(#mobInfo/7).." mobs to cycle through!\n\n")
      for k = 1,#mobInfo,7 do --break it down

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

          --print("Mob #"..v.." is a "..mob[v].." at "..mob.x[v]..","..mob.y[v].." and "..mob.hp[v].."HP. They're targetting "..mob.target.t[v].." which is currently at "..mob.target.x[v]..","..mob.target.y[v]..". They'll be casting spell 1 in "..mob.spell1time[v].." seconds and spell 2 in "..mob.spell2time[v].." seconds.")
          v = v + 1
        else
          addMsg("\n\nTHERE WAS AN ERROR WITH MOB "..v.."!!\n\n")
        end
      end


      for v = 1,#mobInfo/7 do

        if mob.hp[v] > 0 then
          hasFightEnded = false
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
            if pl.state[mob.target.t[v]] == "fight" then
              mob.target.x[v] = pl.x[mob.target.t[v]]+16
              mob.target.y[v] = pl.y[mob.target.t[v]]+16
            else --player is dead!
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

          --take damage / give damage
          local playersInThisFight = listPlayersInFight(i)
          --print("There are "..#playersInThisFight.." players in this fight.")
          for k = 1, #playersInThisFight do
            --print("Player #"..k.." ID of "..playersInThisFight[k])
            local thisPlayer = getPlayerName(tonumber(playersInThisFight[k])) --get username
            local atkInfo = pl.at[thisPlayer]
            --addMsg(thisPlayer.." is "..tostring(atkInfo))

            if atkInfo == true then
              if distanceFrom(pl.x[thisPlayer]+16, pl.y[thisPlayer]+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 32 then
                local pdmg = item.val[pl.wep[thisPlayer]]
                mob.hp[v] = mob.hp[v] - pdmg
              --  addMsg(thisPlayer.." dealth "..pdmg.." to "..mob[v]..", who is now on "..mob.hp[v].." HP.")
                pl.msg[thisPlayer] = pl.msg[thisPlayer].."dmg,"..pdmg..","..mob.x[v]..","..mob.y[v]..";" --feedback for the player to see damage they've done
              end
            elseif distanceFrom(pl.x[thisPlayer]+16, pl.y[thisPlayer]+16, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < mb.rng[mob[v]] then --this has to be separate because of mob range
              local pdmg = (mb.atk[mob[v]]/2)*dt
              --print("A "..mob[v].." dealt "..pdmg.." damage to "..thisPlayer.."!")
              if isPlayerDead(thisPlayer) == false then
                damagePlayer(thisPlayer, pdmg)
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
              elseif string.sub(spellCast,1,6) == "spawn:" then
                spawnMob(i,string.sub(spellCast,7),mob.x[v],mob.y[v])
              end
          end
        end
        --rebuild mob string  name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
        ft.mb[i] = ft.mb[i]..mob[v]..";"..mob.x[v]..";"..mob.y[v]..";"..mob.hp[v]..";"..mob.target.x[v]..","..mob.target.y[v]..","..mob.target.t[v]..";"..mob.spell1time[v]..";"..mob.spell2time[v]..";"

      end

      if hasFightEnded == true then
        endFight(i)
      end
    end

    for k = 1, countPlayersInFight(i) do
      pl.at[getPlayerName(k)] = false
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

  return pdata
end
