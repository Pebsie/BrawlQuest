--This file relates to displaying when mobs speak
speak = {}
speak.mob = "Sorcerer"
speak.text = "Hello world!"
speak.time = 0
speak.totalTime = 0
speak.alpha = 0

function mobSpeak(mobSpeaking,text,time)
  if mobSpeaking == "**player**" then mobSpeaking = pl.name end
  if text ~= speak.text then --as "speak" is a mob, this allows the time bar to work with messages sent from the server
    speak.mob = mobSpeaking
    speak.text = text

    speak.time = 0
    speak.totalTime = tonumber(time)
    speak.alpha = 255
--    newChatMsg(mobSpeaking,text,love.math.random(1,999))
  end
end

function drawSpeak(x,y)
  local by = y

  --draw border
  love.graphics.setColor(50,50,50,speak.alpha)
  if y + (sFont:getWidth(speak.text)/165*sFont:getHeight()) + 16 < y + 40 then
      love.graphics.rectangle("fill", x, y, 200, (sFont:getWidth(speak.text)/165*sFont:getHeight())+56)
  else
      love.graphics.rectangle("fill", x, y, 200, 40+56)
  end
  love.graphics.setFont(font)
  love.graphics.setColor(255,255,255,speak.alpha)
  love.graphics.printf(speak.mob,x,y,200,"center")

  y = y + font:getHeight()+6

  --draw everything else
  love.graphics.setFont(sFont)
  love.graphics.printf(speak.text,x+35,y,165,"left")
  if mb.img[speak.mob] then
    love.graphics.draw(mb.img[speak.mob],x,y)
  elseif speak.mob == pl.name then
    drawPlayer(pl.name,x,y)
  elseif worldImg[speak.mob] then
    love.graphics.draw(worldImg[speak.mob],x,y)
  end

  if y + (sFont:getWidth(speak.text)/165*sFont:getHeight()) + 16 < y + 40 then
    y = y + 40
  else
    y = y + (sFont:getWidth(speak.text)/165*sFont:getHeight()) + 16
  end


  love.graphics.setColor(200,0,0,speak.alpha)
  love.graphics.rectangle("line",x+10,y,180,4)
  love.graphics.rectangle("fill",x+10,y,(speak.time/speak.totalTime)*180,4)

  --border
  love.graphics.setColor(150,150,150,speak.alpha)
  love.graphics.rectangle("line",x,by, 200, 4+y-by)
end

function updateSpeak(dt)
  speak.time = speak.time + 1*dt
  if not speak.time or not speak.totalTime then speak.time = 5 speak.totalTime = 5 speak.text = "Error" speak.mob = pl.name end
  if speak.time > speak.totalTime then
    speak.time = speak.totalTime
    speak.alpha = speak.alpha - 200*dt
  end
end
