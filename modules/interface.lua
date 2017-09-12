--ui variables, use as you wish
ui = {}
ui.selected = "username"
ui.window = {}
ui.window.x = 0
ui.window.y = 0
ui.window.content = "Nothing."

sw,sh = love.graphics.getDimensions()

function drawPhase(phase)
  if phase == "login" then
    drawLogin()
  elseif phase == "game" then
    drawGame()
  else
    love.graphics.print("ERROR: Unknown phase '"..phase.."'. Please report this error message.")
  end
end

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

<<<<<<< Updated upstream

  love.graphics.draw(logo, 305,66,0,0.5)
=======
>>>>>>> Stashed changes
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

  love.graphics.draw(logo, 296,31,0,0.5)

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

function updatePhase(phase, dt)
  if phase == "login" then
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
end

function love.textinput(t)
  pl.cinput = pl.cinput..t

  if phase == "login" then
    if ui.selected == "username" then
      pl.name = pl.cinput
    elseif ui.selected == "password" then
      --pl.cinput = pl.cinput..t
    end
  end

end

function love.keypressed(key)
  if key == "backspace" then
       -- get the byte offset to the last UTF-8 character in the string.
       local byteoffset = utf8.offset(pl.cinput, -1)

       if byteoffset then
           -- remove the last UTF-8 character.
           -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
           pl.cinput = string.sub(pl.cinput, 1, byteoffset - 1)
       end
    elseif key == "return" then
      if phase == "login" then
        if ui.selected == "username" then pl.cinput = "" ui.selected = "password"
      elseif ui.selected == "password" then login() end
      end
   end
end
