floats = {}
numFloats = 0

function createFloat(text,r,g,b,x,y,id,append)
  local foundFloat = false

  if append == true then
    for i = 1, numFloats do
      if id == floats[i].id then
        foundFloat = true
        --if id == "atk" then
          floats[i].text = tonumber(floats[i].text) + text
        --[[elseif id == "dmg" then
          floats[i].text = tonumber(floats[i].text) + text
        end]]

        floats[i].alpha = 255
        floats[i].y = y
      end
    end
  elseif append == false or foundFloat == false then
    numFloats = numFloats + 1
    floats[numFloats] = {text=text,r=r,g=g,b=b,x=x,y=y,alpha=255}
  end
end

function drawFloats()
--  if not fxoff then fxoff = 0 end
if not xoff then xoff = 0 end
if not yoff then yoff = 0 end
love.graphics.setFont(sFont)
  --if not fyoff then fyoff = 0 end
  for i = 1, numFloats do
    love.graphics.setColor(0,0,0,floats[i].alpha)
    love.graphics.rectangle("fill",floats[i].x+xoff,floats[i].y+yoff,sFont:getWidth(floats[i].text),sFont:getHeight())
    love.graphics.setColor(floats[i].r,floats[i].g,floats[i].b,floats[i].alpha)
    love.graphics.print(floats[i].text,floats[i].x+xoff,floats[i].y+yoff)
  end

  love.graphics.setColor(255,255,255,255)
end

function updateFloats(dt)
  for i = 1, numFloats do
    floats[i].y = floats[i].y - 20*dt
    floats[i].alpha = floats[i].alpha - 100*dt

    if floats[i].alpha < 0 then
      if i ~= numFloats then
       floats[i] = floats[numFloats]
      end
      numFloats = numFloats - 1
    end
  end
end
