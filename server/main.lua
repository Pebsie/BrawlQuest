local socket = require "socket"
local udp = socket.udp()

udp:settimeout(0)
udp:setsockname("*", 26650)

msgs = "Server started."

--game variables here
require "tools"
require "players"
require "fight"

local running = true
print("Entering server loop...")

function love.load()
  newPlayer("Pebsie", "yeswenyan")
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

    if cmd == "login" then
      namePass = atComma(parms)
      addMsg("Player claiming to be "..namePass[1].." is trying to login.")
      if loginPlayer(namePass[1], namePass[2]) then
        udp:sendto(string.format("%s %s %s", namePass[1],  "login", "true"), msg_or_ip, port_or_nil)
        addMsg("He is who he says to be. Let him in, boys!")
      else
        udp:sendto(string.format("%s %s %s", namePass[1], "login", "false"), msg_or_ip, port_or_nil)
        addMsg("He wasn't "..namePass[1]..".")
      end
    end
    --responses to commands here

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
