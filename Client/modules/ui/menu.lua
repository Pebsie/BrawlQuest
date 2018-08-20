function drawMenu(x,y)
  if isMouseOver(x,64,y,64) then
    love.graphics.setColor(255,255,255)
    addTT("Character","Opens the character window",cx,cy)
    love.graphics.setColor(180,180,180)
    if love.mouse.isDown(1) then gameUI[1].isVisible = true end
  elseif gameUI[1].isVisible == true then
    love.graphics.setColor(200,200,200)
  else
    love.graphics.setColor(255,255,255)
  end
  love.graphics.draw(uiImg["menu-character"],x,y)

  x = x + 64
  if isMouseOver(x,64,y,64) then
    love.graphics.setColor(255,255,255)
    addTT("Inventory","Opens the inventory window",cx,cy)
    love.graphics.setColor(180,180,180)
    if love.mouse.isDown(1) then gameUI[3].isVisible = true end
  elseif gameUI[3].isVisible == true then
    love.graphics.setColor(200,200,200)
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
    love.graphics.setColor(200,200,200)
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
