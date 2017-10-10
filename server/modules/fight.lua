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

  fightScript = atComma(fs[fscript], ";") --break down fight script, data/fights
  local v = 1 --THIS IS WHERE WE'RE LEAVING THIS OFF. THIS NEEDS TO BE MADE INTO A TWO DIMENSIONAL ARRAY FOR STORING FIGHT AND CURRENT. HAVE FUN.
  for k = 1,(#fightScript/2),2 do
    ft.queue[i][v] = fightScript[k]
    ft.queue.amount[i][v] = tonumber(fightScript[k+1])
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
    addMsg(name.." has joined fight #"..fight)
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
    addMsg(getPlayerName(name).." left fight #"..id)

    local curPlayers = listPlayersInFight(id)
    if #curPlayers < 1 then endFight(id) addMsg("Fight #"..id.." has officially ended.") end
  else
    addMsg("ERROR: can't remove "..getPlayerName(name).." from the fight that they're in, as we can't find what fight it is tha they're in!")
  end
end

function endFight(fight)
  ft.done[fight] = true
  world[ft.tile[fight]].isFight = false
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

function spawnMob(fight, mob) --name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
  --print("Creating mob "..mob.." in fight #"..fight)
  local freshTarget = listPlayersInFight(fight)
  freshTarget = freshTarget[love.math.random(#freshTarget)]
  --print("Target is "..freshTarget)
  freshTarget = getPlayerName(tonumber(freshTarget))
  ft.mb[fight] = ft.mb[fight]..mob..";0;0;"..mb.hp[mob]..";320,240,"..freshTarget..";"..mb.sp1t[mob]..";"..mb.sp2t[mob]..";"
  --print(ft.mb[fight])
end

function countMobs(fight)
  return atComma(ft.mb[i],";")/7
end

function countPlayersInFight(fight)
  return #listPlayersInFight(fight)
end

function updateFights(dt) --the big one!!
  --print("Updating fights...")
  for i = 1, #ft.t do
    if ft.done[i] == false then
      --print(ft.mb[i])
      --spawn new mobs
      local current = ft.queue.current[i]
      if (ft.queue.amount[i][current]) then
        if (ft.queue.amount[i][current] > 0) then

          if love.math.random(100) == 1 then
          --print("Spawning a mob")
            spawnMob(i,ft.queue[i][current])
            ft.queue.amount[i][current] = ft.queue.amount[i][current] - 1
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


        --movement
        local speed = mb.spd[mob[v]]*dt

        if mob.target.x[v] > mob.x[v] then mob.x[v] = mob.x[v] + speed end
        if mob.target.y[v] > mob.y[v] then mob.y[v] = mob.y[v] + speed end
        if mob.target.x[v] < mob.x[v] then mob.x[v] = mob.x[v] - speed end
        if mob.target.y[v] < mob.y[v] then mob.y[v] = mob.y[v] - speed end

        if mob.target.t[v] ~= "static" then
          mob.target.x[v] = pl.x[mob.target.t[v]]
          mob.target.y[v] = pl.y[mob.target.t[v]]
        end

        --take damage / give damage
        local playersInThisFight = listPlayersInFight(i)
        --print("There are "..#playersInThisFight.." players in this fight.")
        for k = 1, #playersInThisFight do
          --print("Player #"..k.." ID of "..playersInThisFight[k])
          local thisPlayer = getPlayerName(tonumber(playersInThisFight[k])) --get username
          local atkInfo = pl.at[thisPlayer]

          if atkInfo == "true" then
            if distanceFrom(pl.x[thisPlayer]+8, pl.y[thisPlayer]+8, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < 20 then
              local pdmg = love.math.random(0, item.val[pl.wep])
              mob.hp[v] = mob.hp[v] - pdmg
              pl.msg[thisPlayer] = pl.msg[thisPlayer].."dmg,"..pdmg..","..mob.x[v]..","..mob.y[v]..";" --feedback for the player to see damage they've done
            end
          elseif distanceFrom(pl.x[thisPlayer]+8, pl.y[thisPlayer]+8, mob.x[v]+(mb.img[mob[v]]/2), mob.y[v]+(mb.img[mob[v]]/2)) < mb.rng[mob[v]] then --this has to be separate because of mob range
            local pdmg = love.math.random(mb.atk[mob[v]])*dt
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
            if spellCast == "die" then
              killMob(v)
            end
        end
        --rebuild mob string  name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
        ft.mb[i] = ft.mb[i]..mob[v]..";"..mob.x[v]..";"..mob.y[v]..";"..mob.hp[v]..";"..mob.target.x[v]..","..mob.target.y[v]..","..mob.target.t[v]..";"..mob.spell1time[v]..";"..mob.spell2time[v]..";"

      end
    end
  end
end

function countFights()
  return #ft.t
end

function getPlayerData(fight, id)
  local playersInThisFight = listPlayersInFight(i)
  local thisPlayer = getPlayerName(tonumber(playersInThisFight[id])) --get username
  pdata = {}
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

  return pdata
end
