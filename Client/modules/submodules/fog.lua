function loadFog()
  fog = {}


  if love.filesystem.getInfo("fogg.txt") then
      local i = 1
    for line in love.filesystem.lines("fog.txt") do
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
  if not fog[t] then
    fog[t] = 254
  end

  for k = -195,305,101 do
    for i = -9, -5 do
      if fog[t+i+k] and fog[t+i+k] == 255 then
        fog[t+i+k] = 254
      end
    end
  end
end

function saveFog(fn)
  local fs = ""
  for i = 1, 100*100 do
    fs = fs..tostring(fog[i]).."\n"
  end

  love.filesystem.write(fn,fs)
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

      if pl.dt == i then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("line",world[i].x+xo,world[i].y+yo,32,32)
        --love.graphics.draw(worldImg["DT"],world[i].x+xo,world[i].y+yo)
      end

      if ambSnd[world[i].tile] then
        if love.math.random(1, 25000) == 1 and ambSnd[world[i].tile]:isPlaying() == false then
          local ambSound = ambSnd[world[i].tile]
          ambSound:setPitch(love.math.random(75,150)/100)
          love.audio.play(ambSound)
        end
      end
    end
  end

  love.graphics.setColor(255,255,255)
end
