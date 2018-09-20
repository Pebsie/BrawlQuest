function drawCharacterWindow(x,y,name)
  local i = 9 --gameUI window (to prevent this being hardcoded)

  drawPlayer(pl.name,x+32,y,"none",2)
  love.graphics.setFont(font)
  love.graphics.printf(pl.name,x,y+64,128,"center")

  love.graphics.setFont(sFont)

  love.graphics.printf("Level "..tostring(pl.lvl).." "..getClass(),x,y+64+font:getHeight(),128,"center")

  love.graphics.setFont(font)

  love.graphics.draw(uiImg["atk"],x+4,y+64+font:getHeight()+sFont:getHeight())
  love.graphics.print(item[pl.wep].val,x+32,y+70+font:getHeight()+sFont:getHeight())

  love.graphics.draw(uiImg["def"],x+68,y+64+font:getHeight()+sFont:getHeight())
  if player[pl.name] then --if we've received data about ourselves yet (otherwise leave this blank!)
    love.graphics.print(getArmourValue(pl.name),x+96,y+70+font:getHeight()+sFont:getHeight())
  end

  love.graphics.printf("Item Level: "..getIlvl(),x,y+64+font:getHeight()+sFont:getHeight()+32,128,"center")

  local ty = y+64+font:getHeight()*2+sFont:getHeight()+40

  if isMouseOver(x,128,ty,font:getHeight()) then
    ttMsg = "Strength.\nSlightly improves melee damage potential and massively improves critical hit damage."
    if pl.cp > 0 then
      love.graphics.setColor(0,150,0)
      ttMsg = ttMsg.."\nLeft click to increase by +1."
    else
      love.graphics.setColor(200,200,200)
    end

    addTT("Character Attribute",ttMsg,love.mouse.getX(),love.mouse.getY())
  end
  love.graphics.printf("STR: "..pl.str,x,ty,128,"center")
  love.graphics.setColor(255,255,255)
  ty = ty + font:getHeight()

  if isMouseOver(x,128,ty,font:getHeight()) then
    ttMsg = "Intelligence.\nImproves all spell value output by 50% for each point."
    if pl.cp > 0 then
      love.graphics.setColor(0,150,0)
      ttMsg = ttMsg.."\nLeft click to increase by +1."
    else
      love.graphics.setColor(200,200,200)
    end

    addTT("Character Attribute",ttMsg,love.mouse.getX(),love.mouse.getY())
  end
  love.graphics.printf("INT: "..pl.int,x,ty,128,"center")
  love.graphics.setColor(255,255,255)
  ty = ty + font:getHeight()


  if isMouseOver(x,128,ty,font:getHeight()) then
    ttMsg = "Stamina.\nIncreases health by 5% for each point."
    if pl.cp > 0 then
      love.graphics.setColor(0,150,0)
      ttMsg = ttMsg.."\nLeft click to increase by +1."
    else
      love.graphics.setColor(200,200,200)
    end

    addTT("Character Attribute",ttMsg,love.mouse.getX(),love.mouse.getY())
  end
  love.graphics.printf("STA: "..pl.sta,x,ty,128,"center")
  love.graphics.setColor(255,255,255)
  ty = ty + font:getHeight()


  if isMouseOver(x,128,ty,font:getHeight()) then
    ttMsg = "Agility.\nIncreases energy by 10% for each point."
    if pl.cp > 0 then
      love.graphics.setColor(0,150,0)
      ttMsg = ttMsg.."\nLeft click to increase by +1."
    else
      love.graphics.setColor(200,200,200)
    end

    addTT("Character Attribute",ttMsg,love.mouse.getX(),love.mouse.getY())
  end
  love.graphics.printf("AGL: "..pl.agl,x,ty,128,"center")
  love.graphics.setColor(255,255,255)
  ty = ty + font:getHeight()




  --STR: "..pl.str.."\nINT: "..pl.int.."\nSTA: "..pl.sta.."\nAGL: "..pl.agl.."\n

  if pl.cp > 0 then
    love.graphics.setFont(sFont)
    love.graphics.printf("You've got "..tonumber(pl.cp).." character points to spend! Click on attributes to increase them.",x,y+64+font:getHeight()*8+sFont:getHeight()+32,128,"center")
  else
    love.graphics.printf("Level up to earn more character points!",x,y+64+font:getHeight()*8+sFont:getHeight()+32,128,"center")
  end
end

function getClass() --gets an assumed class name for the player based on their stats
  local result = ""
  local cp = pl.str + pl.int + pl.sta + pl.agl

  if cp > 3 then
    if pl.str > (pl.int+pl.sta+pl.agl)/cp then
      result = "Warrior"
    elseif pl.int > (pl.str+pl.sta+pl.agl)/cp then
      result = "Wizard"
    elseif pl.sta > (pl.str+pl.sta+pl.agl)/cp then
      result = "Barbarian"
    elseif pl.agl > (pl.str+pl.sta+pl.agl)/cp then
      result = "Hunter"
    else
      result = "Soldier"
    end
  elseif cp == 0 then
    result = "Civilian"
  else
    result = "Adventurer"
  end

  if pl.int > 4 then result = "Wise "..result end
  if pl.str > 4 then result = "Strong "..result end
  if pl.agl > 4 then result = "Agile "..result end
  if pl.sta > 4 then result = "Tough "..result end

  return result
end

function getIlvl()
  return round((item[pl.arm_head].lvl + item[pl.arm_chest].lvl + item[pl.arm_legs].lvl + item[pl.wep].lvl)/4)
  --eturn item[pl.arm_legs].lvl
end
