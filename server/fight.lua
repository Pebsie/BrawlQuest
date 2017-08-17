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

function newFight(tile, fscript)
  local i = #ft.t + 1

  ft.t[i] = 0
  ft.pl[i] = ""
  ft.mb[i] = "Boar;5;1;1;0,0,static;1;1;"
  ft.xp[i] = 1
  ft.tile[i] = tile

  fightScript = atComma(fs[fscript], ";") --break down fight script, data/fights
  local v = 1
  for k = 1, #fightScript,2 do
    ft.queue[v] = fightScript[k]
    ft.queue.current[v] = 1
    ft.queue.amount[v] = tonumber(fightScript[k+1])
    v = v + 1
  end

  print("A new fight has started on tile #"..tile.." running script '"..fscript.."'")
end

function addPlayerToFight(fight, name)
  local id = getPlayerID(name)
  print(name.." has joined fight #"..fight)
  ft.pl[fight] = ft.pl[fight]..id..";" --semicolon at end to prevent repeat errors
end

function listPlayersInFight(fight)
  print("Requested list of players in fight #"..fight..", "..ft.pl[fight])
  return atComma(ft.pl[fight], ";")
end

function listFightsOnTile(tile)
  local fightsOnTile = {} --id;first player;time;

  for i = 1, #ft.t do
    if ft.tile[i] == tile then
      fightsOnTile[#fightsonTile + 1] = i..";"..ft.pl[i]..";"..ft.t[i]..";"
    end
  end

  return fightsOnTile
end

function spawnMob(fight, mob) --name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
  print("Creating mob "..mob.." in fight #"..fight)
  ft.mb[fight] = ft.mb[fight]..mob..";0;0;320,240,static;"..mb.sp1t[mob]..";"..mb.sp2t[mob]
end

function updateFights(dt) --the big one!!
  print("Updating fights...")
  for i = 1, #ft.t do
    --spawn new mobs
    local current = ft.queue.current[i]
    if (ft.queue.amount[current]) then
      if (ft.queue.amount[current] > 0) then

        --if love.math.random(100) == 1 then
        print("Spawning a mob")
          spawnMob(i,ft.queue[current])
          ft.queue.amount[current] = ft.queue.amount[current] - 1
        --end
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

    for v = 1,(#mobInfo/7) do
      for k = 1,(#mobInfo/7),7 do --break it down

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

        print("Mob #"..v.." is a "..mob[v].." at "..mob.x[v]..","..mob.y[v].." and "..mob.hp[v].."HP. They're targetting "..mob.target.t[v].." which is currently at "..mob.target.x[v]..","..mob.target.y[v]..". They'll be casting spell 1 in "..mob.spell1time[v].." seconds and spell 2 in "..mob.spell2time[v].." seconds.")
      end

      --movement
      print(mob[v])
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
      print("There are "..#playersInThisFight.." players in this fight.")
      for k = 1, #playersInThisFight do
        print("Player #"..k.." ID of "..playersInThisFight[k])
        local thisPlayer = getPlayerName(tonumber(playersInThisFight[k])) --get username
        local atkInfo = pl.at[thisPlayer]

        if atkInfo == "true" then
          if distanceFrom(pl.x[thisPlayer]+8, pl.y[thisPlayer]+8, mob.x[v]+(mb.img[mob[v]]:getWidth()/2), mob.y[v]+(mb.img[mob[v]]:getHeight()/2)) < 20 then
            local pdmg = love.math.random(0, item.val[pl.wep])
            mob.hp[v] = mob.hp[v] - pdmg
            pl.msg[thisPlayer] = pl.msg[thisPlayer].."dmg,"..pdmg..","..mob.x[v]..","..mob.y[v]..";" --feedback for the player to see damage they've done
          end
        elseif distanceFrom(pl.x[thisPlayer]+8, pl.y[thisPlayer]+8, mob.x[v]+(mb.img[mob[v]]:getWidth()/2), mob.y[v]+(mb.img[mob[v]]:getHeight()/2)) < mb.rng[mob[v]] then --this has to be separate because of mob range
          local pdmg = love.math.random(mb.atk[mob[v]])*dt
          damagePlayer(thisPlayer, pdmg)
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

        --rebuild mob string  name;x;y;hp;target(x,y,static/playername);mb1st;mb2st;
        ft.mb[i] = ft.mb[i]..mob[v]..";"..mob.x[v]..";"..mob.y[v]..";"..mob.hp[v]..";"..mob.target.x[v]..","..mob.target.y[v]..","..mob.target.t[v]..";"..mob.spell1time[v]..";"..mob.spell2time[v]..";"

      end
    end
  end
end
