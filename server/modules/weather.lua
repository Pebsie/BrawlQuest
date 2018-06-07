function initWeather()
  if not weather then
    weather = {}
    weather.temperature = 11
    weather.condition = "clear"
    weather.time = 9
    weather.day = 1
  end
end

function simulateWeather()
  weather.time = weather.time + 1
  if weather.time > 24 then weather.time = 0 weather.day = weather.day + 1 end

  if weather.time > 0 and weather.time < 5 then
    weather.temperature = weather.temperature + love.math.random(-5,1) --the temperature is more likely to decrease early morning
  elseif weather.time > 5 and weather.time < 12 then
    weather.temperature = weather.temperature + love.math.random(-2,5) --the temperature is more likely to increase during the morning
  elseif weather.time > 12 and weather.time < 17 then
    weather.temperature = weather.temperature + love.math.random(-4,4)
  else
    weather.temperature = weather.temperature + love.math.random(-2,2)
  end

  if weather.temperature > 30 then weather.temperature = 30 end
  if weather.temperature < -5 then weather.temperature = -5 end

  --status simulation
  if weather.temperature > 5 and weather.temperature < 30 and love.math.random(1, 20) == 1 then
    if weather.condition ~= "rain" then addChatMsg("WORLD","Rain begins to fall...") end
    weather.condition = "rain"
  elseif weather.temperature > 15 and love.math.random(1, 20) == 1 then
    if weather.condition ~= "storm" then addChatMsg("WORLD","Thunder rumbles in the distance...") end
    weather.condition = "storm"
  elseif love.math.random(1, 10) == 1 then
    if weather.condition ~= "clear" then addChatMsg("WORLD","The sun peaks out from behind the clouds...") end
    weather.condition = "clear"
  end
end
