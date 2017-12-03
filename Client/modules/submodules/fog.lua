function loadFog()
  fog = {}


  if love.filesystem.exists("fog.txt") then
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
  fog.ignore["Gravestone"] = true
end

function checkFog(tile)
  return fog[tile]
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
