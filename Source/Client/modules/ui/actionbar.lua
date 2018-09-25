function drawActionBar(x,y)
  --boxes
  love.graphics.setColor(51,51,51)
  love.graphics.rectangle("fill",x,y,640,94) --main background
  love.graphics.setColor(0,0,0) --item backgrounds
  love.graphics.rectangle("fill",x+10,y+60,24,24) --wep image
  love.graphics.rectangle("fill",x+43,y+60,24,24) --potion image
  love.graphics.rectangle("fill",x+464,y+16,64,64) --spell 1
  love.graphics.rectangle("fill",x+559,y+16,64,64) --spell 2
  love.graphics.rectangle("fill",x+6,y+6,32,32) --character portrait
  love.graphics.setColor(43,43,43)

  --stats
  love.graphics.setColor(0,255,0)
  love.graphics.rectangle("fill",x+40,y+6,(pl.hp/(100+pl.sta*5))*63,6) --health
  love.graphics.setColor(255,216,0)
  love.graphics.rectangle("fill",x+40,y+18,(pl.en/(100+pl.agl*10))*63,6) --energy
  love.graphics.setColor(100,100,255)
  love.graphics.rectangle("fill",x+40,y+30,(pl.xp/100)*63,6) --xp
  love.graphics.setColor(0,100,0)
  love.graphics.rectangle("line",x+40,y+6,63,6) --health container
  love.graphics.setColor(205,166,0)
  love.graphics.rectangle("line",x+40,y+18,63,6) --energy container
  love.graphics.setColor(100,100,255)
  love.graphics.rectangle("line",x+40,y+30,63,6) --xp container

  love.graphics.setColor(255,255,255)
  love.graphics.setFont(sFont)
  love.graphics.print(round(pl.hp).."%",x+40+65,y+4)
  love.graphics.print(round(pl.en).."%",x+40+65,y+16)
  love.graphics.print(round(pl.xp).."%",x+40+65,y+28)

  love.graphics.setColor(255,255,255)
  love.graphics.draw(item[pl.wep].img,x+9,y+56)
  love.graphics.draw(item[pl.pot].img,x+43,y+56)
  drawPlayer(pl.name,x+6,y+6)--love.graphics.draw(item.img[pl.arm],x+6,y+6)
  love.graphics.draw(uiImg["itemportrait"],x+6,y+56)
  love.graphics.draw(uiImg["itemportrait"],x+39,y+56)
  love.graphics.draw(uiImg["smallportrait"],x+6,y+6)

  if pl.s1 ~= "None" and (pl.s1t > 0 or pl.en < tonumber(atComma(item[pl.s1].val)[2])) then
    love.graphics.setColor(255,255,255,100)
  end
  love.graphics.draw(item[pl.s1].img,x+464,y+16,0,2,2)

    if pl.s2 ~= "None" and (pl.s2t > 0 or pl.en <  tonumber(atComma(item[pl.s2].val)[2])) then
      love.graphics.setColor(255,255,255,100)
    else
      love.graphics.setColor(255,255,255,255)
    end
  love.graphics.draw(item[pl.s2].img,x+559,y+16,0,2,2)
  love.graphics.setColor(255,255,255,255)

  --love.graphics.draw(uiImg["lvtmp"],x+13,y+37)
  love.graphics.draw(uiImg["atkdef"],x+139,y+49)

  --text
  love.graphics.setFont(font)
  love.graphics.setColor(76,255,0)
  love.graphics.printf(item[pl.wep].val+pl.str,x+114,y+52,24,"center")
  if round(pl.armd) ~= 0 then
    love.graphics.setColor(255,0,0)
  end

  if player[pl.name] and player[pl.name].arm_head and player[pl.name].arm_chest and player[pl.name].arm_legs and item[player[pl.name].arm_head].val and item[player[pl.name].arm_chest].val and item[player[pl.name].arm_legs].val then
    love.graphics.printf(round((item[player[pl.name].arm_head].val+item[player[pl.name].arm_chest].val+item[player[pl.name].arm_legs].val) - pl.armd),x+114,y+72,24,"center")
  else
    love.graphics.printf("??",x+114,y+72,24,"center")
  end

  love.graphics.setColor(255,242,132)
  love.graphics.print("LV "..pl.lvl,x+42,y+37)


  --action prompts (text)
  love.graphics.setColor(200,200,255)
  love.graphics.print("R",x+45+5,y+56+23)
  love.graphics.setFont(bFont)
  love.graphics.print("Q",x+464+28,y-5)
  love.graphics.print("E",x+559+28,y-5)


  love.graphics.rectangle("fill",x+173,y+7,268,79) --

  --spell timers
  love.graphics.setColor(255,0,0)
      if pl.s1t > 0 then
        love.graphics.print(round(pl.s1t),x+474,y+16)
      end
      if pl.s2t > 0 then
        love.graphics.print(round(pl.s2t),x+569,y+16)
      end

  drawChat(x+173,y+7,268,79)

  --border
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("line",x,y,640,94)

  love.graphics.setColor(255,255,255)

  local aspects = atComma(pl.aspectString) --TODO: make the network part of the client do this automatically and store it in pl.aspects
  drawAspects(x,y-(#aspects*font:getHeight())-font:getHeight()*2)
end
