local socket = require "socket"
net = {}
net.id = math.random(99999) --THIS SHOULD NOT BE KEPT AS THIS VALUEm

function netConnect(address, port, updaterate)
  udp = socket.udp()
  udp:settimeout(0)
  udp:setpeername(address, port)
  net.urate = updaterate
  net.t = updaterate
end

function netUpdate(dt)
  net.t = net.t - 1*dt

  if net.t < 0 then
    repeat
      data, msg = udp:receive()

      if data then
        ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")

        --data received, input what you want to occur here

      elseif msg ~= 'timeout' then
          error("Network error: "..tostring(msg))
      end

    until not data
  end
end

function netSend(cmd, var1, var2)
  if not var2 then var2 = "n" end --we're wasting a byte a message because I'm lazy! Woo!
  local dg = string.format("%s %s %f %f", net.id, cmd, var1, var2)
  udp:send(dg)
end

function setUpdateRate(newupdaterate)
  net.urate = updaterate
  net.t = updaterate
end

function setID(newid)
  net.id = newid
end
