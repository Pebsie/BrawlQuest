tt = {}

function addTT(title,desc,x,y,decay)
  if not decay then decay = 255 end
  i = 1
  tt[i] = {}
  tt[i].title = title
  tt[i].desc = desc
  tt[i].x = x
  tt[i].y = y
  tt[i].visible = true
  tt[i].alpha = 255
  tt[i].decay = decay
end

function drawTooltips()
  for i = 1, #tt do
    if tt[i].visible == true then
      love.graphics.setColor(0,0,0,tt[i].alpha-100)
      local wid = font:getWidth(tt[i].title)+32
      if wid < 128 then
        wid = 128
      end
      width, wrappedText = sFont:getWrap(tt[i].desc,wid)
      love.graphics.rectangle("fill",tt[i].x,tt[i].y,wid,sFont:getHeight()*(#wrappedText+2))
      love.graphics.setColor(255,255,255,tt[i].alpha)
      love.graphics.setFont(font)
      love.graphics.printf(tt[i].title,tt[i].x,tt[i].y,wid,"center")
      love.graphics.setFont(sFont)
      love.graphics.printf(tt[i].desc,tt[i].x,tt[i].y+font:getHeight()+2,wid,"left")
    end
  end
end

function updateTT(dt)
  for i = 1, #tt do
    tt[i].alpha = tt[i].alpha - tt[i].decay*dt
    if tt[i].alpha < 0 then tt[i].alpha = 0 end
  end
end

function removeTooltip()
  tt[i].visible = false
end
