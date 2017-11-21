require "modules/submodules/login"
require "modules/submodules/tooltip"

--ui variables, use as you wish
ui = {}
ui.selected = 0 --default username
ui.window = {}
ui.window.x = 0
ui.window.y = 0
ui.window.content = "up"

sw,sh = love.graphics.getDimensions()

function drawPhase(phase)
  if phase == "splash" then
    love.graphics.setColor(255,255,255,ui.selected)
    love.graphics.setFont(bFont)
    love.graphics.print("PEB.SI",sw/2-(bFont:getWidth("PEB.SI")/2),sh/4)
    love.graphics.draw(uiImg["love"],sw/2-(uiImg["love"]:getWidth()/2),sh/2)
  elseif phase == "login" then
    drawLogin()
  elseif phase == "game" then
    drawGame()
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
      if ui.selected > 400 then ui.window.content = "down" end
    elseif ui.window.content == "down" then
      ui.selected = ui.selected - 300*dt
      if ui.selected < 1 then
        love.keypressed()
      end
    end
  elseif phase == "login" then
    updateLogin(dt)
  elseif phase == "game" then
    updateGame(dt)
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
      elseif phase == "read" then
        phase = "login"
      end
  elseif key == "u" then
    if phase == "game" then
      requestUserInfo()
      requestWorldInfo()
    end
  elseif key == "z" then
    scale = scale + 0.05
  love.resize(love.graphics.getWidth(),love.graphics.getHeight())
  elseif key == "x" then
    scale = scale - 0.05
    love.resize(love.graphics.getWidth(),love.graphics.getHeight())
  elseif key == "left" then
    if phase == "login" then
      biome = 1
    end
  elseif key == "r" then
    if phase == "game" or phase == "fight" then
      netSend("potion", pl.name)
    end
  elseif key == "q" then
    if phase == "game" then
      vals = atComma(item.val[pl.s1])
      if pl.s1t < 0 and pl.en+1 > tonumber(vals[2]) then --HEY, changing this won't alter when you can and can't use spells, it'll only mess up the UI, so, stop.
        netSend("spell1", pl.name)
        pl.en = pl.en - tonumber(vals[2])
        pl.s1t = vals[1]
        pl.spell = pl.s1
      end
    end
  elseif key == "e" then
    if phase == "game" then
      vals = atComma(item.val[pl.s2])
      if pl.s2t < 0 and pl.en+1 > tonumber(vals[2]) then
        netSend("spell2", pl.name)
        pl.en = pl.en - tonumber(vals[2])
        pl.s2t = vals[1]
        pl.spell = pl.s2
      end
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
    createWorldCanvas()
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
