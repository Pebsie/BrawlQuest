--called by interface

function drawLogin() --login screen
  love.graphics.setBackgroundColor(45, 139, 255)

  for i = 1, 3 do
    love.graphics.draw(loginImg["cloud"],lclouds.x[i],lclouds.y[i])
  end

  love.graphics.draw(loginImg["mountain"], litems["mountains"], 0)

  love.graphics.draw(loginImg["ground"], litems["ground"], sh-96)

  love.graphics.draw(loginImg["tree"],litems["ground"],-20)

  love.graphics.draw(item.img["Old Cloth"],litems["player"],sh-40)
  love.graphics.draw(bli[bli.s],litems["player"]+40,sh-40)

  love.graphics.setColor(64,64,64) --background for text entry
  love.graphics.rectangle("fill",296,31+(373/2),(407/2),32)
  love.graphics.setColor(0,127,14) --login button
  love.graphics.rectangle("fill",296,31+(373/2)+32,(407/2),16)
  love.graphics.setColor(128,128,128)
  love.graphics.rectangle("line",296,31+(373/2),(407/2),16)
  love.graphics.rectangle("line",296,31+(373/2)+16,(407/2),16)
  love.graphics.rectangle("line",296,31+(373/2)+32,(407/2),16)
  love.graphics.setColor(255,255,255)


  local pstring = ""
  for i = 1, string.len(pl.cinput) do pstring = pstring.."*" end

  love.graphics.printf("LOGIN",296,31+(373/2)+32,(407/2),"center")
  love.graphics.print("BrawlQuest "..version)
  love.graphics.setFont(sFont)
  love.graphics.print("Created and programmed by Thomas Lock (http://peb.si)\nGraphics by D.Gervais (used here under a Creative Commons Attribution 3.0 licence)\nLogo created by Danjoe Stubbs\nSpecial thanks to Sam Warland for letting me ramble on about MMO design in recent months", 0, 18)
  love.graphics.setFont(font)

    love.graphics.draw(logo, 305,66,0,0.5)

  if ui.selected == "username" then
    love.graphics.printf(pl.cinput.."|",296,31+(373/2),(407/2),"center")
  elseif ui.selected == "password" then
    love.graphics.printf(pl.name.."",296,31+(373/2),(407/2),"center")
    love.graphics.printf(pstring.."|",296,31+(373/2)+16,(407/2),"center")
  elseif ui.selected == "logging in" then
    love.graphics.printf(pl.name.."",296,31+(373/2),(407/2),"center")
    love.graphics.printf(pstring.."",296,31+(373/2)+16,(407/2),"center")
    love.graphics.print("Logging in...",0,36*12)
  end
end

function updateLogin(dt)
  local speed = 64*dt
  for i = 1, 3 do
    lclouds.x[i] = lclouds.x[i] - (speed/8)
    if lclouds.x[i] < -260 then
      lclouds.x[i] = sw+love.math.random(1, 100)
      lclouds.y[i] = love.math.random(0, 400)
    end
  end

  litems["mountains"] = litems["mountains"] - speed/2
  if litems["mountains"] < -800 then litems["mountains"] = 0 end

  litems["ground"] = litems["ground"] - speed
  if litems["ground"] < -800 then litems["ground"] = 0 end

  litems["player"] = litems["player"] + speed/2
  if litems["player"] > 800 then litems["player"] = love.math.random(-400,0) bli.s = love.math.random(1,12) end
end
