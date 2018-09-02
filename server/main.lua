local socket = require "socket"
local udp = socket.udp()
http = require("socket.http")

udp:settimeout(0)
udp:setsockname("127.0.0.1", 26655)

toboolean = require "libraries/toboolean"

msgs = "Server started."
nett = 0.1

saveTime = 1
currentDay = os.date("*t").wday

--game variables here
require "modules/tools"
require "modules/players"
require "modules/fight"
require "modules/world"
require "modules/char"
require "modules/chat"
require "modules/highscores"
require "modules/aspects"
require "modules/weather"

stdSW = 1920/2
stdSH = 1080/2

local running = true
print("Entering server loop...")

function love.load()
  loadGame()

  downloadMobs()
  loadMobs()

  loadOverworld()
  initAspects()
  initWeather()

 newPlayer("a","a")
  givePlayerItem("a","Guardian's Helmet",1,4)
  givePlayerItem("a","Guardian's Leggings",1,12)
  givePlayerItem("a","Guardian's Chestplate",1)
  givePlayerItem("a","Guardian's Blade",1)
  givePlayerItem("a","Recovery",1)
  givePlayerItem("a","Polymorph",1)
end

function love.draw()
  love.graphics.print(msgs)
end

function love.update(dt)
  --nett = nett - 1*dt

--  if nett < 0 then
    repeat
      data, msg_or_ip, port_or_nil = udp:receivefrom()
      if data then --REMINDER: when sending messages format is username command paramaters (split by |)
        entity, cmd, parms = data:match("^(%S*) (%S*) (.*)")

        param = {}
        --for word in parms:gmatch("([^%s]+)") do param[#param+1] = word end --split params at space
        param[1] = parms

        if cmd == "login" then

          namePass = atComma(parms)
        --  addMsg("Player claiming to be "..namePass[1].." is trying to login.")
          if loginPlayer(namePass[1], namePass[2]) then
            udp:sendto(string.format("%s %s %s|%s", namePass[1],  "login", "true",pl[namePass[1]].authcode), msg_or_ip, port_or_nil)
            addMsg("Player "..namePass[1].." logged in.")
            addChatMsg("SERVER",namePass[1].." entered the world.")
            --addChatMsg("SERVER",namePass[1].." entered the world.")
          elseif getPlayerID(namePass[1]) then
            udp:sendto(string.format("%s %s %s", namePass[1], "login", "false"), msg_or_ip, port_or_nil)
            addMsg(namePass[1].." tried to login with an incorrect password.")
          else
            newPlayer(namePass[1],namePass[2])

            udp:sendto(string.format("%s %s %s", namePass[1],  "login", "true"), msg_or_ip, port_or_nil)
          end

        elseif cmd == "char" then --client is requesting character info
        --  addMsg(param[1].." requested user info!")
          local i = param[1]
          local aspectString = ""
          if #pl[i].aspects > 0 then
            for i, v in pairs(pl[i].aspects) do
              aspectString = aspectString..v..","
            end
          else
            aspectString = "None"
          end

          udp:sendto(string.format("%s %s %s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s", i, "char", pl[i].hp, pl[i].en, pl[i].s1, pl[i].s2, pl[i].gold, pl[i].x, pl[i].y, pl[i].t, pl[i].dt, pl[i].wep, pl[i].inv, pl[i].lvl, pl[i].xp, pl[i].pot, pl[i].state, pl[i].armd, pl[i].bud, pl[i].dt, pl[i].str, pl[i].owed, round(pl[i].score), round(pl[i].combo), aspectString), msg_or_ip, port_or_nil)
        pl[i].lastLogin = 0
        elseif cmd == "move" then
          parms = atComma(parms)
          if 1 == 1 or parms[3] == pl[parms[1]].authcode then
            movePlayer(parms[1],parms[2])
          else
            pl[parms[1]].authcode = love.math.random(10000,99999)
            addMsg(parms[1].."::Wrong authcode, kicked client.")
            udp:sendto(parms[1].." kick authcode",msg_or_ip,port_or_nil)
          end
        elseif cmd == "players" then
          local requestName = parms
          local plyrs = countPlayers()

          local msgToSend = ""
          --compile location of current players, including ourselves
          for i = 1, countPlayers() do
            --addMsg("Player "..i.."/"..countPlayers().." is "..getPlayerName(i))
            local name = getPlayerName(i)
            local isOnline = true
            if pl[name].timeout < 1 then
              isOnline = false
            else
              isOnline = true
            end
            if isOnline then
              msgToSend = msgToSend..string.format("user|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|", name, getPlayerTile(name),pl[name].arm_head, pl[name].arm_chest, pl[name].arm_legs, getPlayerState(name), pl[name].spell, pl[name].bud, isOnline, pl[name].wep)
            else
              plyrs = plyrs - 1 --player is offline so we reduce the number of players the client should expect by 1
            end
          end

            udp:sendto(requestName.." players "..plyrs.."|"..msgToSend,msg_or_ip,port_or_nil)
        elseif cmd == "world" then --URGENT TODO: separate parts of this to lower size of messages sent
          local msgToSend = countFights().."|"..countChats().."|"
          local name = parms
          pl[name].timeout = 5

          for k = -195,305,101 do
            for t = -9, -5 do
              if world[i].isFight == true and playerCanFight(name,i) then
                msgToSend = msgToSend..string.format("fight|%s|", i)
              end
            end
          end

         c = getChats()
         for i = 1, #c do
           msgToSend = msgToSend..string.format("%s|%s|%s|", c[i].sender, c[i].msg, c[i].id)
         end

         msgToSend = msgToSend..weather.time.."|"..weather.temperature.."|"..weather.condition.."|"..weather.day.."|"

        local msgOn = ""
        local spawned = 0
        local i = tonumber(pl[name].t)
         for k = -195,305,101 do
           for t = -9, -5 do
             if world[t+i+k] and world[t+i+k].spawned and playerCanFight(name,t+i+k) then
               spawned = spawned + 1
               local fightData = atComma(world[t+i+k].fight,"|")
               msgOn = msgOn..t+i+k.."|"..getFirstMob(fightData[1]).."|"
             end
           end
         end

         msgToSend = msgToSend..spawned.."|"..msgOn

          udp:sendto(name.." world "..msgToSend,msg_or_ip,port_or_nil)

        elseif cmd == "fight" then
          parms = atComma(param[1])
          local i = parms[1]
          if parms[4] == pl[i].authcode then

            local x = tonumber(parms[2])
            local y = tonumber(parms[3])

            local id = findFightPlayerIsIn(getPlayerID(i))
            if x > stdSW-32 then x = stdSW-32 end
            if x < 0 then x = 0 end
            if y > stdSH-32 then y = stdSH-32 end
            if y < 0 then y = 0 end

            setPlayerPos(i,x,y)
        --    addMsg("Player "..i.." is at "..x..","..y)
            -- * Number of players, mobs and spells in fight
            -- * Player X,Y,Armour and HP
            -- * Spell X,Y and type
            -- * Mob X,Y,Type and HP
            if id then
              msgToSend = countMobs(id).."|"..countPlayersInFight(id).."|"
              local playersIF = listPlayersInFight(id)
              for i = 1, countPlayersInFight(id) do
                pdata = getPlayerData(id,i)
                msgToSend = msgToSend..string.format("%s|%s|%s|%s|%s|%s|",pdata["name"],pdata["x"],pdata["y"],pdata["arm"],pdata["hp"],pdata["spell"]) --id|x|y|arm|hp
              end

              for i = 1, countMobs(id) do-- * All mob info (X,Y,Type,HP)
                tmob = getMobData(id,i)
                msgToSend = msgToSend..string.format("%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|",tmob.x,tmob.y,tmob.type,tmob.hp,mb.hp[tmob.type],tmob.id,tmob.spell1time,mb.sp1t[tmob.type],tmob.spell2time,mb.sp2t[tmob.type])
              end
              if hs[ft.title[id]] then
                msgToSend = msgToSend..round(hs[ft.title[id]].score).."|"..hs[ft.title[id]].player.."|"
              else
                msgToSend = msgToSend.."0|No-one|"
              end
              udp:sendto(i.." fight "..msgToSend,msg_or_ip,port_or_nil)
            end
          else
            pl[parms[1]].authcode = love.math.random(10000,99999)
            addMsg(parms[1].."::Wrong authcode, kicked client.")
            udp:sendto(parms[1].." kick authcode",msg_or_ip,port_or_nil)
          end
        elseif cmd == "atk" then
          parms = atComma(parms)
          local name = parms[1]
          local dir = parms[2]
          if pl[name].en > 20 then
            pl[name].at = true
            pl[name].atm = 0.05
            pl[name].en = pl[name].en - 5
          end
        elseif cmd == "use" then --use item

          parms = atComma(param[1])
          local name = parms[1]
          local item = parms[2]
        --  if pl[name].authcode == parms[3] then
            if parms[3] then
              playerUse(name,item,parms[3])
            else
              playerUse(name,item)
            end
        --[[  else
            pl[name].authcode = love.math.random(10000,99999)
            addMsg(name.."::Wrong authcode, kicked client.")
            udp:sendto(name.." kick authcode",msg_or_ip,port_or_nil)
          end]]
        elseif cmd == "buy" then
          parms = atComma(param[1])
          local name = parms[1]
          local titem = parms[2]
        --  addMsg(name.." is trying to buy "..titem)
          local itemCost = atComma(item.price[titem])
          if world[pl[name].t].tile == "Blacksmith" then --check that they're on the right shop tile
            if playerHasItem(name,itemCost[2],tonumber(itemCost[1])) then
              playerUse(name,itemCost[2],0,tonumber(itemCost[1])) --remove gold from player
              givePlayerItem(name,titem) --give player item they've bought
            end
          end
        elseif cmd == "potion" then --use potion
          local name = param[1]

          if pl[name].pot ~= "None" then
            if item.type[pl[name].pot] == "hp" and pl[name].hp < 100 then
              pl[name].spell = pl[name].pot
              pl[name].spellT = 3
              pl[name].pot = "None"
            end
          end
        elseif cmd == "spell1" then
          local name = param[1]

          if pl[name].s1 ~= "None" and pl[name].s1t < 0 then
            vals = atComma(item.val[pl[name].s1])

            useSpell(pl[name].s1,name)
            pl[name].s1t = tonumber(vals[1])
          end
        elseif cmd == "spell2" then
          local name = param[1]

          if pl[name].s2 ~= "None" and pl[name].s2t < 0 then
            vals = atComma(item.val[pl[name].s2])
            useSpell(pl[name].s2,name)

            pl[name].s2t = tonumber(vals[1])
          end
        elseif cmd == "pray" then
          local name = param[1]

          if world[pl[name].t].tile == "Graveyard" then
            setPlayerDT(name,pl[name].t)
          end
        elseif cmd == "chat" then
          param = atComma(parms)
          addChatMsg(param[1],param[2])
        elseif cmd == "claim" then --claiming loot at the end of a fight
          param = atComma(parms)
          playerClaim(param[1],param[2])
        elseif cmd == "blueprints" then
          param = atComma(parms)
          udp:sendto(param[1].." blueprints "..pl[param[1]].blueprints,msg_or_ip,port_or_nil)
        elseif cmd == "craft" then --craft item
          param = atComma(parms)
          --addMsg(param[1].." is trying to craft "..param[2])
          if canPlayerCraft(param[1],param[2]) and playerHasBlueprint(param[1],param[2]) and world[pl[param[1]].t].tile == "Anvil" then
            local craftMats = atComma(item.price[param[2]])
            for i = 1, #craftMats, 2 do --cycle through crafting materials and remove them from the user
              playerUse(param[1],craftMats[i+1],0,tonumber(craftMats[i]))
            end
            givePlayerItem(param[1],param[2])
          end
        elseif cmd == "fightInfo" then
          param = atComma(parms)
          if fs[param[2]] and fs.rewards[param[2]] and fs.spawnTime[param[2]] then
            udp:sendto(param[1].." fightInfo "..fs[param[2]].."/"..fs.rewards[param[2]].."/"..fs.spawnTime[param[2]].."/"..param[2],msg_or_ip,port_or_nil)
          end
        elseif cmd == "error" then
          addMsg("A player has encountered an error: "..parms)
        end



      elseif msg_or_ip ~= 'timeout' then
        addMsg("Unknown network error: "..tostring(msg))
      end
    until not data

  --  nett = 0.1
--  end
--  socket.sleep(0.1)

  updateFights(dt)
  updateWorld(dt)
  updatePlayers(dt)
  updateChat(dt)

  saveTime = saveTime - 1*dt
  if saveTime < 0 then
    saveGame()
    saveTime = 300
  end
end

function addMsg(msg)
  print(msg)
  msgs = msg.."\n"..msgs
end

function saveGame()
--  addMsg("Saving game.")
  local fp = "bqplayers.txt"
  local fs = ""
  for i = 1, countPlayers() do
      local k = getPlayerName(i)
        fs = fs.."new-file-format|"..acc.username[i].."|"..acc.password[i].."|" --..pl[k].hp.."|"..pl[k].en.."|"..pl[k].s1.."|"..pl[k].s2.."|"..pl[k].gold.."|"..pl[k].x.."|"..pl[k].y.."|"..pl[k].t.."|"..pl[k].wep.."|"..pl[k].arm.."|"..pl[k].inv.."|"..pl[k].pot.."|"..pl[k].lvl.."|"..pl[k].xp.."|"..pl[k].bud.."|"..pl[k].dt.."|"..pl.playtime[k].."|"..pl.kills[k].."|"..pl.deaths[k].."|"..pl.distance[k].."|"..pl.str[k].."|"..pl[k].lastLogin.."|"..pl.blueprints[k].."|"..pl.arm_head[k].."|"..pl.arm_chest[k].."|"..pl.arm_legs[k].."\n"
        local alreadySet = {} --we were encountring a strange bug whereby with each save each value would save twice. Very strange. This is a lazy fix for that.
        for i, v in pairs(pl[k]) do
          if type(v) ~= "table" and type(v) ~= "boolean" and i ~= "authcode" and not alreadySet[i] and i ~= "state" then
            if not v then v = 0 end
            fs = fs..i.."|"..v.."|"
            alreadySet[i] = true
          end
        end
      --fp = "map-new.txt"
    --  end
    --  uploadCharacter(k)
      --now we check if it's tomorrow!
      if os.date("*t").wday ~= currentDay then
        pl[k].fightsPlayed = {} --this is a list of the fights that have been played today, and so it is reset at midnight
        pl[k].lastLogin = pl[k].lastLogin + 1 --increase lastlogin day by 1. it'll be set to 0 when they login.
      end
      fs = fs .. "\n"
  end
  outputCharacterList()
  love.filesystem.write(fp, fs)
  love.filesystem.write("bqplayers-backup-"..os.date("*t").wday.."-"..os.time()..".txt",fs) --backup

  local fs = "weather=|"..weather.time.."|"..weather.condition.."|"..weather.temperature.."|"..weather.day.."|"
  love.filesystem.write("server-info.txt",fs)

  currentDay = os.date("*t").wday
  saveHighscores()
  addMsg("Saved "..os.time())
end

function love.quit()
  saveGame()
end

function loadGame()
  if love.filesystem.exists("bqplayers.txt") then
    for line in love.filesystem.lines("bqplayers.txt") do
      word = atComma(line,"|")

      if word[1] == "new-file-format" then
        newPlayer(word[2],word[3])
        i = getPlayerName(countPlayers())
        for k = 4, #word, 2 do
          if word[k] ~= "state" then
            if tonumber(word[k+1]) ~= nil then word[k+1] = tonumber(word[k+1]) end
            pl[i][word[k]] = word[k+1]
          end
        end
      end
    end

    if love.filesystem.exists("server-info.txt") then
      for line in love.filesystem.lines("server-info.txt") do
        word = atComma(line,"|")
        if string.sub(word[1],1,8) == "weather=" then
          weather = {}
          weather.time = tonumber(word[2])
          weather.condition = word[3]
          weather.temperature = tonumber(word[4])
          weather.day = tonumber(word[5])
        end
      end
    end

    loadHighscores()
    addMsg("Game loaded.")
  else
    addMsg("Couldn't find save file.")
  end
end
