hs = {}

function loadHighscores()
  if love.filesystem.exists("highscores.txt") then
    addMsg("Found highscores file")
    for line in love.filesystem.lines("highscores.txt") do
      local score = atComma(line,"=")
      hs[score[1]] = {}
      hs[score[1]].score = tonumber(score[2])
      hs[score[1]].player = score[3]
      addMsg("Highscore for "..score[1].." is "..score[2]..", earned by "..score[3])
    end
  else
    addMsg("Couldn't find highscores file!")
  end
end

function saveHighscores()
  --addMsg("Saving highscores...")
  local fs = ""
  for i, v in pairs(hs) do
    fs = fs..i.."="..v.score.."="..v.player.."\n"
  end
--  addMsg("fs: "..fs)
  love.filesystem.write("highscores.txt", fs)
end
