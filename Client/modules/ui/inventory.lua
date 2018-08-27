function drawInventory(x,y)

  pl.selItem = "None"
  local tx = 4
  local ty = 10
  love.graphics.setFont(sFont)
  for i = 1, 25 do
    if cx > x+tx and cx < x+tx+32 and cy > y+ty and cy < y+ty+32 then
      love.graphics.setColor(100,100,100)
    else
      love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("line",x+tx,y+ty,32,32)

    if pl.inv[i] then
      drawItem(pl.inv[i].name,pl.inv[i].amount,x+tx,y+ty)
      if cx > x+tx and cx < x+tx+32 and cy > y+ty and cy < y+ty+32 then
        pl.selItem = pl.inv[i].name
      end
    end

    tx = tx + 36
    if tx > 36*5 then
      tx = 4
      ty = ty + 36
    end
  end
end

--[[for i = 1, #inv, 2 do
  love.graphics.setColor(255,255,255)
  if item.img[inv[i]]--[[ and item.type[inv[i]]--[[ ~= "buddy" then

    --display tooltip
    drawItem(inv[i],inv[i+1],x+tx, y+ty)
    if cx > x+tx and cx < x+tx+32 and cy > y+ty and cy < y+ty+32 then
      pl.selItem = inv[i]
    end

    tx = tx + 36
    if tx > (36*4) then
      tx = 2
      ty = ty + 36
    end
  end
end]]
