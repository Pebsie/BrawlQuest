--ui variables, use as you wish
ui = {}
ui.selected = "nothing"
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
  if ui.selected == "username" then
    love.graphics.print("BrawlQuest "..version.."\n\nRegister at http://peb.si/bq\nUsername: "..pl.cinput.."")
  end
end
