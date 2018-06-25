craftingMenu = {
  x = 0,
  y = 0,
  scrn = "menu",
  visible = true,
  width = 36*3,
  height = 36*3
}

function drawCraftingMenu(x,y)
  craftingMenu.x = x
  craftingMenu.y = y

  --love.graphics.setColor(50,50,50)
  --love.graphics.rectangle("fill",craftingMenu.x,craftingMenu.y, craftingMenu.width, craftingMenu.height)

  love.graphics.setColor(255,255,255)
  if craftingMenu.scrn == "menu" then
    local x = 0 + craftingMenu.x
    local y = 4 + craftingMenu.y
    for i = 1, 5 do
      if isMouseOver(x,32*3,y,sFont:getHeight()) == true then
        love.graphics.setColor(100,100,100)
        if love.mouse.isDown(1) then
          if i == 1 then craftingMenu.scrn = "wep"
          elseif i == 2 then craftingMenu.scrn = "spell"
          elseif i == 3 then craftingMenu.scrn = "head armour"
          elseif i == 4 then craftingMenu.scrn = "chest armour"
          elseif i == 5 then craftingMenu.scrn = "leg armour" end
        end
      else
        love.graphics.setColor(0,0,0)
      end
      love.graphics.rectangle("fill",x,y,gameUI[6].width,sFont:getHeight())
      y = y + sFont:getHeight()
    end
    y = 4 + craftingMenu.y
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(sFont)
    love.graphics.printf("Weapons\nMagic\nHead Armour\nChest Armour\nLeg Armour",x,y,32*3,"center")
  else
    local x = 0
    local y = 0
    for i, v in pairs(item.title) do
      if item.type[v] == craftingMenu.scrn then
        drawItem(v,1,craftingMenu.x + x, craftingMenu.y + y, 255)
        x = x + 32
        if x > (32*2) then
          x = 0
          y = y + 32
        end
      end
    end
    x = 0
    y = 80 - sFont:getHeight()
    if isMouseOver(craftingMenu.x+x,32*3,craftingMenu.y+y,sFont:getHeight()) == true then
      love.graphics.setColor(100,100,100)
      if love.mouse.isDown(1) then
        craftingMenu.scrn = "menu"
      end
    else
      love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill",craftingMenu.x + x,craftingMenu.y + y,32*3,sFont:getHeight())
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(sFont)
  --  love.graphics.printf("More recipes can be found through explorations and victories in battle",craftingMenu.x,craftingMenu.y + (y-30),gameUI[6].width,"center")
    love.graphics.printf("Back",craftingMenu.x + x,craftingMenu.y + y,gameUI[6].width,"center")
  end

  --love.graphics.setColor(150,150,150)
--  love.graphics.rectangle("line",craftingMenu.x,craftingMenu.y, craftingMenu.width, craftingMenu.height)
end
