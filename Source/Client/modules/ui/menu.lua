menu = {charWhite = 255, charS = 1}

function drawMenu(x,y)
  if isMouseOver(x,64,y,64) then
    love.graphics.setColor(255,255,255)
    addTT("Character","Opens the character window",cx,cy)
    love.graphics.setColor(180,180,180)
    if love.mouse.isDown(1) then gameUI[9].isVisible = true end
  elseif gameUI[9].isVisible == true then
    love.graphics.setColor(100,100,100)
  else
    love.graphics.setColor(255,255,255)
  end
  love.graphics.draw(uiImg["menu-character"],x,y)

  if pl.cp > 0 then
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",x+uiImg["menu-character"]:getWidth()-sFont:getWidth(tostring(pl.cp)),y,sFont:getWidth(tostring(pl.cp)),sFont:getHeight())
    love.graphics.setColor(255,255,255)
    love.graphics.print(pl.cp,x+uiImg["menu-character"]:getWidth()-sFont:getWidth(tostring(pl.cp)),y)
  end

  x = x + 64
  if isMouseOver(x,64,y,64) then
    love.graphics.setColor(255,255,255)
    addTT("Inventory","Opens the inventory window",cx,cy)
    love.graphics.setColor(180,180,180)
    if love.mouse.isDown(1) then gameUI[3].isVisible = true end
  elseif gameUI[3].isVisible == true then
    love.graphics.setColor(100,100,100)
  else
    love.graphics.setColor(255,255,255)
  end
  love.graphics.draw(uiImg["menu-inventory"],x,y)

  x = x + 64
  if isMouseOver(x,64,y,64) then
    love.graphics.setColor(255,255,255)
    addTT("Buddy","Opens the buddy window",cx,cy)
    love.graphics.setColor(180,180,180)
    if love.mouse.isDown(1) then gameUI[7].isVisible = true end
  elseif gameUI[7].isVisible == true then
    love.graphics.setColor(100,100,100)
  else
    love.graphics.setColor(255,255,255)
  end
  love.graphics.draw(uiImg["menu-buddy"],x,y)

  x = x + 64
  if isMouseOver(x,64,y,64) then
    love.graphics.setColor(255,255,255)
    addTT("Quit","Quits the game",cx,cy)
    love.graphics.setColor(180,180,180)
    if love.mouse.isDown(1) then love.event.quit() end
  else
    love.graphics.setColor(255,255,255)
  end
  love.graphics.draw(uiImg["menu-exit"],x,y)
end

function updateMenu(dt)
  if pl.cp > 0 then
    if menu.charS == 1 then
      menu.charWhite = menu.charWhite + 255*dt
      if menu.charWhite > 800 then
        menu.charS = 0
      end
    else
      menu.charWhite = menu.charWhite - 100*dt
      if menu.charWhite < 255 then
        menu.charS = 1
      end
    end
  else
    menu.charWhite = 255
  end
end
