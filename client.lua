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
        print("We've got a message!" .. data)
        ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")

        param = {}
        for word in parms:gmatch("([^%s]+)") do  param[#param+1] = word end --split params at space

        --data received, input what you want to occur here
        if cmd == "login" then
          if ent == pl.name then --verification to prevent hacking
            if param[1] == "true" then
              enterGame()
            else
              phase = "login"
              pl.cinput = ""
              ui.selected = "username"
            end
          end
        end

      elseif msg ~= 'timeout' then
          error("Network error: "..tostring(msg))
      end

    until not data

    net.t = 0.1
  end
end

function netSend(cmd, var1)

  local dg = string.format("%s %s %s", net.id, cmd, var1)
  udp:send(dg)
end

function setUpdateRate(newupdaterate)
  net.urate = updaterate
  net.t = updaterate
end

function setID(newid)
  net.id = newid
end
