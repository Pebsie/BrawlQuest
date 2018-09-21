function initAspects()
  aspect = {}

  newAspect("Bleeding","pl.hp = pl.hp-1*dt","if love.math.random(1,100) == 1 then return true end")
  newAspect("Assisted by 3 Drunk Guards","pl.hp = pl.hp-1*dt","if love.math.random(1,100) == 1 then return true end")
end

function newAspect(name,effect,antidote)
  aspect[name] = {}
  aspect[name].effect = effect
  aspect[name].description = description
  aspect[name].trigger = trigger
end

function drawAspects(x,y) --the y position is called by drawActionBar() in modules/ui/actionbar.lua and automatically moves the Y position tot he correct place
  if not x then x = 0 y = 0 end
  if not y then x = 0 y = 0 end
  if pl.aspectString and pl.aspectString ~= "None" then
    local aspects = atComma(pl.aspectString)
    love.graphics.setFont(font)
    for i, v in pairs(aspects) do
      love.graphics.setColor(0,0,0,200)
      love.graphics.rectangle("fill",x,y+(i*font:getHeight()),font:getWidth(v),font:getHeight())
      love.graphics.setColor(255,255,255,255)
      love.graphics.print(v,x,y+(i*font:getHeight()))
    end
  end
end
