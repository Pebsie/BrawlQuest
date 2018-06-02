--[[
Aspects feature

Things to note:
* 'effect' is code that alters the player every frame. Leave this blank if the effect is to be hardcoded.
* 'antidote' is a condition that should return true or false and is checked every frame
]]

function initAspects()
  aspect = {}

  newAspect("Bleeding","","if love.math.random(1,1000) == 1 then return true end")
end

function newAspect(name,effect,antidote)
  aspect[name] = {}
  aspect[name].effect = loadstring(effect)
  aspect[name].trigger = trigger
  aspect[name].antidote = loadstring(antidote)
end

function inflictAspect(playerName,effect)
  if not playerHasAspect(playerName,effect) then
    pl.aspects[playerName][#pl.aspects+1] = effect
    addMsg(playerName.." is now inflicted with "..effect.."!")
  end
end

function playerHasAspect(playerName,effect)
  for i, v in pairs(pl.aspects[playerName]) do
    if v == effect then
      local hasAspect = true
    end
  end

  return hasAspect
end
