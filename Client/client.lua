socket = require "socket"
http = require("socket.http")
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
        print("Entity is "..ent..", command is "..cmd.." with parameters ("..parms..")")

        param = atComma(parms, "|")

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
        elseif cmd == "char" then
          if ent == pl.name then

            pl.x = tonumber(param[6])
            pl.y = tonumber(param[7])
            pl.t = tonumber(param[8])
            pl.dt = param[9]
            pl.hp = tonumber(param[1])
            pl.en = tonumber(param[2])
            pl.gold = tonumber(param[5])
            pl.lvl = tonumber(param[13])
            pl.xp = tonumber(param[14]) print(pl.xp)
            pl.wep = param[10]
            pl.arm = param[11]
            pl.s1 = param[3]
            pl.s2 = param[4]
            pl.msg = param[15]
            pl.inv = param[12]

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
