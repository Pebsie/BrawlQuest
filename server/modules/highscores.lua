hs = {}

function loadHighscores()
  if love.filesystem.getInfo("highscores.txt") then
    addMsg("Found highscores file")
    for line in love.filesystem.lines("highscores.txt") do
      local score = atComma(line,"=")
      hs[score[1]] = {}
      hs[score[1]].score = tonumber(hs[score[2]])
      hs[score[1]].player = score[3]
      addMsg("Highscore for "..score[1].." is "..hs[score[2]]..", earned by "..hs[score[3]])
    end
  else
    addMsg("Couldn't find highscores file!")
  end
end

function saveHighscores()
  local fs = ""
  for i, v in pairs(hs) do
    fs = fs..i.."="..v.score.."="..v.player.."\n"
  end
  love.filesystem.write("highscores.txt", fs)
end
