ft = {}
ft.t = {} --time ALSO USED FOR COUNTING NUMBER OF FIGHTS
ft.pl = {} --players, semicolon separated list
ft.mb = {} --current mobs, name;x;y;hp;target(x,y,static/playername);
ft.xp = {} --current XP pool
ft.queue = {} --mob list
ft.queue.amount = {} --mob list amount
ft.tile = {} --tile in the world the fight is taking place

function newFight(tile, fscript)
  local i = #ft.t + 1

  ft.t[i] = 0
  ft.pl[i] = ""
  ft.mb[i] = ""
  ft.xp[i] = 1
  ft.tile[i] = tile

  fightScript = atComma(fs[fscript], ";") --break down fight script, data/fights
  local v = 1
  for k = 1, #fightScript, k+2 do
    ft.queue[v] = fightScript[k]
    ft.queue.amount[v] = fightScript[k+1]
  end
end

function addPlayerToFight(fight, name)
  local id = getPlayerID(name)

  ft.pl[fight] = ft.pl[fight]..id..";" --semicolon at end to prevent repeat errors
end

function listPlayersInFight(fight)
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

function updateFights(dt) --the big one!!
  for i = 1, #ft.t do

    local mobInfo = atComma(ft.mb[i], ";") --get mob info
    local mob = {}
    mob.x = {}
    mob.y = {}
    mob.hp = {}
    mob.target = {}
    mob.target.x = {}
    mob.target.y = {}
    mob.target.t = {}

    local v = 1
    for k = 1,#mobInfo,k+5 do --break it down
      mob[v] = mobInfo[k]
      mob.x[v] = mobInfo[k+1]
      mob.y[v] = mobInfo[k+2]
      mob.hp[v] = mobInfo[k+3]
      mob.target[v] = mobInfo[k+4]

      local targetInfo = atComma(mob.target[v])
      mob.target.x[v] = tonumber(targetInfo[1])
      mob.target.y[v] = tonumber(targetInfo[2])
      mob.target.y[v] = targetInfo[3]

      v = v + 1
    end

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
    for k = 1, #playersInThisFight do
      local thisPlayer = getPlayerName(playersInThisFight[k]) --get username
      local atkInfo = atComma(pl.at[thisPlayer])
    end
  end
end
