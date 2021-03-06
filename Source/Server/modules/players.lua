require "data/level"

pl = {} --identified by username

acc = {} --identified by number
acc.username = {}
acc.password = {}

chat = {}

function newPlayer(name)
 -- if not pl[name] then --we don't want to create a character that already exists! -- superfluous now that characters can't be created during login
    acc.username[#acc.username + 1] = name
    acc.password[#acc.password + 1] = "NOLONGERUSED"

    local i = name
    pl[i] = {
      hp = 100,
      en = 100,
      s1 = "None",
      s1t = 0,
      s2 = "None",
      s2t = 0,
      gold = 0,
      x = 0,
      y = 0,
      t = 7693, --805 is shipwrecked, 918 is hell
      dt = 7693,
      dtz = "Hunters", --death tile zone
      wep = "Long Stick",
      armd = 0,
      arm_head = "None",
      arm_chest = "Green Shirt",
      arm_legs = "Brown Trousers",
      inv = "None",
      pot = "None",
      lvl = 1,
      xp = 0,
      at = false,
      atm = 0,
      msg = "world",
      online = true,
      state = "world",
      spell = "None",
      spellT = 0,
      timeout = 0,
      bud = "None",
      playtime = 0,
      kills = 0,
      deaths = 0,
      distance = 0,
      lastEquip = 0,
      fightsPlayed = {},
      str = 0, --slightly improves all melee damage and massively improves damage caused by critical hits
      int = 0, --improves all spell abilities
      agl = 0, --gain 10% en for each point in agility
      sta = 0, --gain 5% hp for each point in stamina
      cp = 10,
      lastLogin = 0,
      owed = "reset",
      score = 0,
      combo = 0,
      aspects = {},
      encounterBuild = 0,
      blueprints = "",
      authcode = 0,
      zone = "Hunters",
      party = 0,
      activeQuests = "",
      completedQuests = ""
    }


    addMsg("New player by the name of "..name)
 -- else
   -- addMsg("Player "..name.." already exists!")
  --end
end

function updatePlayers(dt)

  for i = 1, countPlayers() do
    local k = getPlayerName(i)

    pl[k].atm = pl[k].atm - 1*dt
    if pl[k].atm < 0 then pl[k].at = false end

    pl[k].en = pl[k].en + 25*dt
    if pl[k].en > 100+pl[k].agl*10 then pl[k].en = 100+pl[k].agl*10 end

    if pl[k].spellT then
      pl[k].spellT = pl[k].spellT - 1*dt
      if pl[k].spellT < 0 then pl[k].spell = "None" end
    else
      pl[k].spellT = 1
    end

    if pl[k] and pl[k].spell and item[pl[k].spell] and item[pl[k].spell].type == "hp" then
      pl[k].hp = pl[k].hp + (item[pl[k].spell].val/3)*dt
    end

    pl[k].armd = pl[k].armd - (getArmourValue(k)/5)*dt
    if pl[k].armd < 0 then pl[k].armd = 0 end

    pl[k].s1t = pl[k].s1t - 1*dt
    pl[k].s2t = pl[k].s2t - 1*dt

    if pl[k].spell == "Recovery" then
      pl[k].hp = pl[k].hp + 10*dt --increase by 10% per second
    end

    if pl[k].hp > 100+5*pl[k].sta then pl[k].hp = 100+5*pl[k].sta  end
    pl[k].at = false

    if pl[k].timeout > 0 then
      pl[k].playtime = pl[k].playtime + 1*dt
    end

    pl[k].timeout = pl[k].timeout - 1*dt

    if world[pl[k].zone][pl[k].t].rest then
      pl[k].hp = pl[k].hp + 10*dt
    end

    for i, v in pairs(pl[k].aspects) do
      if v == "Bleeding" then
        damagePlayer(k,2*dt)
      end
      if aspect[v].antidote() then pl[k].aspects[i] = nil  end
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
  if pl[name].lvl < 10 then
    pl[name].xp = pl[name].xp + xp/pl[name].lvl

    if pl[name].xp > 99 then --level up
      pl[name].lvl = pl[name].lvl + 1
      pl[name].xp = (pl[name].xp - 100)/pl[name].lvl --still earn XP from this reward
      pl[name].cp = pl[name].cp + pl[name].lvl --give player character points
    end
  end
end

function givePlayerGold(name, gold)
  givePlayerItem(name,"Gold",gold)
end

function givePlayerItem(name, ritem, amount, slot)
  if pl[name] and item[ritem] then
    if ritem == "XP" then givePlayerXP(name,amount) else -- this allows us to use givePlayerItem to give XP to reduce the amount of code required in other functions
      if pl[name].inv == "None" then pl[name].inv = ritem..";"..amount..";1;" else

        if not amount then amount = 1 end
        if not slot then slot = -1 hadSlot = false end

        curInv = atComma(pl[name].inv, ";")
        local alreadyOwned = false

        for i=1,#curInv,3 do
          curInv[i+1] = tonumber(curInv[i+1])
          if curInv[i] == ritem and hadSlot == false then curInv[i+1] = curInv[i+1] + amount alreadyOwned = true end --if slot is defined then the player wants the stack to be split
        end

        if alreadyOwned == false then --insert into inventory
          local i = #curInv+1
          curInv[i] = ritem
          curInv[i+1] = amount
          if slot ~= -1 then
            curInv[i+2] = slot --addMsg(curInv[i+2].."=="..slot.." (input via slot)")
          else
            curInv[i+2] = getNextFreeInventorySlot(name)
          end
        end

        pl[name].inv = ""
        --rebuild inventory string
        for i = 1, #curInv do
          pl[name].inv = pl[name].inv..curInv[i]..";"
        end
      end
    end
  else
    addMsg("ERROR: Tried to give player "..name.." "..amount.."x "..ritem.." but that item or player doesn't exist!")
  end
end

function getNextFreeInventorySlot(name)
  local thisSlot = 1
  local curInv = atComma(pl[name].inv,";")
  local fullSlot = {}
  local finished = false

  for i = 1, #curInv, 3 do --build table of slots that have somthing in them
    fullSlot[tonumber(curInv[i+2])] = true
  end

  while not finished do
    for i = 1, #fullSlot do
      if thisSlot == fullSlot[i] then thisSlot = thisSlot + 1 end --if we're on a full slot, increase by one
    end

    if not fullSlot[thisSlot] then finished = true else thisSlot = thisSlot + 1 end --if we're still on a full slot, increase by one and try again. Otherwise, exit the loop.
  end

  return thisSlot
end

function playerUse(name, ritem, index, amount)
  if not amount then amount = 1 end
  curInv = atComma(pl[name].inv,";")
  local hasItem = false
  local haveInserted = false

  rebuiltInv = {}
  local k = 1

  for i = 1, #curInv, 3 do --do we have this item?
    curInv[i+1] = tonumber(curInv[i+1])
    if curInv[i] == ritem then --found item in inventory
      hasItem = true
      curInv[i+1] = curInv[i+1] - amount
    end

    rebuiltInv[k] = {}
    rebuiltInv[k].item = curInv[i]
    rebuiltInv[k].amount = curInv[i+1]
    rebuiltInv[k].slot = curInv[i+2]
    k = k + 1
  end

  --use item
  if hasItem == true then
    if item[ritem].type == "wep" then
      rebuiltInv[#rebuiltInv + 1] = {}
      rebuiltInv[#rebuiltInv].item = pl[name].wep
      rebuiltInv[#rebuiltInv].amount = 1
      haveInserted = true
      pl[name].wep = ritem
    elseif item[ritem].type == "Spell" then
      local slot = pl[name].lastEquip

      if slot == 0 and pl[name].s1 == "None" then
        pl[name].s1 = ritem
          pl[name].lastEquip = 1
      elseif slot == 1 and pl[name].s2 == "None" then
        pl[name].s2 = ritem
          pl[name].lastEquip = 0
      else
        if slot == 0 and pl[name].s1 ~= "None" then
          rebuiltInv[#rebuiltInv + 1] = {}
          rebuiltInv[#rebuiltInv].item = pl[name].s1
          rebuiltInv[#rebuiltInv].amount = 1
          haveInserted = true
          pl[name].s1 = ritem
          pl[name].lastEquip = 1
        elseif slot == 1 and pl[name].s2 ~= "None" then
          rebuiltInv[#rebuiltInv + 1] = {}
          rebuiltInv[#rebuiltInv].item = pl[name].s2
          rebuiltInv[#rebuiltInv].amount = 1
          haveInserted = true
          pl[name].s2 = ritem
          pl[name].lastEquip = 0
        end
      end
    elseif item[ritem].type == "hp" then
      if pl[name].pot ~= "None" then
        rebuiltInv[#rebuiltInv + 1] = {}
        rebuiltInv[#rebuiltInv].item = pl[name].pot
        rebuiltInv[#rebuiltInv].amount = 1
        haveInserted = true
      end
      pl[name].pot = ritem
    elseif item[ritem].type == "buddy" then
      if pl[name].bud ~= "None" then
        rebuiltInv[#rebuiltInv + 1] = {}
        rebuiltInv[#rebuiltInv].item = pl[name].bud
        rebuiltInv[#rebuiltInv].amount = 1
        haveInserted = true
      end
      pl[name].bud = ritem
    elseif item[ritem].type == "upgrade" then
      local stat = atComma(item[ritem].val)
      if stat[2] == "ATK" then
        pl[name].str = pl[name].str + tonumber(stat[1])
      end
    elseif item[ritem].type == "head armour" then

      if pl[name].arm_head ~= "None" then rebuiltInv[#rebuiltInv + 1] = { item = pl[name].arm_head, amount = 1 } haveInserted = true end
      pl[name].arm_head = ritem

    elseif item[ritem].type == "chest armour" then

      if pl[name].arm_chest ~= "None" then rebuiltInv[#rebuiltInv + 1] = {item = pl[name].arm_chest, amount = 1 } haveInserted = true end
      pl[name].arm_chest = ritem

    elseif item[ritem].type == "leg armour" then

      if pl[name].arm_legs ~= "None" then rebuiltInv[#rebuiltInv + 1] = {item = pl[name].arm_legs, amount = 1 } haveInserted = true end
      pl[name].arm_legs = ritem
    
    else
      givePlayerItem(name, ritem, amount)
    end
  else
    addMsg(name.." tried to use an item ("..ritem..") that they don't own!")
  end

  --rebuild inventory
  pl[name].inv = ""
  for i = 1, #rebuiltInv do
    if rebuiltInv[i].amount > 0 then
      if i == #rebuiltInv and haveInserted == true then --we insert into the rebuiltInv table when, say, a player unequips an item and we need to put the old one back into their inventory
        givePlayerItem(name, rebuiltInv[i].item, rebuiltInv[i].amount) --slotless as the player might already ahve this item
      else
        givePlayerItem(name, rebuiltInv[i].item, rebuiltInv[i].amount, rebuiltInv[i].slot)
      end
    elseif not rebuiltInv[i] or not rebuiltInv[i].amount then
      addMsg("AN ERROR OCCURRED REBUILDING "..name.."'S INVENTORY::"..i.."::Arguments were name = "..name..", ritem = "..ritem..", index = "..index..", amount = "..amount)
    end
  end
end

function playerHasItem(name,item,amount)
  if not amount then amount = 0 end
  local hasItem = false
  curInv = atComma(pl[name].inv,";")
  for i = 1, #curInv, 3 do
    if curInv[i] == item and tonumber(curInv[i+1]) > (tonumber(amount)-1) then hasItem = true end
  end

  return hasItem
end

function playerClaim( name, item )
  local claims = atComma(pl[name].owed)

  for i = 1, #claims, 2 do
    if item == claims[i] then

      if string.sub(item,1,10) == "Blueprint:" then
        pl[name].blueprints = pl[name].blueprints..";"..string.sub(item,12)
      elseif item == "XP" then
        givePlayerXP(name,tonumber(claims[i+1]))
      else
        givePlayerItem(name,claims[i],tonumber(claims[i+1]))
      end

      claims[i] = nil
      claims[i+1] = nil
     end
  end

  pl[name].owed = "" --rebuild owed inventory
  for i = 1, #claims, 2 do
    if claims[i] and claims[i+1] then
      pl[name].owed = pl[name].owed..claims[i]..","..claims[i+1].."," --TODO: make this into a table (pl.owed)
    end
  end

  if pl[name].owed == "" then pl[name].state = "world" pl[name].owed = "reset" end --the player has collected all of their loot!
end

function movePlayer(name, dir)
  local curt = pl[name].t
  if dir == "up" then pl[name].t = pl[name].t - 101
  elseif dir == "down" then pl[name].t = pl[name].t + 101
  elseif dir == "left" then pl[name].t = pl[name].t - 1
  elseif dir == "right" then pl[name].t = pl[name].t + 1 end

  if world[pl[name].zone][pl[name].t].fightc == 0 then pl[name].encounterBuild = 0 end

  if world[pl[name].zone][pl[name].t].collide then
    pl[name].t = curt
  elseif string.sub(world[pl[name].zone][pl[name].t].fight,1,3) == "tp|" then --teleport
    pl[name].t = tonumber(string.sub(world[pl[name].zone][pl[name].t].fight,4))
  elseif string.sub(world[pl[name].zone][pl[name].t].fight,1,3) == "zw|" then --zone warp
    local word = atComma(world[pl[name].zone][pl[name].t].fight,"|")
    pl[name].zone = word[2]
    pl[name].t = tonumber(word[3])
  elseif world[pl[name].zone][pl[name].t].fight == "The Arena" then
    givePlayerItem(name,pl[name].arm_head,1)
    givePlayerItem(name,pl[name].arm_chest,1)
    givePlayerItem(name,pl[name].arm_legs,1)
    givePlayerItem(name,pl[name].wep,1)
    pl[name].arm_head = "None"
    pl[name].arm_chest = "None"
    pl[name].arm_legs = "None"
    pl[name].wep = "Long Stick"
    newFight(pl[name].t,"The Arena",pl[name].zone)
    addPlayerToFight(#ft.t,name)
  elseif string.sub(world[pl[name].zone][pl[name].t].fight,1,5) ~= "speak" then
    if world[pl[name].zone][pl[name].t].isFight == true and playerCanFight(name,pl[name].t) then
      local fightsOnTile = listFightsOnTile(pl[name].t)
      addPlayerToFight(fightsOnTile[1],name)
      pl[name].encounterBuild = 0
    else
      if not pl[name].fightsPlayed[pl[name].t] and playerCanFight(name,pl[name].t) then
        local fightData = atComma(world[pl[name].zone][pl[name].t].fight,"|")
        local fightChance = love.math.random(1,100)-pl[name].encounterBuild
        if world[pl[name].zone][pl[name].t].spawned then --fightChance < world[pl[name].zone][pl[name].t].fightc or world[pl[name].zone][pl[name].t].fightc > 90 or world[pl[name].zone][pl[name].t].spawned then
          world[pl[name].zone][pl[name].t].isFight = true
          if fs[fightData[1]] then
            newFight(pl[name].t, fightData[1],pl[name].zone)
            pl[name].encounterBuild = 0
            addPlayerToFight(#ft.t, name)
            world[pl[name].zone][pl[name].t].spawned = "fight"
          else
          --  newFight(pl[name].t, "Ghostly Haunting")
            pl[name].encounterBuild = 0
          end

        end
      else
        pl[name].encounterBuild = pl[name].encounterBuild + world[pl[name].zone][pl[name].t].fightc
      end

      pl[name].distance = pl[name].distance + 1
    end
  end
end

function setPlayerPos(name,x,y)
  pl[name].en = pl[name].en - distanceFrom(pl[name].x,pl[name].y,x,y)*0.1
  if pl[name].en < 0 then pl[name].en = 0 end
  pl[name].x = x
  pl[name].y = y
end

function setPlayerDT(name,dt)
  pl[name].dt = tonumber(dt)
  pl[name].dtz = pl[name].zone
  return true
end

function damagePlayer(name, amount)
  pl[name].armd = pl[name].armd + amount
  if pl[name].armd > getArmourValue(name) then
    pl[name].armd = getArmourValue(name)
    pl[name].hp = pl[name].hp - amount
  end

  if pl[name].hp < 1 then pl[name].hp = 100+5*pl[name].sta pl[name].t =  pl[name].dt pl[name].zone = pl[name].dtz removePlayerFromFight(name, true) pl[name].deaths = pl[name].deaths + 1 end
end

function getArmourValue(name)
  if item[pl[name].arm_head] and item[pl[name].arm_chest] and item[pl[name].arm_legs] then
    return (item[pl[name].arm_head].val + item[pl[name].arm_chest].val + item[pl[name].arm_legs].val)
  else
    return 0
  end
end

--return info functions

function isPlayerDead(name)
  if pl[name].hp < 1 then return true else return false end
end

function isPlayerOnline(name)
  return pl[name].online
end

function getPlayerTile(name)
  return pl[name].t
end

function getPlayerState(name)
  return pl[name].state
end

function useSpell(spellName,name)
  vals = atComma(item[spellName].val)

  if pl[name].spell == "None" then
    if tonumber(pl[name].en)+1 > tonumber(vals[2]) then
      pl[name].spell = spellName
      --addMsg(name.." used "..spellName)
      pl[name].spellT = tonumber(vals[3])
      pl[name].en = pl[name].en - tonumber(vals[2])
    end

  end
end

function playerHasBlueprint(name,bprint)
  local result = false
  local prints = atComma(pl[name].blueprints,";")
  for i, v in pairs(prints) do
    if v == bprint then
      result = true
    end
  end

  return result
end

function canPlayerCraft(name, itemName) --returns true or false whether the player has the materials to craft the item name. Ignores existence of blueprint.
  if item[itemName].recipe then
    local craftMats = atComma(item[itemName].recipe)
    local canCraft = true

    if #craftMats > 1 then
      for i = 1, #craftMats, 2 do
        if not playerHasItem(name,craftMats[i+1],tonumber(craftMats[i])) then
          canCraft = false
        end
      --  print(craftMats[i].." of ")--..tonumber(craftMats[i+1]))
      end
    end

    return canCraft
  else
    return false
  end
end

function playerHasBuddy(name,itemName)
--  addMsg("Is "..item.type[itemName].."==buddy and does "..name.." have "..itemName.."? ("..tostring(playerHasItem(name,itemName,1))..") Does "..pl[name].bud.."=="..itemName.."?")
  if item[itemName] and item[itemName].type == "buddy" and (playerHasItem(name,itemName,1) or pl[name].bud == itemName) then
    return true
  else
    return false
  end
end

function playerCanFight(name,tile)
--  addMsg("Can "..name.." fight on "..tile.."? ("..world[tile].fight..")")
  local canFight = false
  local word = atComma(world[pl[name].zone][tile].fight,"|")

  if #word > 1 then
  --  addMsg("There are requirements... does "..pl[name][word[2]].." == "..word[3].."? "..word[2])
    if word[2] == "quest" then
      --fill in once quest system is done
    else
      if pl[name][word[2]] == word[3] then
        canFight = true
      end
    end
  else
    canFight = true
  end

  if pl[name].fightsPlayed[tile] then canFight = false end

  return canFight
end

function playerAssignSkill(name,skill)
  if pl[name].cp > 0 then
    pl[name][skill] = pl[name][skill] + 1

    if skill == "sta" then
      pl[name].hp = pl[name].hp+5
    end

    pl[name].cp = pl[name].cp - 1
    return true
  else
    return false
  end
end

function getNameFromAuthcode(authcode)
  for i,v in pairs(pl) do
    addMsg(tostring(v.name).."'s authcode is "..v.authcode)
    if tostring(v.authcode) == tostring(authcode) and v.name then
      return v.name -- return the player name if we find the correct authcode
    end
  end
end

