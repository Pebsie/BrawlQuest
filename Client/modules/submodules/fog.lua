function loadFog()
  fog = {}
  for i = 1, 100*100 do
    fog[i] = false
  end
end

function checkFog(tile)
  return fog[tile]
end

function addFog(t)
  fog[t] = true

  for k = -495,505,101 do
    for i = -20, 0 do
      fog[t+i+k] = true
    end
  end

end
