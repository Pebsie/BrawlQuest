local socket = require "socket"
local udp = socket.udp()
http = require("socket.http")

udp:settimeout(0)
udp:setsockname("*", 26650)

msgs = "Server started."

--game variables here
require "modules/tools"
require "modules/players"
require "modules/fight"
require "modules/world"

local running = true
print("Entering server loop...")

function love.load()
  initItems()
  loadOverworld()
  newPlayer("demo","demo")
  newPlayer("JoeyFunWithMusic","demo")
  newPlayer("pebsie","demo")
  --newFight(1, "Boar Hunt")
  --addPlayerToFight(1, "Pebsie")
end

function love.draw()
  love.graphics.print(msgs)
end

function love.update(dt)
  data, msg_or_ip, port_or_nil = udp:receivefrom()
  if data then --REMINDER: when sending messages format is username command paramaters (split by |)
    entity, cmd, parms = data:match("^(%S*) (%S*) (.*)")

    param = {}
    for word in parms:gmatch("([^%s]+)") do  param[#param+1] = word end --split params at space

    if cmd == "login" then

      namePass = atComma(parms)
      addMsg("Player claiming to be "..namePass[1].." is trying to login.")
      if loginPlayer(namePass[1], namePass[2]) then
        udp:sendto(string.format("%s %s %s", namePass[1],  "login", "true"), msg_or_ip, port_or_nil)
        addMsg("They are who they claim to be. Let them in, boys!")
      else
        udp:sendto(string.format("%s %s %s", namePass[1], "login", "false"), msg_or_ip, port_or_nil)
        addMsg("He wasn't "..namePass[1]..".")
      end

    elseif cmd == "char" then --client is requesting character info
    --  addMsg(param[1].." requested user info!")
      local i = param[1]
      udp:sendto(string.format("%s %s %s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s", i, "char", round(pl.hp[i]), pl.en[i], pl.s1[i], pl.s2[i], pl.gold[i], pl.x[i], pl.y[i], pl.t[i], pl.dt[i], pl.wep[i], pl.arm[i], pl.inv[i], pl.lvl[i], pl.xp[i], pl.pot[i], pl.state[i], pl.msg[i]), msg_or_ip, port_or_nil)
      pl.msg[i] = ""
    elseif cmd == "move" then
      parms = atComma(parms)
      movePlayer(parms[1],parms[2])
    elseif cmd == "world" then
      local msgToSend = countPlayers().."|"..countFights().."|"
      local name = parms
      --compile location of current players, including ourselves
      for i = 1, countPlayers() do
        --addMsg("Player "..i.."/"..countPlayers().." is "..getPlayerName(i))
        if isPlayerOnline(getPlayerName(i)) then
          msgToSend = msgToSend..string.format("user|%s|%s|%s|%s|", getPlayerName(i), getPlayerTile(getPlayerName(i)), getPlayerArmour(getPlayerName(i)), getPlayerState(getPlayerName(i)))
        end
      end

      for i = 1, 100*100 do
        if world[i].isFight == true then
          msgToSend = msgToSend..string.format("fight|%s|", i)
        end
      end

      udp:sendto(name.." world "..msgToSend,msg_or_ip,port_or_nil)
    elseif cmd == "fight" then
      parms = atComma(param[1])
      local i = parms[1]
      local x = parms[2]
      local y = parms[3]

      local id = findFightPlayerIsIn(getPlayerID(i))
      setPlayerPos(i,x,y)
  --    addMsg("Player "..i.." is at "..x..","..y)
      -- * Number of players, mobs and spells in fight
      -- * Player X,Y,Armour and HP
      -- * Spell X,Y and type
      -- * Mob X,Y,Type and HP
      if id then
        msgToSend = countMobs(id).."|"..countPlayersInFight(id).."|"

        for i = 1, countPlayersInFight(id) do
          pdata = getPlayerData(id,i)
          msgToSend = msgToSend..string.format("%s|%s|%s|%s|%s|",i,pdata["x"],pdata["y"],pdata["arm"],pdata["hp"]) --id|x|y|arm|hp
        end

        for i = 1, countMobs(id) do-- * All mob info (X,Y,Type,HP)
          tmob = getMobData(id,i)
          msgToSend = msgToSend..string.format("%s|%s|%s|%s|",tmob.x,tmob.y,tmob.type,tmob.hp)
        end

        udp:sendto(i.." fight "..msgToSend,msg_or_ip,port_or_nil)
      end
    elseif cmd == "atk" then  --    netSend("atk",pl.name..","..dir)
      parms = atComma(param[1])
      local name = parms[1]
      local dir = parms[2]

      pl.at[name] = true
      pl.atm[name] = 0.1
    end



  elseif msg_or_ip ~= 'timeout' then
    error("Unknown network error: "..tostring(msg))

    socket.sleep(0.1)
  end

  updateFights(dt)
  updateWorld(dt)
  updatePlayers(dt)
end

function addMsg(msg)
  print(msg)
  msgs = msg.."\n"..msgs
end
