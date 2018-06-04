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
            if pl.t ~= tonumber(param[8]) then
              addFog(tonumber(param[8]))
            end

            if pl.t ~= tonumber(param[8]) and tonumber(param[8]) == pl.dt then
              whiteOut = 500
              love.audio.play(sfx["awake"])
              mobSpeak("**player**","W-where am I?",5)
            end
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
            if param[12] ~= pl.inv and pl.inv then --inventory has changed, we need to display the changes!
              local oldInv = atComma(pl.inv,";")
              local newInv = atComma(param[12],";")

              for i = 1, #newInv, 2 do
                local isNewItem = "No" --not a bool to save having to create variables for each condition
                if oldInv[i] then --does this part even exist?
                  if oldInv[i] == newInv[i] then
                    if oldInv[i+1] ~= newInv[i+1] then
                      isNewItem = "NewAmount"
                    end
                  else
                    isNewItem = "Yes"
                  end
                else
                  isNewItem = "Yes"
                end

                if isNewItem == "Yes" then
                  newLoot(newInv[i],newInv[i+1])
                elseif isNewItem == "NewAmount" then
                  newLoot(newInv[i],tonumber(newInv[i+1])-tonumber(oldInv[i+1]))
                end
              end
            end

            pl.inv = param[12]
          --  love.window.showMessageBox("Debug",pl.inv)
            pl.pot = param[15]
            if pl.state ~= param[16] then music.curPlay:stop() end --reset music
            if pl.state ~= "fight" and param[16] == "fight" then
              love.graphics.setBackgroundColor(45, 139, 255)
              pl.x = love.math.random(200, 600) --place players in a line at the bottom of the arena
              pl.y = 380
              pl.s1t = 0
              pl.s2t = 0
              createFightCanvas(pl.t)
              killMobs()
              requestWorldInfo()
            elseif pl.state ~= "afterfight" and param[16] == "afterfight" then
              love.audio.play(sfx["victory"])
              pl.x = love.math.random(200, 600) --place players in a line at the bottom of the arena
              pl.y = 380
              killMobs()
            elseif pl.state ~= "fight" then
              love.graphics.setBackgroundColor(0,0,0)
            end
            pl.state = param[16]

            if curAreaTitle ~= world[pl.t].name then
              areaTitleAlpha = 400
              curAreaTitle = world[pl.t].name
            end
      --      love.window.showMessageBox("Debug",param[17])
            pl.armd = tonumber(param[17])
            pl.dt = tonumber(param[19])
            pl.str = param[20]
            pl.owed = param[21]
            pl.score = param[22]
            pl.combo = param[23]
            pl.aspectString = param[24]

            local i = loginI.select
            if pl.arm and pl.wep and pl.buddy then
              loadedCharacter[i].arm = pl.arm
              loadedCharacter[i].wep = pl.wep
              loadedCharacter[i].bud = pl.buddy
            end
            saveCharacters()


          end
        elseif cmd == "world" then --update world
          local plyrs = tonumber(param[1])
          local fghts = tonumber(param[2])
          local bcs = tonumber(param[3]) --broadcast chats
          local tparam = 4
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
              if name == pl.name then pl.buddy = param[tparam+6] end
              updatePlayer(name,"online",param[tparam+7])

              tparam = tparam + 8
            end
          end

          for i = 1, 100*100 do --cycle through the world to calculate player positions and turn off all fights
            world[i].isFight = false


            for k = 1,countPlayers() do
              local name = getPlayerName(k)
              if getPlayer(name,"t") == i and getPlayer(name,"state") == "world" then
                player[name].tx = world[i].x
                player[name].ty = world[i].y
              end
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

          for i = 1, bcs do --broadcast chats
            newChatMsg(param[tparam],param[tparam+1],param[tparam+2])
            tparam = tparam + 3
          end

          weather.time = param[tparam]
          weather.temperature = param[tparam+1]
          weather.condition = param[tparam+2]
          tparam = tparam + 3
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

          --we need to cycle through every existing mob and set their "updated" attribute to false so that we can see who is and isn't still alive
          for i = 1, countMobs() do
            updateMob(i,"updated",false)
          end

          for i = 1, mbs do -- * All mob info (X,Y,Type,HP)
          --  love.window.showMessageBox("Debug","Mob "..param[tparam+3].." at ")

          if not doesMobExist(i) then
              addMob(i)
          elseif  param[tparam+5] ~= getMob(i,"id") then
              local k = findMob("id",param[tparam+5])
              if k then
                --new version of mob (order rejigged) so set x and y
                if tonumber(getMob(k,"x")) > stdSW or tonumber(getMob(k,"x")) < 0 and tonumber(getMob(k,"y")) > stdSH then --mob is outside bounds of screen
                  local boneCount = 10
                --  if getMob(i,"mhp") > 2000 and getMob(i,"mhp") < 20000 then boneCount = 100 elseif getMob(i,"mhp") > 30 then boneCount = 15 end
                --  addBones(getMob(i,"type"),getMob(i,"x")+mb.img[getMob(i,"type")]:getWidth()/2,getMob(i,"y")+mb.img[getMob(i,"type")]:getHeight()/2,boneCount,getMob(i,"id"))
                end

                updateMob(i,"x",tonumber(getMob(k,"x")))
                updateMob(i,"y",tonumber(getMob(k,"y")))
             end
          else

          end

            updateMob(i,"tx",tonumber(param[tparam]))
            updateMob(i,"ty",tonumber(param[tparam+1]))
            updateMob(i,"type",param[tparam+2])
            if getMob(i,"hp") > tonumber(param[tparam+3]) then
              if tonumber(param[tparam+3]) < 1 then
                love.audio.play(sfx["kill"])
              else
              --[[  if getMob(i,"hp")-tonumber(param[tparam+3]) > 4 and mb.friend[getMob(i,"type")] == false then
                  addBones(getMob(i,"type"),getMob(i,"x"),getMob(i,"y"),getMob(i,"hp")-tonumber(param[tparam+3]))
                else
                  addBones(getMob(i,"type"),getMob(i,"x"),getMob(i,"y"),4)
                end]]
                love.audio.play(sfx["hit"])

                if not mb.friend[getMob(i,"type")] and getMob(i,"id") == param[tparam+5] then
                  createFloat("-"..round(getMob(i,"hp")-tonumber(param[tparam+3])),255,100,100,getMob(i,"x")+mb.img[getMob(i,"type")]:getWidth()/2,getMob(i,"y"),getMob(i,"id"),false)
                end
              end
            end

            if getMob(i,"id") ~= param[tparam+5] then
            --  addBones(getMob(i,"type"),getMob(i,"x"),getMob(i,"y"),4)
            end

            updateMob(i,"hp",tonumber(param[tparam+3]))
            updateMob(i,"mhp",tonumber(param[tparam+4]))
            updateMob(i,"id",param[tparam+5])
            updateMob(i,"updated",true)

            if string.sub(param[tparam+2],1,5) == "speak" then
              local speakInfo = atComma(param[tparam+2])
              mobSpeak(speakInfo[2],speakInfo[3],speakInfo[4])
              killMob(i)
            end

            tparam = tparam + 6
          end

          fight.highscore = param[tparam]
          fight.highscorePlayer = param[tparam+1]
          tparam = tparam + 2
          --now we need to cycle through every mob and kill those that no longer exist
          for i = 1, countMobs() do
            if getMob(i,"updated") == false and getMob(i,"id") ~= -1 then
              killMob(i)
            end
          end
        end

        if cmd ~= "login" then --if we aren't logged in yet then we don't have a username or position or anything, creating issues with fog.
        --  createWorldCanvas() --finally, update the world
          createWorldObjectCanvas()
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
