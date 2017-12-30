--this makes it a lot easier to draw the standardised item. Woo!

function drawItem(name,amount,x,y,alpha)
  if not alpha then alpha = 255 end

  if cx > x and cx < x+32 and cy > y and cy < y+32 then
    local itemCost = atComma(item.price[name])
    --get phonetic item type name
    local pit = "unknown"
    local cit = item.type[name]
    local piv = "None"
    local civ = item.val[name]
    if cit == "wep" then pit = "Weapon" piv = "Deals up to "..civ.." damage."
    elseif cit == "arm" then pit = "Armour" piv = "Defends for "..civ.." damage."
    elseif cit == "hp" then pit = "Health Potion" piv = "Recovers "..civ.." health over 3 seconds."
    elseif cit == "en" then pit = "Energy Potion" piv = "Instantly recovers "..civ.." energy."
    elseif cit == "Craftable" then pit = "Craftable" piv = "Can be used in crafting."
    elseif cit == "Key" then pit = "Key" piv = "Opens doors."
    elseif cit == "buddy" then pit = "Buddy" piv = "Your new best friend. "..item.desc[name]
    elseif cit == "Spell" then
      pit = "Spell"
      piv = '"'..item.desc[name]..'."'
      local stats = atComma(item.val[name])
      piv = piv.."\n"..stats[1].." second cooldown.\nRequires "..stats[2].." energy."
    elseif cit == "Letter" then
      pit = "Letter" piv = "A letter. Want to read it?"
    elseif cit == "currency" then
      pit = "Coinage" piv = "Can be exchanged for goods and services." itemCost[1] = amount
    end
    addTT(name,"Level "..item.lvl[name].." "..pit..".\n"..piv.."\nWorth "..itemCost[1].." "..itemCost[2].." .",cx,cy)
    love.graphics.setColor(150,150,150,alpha)
  else
    love.graphics.setColor(0,0,0,alpha)
  end
  love.graphics.rectangle("fill",x,y,32,32)
  love.graphics.setColor(255,255,255,alpha)
  love.graphics.draw(item.img[name],x,y)


  if tonumber(amount) > 1 then
    love.graphics.setFont(sFont)
    love.graphics.setColor(0,0,0,150)
    love.graphics.rectangle("fill",x,y+20,32,sFont:getHeight())
    love.graphics.setColor(255,255,255,alpha)
    love.graphics.printf("x"..amount,x,y+20,32,"right")
  end
end
