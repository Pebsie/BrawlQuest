local socket = require "socket"
local udp = socket.udp()
http = require("socket.http")

udp:settimeout(0)
udp:setsockname("127.0.0.1", 26657)

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

    newPlayer("a","a")
 givePlayerItem("a","Long Sword",1)
 givePlayerItem("a","Short Sword",1)
 givePlayerItem("a","Gold",5000)
 pl.t["a"] = 3707

  --initItems()
  --loadHighscores()
  loadOverworld()
  initAspects()
  initWeather()

  --newFight(1, "Boar Hunt")
  --addPlayerToFight(1, "Pebsie")
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
            udp:sendto(string.format("%s %s %s", namePass[1],  "login", "true"), msg_or_ip, port_or_nil)
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
          if #pl.aspects[i] > 0 then
            for i, v in pairs(pl.aspects[i]) do
              aspectString = aspectString..v..","
            end
          else
            aspectString = "None"
          end

          udp:sendto(string.format("%s %s %s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s", i, "char", pl.hp[i], pl.en[i], pl.s1[i], pl.s2[i], pl.gold[i], pl.x[i], pl.y[i], pl.t[i], pl.dt[i], pl.wep[i], pl.arm[i], pl.inv[i], pl.lvl[i], pl.xp[i], pl.pot[i], pl.state[i], pl.armd[i], pl.bud[i], pl.dt[i], pl.str[i], pl.owed[i], round(pl.score[i]), round(pl.combo[i]), aspectString), msg_or_ip, port_or_nil)
        --  pl.msg[i] = ""
        pl.lastLogin[i] = 0
        elseif cmd == "move" then
          parms = atComma(parms)
          movePlayer(parms[1],parms[2])
        elseif cmd == "players" then
          local requestName = parms
          local plyrs = countPlayers()

          local msgToSend = ""
          --compile location of current players, including ourselves
          for i = 1, countPlayers() do
            --addMsg("Player "..i.."/"..countPlayers().." is "..getPlayerName(i))
            local name = getPlayerName(i)
            local isOnline = true
            if pl.timeout[name] < 1 then
              isOnline = false
            else
              isOnline = true
            end
            if isOnline then
              msgToSend = msgToSend..string.format("user|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|", name, getPlayerTile(name), getPlayerArmour(name), pl.arm_head[name], pl.arm_chest[name], pl.arm_legs[name], getPlayerState(name), pl.spell[name], pl.bud[name], isOnline, pl.wep[name])
            else
              plyrs = plyrs - 1 --player is offline so we reduce the number of players the client should expect by 1
            end
          end

            udp:sendto(requestName.." players "..plyrs.."|"..msgToSend,msg_or_ip,port_or_nil)
        elseif cmd == "world" then --URGENT TODO: separate parts of this to lower size of messages sent
          local msgToSend = countFights().."|"..countChats().."|"
          local name = parms
          pl.timeout[name] = 5

          for i = 1, 100*100 do
            if world[i].isFight == true then
              msgToSend = msgToSend..string.format("fight|%s|", i)
            end
          end

         c = getChats()
         for i = 1, #c do
           msgToSend = msgToSend..string.format("%s|%s|%s|", c[i].sender, c[i].msg, c[i].id)
         end

         msgToSend = msgToSend..weather.time.."|"..weather.temperature.."|"..weather.condition.."|"..weather.day.."|"

          udp:sendto(name.." world "..msgToSend,msg_or_ip,port_or_nil)

        elseif cmd == "fight" then
          parms = atComma(param[1])
          local i = parms[1]
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
              msgToSend = msgToSend..string.format("%s|%s|%s|%s|%s|%s|",tmob.x,tmob.y,tmob.type,tmob.hp,mb.hp[tmob.type],tmob.id)
            end
            if hs[ft.title[id]] then
              msgToSend = msgToSend..round(hs[ft.title[id]].score).."|"..hs[ft.title[id]].player.."|"
            else
              msgToSend = msgToSend.."0|No-one|"
            end
            udp:sendto(i.." fight "..msgToSend,msg_or_ip,port_or_nil)
          end
        elseif cmd == "atk" then  --    netSend("atk",pl.name..","..dir)
          parms = atComma(parms)
          local name = parms[1]
          local dir = parms[2]
          if pl.en[name] > 20 then
            pl.at[name] = true
            pl.atm[name] = 0.05
            pl.en[name] = pl.en[name] - 5
          end
        elseif cmd == "use" then --use item

          parms = atComma(param[1])
          local name = parms[1]
          local item = parms[2]
          if parms[3] then
            playerUse(name,item,parms[3])
          else
            playerUse(name,item)
          end
        elseif cmd == "buy" then
          parms = atComma(param[1])
          local name = parms[1]
          local titem = parms[2]
        --  addMsg(name.." is trying to buy "..titem)
          local itemCost = atComma(item.price[titem])
          if world[pl.t[name]].tile == "Blacksmith" then --check that they're on the right shop tile
            if playerHasItem(name,itemCost[2],tonumber(itemCost[1])) then
              playerUse(name,itemCost[2],0,tonumber(itemCost[1])) --remove gold from player
              givePlayerItem(name,titem) --give player item they've bought
            end
          end
        elseif cmd == "potion" then --use potion
          local name = param[1]

          if pl.pot[name] ~= "None" then
            if item.type[pl.pot[name]] == "hp" and pl.hp[name] < 100 then
              pl.spell[name] = pl.pot[name]
              pl.spellT[name] = 3
              pl.pot[name] = "None"
            end
          end
        elseif cmd == "spell1" then
          local name = param[1]

          if pl.s1[name] ~= "None" and pl.s1t[name] < 0 then
            vals = atComma(item.val[pl.s1[name]])

            useSpell(pl.s1[name],name)
            pl.s1t[name] = tonumber(vals[1])
          end
        elseif cmd == "spell2" then
          local name = param[1]

          if pl.s2[name] ~= "None" and pl.s2t[name] < 0 then
            vals = atComma(item.val[pl.s2[name]])
            useSpell(pl.s2[name],name)

            pl.s2t[name] = tonumber(vals[1])
          end
        elseif cmd == "pray" then
          local name = param[1]

          if world[pl.t[name]].tile == "Graveyard" then
            setPlayerDT(name,pl.t[name])
          end
        elseif cmd == "chat" then
          param = atComma(parms)
          addChatMsg(param[1],param[2])
        elseif cmd == "claim" then --claiming loot at the end of a fight
          param = atComma(parms)
          playerClaim(param[1],param[2])
        elseif cmd == "blueprints" then
          param = atComma(parms)
          udp:sendto(param[1].." blueprints "..pl.blueprints[param[1]],msg_or_ip,port_or_nil)
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
      --if pl.state[k] ~= "fight" then
        fs = fs..acc.username[i].."|"..acc.password[i].."|"..pl.hp[k].."|"..pl.en[k].."|"..pl.s1[k].."|"..pl.s2[k].."|"..pl.gold[k].."|"..pl.x[k].."|"..pl.y[k].."|"..pl.t[k].."|"..pl.wep[k].."|"..pl.arm[k].."|"..pl.inv[k].."|"..pl.pot[k].."|"..pl.lvl[k].."|"..pl.xp[k].."|"..pl.bud[k].."|"..pl.dt[k].."|"..pl.playtime[k].."|"..pl.kills[k].."|"..pl.deaths[k].."|"..pl.distance[k].."|"..pl.str[k].."|"..pl.lastLogin[k].."|"..pl.blueprints[k].."|"..pl.arm_head[k].."|"..pl.arm_chest[k].."|"..pl.arm_legs[k].."\n"
      --fp = "map-new.txt"
    --  end
      uploadCharacter(k)
      --now we check if it's tomorrow!
      if os.date("*t").wday ~= currentDay then
        pl.fightsPlayed[k] = {} --this is a list of the fights that have been played today, and so it is reset at midnight
        pl.lastLogin[k] = pl.lastLogin[k] + 1 --increase lastlogin day by 1. it'll be set to 0 when they login.
      end
  end
  outputCharacterList()
  love.filesystem.write(fp, fs)

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
      newPlayer(word[1],word[2])
      i = getPlayerName(countPlayers())
      pl.hp[i] = tonumber(word[3])
      pl.en[i] = tonumber(word[4])
      pl.s1[i] = word[5]
      pl.s2[i] = word[6]
      pl.gold[i] = tonumber(word[7])
      pl.x[i] = tonumber(word[8])
      pl.y[i] = tonumber(word[9])
      pl.t[i] = tonumber(word[10])
      pl.wep[i] = word[11]
      pl.arm[i] = word[12]
      pl.inv[i] = word[13]
      pl.pot[i] = word[14]
      pl.lvl[i] = tonumber(word[15])
      pl.xp[i] = tonumber(word[16])
      pl.bud[i] = word[17]
      pl.dt[i] = word[18]
      if word[19] then
      pl.playtime[i] = word[19]
      end

      if word[20] then pl.kills[i] = word[20] end
      if word[21] then pl.deaths[i] = word[21] end
      if word[22] then  pl.distance[i] = word[22] end
      if word[23] then pl.str[i] = tonumber(word[23]) end
      if word[24] then pl.lastLogin[i] = tonumber(word[24]) end
      if word[25] then pl.blueprints[i] = word[25] end
      if word[26] then pl.arm_head[i] = word[26] end
      if word[27] then pl.arm_chest[i] = word[27] end
      if word[28] then pl.arm_legs[i] = word[28] end
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
