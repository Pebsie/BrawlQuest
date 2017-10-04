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
pl.at = {} --attack info. true/false;dir
pl.msg = {} --messages separated with semicolons

acc = {} --identified by number
acc.username = {}
acc.password = {}

function newPlayer(name, password)
  acc.username[#acc.username + 1] = name
  acc.password[#acc.password + 1] = password

  local i = name
  pl.hp[i] = 100
  pl.en[i] = 100
  pl.s1[i] = "None"
  pl.s2[i] = "None"
  pl.gold[i] = 0
  pl.x[i] = 320
  pl.y[i] = 240
  pl.t[i] = 9457 --CHANGE TO STARTING ZONE WHEN MAP IS READY <=== I've done that tyvm :) 
  pl.wep[i] = "Guardian's Blade"
  pl.arm[i] = "Legendary Padding"
  pl.inv[i] = "None"
  pl.pot[i] = "Red Potion"
  pl.lvl[i] = 1
  pl.xp[i] = 0
  pl.at[i] = "false,w"
  pl.msg[i] = "chat|Server|Welcome "..i.."!|"
  pl.online[i] = false

  addMsg("New player by the name of "..name)
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

function givePlayerItem(name, item, amount)
  if not amount then amount = 1 end

  curInv = atComma(pl.inv[name], ";")
  local alreadyOwned = false

  for i=1,#curInv,2 do
    if curInv[i] == item then curInv[i+1] = curInv[i+1] + amount alreadyOwned = true end
  end

  if alreadyOwned == false then
    curInv[#curInv + 1] = item
    curInv[#curInv + 1] = amount
  end

  pl.inv[name] = ""
  --rebuild inventory string
  for i = 1, curInv[#curInv] do
    pl.inv[name] = curInv[i]..";"
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
  end

end

function damagePlayer(name, amount)
  pl.hp[name] = pl.hp[name] - amount
  pl.msg[name] = pl.msg[name].."tdmg,"..amount..";"

  if pl.hp[name] < 1 then pl.hp[name] = 0 addMsg(name.." died!") end
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
