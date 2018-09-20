function loadFog()
  fog = {}


  if love.filesystem.getInfo("fog-"..pl.name.."-"..pl.zone..".txt") then
      local i = 1
    for line in love.filesystem.lines("fog-"..pl.name.."-"..pl.zone..".txt") do
      if line == "true" then
        fog[i] = 0
      else
        fog[i] = 255
      end
      i = i + 1
    end

  else
    for i = 1, 100*100 do
      fog[i] = 255
    end
  end

  fog.ignore = {} --what tile types to ignore
  fog.ignore["Sandy Grass"] = true
  fog.ignore["Sandstone"] = true
  fog.ignore["Mountain"] = true
  fog.ignore["Water"] = true
  fog.ignore["Bridge"] = true
  fog.ignore["Sand"] = true
  fog.ignore["PU"] = true
  fog.ignore["PDL"] = true
  fog.ignore["PDR"] = true
  fog.ignore["PS"] = true
  fog.ignore["PUL"] = true
  fog.ignore["PUR"] = true
  fog.ignore["Graveyard"] = true
  fog.ignore["Cave Floor"] = true
  fog.ignore["Stone Floor"] = true
  fog.ignore["Wall"] = true
  fog.ignore["Wood Wall"] = true
  fog.ignore["Wood Floor"] = true
  fog.ignore["Cold Wall"] = true
  fog.ignore["Cold Mountain"] = true
  fog.ignore["Beach Tree"] = true
  fog.ignore["Portal"] = true
  fog.ignore["Mana Stream"] = true
  fog.ignore["Door"] = true
  fog.ignore["Armoury Door"] = true
  fog.ignore["Barracks Door"] = true
  fog.ignore["Bar Door"] = true
  fog.ignore["Library Door"] = true
end

function updateFog(dt)
  if fog then
    for i,v in ipairs(fog) do
      if fog[i] > 0 and fog[i] ~= 255 then fog[i] = fog[i] - 1000*dt end
    end
  end
end

function checkFog(tile)
  if fog then
    return fog[tile]
  else
    return 255
  end
end

function addFog(t)
  if t then
    if not fog[t] then
      fog[t] = 254
    end

    for k = -195,305,101 do
      for i = -9, -5 do
        if fog[t+i+k] and fog[t+i+k] == 255 then
          fog[t+i+k] = 254
          if world[t+i+k] and lightsource[world[t+i+k].tile] then
            addFog(t+i+k)
          end
        end
      end
    end
  end
end

function saveFog(fn)

  local fs = ""
  for i = 1, 100*100 do
    if tonumber(fog[i]) == 255 then
      fs = fs.."false\n"
    else
      fs = fs.."true\n"
    end

  end

  if fn then
    love.filesystem.write(fn,fs)
  else
    love.filesystem.write("fog-"..pl.name.."-"..pl.zone..".txt",fs)
  end
end

function drawFog(xo,yo)
  for i = 1, 100*100 do
    --we're doing this here because it saves having to do another 100*100 calculation
    if world[i].x-mx > -64 and world[i].x-mx < screenW+64 and world[i].y-my > -64 and world[i].y-my < screenH+64 then

      if world[i].isFight then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(uiImg["fight"],world[i].x+xo,world[i].y+yo)
      end

      if fog[i] == 255 then
        if fog.ignore[world[i].tile] then
          love.graphics.setColor(0,0,0,200)
          love.graphics.rectangle("fill",world[i].x+xo,world[i].y+yo,32,32)
        else
          love.graphics.setColor(50,50,50)
          love.graphics.draw(worldImg[world[i].bg],world[i].x+xo,world[i].y+yo)
        end
        --love.graphics.rectangle("fill",world[i].x+xo,world[i].y+yo,32,32)
        --love.graphics.draw(worldImg["Cloud"], world[i].x+xo, world[i].y+yo)
      elseif fog[i] > 1 then
        love.graphics.setColor(255,255,255)
        love.graphics.draw(worldImg[world[i].bg],world[i].x+xo,world[i].y+yo)
        love.graphics.draw(worldImg[world[i].tile],world[i].x+xo,world[i].y+yo)
        love.graphics.setColor(0,0,0,fog[i])
        love.graphics.rectangle("fill",world[i].x+xo,world[i].y+yo,32,32)
      end
      if fog[i] ~= 255 then

        --  if tileDarkness < 0 then tileDarkness = 0 end
        love.graphics.setColor(255,255,255,255)
        if world[i].spawned ~= "unknown" then
          if mb.img[world[i].spawned] then
            local xi = mb.img[world[i].spawned]:getWidth()/2
            local yi = mb.img[world[i].spawned]:getHeight()/2
            love.graphics.draw(mb.img[world[i].spawned],world[i].x+xo-xi+16,world[i].y+yo-yi+16)
            if isMouseOver((world[i].x+xo)*scaleX,32*scaleX,(world[i].y+yo)*scaleY,32*scaleY) then
              if fightInfo[world[i].fight] and fightInfo[world[i].fight].requested and not fightInfo[world[i].fight].mobs then
                addTT(world[i].fight,"Awaiting fight info...",cx,cy)
              elseif fightInfo[world[i].fight] and fightInfo[world[i].fight].requested and fightInfo[world[i].fight].mobs then
                addTT(world[i].fight,fightInfo[world[i].fight].msg,cx,cy)
              else
                netSend("fightInfo",pl.name..","..world[i].fight)
                fightInfo[world[i].fight] = {requested = true}
                addTT(world[i].fight,"Requesting fight info...",cx,cy)
              end
            end
          else
            love.graphics.draw(uiImg["error"],world[i].x+xo,world[i].y+yo)
            love.graphics.print(world[i].spawned,world[i].x+xo,world[i].y+yo)
          end
        end

      --  tileDarkness = tileDarkness - (lightmap[i]*20)
        love.graphics.setColor(0,0,25,tileDarkness[i])
        love.graphics.rectangle("fill",world[i].x+xo,world[i].y+yo,32,32)
        if love.keyboard.isDown("v") then
          love.graphics.setFont(sFont)
          love.graphics.setColor(255,255,255,255)
          love.graphics.print(round(val),world[i].x+xo,world[i].y+yo)
        end



        if ambSnd[world[i].tile] then
          if love.math.random(1,250) == 1 and ambSnd[world[i].tile]:isPlaying() == false and distanceFrom(world[i].x,world[i].y,world[pl.t].x,world[pl.t].y) < 256 then
            local ambSound = ambSnd[world[i].tile]
            ambSound:setPitch(love.math.random(75,150)/100)
          --  ambSound:setPosition((world[i].x-pl.x),world[i].y-pl.y,1)
            love.audio.play(ambSound)
          end
        end

        if string.sub(world[i].fight,1,6) == "speak|" and distanceFrom(world[i].x,world[i].y,world[pl.t].x,world[pl.t].y) < 92 then
          drawNamePlate("<NPC> "..world[i].tile,world[i].x+xo,world[i].y+yo)
        elseif string.sub(world[i].fight,1,7) == "Gather:" and world[i].spawned ~= "unknown" then --I'm well aware that this whole section is nasty. TODO: make it doable in the editor.
          drawNamePlate("Harvestable",world[i].x+xo,world[i].y+yo,"gather")
        elseif world[i].tile == "Anvil" then
          drawNamePlate("Crafting Anvil",world[i].x+xo,world[i].y+yo)
        elseif string.sub(world[i].fight,1,7) == "Dungeon" then
          drawNamePlate("Dungeon",world[i].x+xo,world[i].y+yo,"dungeon")
        elseif string.sub(world[i].fight,1,4) == "Raid" then
          drawNamePlate("Raid",world[i].x+xo,world[i].y+yo,"dungeon")
        elseif string.sub(world[i].fight,1,4) == "Boss" then
          drawNamePlate("Boss",world[i].x+xo,world[i].y+yo,"dungeon")
        elseif string.sub(world[i].fight,1,8) == "Miniboss" then
          drawNamePlate("Miniboss",world[i].x+xo,world[i].y+yo,"dungeon")
        elseif world[i].tile == "Graveyard" then
          drawNamePlate("Graveyard",world[i].x+xo,world[i].y+yo)
        end
      end




      if pl.dt == i then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("line",world[i].x+xo,world[i].y+yo,32,32)
        --love.graphics.draw(worldImg["DT"],world[i].x+xo,world[i].y+yo)
      end

    end --if tile is on screen
  end --for statement

  love.graphics.setColor(255,255,255)
end

function updateLightmap()
  tileDarkness = {}
  weather.time = tonumber(weather.time)
  for i = 1, 100*100 do
    world[i].spawned = "unknown"
   tileDarkness[i] = 0


    if weather.time == 0 then tileDarkness[i] = 160
    elseif weather.time == 1 then tileDarkness[i] = 150
    elseif weather.time == 2 then tileDarkness[i] = 150
    elseif weather.time == 3 then tileDarkness[i] = 120
    elseif weather.time == 4 then tileDarkness[i] = 100
    elseif weather.time == 5 then tileDarkness[i] = 90
    elseif weather.time == 6 then tileDarkness[i] = 75
    elseif weather.time == 7 then tileDarkness[i] = 30
    elseif weather.time == 8 then tileDarkness[i] = 15
    elseif weather.time == 16 then tileDarkness[i] = 20
    elseif weather.time == 17 then tileDarkness[i] = 40
    elseif weather.time == 18 then tileDarkness[i] = 50
    elseif weather.time == 19 then tileDarkness[i] = 70
    elseif weather.time == 20 then tileDarkness[i] = 90
    elseif weather.time == 21 then tileDarkness[i] = 120
    elseif weather.time == 22 then tileDarkness[i] = 130
    elseif weather.time == 23 then tileDarkness[i] = 150
    elseif weather.time == 24 then tileDarkness[i] = 150 end

    if weather.condition ~= "clear" then tileDarkness[i] = tileDarkness[i] + 25 end



        local val = 0
        local calc = 0
        for k = -195,305,101 do
          for t = -9, -5 do
            if lightmap[t+i+k] then
              val = val + (lightmap[t+i+k]*20 - distanceFrom(world[i].x,world[i].y,world[t+i+k].x,world[t+i+k].y)/32)
              calc = calc + 1
            end
          end
        end

      if val > 0 then
        tileDarkness[i] = tileDarkness[i] - val
      end
    end
end

function createLightmap()
  lightmap = {}
  tileDarkness = {}
  for i = 1, 100*100 do
    if world[i].tile and lightsource[world[i].tile] then lightmap[i] = lightsource[world[i].tile]
    else lightmap[i] = 0 end
    tileDarkness[i] = 0
  end
end
