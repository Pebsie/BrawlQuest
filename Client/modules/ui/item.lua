--this makes it a lot easier to draw the standardised item. Woo!

function drawItem(name,amount,x,y)

  if cx > x and cx < x+32 and cy > y and cy < y+32 then
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
      pit = "Coinage" piv = "Can be exchanged for goods and services." item.price[name] = amount
    end
    addTT(name,"Level "..item.lvl[name].." "..pit..".\n"..piv.."\nWorth "..item.price[name].." gold.",cx,cy)
    love.graphics.setColor(150,150,150)
  else
    love.graphics.setColor(0,0,0)
  end
  love.graphics.rectangle("fill",x,y,32,32)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(item.img[name],x,y)


  if amount ~= -1 then
    love.graphics.print("x"..amount,x+20,y+20)
  end
end