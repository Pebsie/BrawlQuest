socket = require "socket"
http = require("socket.http")
net = {}
net.id = love.math.random(99999) --THIS SHOULD NOT BE KEPT AS THIS VALUE

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
      --  print("We've got a message!" .. data)
        ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
        --print("Entity is "..ent..", command is "..cmd.." with parameters ("..parms..")")

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

          --  pl.x = tonumber(param[6])
          --  pl.y = tonumber(param[7])
            pl.t = tonumber(param[8])
            pl.dt = param[9]
            pl.hp = tonumber(param[1])
            pl.en = tonumber(param[2])
            if pl.gold < tonumber(param[5]) then
              local msg = ""
              if pl.gold < tonumber(param[5]) then
                msg = "Gained "..tonumber(param[5])-pl.gold.." gold!"
              else
                msg = "Spent "..pl.gold-tonumber(param[5]).." gold!"
              end
              gameUI[4].isVisible = true
              gameUI[4].msg = msg
            end
            pl.gold = tonumber(param[5])
            pl.lvl = tonumber(param[13])
            pl.xp = tonumber(param[14])
            pl.wep = param[10]
            pl.arm = param[11]
            pl.s1 = param[3]
            pl.s2 = param[4]
            --pl.msg = param[18]
            pl.inv = param[12]
          --  love.window.showMessageBox("Debug",pl.inv)
            pl.pot = param[15]
            if param[16] ~= pl.state then  --if we are newly entering this fight
              music.curPlay:stop() --reset music
              pl.x = love.math.random(200, 600) --place players in a line at the bottom of the arena
              pl.y = 380
              pl.s1t = 0
              pl.s2t = 0
              createFightCanvas(pl.t)
              killMobs()
              requestWorldInfo()
            end
            pl.state = param[16]

            if curAreaTitle ~= world[pl.t].name then
              areaTitleAlpha = 400
              curAreaTitle = world[pl.t].name
            end
      --      love.window.showMessageBox("Debug",param[17])
            pl.armd = tonumber(param[17])
            pl.dt = tonumber(param[19])
          --  pl.bud = param[18]


          end
        elseif cmd == "world" then --update world
          for i = 1, 100*100 do --AAAAAH FIX THIS AWFUL CODE
            world[i].isFight = false
          end

          local plyrs = tonumber(param[1])
          local fghts = tonumber(param[2])
          local tparam = 3
          for i = 1, plyrs do --this is awful please stop doing this
            if param[tparam] == "user" then
              local name = param[tparam+1]

              if not playerExists(name) then
                addPlayer(name)
              end

              updatePlayer(name,"t",tonumber(param[tparam+2]))
              updatePlayer(name,"arm",param[tparam+3])
              updatePlayer(name,"state",param[tparam+4])
              updatePlayer(name,"spell",param[tparam+5])
              updatePlayer(name,"buddy",param[tparam+6])

              tparam = tparam + 7
            end
          end

          for i = 1, fghts do
            if param[tparam] == "fight" then
              local tile = tonumber(param[tparam+1])

              world[tile].isFight = true
              --love.window.showMessageBox("debug","There's a fight on tile #"..i)
              tparam = tparam + 2
            end
          end
        elseif cmd == "fight" then
          local mbs = tonumber(param[1])
          local plyrs = tonumber(param[2])

          local tparam = 3
          for i = 1, plyrs do --id|x|y|arm|hp
            local id = param[tparam]
            updatePlayer(id,"tx",tonumber(param[tparam+1]))
            updatePlayer(id,"ty",tonumber(param[tparam+2]))
            updatePlayer(id,"arm",param[tparam+3])
            if getPlayer(id,"hp") > tonumber(param[tparam+4]) then
             addBones("Player",getPlayer(id,"tx"),getPlayer(id,"ty"),(getPlayer(id,"hp")-tonumber(param[tparam+4]))*4)
            end
            updatePlayer(id,"hp",tonumber(param[tparam+4]))
            updatePlayer(id,"spell",param[tparam+5])
        --    updatePlayer(id,"buddy",param[tparam+6])


            --  love.window.showMessageBox("debug",getPlayerName(i)..","..getPlayer(name,"buddy"))
           --love.window.showMessageBox("Debug","Player in fight #"..i.." is ID #"..i.." "..getPlayerName(id))
            tparam = tparam + 6
          end

          for i = 1, mbs do -- * All mob info (X,Y,Type,HP)
          --  love.window.showMessageBox("Debug","Mob "..param[tparam+3].." at ")


          if not doesMobExist(i) or not getMob(i,"hp") then
              addMob(i)
          elseif  param[tparam+4] ~= getMob(i,"id") then
              local k = findMob("id",param[tparam+4])
              if k then
                --new version of mob (order rejigged) so set x and y
                updateMob(i,"x",tonumber(getMob(k,"x")))
                updateMob(i,"y",tonumber(getMob(k,"y")))
             end
          else

          end

            updateMob(i,"tx",tonumber(param[tparam]))
            updateMob(i,"ty",tonumber(param[tparam+1]))
            updateMob(i,"type",param[tparam+2])
            if getMob(i,"hp") > tonumber(param[tparam+3]) then
              if tonumber(param[tparam+3]) < 0.1 then
                addBones(getMob(i,"type"),getMob(i,"x"),getMob(i,"y"),32)
                love.audio.play(sfx["kill"])
                killMob(i)
              else
                if getMob(i,"hp")-tonumber(param[tparam+3]) > 4 then
                  addBones(getMob(i,"type"),getMob(i,"x"),getMob(i,"y"),getMob(i,"hp")-tonumber(param[tparam+3]))
                else
                  addBones(getMob(i,"type"),getMob(i,"x"),getMob(i,"y"),4)
                end
                love.audio.play(sfx["hit"])
              end
            end

            updateMob(i,"hp",tonumber(param[tparam+3]))
            updateMob(i,"id",param[tparam+4])


            tparam = tparam + 5
          end
        end

        if cmd ~= "login" then --if we aren't logged in yet then we don't have a username or position or anything, creating issues with fog.
          createWorldCanvas() --finally, update the world
        end
      elseif msg ~= 'timeout' then
        phase = "login"
        news = news.."\nUnable to connect to the server."
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
