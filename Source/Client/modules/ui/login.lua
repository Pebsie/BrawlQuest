--called by interface
biome = love.math.random(1, 4)

loadedCharacter = {}

--TODO: tirelessly treck through this code and replace all love.mouse.isDown to a love.mousepressed function

--[[
loadedCharacter[1] = {}
loadedCharacter[1].arm = "Old Cloth"
loadedCharacter[1].name = "Pebsie"
loadedCharacter[1].lvl = 3
loadedCharacter[1].wep = "Long Stick"
loadedCharacter[1].bud = "Snake"

loadedCharacter[2] = {}
loadedCharacter[2].arm = "Legendary Padding"
loadedCharacter[2].name = "a"
loadedCharacter[2].lvl = 10
loadedCharacter[2].wep = "Legendary Sword"
loadedCharacter[2].bud = "Sheep"

loadedCharacter[3] = {}
loadedCharacter[3].arm = "Guardian's Padding"
loadedCharacter[3].name = "CrimsnMonkey"
loadedCharacter[3].lvl = 9
loadedCharacter[3].wep = "Guardian's Blade"
loadedCharacter[3].bud = "Baby Bat"]]

loginI = {}
loginI.status = "select"
loginI.select = 1

--let me save you the leg work, future Tom
--When logging in, pl.name is used as username and pl.cinput is used as password. Why? Who knows.

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

  love.graphics.draw(uiImg["Old Cloth"],litems["player"],sh-40)
  --love.graphics.draw(,litems["player"],sh-40)
--  love.graphics.draw(bli[bli.s],litems["player"]+40,sh-40)

  local xpos = round(sw/2-(181/2)-11)
  local ypos = round(sh/2-(145/2))
  --[[love.graphics.setColor(64,64,64) --background for text entry
  love.graphics.rectangle("fill",xpos,ypos,(407/2),32)
  love.graphics.setColor(0,127,14) --login button
  love.graphics.rectangle("fill",xpos,ypos+32,(407/2),16)
  love.graphics.setColor(128,128,128)
  love.graphics.rectangle("line",xpos,ypos,(407/2),16)
  love.graphics.rectangle("line",xpos,ypos+16,(407/2),16)
  love.graphics.rectangle("line",xpos,ypos+32,(407/2),16)
  love.graphics.setColor(255,255,255)]]


  local pstring = ""
  for i = 1, string.len(pl.cinput) do pstring = pstring.."*" end
  love.graphics.setFont(font)

  love.graphics.print("BrawlQuest "..version)

  love.graphics.setFont(sFont)

  --love.graphics.print("\nFreshPlay 2018 (http://freshplay.co.uk)\n\nPowered by enhost (http://enhost.io)\n\nGraphics by D.Gervais (used here under a Creative Commons Attribution 3.0 licence)\nTitle theme composed by Joey Pearce (YouTube @JoeyFunWithMusic)\nMusic by Eric Matyas (used here under a Creative Commons Attribution 4.0 license)\nLogo created by Danjoe Stubbs", 0, 18)
--  love.graphics.setFont(font)

    love.graphics.draw(logo,(sw/2-(181/2)),(sh/2-(145/2))-160,0,0.5)--logo is 362x290 which at this size is
    love.graphics.setFont(bFont)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",(sw/2-(181/2)),(sh/2-(145/2))-20,181,bFont:getHeight())
    love.graphics.setColor(255,255,255)

    love.graphics.printf("BETA",(sw/2-(181/2)),(sh/2-(145/2))-20,181,"center")
    love.graphics.printf("LOGIN",xpos,ypos+32,(407/2),"center")
    --which at this size is 181x145
  ypos = ypos + 40

  if loginI.status == "select" then
    for i = 1, #loadedCharacter do
      if #loadedCharacter then
        local isSel = false
        if isMouseOver(xpos,204,ypos,66) then
          love.graphics.setColor(100,100,100)
        else
          love.graphics.setColor(50,50,50)
        end

        love.graphics.rectangle("fill",xpos,ypos,204,66)
        love.graphics.setColor(255,255,255)
        love.graphics.setFont(font)
        love.graphics.printf( loadedCharacter[i].name , xpos+64 , ypos , 140 , "center" )
        love.graphics.setFont(sFont)
        --love.graphics.printf( "Level "..loadedCharacter[i].lvl.."\n"..loadedCharacter[i].arm.." (0 DEF)\n"..loadedCharacter[i].wep.." ("..item[loadedCharacter[i]].wep.." ATK)", xpos+64 , ypos+font:getHeight() , 140 , "center")

        if isMouseOver(xpos,204,ypos,66) then
          love.graphics.draw(item["Naked"].img,xpos+4,ypos,0,2,2)
          if isMouseDown or love.keyboard.isDown("return") then
            if loadedCharacter[i].pw then
              pl.name = loadedCharacter[i].name
              pl.cinput = loadedCharacter[i].pw
              login()
              love.audio.play(sfx["hit"])
            else
              loginI.status = "pw"
              loginI.select = i
              ui.selected = "password"
              pl.cinput = ""
              pl.name = loadedCharacter[i].name
              love.audio.play(sfx["hit"])
            end
            isMouseDown = false
          end
        else
          love.graphics.draw(item["Naked"].img,xpos,ypos,0,2,2)
        end

        if buddy and buddy[loadedCharacter[i].bud] then
          local budPos = ypos
          while budPos+buddy[loadedCharacter[i].bud]:getHeight()*2 < ypos+64 do
            budPos = budPos + 1
          end

          if isMouseOver(xpos,204,ypos,66) then
            love.graphics.draw(buddy[loadedCharacter[i].bud],xpos+30+2,budPos,0,2,2)
          else
            love.graphics.draw(buddy[loadedCharacter[i].bud],xpos+30,budPos,0,2,2)
          end
        end
        love.graphics.setColor(150,150,150)
        love.graphics.rectangle("line",xpos,ypos,204,66)

        ypos = ypos + 68
      end
    end

    if #loadedCharacter < 3 then
      if isMouseOver(xpos,204,ypos,66) then
        love.graphics.setColor(100,100,100)
        if isMouseDown then
          loginI.status = "create"
          loginI.select = #loadedCharacter+1
        --  love.window.showMessageBox("set lc","setlc")
          isMouseDown = false
          pl.cinput = ""
          pl.name = ""
          ui.selected = "username"
          love.audio.play(sfx["hit"])
        end
      else
        love.graphics.setColor(50,50,50)
      end
      love.graphics.rectangle("fill",xpos,ypos,204,66)
      love.graphics.setColor(255,255,255)
      love.graphics.setFont(font)
      love.graphics.printf( "Add Character" , xpos , ypos+33-font:getHeight() , 204 , "center" )
      love.graphics.setColor(150,150,150)
      love.graphics.rectangle("line",xpos,ypos,204,66)
    end

  elseif loginI.status == "create" then
    local oypos = ypos --original ypos
    love.graphics.setColor(50,50,50)
    love.graphics.rectangle("fill",xpos,ypos,204,180)

  --  love.graphics.setColor(0,0,0)
    --love.graphics.rectangle("fill",xpos+102-(32*1.5),ypos+font:getHeight()+3,94,94)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(worldImg["Grass"],xpos+102-(32*1.5),ypos+font:getHeight()+3,0,3,3)
    love.graphics.setFont(font)
    love.graphics.printf( "Add Character" , xpos , ypos , 204 , "center" )
    love.graphics.draw(item["Naked"].img,xpos+102-(32*1.5),ypos+font:getHeight()+3,0,3,3)
    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",xpos+102-(32*1.5),ypos+font:getHeight()+3,96,96)

    ypos = ypos + font:getHeight()+3+96+4
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)
    love.graphics.printf("Username:",xpos-2,ypos,100,"center")
    if isMouseOver(xpos+101,100,ypos,font:getHeight()) then
      love.graphics.setColor(100,100,100)
      if isMouseDown then
        ui.selected = "username"
        pl.cinput = ""
        love.audio.play(sfx["hit"])
      end
    else
      love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill",xpos+101,ypos,100,font:getHeight())
    ypos = ypos + font:getHeight()+4
    love.graphics.setColor(255,255,255)
    love.graphics.printf("Password:",xpos-2,ypos,100,"center")
    if isMouseOver(xpos+101,100,ypos,font:getHeight()) then
      love.graphics.setColor(100,100,100)
      if isMouseDown then
        ui.selected = "password"
        pl.cinput = ""
        love.audio.play(sfx["hit"])
      end
    else
      love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill",xpos+101,ypos,100,font:getHeight())
    ypos = ypos + font:getHeight() + 4

    if isMouseOver(xpos,102,ypos,font:getHeight()) then --back
      love.graphics.setColor(200,0,0)
      if isMouseDown then
        loginI.status = "select"
        pl.name = ""
        pl.cinput = ""
        isMouseDown = false
        love.audio.play(sfx["hit"])
      end
    else
      love.graphics.setColor(100,0,0)
    end

    love.graphics.rectangle("fill",xpos,ypos,102,font:getHeight())
    if isMouseOver(xpos+102,102,ypos,font:getHeight()) then --add
      love.graphics.setColor(0,200,0)
      if isMouseDown or love.keyboard.isDown("return") then
        if string.sub(pl.name, 1, 1) ~= "" then
          addLoginCharacter()
          isMouseDown = false
          love.audio.play(sfx["hit"])
        end
      end
    else
      love.graphics.setColor(0,100,0)
    end

    love.graphics.rectangle("fill",xpos+102,ypos,102,font:getHeight())
    love.graphics.setColor(255,255,255)
    if ui.selected == "username" then
      love.graphics.print(pl.cinput.."|",xpos+103,ypos-(font:getHeight()+4)*2)
    elseif ui.selected == "password" then
      love.graphics.print(pl.name.."",xpos+103,ypos-(font:getHeight()+4)*2)
      love.graphics.print(pstring.."|",xpos+103,ypos-(font:getHeight()+4))
    end
    love.graphics.printf("Back",xpos,ypos,102,"center")
    love.graphics.printf("Add",xpos+102,ypos,102,"center")

    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",xpos,oypos,204,180)

    ypos = ypos + 180
  elseif loginI.status == "pw" then

    local oypos = ypos --original ypos
    love.graphics.setColor(50,50,50)
    love.graphics.rectangle("fill",xpos,ypos,204,180)

  --  love.graphics.setColor(0,0,0)
    --love.graphics.rectangle("fill",xpos+102-(32*1.5),ypos+font:getHeight()+3,94,94)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(worldImg["Grass"],xpos+102-(32*1.5),ypos+font:getHeight()+3,0,3,3)
    love.graphics.draw(item["Naked"].img,xpos+102-(32*1.5),ypos+font:getHeight()+3,0,3,3)
    love.graphics.setFont(font)
    love.graphics.printf( "#"..loginI.select..": "..pl.name , xpos , ypos , 204 , "center" )
  --  love.graphics.draw(item.img[loadedCharacter[loginI.select].arm],xpos+102-(32*1.5),ypos+font:getHeight()+3,0,3,3)
    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",xpos+102-(32*1.5),ypos+font:getHeight()+3,96,96)

    ypos = ypos + font:getHeight()+3+96+4
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)
    love.graphics.printf("Password:",xpos-2,ypos,100,"center")
    if isMouseOver(xpos+101,100,ypos,font:getHeight()) then
      love.graphics.setColor(100,100,100)
      if isMouseDown then
        ui.selected = "username"
        pl.cinput = ""
        love.audio.play(sfx["hit"])
      end
    else
      love.graphics.setColor(0,0,0)
    end
    love.graphics.rectangle("fill",xpos+101,ypos,100,font:getHeight())
    ypos = ypos + font:getHeight()+4

    ypos = ypos + font:getHeight() + 4

    if isMouseOver(xpos,68,ypos,font:getHeight()) then --back button
      love.graphics.setColor(200,0,0)
      if isMouseDown then
        loginI.status = "select"
        pl.name = ""
        pl.cinput = ""
        isMouseDown = false
        love.audio.play(sfx["hit"])
      end
    else
      love.graphics.setColor(100,0,0)
    end
    love.graphics.rectangle("fill",xpos,ypos,68,font:getHeight())

    if isMouseOver(xpos+68,68,ypos,font:getHeight()) then --delete button
      love.graphics.setColor(100,200,0)
      if isMouseDown then
        deleteChar(tonumber(loginI.select))
        love.audio.play(sfx["kill"])
      end
    else
      love.graphics.setColor(200,100,0)
    end
    love.graphics.rectangle("fill",xpos+68,ypos,68,font:getHeight())


    if isMouseOver(xpos+136,68,ypos,font:getHeight()) then --add button
      love.graphics.setColor(0,200,0)
      if isMouseDown or love.keyboard.isDown("return") then
        login()
      --  pl.cinput = ""
        ui.selected = "logging in"
        love.audio.play(sfx["hit"])
      end
    else
      love.graphics.setColor(0,100,0)
    end
    love.graphics.rectangle("fill",xpos+136,ypos,68,font:getHeight())

    love.graphics.setColor(255,255,255)


    love.graphics.print(pstring.."|",xpos+103,ypos-(font:getHeight()+4)*2)

    love.graphics.printf("Back",xpos,ypos,68,"center")
    love.graphics.printf("Delete",xpos+68,ypos,68,"center")
    love.graphics.printf("Login",xpos+136,ypos,68,"center")

    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",xpos,oypos,204,180)

    ypos = ypos + 180
  end

  ypos = ypos + 80
  love.graphics.setFont(sFont)
  love.graphics.setColor( 255, 255, 255 )
  love.graphics.printf(news,0,ypos,sw,"center")

  ---OLD LOGIN SYSTEM
  --[[if ui.selected == "username" then
    love.graphics.printf(pl.cinput.."|",xpos,ypos,(407/2),"center")
  elseif ui.selected == "password" then
    love.graphics.printf(pl.name.."",xpos,ypos,(407/2),"center")
    love.graphics.printf(pstring.."|",xpos,ypos+16,(407/2),"center")
  elseif ui.selected == "logging in" then
    love.graphics.printf(pl.name.."",xpos,ypos,(407/2),"center")
    love.graphics.printf(pstring.."",xpos,ypos+16,(407/2),"center")
    love.graphics.print("Logging in...",0,36*12)
  end]]
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
      love.graphics.draw(worldImg["Grass"],i*32,0) --grass for beta
      love.graphics.draw(worldImg["Grass"],i*32,32)
    else
      love.graphics.draw(worldImg["Sand"],i*32,0) --sand for beta
      love.graphics.draw(worldImg["Sand"],i*32,32)
    end
  end

  love.graphics.setCanvas(uiTree)
  love.graphics.clear()

  local y = {}
  for i = 0, sw/1024 do --sw/128 for beta
      y[i] = love.math.random(10,44)
      if biome == 1 then
        love.graphics.draw(worldImg["Cactus"],i*128,y[i],0,2) --Dead Tree for beta
      else
        love.graphics.draw(worldImg["Tree"],i*128,y[i],0,2) --Tree for beta
      end
  end

  love.graphics.setCanvas()
end

function addLoginCharacter()
  if pl.name ~= "" and pl.cinput ~= "" then
    loadedCharacter[loginI.select] = {}
    loadedCharacter[loginI.select].arm = "Old Cloth"
    loadedCharacter[loginI.select].name = pl.name
    loadedCharacter[loginI.select].lvl = 1
    loadedCharacter[loginI.select].wep = "Long Stick"
    loadedCharacter[loginI.select].bud = "None"
    loadedCharacter[loginI.select].pw = pl.cinput
  end
  loginI.status = "select"
  pl.name = ""
  pl.cinput = ""
  ui.selected = "username"
  saveCharacters()
  love.keyboard.setTextInput(false)
  login()
end

function deleteChar(i)

  --love.window.showMessageBox("debug",loadedCharacter[i].lvl.." / "..pl.name)
  if i ~= #loadedCharacter then --if we aren't the last element

    loadedCharacter[i] = loadedCharacter[#loadedCharacter] --copy the element
  --  love.window.showMessageBox("debug",loadedCharacter[i].name.." / "..loadedCharacter[#loadedCharacter].name)
    loadedCharacter[#loadedCharacter] = nil
  --  love.window.showMessageBox("debug",tostring(loadedCharacter[i].name).." / "..tostring(loadedCharacter[#loadedCharacter].name))
  else
    loadedCharacter[#loadedCharacter] = nil
  end

  saveCharacters()
  loadCharacters()
  loginI.status = "select"
  isMouseDown = false
end

function saveCharacters()
  local str = ""
  for i = 1, #loadedCharacter do
    if loadedCharacter and loadedCharacter[i].bud then
      str = str..loadedCharacter[i].arm..","..loadedCharacter[i].name..","..loadedCharacter[i].lvl..","..loadedCharacter[i].wep..","..loadedCharacter[i].bud.."\n"
    end
  end

  love.filesystem.write("char.txt",str)
end

function loadCharacters()
  local i = 1
  if love.filesystem.getInfo("char.txt") then
    for line in love.filesystem.lines("char.txt") do
      local words = atComma(line)
      loadedCharacter[i] = {}
      loadedCharacter[i].arm = "Naked"
      loadedCharacter[i].name = words[2]
      loadedCharacter[i].lvl = words[3]
      loadedCharacter[i].wep = words[4]
      loadedCharacter[i].bud = words[5]
      i = i + 1
    end

  end

  loginI.select = i
end
