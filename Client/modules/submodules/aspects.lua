function initAspects()
  aspect = {}

  newAspect("Bleeding","pl.hp = pl.hp-1*dt","if love.math.random(1,100) == 1 then return true end")
end

function newAspect(name,effect,antidote)
  aspect[name] = {}
  aspect[name].effect = effect
  aspect[name].description = description
  aspect[name].trigger = trigger
end

function drawAspects()
  if pl.aspectString and pl.aspectString ~= "None" then
    local aspects = atComma(pl.aspectString)
    love.graphics.setFont(font)
    for i, v in pairs(aspects) do
      love.graphics.setColor(0,0,0,200)
      love.graphics.rectangle("fill",screenW-font:getWidth(v),0+(font:getHeight()*(i-1)),font:getWidth(v),font:getHeight())
      love.graphics.setColor(255,255,255,255)
      love.graphics.print(v,screenW-font:getWidth(v),0+(font:getHeight()*(i-1)))
    end
  end
end
