weather = {}
weather.time = 0

weather.tileDarkness = {}

function drawLight(x,y,i)

  --  if tileDarkness < 0 then tileDarkness = 0 end

  --  tileDarkness = tileDarkness - (lightmap[i]*20)
  love.graphics.setColor(0,0,25,weather.tileDarkness[i])
  love.graphics.rectangle("fill",x,y,32,32)
end
