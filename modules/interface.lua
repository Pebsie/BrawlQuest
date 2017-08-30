--ui variables, use as you wish
ui = {}
ui.selected = "username"
ui.window = {}
ui.window.x = 0
ui.window.y = 0
ui.window.content = "Nothing."

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
  local pstring = ""
  for i = 1, string.len(pl.cinput) do pstring = pstring.."*" end

  if ui.selected == "username" then
    love.graphics.print("BrawlQuest "..version.."\n\nRegister at http://peb.si/bq\nUsername: "..pl.cinput.."|")
  elseif ui.selected == "password" then
    love.graphics.print("BrawlQuest "..version.."\n\nRegister at http://peb.si/bq\nUsername: "..pl.name.."\nPassword: "..pstring.."|")
  elseif ui.selected == "logging in" then
    love.graphics.print("BrawlQuest "..version.."\n\nRegister at http://peb.si/bq\nUsername: "..pl.name.."\nPassword: "..pstring.."\n\nLogging in...")
  end
end

function updatePhase(phase)
  if phase == "login" then

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
