require "modules/ui/login"
require "modules/submodules/tooltip"
require "modules/ui/master"
require "modules/ui/chat"
require "modules/ui/floats"
require "modules/ui/crafting"

--ui variables, use as you wish
ui = {}
ui.selected = 0 --default username
ui.window = {}
ui.window.x = 0
ui.window.y = 0
ui.window.content = "up"

sw,sh = love.graphics.getDimensions()

newScale = 1

function drawPhase(phase)
  if phase == "splash" then
    if ui.window.content == "down" then
      drawLogin()
    end
    love.graphics.setColor(0,0,0,ui.selected)
    love.graphics.rectangle("fill",0,0,sw,sh)
    love.graphics.setColor(255,255,255,ui.selected)
  --  love.graphics.print("PEB.SI",sw/2-(bFont:getWidth("PEB.SI")/2),sh/4)
    love.graphics.rectangle("fill",round(sw/2-(uiImg["freshplay"]:getWidth()/2)),sh/2-200,uiImg["freshplay"]:getWidth(),uiImg["freshplay"]:getHeight())
    love.graphics.draw(uiImg["freshplay"],sw/2-(uiImg["freshplay"]:getWidth()/2),sh/2-200)
    love.graphics.draw(uiImg["enhost"],sw/2-(uiImg["enhost"]:getWidth()/2),sh/2)
    love.graphics.setFont(font)
    love.graphics.printf("POWERED BY",sw/2-(uiImg["enhost"]:getWidth()/2),sh/2,uiImg["enhost"]:getWidth(),"right")
  elseif phase == "login" then
    drawLogin()
  elseif phase == "game" then
    drawGame()
    drawUI()
  elseif phase == "read" then
    love.graphics.push()
    local xscale = realScreenWidth/stdSH
    local yscale = realScreenHeight/stdSW
   love.graphics.scale(xscale,yscale)
    love.graphics.draw(uiImg["readme"])
    love.graphics.pop()
  else
    love.graphics.print("ERROR: Unknown phase '"..phase.."'. Please report this error message.")
  end
end

function updatePhase(phase, dt)
  if phase == "splash" then
    if ui.window.content == "up" then
      ui.selected = ui.selected + 300*dt
      if ui.selected > 600 then ui.window.content = "down" end
    elseif ui.window.content == "down" then
      ui.selected = ui.selected - 400*dt
      if ui.selected < 1 then
        love.keypressed()
      end
    end
    updateLogin(dt)
  elseif phase == "login" then
    updateLogin(dt)
  elseif phase == "game" then
    updateGame(dt)
    updateUI(dt)

    if newScale ~= scale then
      if newScale > scale+0.01 then scale = scale + 1*dt love.resize(love.graphics.getWidth(),love.graphics.getHeight())
      elseif newScale < scale-0.01 then scale = scale - 1*dt love.resize(love.graphics.getWidth(),love.graphics.getHeight())
      elseif newScale ~= scale then scale = newScale love.resize(love.graphics.getWidth(),love.graphics.getHeight())
      else  newScale = scale love.resize(love.graphics.getWidth(),love.graphics.getHeight()) end
    end
  end
end

function love.textinput(t)
  if t ~= "," then --as this is used for server commands
    pl.cinput = pl.cinput..t
  end

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
      if phase == "login" and loginI.status == "create" then
        if ui.selected == "username" then pl.cinput = "" ui.selected = "password"
        elseif ui.selected == "password" then addLoginCharacter() end--login() end
      elseif phase == "read" then
        phase = "game"
      elseif phase == "game" then
        if ui.selected == "chat" then ui.selected = 0 love.keyboard.setTextInput(false) sendChat(pl.cinput) else pl.cinput = "" ui.selected = "chat" love.keyboard.setTextInput(true) end
      end
  elseif key == "u" then
    if phase == "game" and ui.selected ~= "chat" then
      requestUserInfo()
      requestWorldInfo()
    end
  elseif key == "z" and ui.selected ~= "chat" then
    newScale = newScale + 1
    love.resize(love.graphics.getWidth(),love.graphics.getHeight())
  elseif key == "x" and ui.selected ~= "chat" then
    newScale = newScale - 1
    if newScale < 0.25 then newScale = 1 end
    love.resize(love.graphics.getWidth(),love.graphics.getHeight())
  elseif key == "left" then
    if phase == "login" then
      biome = 1
    end
  elseif key == "r" and ui.selected ~= "chat" then
    if phase == "game" or phase == "fight" then
      netSend("potion", pl.name)
    end
  elseif key == "q" and ui.selected ~= "chat" then
    if phase == "game" then
      vals = atComma(item.val[pl.s1])
      if pl.s1 ~= "None" and pl.s1t < 0 and pl.en+1 > tonumber(vals[2]) then --HEY, changing this won't alter when you can and can't use spells, it'll only mess up the UI, so, stop.
        netSend("spell1", pl.name)
        pl.en = pl.en - tonumber(vals[2])
        pl.s1t = vals[1]
        pl.spell = pl.s1
      end
    end
  elseif key == "e" and ui.selected ~= "chat" then
    if phase == "game" then
      vals = atComma(item.val[pl.s2])
      if pl.s1 ~= "None" and pl.s2t < 0 and pl.en+1 > tonumber(vals[2]) then
        netSend("spell2", pl.name)
        pl.en = pl.en - tonumber(vals[2])
        pl.s2t = vals[1]
        pl.spell = pl.s2
      end
    end
  elseif key == "escape" then
  --[[  fullscreen, fstype = love.window.getFullscreen( )
    if fullscreen == true then
      love.window.setFullscreen(false)
    else
      love.window.setFullscreen(true,"desktop")
    end]]
    if love.window.highdpi == true then
      love.window.highdpi = false
    else
      love.window.highdpi = true
    end

  end

   if phase == "splash" then
     phase = "login"
     ui.selected = "username"
   end
end

function love.resize(w,h) --reset sw and sh
  sw = w/scale
  sh = h/scale
  screenW = sw
  screenH = sh
  realScreenWidth = w
  realScreenHeight = h

  if phase == "login" or phase == "read" then
    createLoginCanvas()
  elseif phase == "game" then
  --  createWorldCanvas()
    createWeather()
  end
end

function centerCamera()
   --my = round((pl.t/101)-((sh/32)/2))*32 mx = round(tonumber(string.sub(tostring(pl.t/101),3))*3200)-((sw/32)/2)*32
   mx = round(pl.x - sw/2)
   my = round(pl.y - sh/2)

  -- if playerExists(pl.name) then
--     mx = round(getPlayer(pl.name, "x") - sw/2)
  --   my = round(getPlayer(pl.name, "y") - sh/2)
--   end
end
