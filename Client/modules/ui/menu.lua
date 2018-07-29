function drawMenu(x,y)
  love.graphics.draw(uiImg["menu-character"],x,y)
  x = x + 64
  love.graphics.draw(uiImg["menu-inventory"],x,y)
  x = x + 64
  love.graphics.draw(uiImg["menu-buddy"],x,y)
  x = x + 64
  love.graphics.draw(uiImg["menu-exit"],x,y)
end
