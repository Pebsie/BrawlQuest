--called by interface
biome = love.math.random(1, 4)

function drawLogin() --login screen
  love.graphics.setBackgroundColor(45, 139, 255)

  for i = 1, 10 do
    love.graphics.draw(loginImg["cloud"],lclouds.x[i],lclouds.y[i])
  end


  love.graphics.setBlendMode("alpha", "premultiplied")

  love.graphics.draw(uiMountains, litems["mountains"], sh-128-63)

  love.graphics.draw(uiGrass, litems["ground"], sh-64)

    love.graphics.setBlendMode("alpha")

 love.graphics.draw(uiTree,litems["ground"],sh-128)
 love.graphics.draw(uiTree,litems["ground"]+sw,sh-128)

  love.graphics.draw(item.img["Old Cloth"],litems["player"],sh-40)
  love.graphics.draw(bli[bli.s],litems["player"]+40,sh-40)

  local xpos = sw/2-(181/2)-11
  local ypos = sh/2-(145/2)
  love.graphics.setColor(64,64,64) --background for text entry
  love.graphics.rectangle("fill",xpos,ypos,(407/2),32)
  love.graphics.setColor(0,127,14) --login button
  love.graphics.rectangle("fill",xpos,ypos+32,(407/2),16)
  love.graphics.setColor(128,128,128)
  love.graphics.rectangle("line",xpos,ypos,(407/2),16)
  love.graphics.rectangle("line",xpos,ypos+16,(407/2),16)
  love.graphics.rectangle("line",xpos,ypos+32,(407/2),16)
  love.graphics.setColor(255,255,255)


  local pstring = ""
  for i = 1, string.len(pl.cinput) do pstring = pstring.."*" end

  love.graphics.printf("LOGIN",xpos,ypos+32,(407/2),"center")
  love.graphics.print("BrawlQuest "..version)

  love.graphics.setFont(sFont)
  love.graphics.printf(news,0,sh/2+10,sw,"center")
  love.graphics.print("Created and programmed by Thomas Lock (http://peb.si)\nGraphics by D.Gervais (used here under a Creative Commons Attribution 3.0 licence)\nMusic by Eric Matyas (used here under a Creative Commons Attribution 4.0 license)\nLogo created by Danjoe Stubbs\nSpecial thanks to Sam Warland for letting me ramble on about MMO design in recent months", 0, 18)
  love.graphics.setFont(font)

    love.graphics.draw(logo,(sw/2-(181/2)),(sh/2-(145/2))-160,0,0.5)--logo is 362x290 which at this size is
    --which at this size is 181x145

  if ui.selected == "username" then
    love.graphics.printf(pl.cinput.."|",xpos,ypos,(407/2),"center")
  elseif ui.selected == "password" then
    love.graphics.printf(pl.name.."",xpos,ypos,(407/2),"center")
    love.graphics.printf(pstring.."|",xpos,ypos+16,(407/2),"center")
  elseif ui.selected == "logging in" then
    love.graphics.printf(pl.name.."",xpos,ypos,(407/2),"center")
    love.graphics.printf(pstring.."",xpos,ypos+16,(407/2),"center")
    love.graphics.print("Logging in...",0,36*12)
  end
end

function updateLogin(dt)
  local speed = 64*dt
  for i = 1, 10 do
    lclouds.x[i] = lclouds.x[i] - (speed/8)
    if lclouds.x[i] < -260 then
      lclouds.x[i] = sw+love.math.random(1, 100)
      lclouds.y[i] = love.math.random(0, 400)
    end
  end

  litems["mountains"] = litems["mountains"] - speed/2
  if litems["mountains"] < -sw then litems["mountains"] = 0 end

  litems["ground"] = litems["ground"] - speed
  if litems["ground"] < -sw then litems["ground"] = 0 end

  litems["player"] = litems["player"] + speed/2
  if litems["player"] > sw then litems["player"] = love.math.random(-400,0) bli.s = love.math.random(1,12) end
end

function createLoginCanvas()
  --we're going to create all of the different elements of the login screen separately in their own createLoginCanvas
  --this function needs only be called when the screen is resized
  uiMountains = love.graphics.newCanvas(sw*2,128)
  uiGrass = love.graphics.newCanvas(sw*2,64)
  uiTree = love.graphics.newCanvas(sw*2,256)

  love.graphics.setCanvas(uiMountains)
  love.graphics.clear()
  for i = 0, (sw/128)*2 do
    love.graphics.draw(loginImg["mountain"],i*128,0) --y is 0 because it is defined by the draw function
  end

  love.graphics.setCanvas(uiGrass)
  love.graphics.clear()
  for i = 0, (sw/32)*2 do
    if biome ~= 1 then
      love.graphics.draw(worldImg["Grass"],i*32,0)
      love.graphics.draw(worldImg["Grass"],i*32,32)
    else
      love.graphics.draw(worldImg["Sand"],i*32,0)
      love.graphics.draw(worldImg["Sand"],i*32,32)
    end
  end

  love.graphics.setCanvas(uiTree)
  love.graphics.clear()

  local y = {}
  for i = 0, sw/128 do
      y[i] = love.math.random(10,44)
      love.graphics.draw(loginImg["tree"],i*128,y[i]) --this needs work
  end

  love.graphics.setCanvas()
end
