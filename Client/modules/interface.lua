require "modules/submodules/login"
require "modules/submodules/tooltip"

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

function updatePhase(phase, dt)
  if phase == "login" then
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
  end

   if phase == "game" then
    -- if key == "w" then movePlayer("up") end
    -- if key == "s" then movePlayer("down") end
    -- if key == "d" then  movePlayer("right") end
    -- if key == "a" then movePlayer("left") end
  --   if key == "space" then centerCamera() end --center camera on player
    -- if key == "p" then movePlayer(selT) end
   end
end

function love.resize(w,h) --reset sw and sh
  sw = w/scale
  sh = h/scale
  screenW = sw
  screenH = sh
  realScreenWidth = w
  realScreenHeight = h

  if phase == "login" then
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
