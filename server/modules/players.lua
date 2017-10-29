require "data/level"

pl = {} --identified by username
pl.hp = {}
pl.en = {}
pl.s1 = {} --scroll 2 (q)
pl.s2 = {} --scroll 2 (e)
pl.gold = {}
pl.x = {}
pl.y = {}
pl.t = {} --tile
pl.dt = {} --dead tile (home tile)
pl.wep = {}
pl.arm = {}
pl.pot = {}
pl.inv = {} --inventory
pl.lvl = {}
pl.xp = {}
pl.at = {} --attack info. true/false
pl.atm = {} --time left before attack is no longer there
pl.msg = {} --messages separated with semicolons
pl.online = {}
pl.state = {}

acc = {} --identified by number
acc.username = {}
acc.password = {}

function newPlayer(name, password)
  acc.username[#acc.username + 1] = name
  acc.password[#acc.password + 1] = password

  local i = name
  pl.hp[i] = 10000
  pl.en[i] = 100
  pl.s1[i] = "None"
  pl.s2[i] = "None"
  pl.gold[i] = 0
  pl.x[i] = 320
  pl.y[i] = 240
  pl.t[i] = 9457 --CHANGE TO STARTING ZONE WHEN MAP IS READY <=== I've done that tyvm :)
  pl.wep[i] = "Long Stick"
  pl.arm[i] = "Old Cloth"
  pl.inv[i] = "Legendary Blade;1"
  pl.pot[i] = "Red Potion"
  pl.lvl[i] = 1
  pl.xp[i] = 0
  pl.at[i] = false
  pl.atm[i] = 0
  pl.msg[i] = "world"
  pl.online[i] = true
  pl.state[i] = "world"

  addMsg("New player by the name of "..name)
end

function updatePlayers(dt)
  for i = 1, countPlayers() do
    local k = getPlayerName(i)

    pl.atm[k] = pl.atm[k] - 1*dt
    if pl.atm[k] < 0 then pl.at[k] = false end

    pl.en[k] = pl.en[k] + 25*dt
    if pl.en[k] > 100 then pl.en[k] = 100 end
  end
end

function countPlayers()
  return #acc.username
end

function getPlayerID(name) --returns id
  for i = 1, #acc.username do
    if acc.username[i] == name then return i end
  end
end

function getPlayerName(id) --returns name
  --print("Requested user "..id..", who is "..acc.username[id])
  return acc.username[id]
end

function loginPlayer(name, password) --returns a boolean
  if acc.password[getPlayerID(name)] == password then return true else return false end
end

function givePlayerXP(name, xp)
  if pl.lvl[name] < 10 then
    pl.xp[name] = pl.xp[name] + xp

    if pl.xp[name] > lvlXP[pl.lvl[name]] then --level up
      pl.lvl[name] = pl.lvl[name] + 1
      pl.xp[name] = pl.xp[name] - lvlXP[pl.lvl[name]] --still earn XP from this reward
    end
  end
end

function givePlayerGold(name, gold)
  pl.gold[name] = pl.gold[name] + gold
end

function givePlayerItem(name, ritem, amount)
  if not amount then amount = 1 end

  curInv = atComma(pl.inv[name], ";")
  local alreadyOwned = false

  for i=1,#curInv,2 do
    curInv[i+1] = tonumber(curInv[i+1])
    if curInv[i] == ritem then curInv[i+1] = curInv[i+1] + amount alreadyOwned = true addMsg(name.." obtained another "..amount.."x "..ritem) end
  end

  if alreadyOwned == false then
    curInv[#curInv + 1] = ritem
    curInv[#curInv + 1] = amount
  --  addMsg(name.." obtained "..amount.."x "..ritem)
  end



  pl.inv[name] = ""
  --rebuild inventory string
  for i = 1, #curInv do
--    addMsg(curInv[i].." ("..i.."/"..#curInv..")")
    pl.inv[name] = pl.inv[name]..curInv[i]..";"
  --  addMsg(pl.inv[name])
  end
end

function playerUse(name, ritem)
  curInv = atComma(pl.inv[name],";")
  local hasItem = false

  rebuiltInv = {}
  local k = 1

  for i = 1, #curInv, 2 do
    curInv[i+1] = tonumber(curInv[i+1])
    if curInv[i] == ritem then --found item in inventory
      hasItem = true
      curInv[i+1] = curInv[i+1] - 1
    end

    rebuiltInv[k] = {}
    rebuiltInv[k].item = curInv[i]
    rebuiltInv[k].amount = curInv[i+1]
    k = k + 1
  end

  --use item
  if hasItem == true then
    if item.type[ritem] == "wep" then
      rebuiltInv[#rebuiltInv + 1] = {}
      rebuiltInv[#rebuiltInv].item = pl.wep[name]
      rebuiltInv[#rebuiltInv].amount = 1
      pl.wep[name] = ritem
    elseif item.type[ritem] == "arm" then
      rebuiltInv[#rebuiltInv + 1] = {}
      rebuiltInv[#rebuiltInv].item = pl.arm[name]
      rebuiltInv[#rebuiltInv].amount = 1
      pl.arm[name] = ritem
    end
  else
    addMsg(name.." tried to use an item ("..ritem..") that they don't own!")
  end

  --rebuild inventory
  pl.inv[name] = ""
  for i = 1, #rebuiltInv do
    if rebuiltInv[i].amount > 0 then
      givePlayerItem(name, rebuiltInv[i].item, rebuiltInv[i].amount)
    end
  end
end

function movePlayer(name, dir)
  local curt = pl.t[name]
  if dir == "up" then pl.t[name] = pl.t[name] - 101
  elseif dir == "down" then pl.t[name] = pl.t[name] + 101
  elseif dir == "left" then pl.t[name] = pl.t[name] - 1
  elseif dir == "right" then pl.t[name] = pl.t[name] + 1 end

  if world[pl.t[name]].collide then
    pl.t[name] = curt
  else
    if world[pl.t[name]].isFight == true then
      local fightsOnTile = listFightsOnTile(pl.t[name])
      addPlayerToFight(fightsOnTile[1],name)
    else
      local fightChance = love.math.random(1,299)
      if fightChance < world[pl.t[name]].fightc then
        world[pl.t[name]].isFight = true
        if fs[world[pl.t[name]].fight] then
          newFight(pl.t[name], world[pl.t[name]].fight)
        else
          newFight(pl.t[name], "Ghostly Haunting")
        end
        addPlayerToFight(#ft.t, name)
        addMsg(fightChance.." < "..world[pl.t[name]].fightc)
      else
          addMsg(fightChance.." > "..world[pl.t[name]].fightc)
      end
    end
  end
end

function setPlayerPos(name,x,y)
  pl.x[name] = x
  pl.y[name] = y
end

function damagePlayer(name, amount)
  pl.hp[name] = pl.hp[name] - amount
--  pl.msg[name] = pl.msg[name].."tdmg,"..amount..";" --The client could figure this out itself

  if pl.hp[name] < 1 then pl.hp[name] = 100 pl.t[name] = 9457 addMsg(name.." died!") removePlayerFromFight(name) end
end

--return info functions

function isPlayerDead(name)
  if pl.hp[name] < 1 then return true else return false end
end

function isPlayerOnline(name)
  return pl.online[name]
end

function getPlayerTile(name)
  return pl.t[name]
end

function getPlayerArmour(name)
  return pl.arm[name]
end

function getPlayerState(name)
  return pl.state[name]
end
