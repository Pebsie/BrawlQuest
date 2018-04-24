function loadFog()
  fog = {}


  if love.filesystem.getInfo("fog.txt") then
      local i = 1
    for line in love.filesystem.lines("fog.txt") do
      if line == "true" then
        fog[i] = true
      else
        fog[i] = false
      end
      i = i + 1
    end

  else
    for i = 1, 100*100 do
      fog[i] = false
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

function checkFog(tile)
  if fog then
    return fog[tile]
  else
    return false
  end
end

function addFog(t)
  fog[t] = true

  for k = -195,305,101 do
    for i = -9, -5 do
      fog[t+i+k] = true
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
  love.graphics.setColor(0,0,0)

  for i = 1, 100*100 do
    if not fog[i] then
      --love.graphics.draw(worldImg[world[i].bg],world[i].x+xo,world[i].y+yo)
      if world[i].x-mx > -64 and world[i].x-mx < screenW+64 and world[i].y-my > -64 and world[i].y-my < screenH+64 then

        love.graphics.rectangle("fill",world[i].x+xo,world[i].y+yo,32,32)
      --  love.graphics.draw(worldImg["Cloud"], world[i].x+xo, world[i].y+yo)
      end
    end
  end
  
  love.graphics.setColor(255,255,255)
end
