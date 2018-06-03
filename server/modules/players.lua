require "data/level"

pl = {} --identified by username
pl.hp = {}
pl.en = {}
pl.s1 = {} --scroll 2 (q)
pl.s1t = {}
pl.s2 = {} --scroll 2 (e)
pl.s2t = {}
pl.gold = {}
pl.x = {}
pl.y = {}
pl.t = {} --tile
pl.dt = {} --dead tile (home tile)
pl.wep = {}
pl.arm = {}
pl.armd = {}
pl.bud = {}
pl.pot = {}
pl.inv = {} --inventory
pl.lvl = {}
pl.xp = {}
pl.at = {} --attack info. true/false
pl.atm = {} --time left before attack is no longer there
pl.str = {} --strength
pl.msg = {} --messages separated with semicolons
pl.online = {}
pl.state = {}
pl.spell = {}
pl.spellT = {}
pl.timeout = {}
pl.playtime = {}
pl.kills = {}
pl.deaths = {}
pl.distance = {}
pl.lastEquip = {}
pl.fightsPlayed = {}
pl.lastLogin = {}
pl.owed = {} --what items are owed to the player (for the post-fight section)
pl.score = {} --this is reset at the start of each fight and represents the player's score for the last fight
pl.combo = {} --this is the players current combo
pl.aspects = {}

acc = {} --identified by number
acc.username = {}
acc.password = {}

chat = {}

function newPlayer(name, password)
  acc.username[#acc.username + 1] = name
  acc.password[#acc.password + 1] = password

  local i = name
  pl.hp[i] = 100
  pl.en[i] = 100
  pl.s1[i] = "None"
  pl.s1t[i] = 0
  pl.s2[i] = "None"
  pl.s2t[i] = 0
  pl.gold[i] = 0
  pl.x[i] = 320
  pl.y[i] = 240
  pl.t[i] = 805 --CHANGE TO STARTING ZONE WHEN MAP IS READY <=== I've done that tyvm :)
  pl.dt[i] = 1942
  pl.wep[i] = "Long Stick"
  pl.arm[i] = "Legendary Padding"
  pl.armd[i] = 0
  pl.inv[i] = "A letter addressed to you;1"
  pl.pot[i] = "None"
  pl.lvl[i] = 1
  pl.xp[i] = 0
  pl.at[i] = false
  pl.atm[i] = 0
  pl.msg[i] = "world"
  pl.online[i] = true
  pl.state[i] = "world"
  pl.spell[i] = "None"
  pl.spellT[i] = 0
  pl.timeout[i] = 0
  pl.bud[i] = "None"
  pl.playtime[i] = 0
  pl.kills[i] = 0
  pl.deaths[i] = 0
  pl.distance[i] = 0
  pl.lastEquip[i] = 0
  pl.fightsPlayed[i] = {}
  pl.str[i] = 0
  pl.lastLogin[i] = 0
  pl.owed[i] = "reset"
  pl.score[i] = 0
  pl.combo[i] = 0
  pl.aspects[i] = {}


  addMsg("New player by the name of "..name)
end

function updatePlayers(dt)

  for i = 1, countPlayers() do
    local k = getPlayerName(i)

    pl.atm[k] = pl.atm[k] - 1*dt
    if pl.atm[k] < 0 then pl.at[k] = false end

    pl.en[k] = pl.en[k] + 25*dt
    if pl.en[k] > 100 then pl.en[k] = 100 end

    if pl.spellT[k] then
      pl.spellT[k] = pl.spellT[k] - 1*dt
      if pl.spellT[k] < 0 then pl.spell[k] = "None" end
    else
      pl.spellT[k] = 1
    end

    if item.type[pl.spell[k]] == "hp" then
      pl.hp[k] = pl.hp[k] + (item.val[pl.spell[k]]/3)*dt
    end

    pl.armd[k] = pl.armd[k] - 1*dt
    if pl.armd[k] <0 then pl.armd[k] = 0 end

    pl.s1t[k] = pl.s1t[k] - 1*dt
    pl.s2t[k] = pl.s2t[k] - 1*dt

    if pl.spell[k] == "Recovery" then
      pl.hp[k] = pl.hp[k] + 1000*dt --increase by 10% per second
    end

    if pl.hp[k] > 100 then pl.hp[k] = 100 end
    pl.at[k] = false

    if pl.timeout[k] > 0 then
      pl.playtime[k] = pl.playtime[k] + 1*dt
    end

    pl.timeout[k] = pl.timeout[k] - 1*dt

    for i, v in pairs(pl.aspects[k]) do
      if v == "Bleeding" then
        damagePlayer(k,2*dt)
      end
      if aspect[v].antidote() then pl.aspects[k][i] = nil  end
    end
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
  --pl.gold[name] = pl.gold[name] + tonumber(gold)
  givePlayerItem(name,"Gold",gold)
end

function givePlayerItem(name, ritem, amount)
  if not amount then amount = 1 end

  curInv = atComma(pl.inv[name], ";")
  local alreadyOwned = false

  for i=1,#curInv,2 do
    curInv[i+1] = tonumber(curInv[i+1])
    if curInv[i] == ritem then curInv[i+1] = curInv[i+1] + amount alreadyOwned = true end
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

function playerUse(name, ritem, index, amount)
  if not amount then amount = 1 end
  curInv = atComma(pl.inv[name],";")
  local hasItem = false

  rebuiltInv = {}
  local k = 1

  for i = 1, #curInv, 2 do --do we have this item?
    curInv[i+1] = tonumber(curInv[i+1])
    if curInv[i] == ritem then --found item in inventory
      hasItem = true
      curInv[i+1] = curInv[i+1] - amount
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
    elseif item.type[ritem] == "Spell" then
      local slot = pl.lastEquip[name]

      if slot == 0 and pl.s1[name] == "None" then
        pl.s1[name] = ritem
          pl.lastEquip[name] = 1
      elseif slot == 1 and pl.s2[name] == "None" then
        pl.s2[name] = ritem
          pl.lastEquip[name] = 0
      else
        if slot == 0 and pl.s1[name] ~= "None" then
          rebuiltInv[#rebuiltInv + 1] = {}
          rebuiltInv[#rebuiltInv].item = pl.s1[name]
          rebuiltInv[#rebuiltInv].amount = 1
          pl.s1[name] = ritem
          pl.lastEquip[name] = 1
        elseif slot == 1 and pl.s2[name] ~= "None" then
          rebuiltInv[#rebuiltInv + 1] = {}
          rebuiltInv[#rebuiltInv].item = pl.s2[name]
          rebuiltInv[#rebuiltInv].amount = 1
          pl.s2[name] = ritem
          pl.lastEquip[name] = 0
        end
      end
    elseif item.type[ritem] == "hp" then
      if pl.pot[name] ~= "None" then
        rebuiltInv[#rebuiltInv + 1] = {}
        rebuiltInv[#rebuiltInv].item = pl.pot[name]
        rebuiltInv[#rebuiltInv].amount = 1
      end
      pl.pot[name] = ritem
    elseif item.type[ritem] == "buddy" then
      if pl.bud[name] ~= "None" then
        rebuiltInv[#rebuiltInv + 1] = {}
        rebuiltInv[#rebuiltInv].item = pl.bud[name]
        rebuiltInv[#rebuiltInv].amount = 1
      end
      pl.bud[name] = ritem
    elseif item.type[ritem] == "upgrade" then
      local stat = atComma(item.val[ritem])
      if stat[2] == "ATK" then
        pl.str[name] = pl.str[name] + tonumber(stat[1])
      end
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

function playerHasItem(name,item,amount)
  if not amount then amount = 0 end
  local hasItem = false
  curInv = atComma(pl.inv[name],";")
  for i = 1, #curInv, 2 do
    if curInv[i] == item and tonumber(curInv[i+1]) > (tonumber(amount)-1) then hasItem = true end
  end

  return hasItem
end

function playerClaim( name, item )
  local claims = atComma(pl.owed[name])

  for i = 1, #claims, 2 do
    if item == claims[i] then
      givePlayerItem(name,claims[i],tonumber(claims[i+1]))
      claims[i] = nil
      claims[i+1] = nil
     end
  end

  pl.owed[name] = "" --rebuild owed inventory
  for i = 1, #claims, 2 do
    if claims[i] and claims[i+1] then
      pl.owed[name] = pl.owed[name]..claims[i]..","..claims[i+1]..","
    end
  end

  if pl.owed[name] == "" then pl.state[name] = "world" pl.owed[name] = "reset" end --the player has collected all of their loot!
end

function movePlayer(name, dir)
  local curt = pl.t[name]
  if dir == "up" then pl.t[name] = pl.t[name] - 101
  elseif dir == "down" then pl.t[name] = pl.t[name] + 101
  elseif dir == "left" then pl.t[name] = pl.t[name] - 1
  elseif dir == "right" then pl.t[name] = pl.t[name] + 1 end

  if world[pl.t[name]].collide and pl.t[name] ~= 4971 then
    pl.t[name] = curt
  else

    if world[pl.t[name]].isFight == true then
      local fightsOnTile = listFightsOnTile(pl.t[name])
      addPlayerToFight(fightsOnTile[1],name)
    else
      if not pl.fightsPlayed[name][pl.t[name]] then
        local fightChance = love.math.random(1,299)
        if fightChance < world[pl.t[name]].fightc or world[pl.t[name]].fightc > 90 then
          world[pl.t[name]].isFight = true
          if fs[world[pl.t[name]].fight] then
            newFight(pl.t[name], world[pl.t[name]].fight)
          else
            newFight(pl.t[name], "Ghostly Haunting")
          end
          addPlayerToFight(#ft.t, name)
        end
      end

      pl.distance[name] = pl.distance[name] + 1
    end
  end
end

function setPlayerPos(name,x,y)
  pl.en[name] = pl.en[name] - distanceFrom(pl.x[name],pl.y[name],x,y)*0.1
  if pl.en[name] < 0 then pl.en[name] = 0 end
  pl.x[name] = x
  pl.y[name] = y
end

function setPlayerDT(name,dt)
  pl.dt[name] = tonumber(dt)
  return true
end

function damagePlayer(name, amount)
  pl.armd[name] = pl.armd[name] + amount
  if pl.armd[name] > item.val[pl.arm[name]] then
    pl.armd[name] = item.val[pl.arm[name]]
    pl.hp[name] = pl.hp[name] - amount
  end
--  pl.msg[name] = pl.msg[name].."tdmg,"..amount..";" --The client could figure this out itself

  if pl.hp[name] < 1 then pl.hp[name] = 100 pl.t[name] =  pl.dt[name] removePlayerFromFight(name, true) pl.deaths[name] = pl.deaths[name] + 1 end
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

function useSpell(spellName,name)
  vals = atComma(item.val[spellName])

  if pl.spell[name] == "None" then
    if tonumber(pl.en[name])+1 > tonumber(vals[2]) then
      pl.spell[name] = spellName
      --addMsg(name.." used "..spellName)
      pl.spellT[name] = tonumber(vals[3])
      pl.en[name] = pl.en[name] - tonumber(vals[2])
    end

  end
end
