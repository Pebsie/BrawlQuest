function drawGame()
  if ui.selected == "map" then
    for i = 1, 100 do
      for k = 1, 100 do
        if pl.t == i*k then
          love.graphics.draw(item.img[pl.arm],i,k)
          --love.graphics.rectangle("fill", i*16, k*16, 16, 16)
        else
          love.graphics.setColor(255,255,255)
        end
        love.graphics.rectangle("line", i*32, k*32, 32, 32)
        --love.graphics.print(i*k, i*32, k*132)
      end
    end
  end
  if item.val[pl.wep] and item.val[pl.arm] then
    love.graphics.print(pl.name.." - "..item.val[pl.wep].." ATK ("..pl.wep..") - "..item.val[pl.arm].." DEF ("..pl.arm..") - Tile "..pl.t)
  else
    love.graphics.print("Awaiting character info...")
  end
end
