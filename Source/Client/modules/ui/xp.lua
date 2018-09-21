--TODO: remove the alive system for optimisation
exp = {}

function addXP(x,y)
  exp[#exp+1] = {x = x, y = y, alive = true}
end

function updateXP(dt)
  --target: gameUI[1].x+40+((pl.xp/100)*63), gameUI[1].y+30
--[[  local targetX = gameUI[1].x+40+((pl.xp/100)*63)
  local targetY = gameUI[1].y+32+10
  for i = 1, #exp do
    local speed = love.math.random(120,160)*dt--distanceFrom(exp[i].x,exp[i].y,targetX,targetY)*dt

    if targetX > exp[i].x then exp[i].x = exp[i].x + speed
    elseif targetX < exp[i].x then exp[i].x = exp[i].x - speed end
    if targetY > exp[i].y then exp[i].y = exp[i].y + speed
    elseif targetY < exp[i].y then exp[i].y = exp[i].y - speed end

    if distanceFrom(exp[i].x,exp[i].y,targetX,targetY) < 16 and exp[i].alive then
      exp[i].alive = false
      pl.xp = pl.xp + 1
      local snd = love.audio.newSource("sound/sfx/xp.wav","static")
      snd:setPitch(0.5+(pl.xp/100))
      love.audio.play(snd)
    end
  end]]
  local roundCur = round(pl.xp)
  if round(pl.xpt) ~= round(pl.xp) then pl.xp = pl.xp + 20*dt end
  if pl.xp > 100 then pl.xp = 0 end
  --if pl.xpt < pl.xp then pl.xp = pl.xpt end
  if round(pl.xp) > roundCur then
    local snd = love.audio.newSource("sound/sfx/xp.wav","static")
    snd:setPitch(0.5+(pl.xp/100))
    snd:setVolume(0.2)
    love.audio.play(snd)
  end
end

function drawXP()
  love.graphics.setColor(100,100,255)
  for i = 1, #exp do
    if exp[i].alive then
  --    love.graphics.rectangle("fill",exp[i].x,exp[i].y,4,4)
    end
  end
end
