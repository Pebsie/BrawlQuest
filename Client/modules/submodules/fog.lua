function loadFog()
  fog = {}
  for i = 1, 100*100 do
    fog[i] = false
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
end

function checkFog(tile)
  return true
end

function addFog(t)
  fog[t] = true

  for k = -195,305,101 do
    for i = -9, -5 do
      fog[t+i+k] = true
    end
  end

end
