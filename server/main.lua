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
  loadOverworld()
  newPlayer("demo","demo")
  --newFight(1, "Boar Hunt")
  --addPlayerToFight(1, "Pebsie")
end

function love.draw()
  love.graphics.print(msgs)
end

function love.update(dt)
  data, msg_or_ip, port_or_nil = udp:receivefrom()
  if data then
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
      udp:sendto(string.format("%s %s %s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s", i, "char", pl.hp[i], pl.en[i], pl.s1[i], pl.s2[i], pl.gold[i], pl.x[i], pl.y[i], pl.t[i], pl.dt[i], pl.wep[i], pl.arm[i], pl.inv[i], pl.lvl[i], pl.xp[i], pl.msg[i], pl.pot[i]), msg_or_ip, port_or_nil)
      pl.msg[i] = ""
    elseif cmd == "move" then
      parms = atComma(parms)
      movePlayer(parms[1],parms[2])
    elseif cmd == "world" then
      local msgToSend = ""

      --compile location of current players, including ourselves
      for i = 1, countPlayers() do
        if isPlayerOnline(getPlayerName(i)) then
          msgToSend = msgToSend..string.format("%s|%s|", getPlayerName(i), getPlayerTile(getPlayerName(i)))
        end
      end

      udp:sendto(",world,"..msgToSend,msg_or_ip,port_or_nil)
    end



  elseif msg_or_ip ~= 'timeout' then
    error("Unknown network error: "..tostring(msg))

    socket.sleep(0.1)
  end

  updateFights(dt)
end

function addMsg(msg)
  print(msg)
  msgs = msg.."\n"..msgs
end
