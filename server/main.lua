local socket = require "socket"
local udp = socket.udp()

udp:settimeout(0)
udp:setsockname("*", 26650)

--game variables here
require "tools"
require "players"
require "fight"

local running = true
print("Entering server loop...")

function love.load()
  newPlayer("Pebsie", "yeswenyan")
  newFight(1, "Boar Hunt")
  addPlayerToFight(1,"Pebsie")
end

function love.update(dt)
  data, msg_or_ip, port_or_nil = udp:receivefrom()
  if data then
    entity, cmd, parms = data:match("^(%S*) (%S*) (.*)")

    --responses to commands here

  elseif msg_or_ip ~= 'timeout' then
    error("Unknown network error: "..tostring(msg))

    socket.sleep(0.1)
  end

  updateFights(dt)
end
