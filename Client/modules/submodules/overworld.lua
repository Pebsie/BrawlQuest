world = {}
world.bg = {}
world.name = {}
world.fight = {}
world.collide = {}
world.isFight = {}
world.players = {}

function loadOverworld()
  if love.filesystem.exists("map.txt") then
    for line in love.filesystem.lines("map.txt") do
      word = atComma(line)
      i = #world + 1
      world[i] = word[1]
      world.fight[i] = word[2]
      if word[4] == "true" then world.collide[i] = true else world.collide[i] = false end
      world.name[i] = word[5]
      world.bg[i] = word[6]
      world.isFight[i] = false
      world.players[i] = ""
      
    end
  else
    love.window.showMessageBox("World doesn't exist!", "We couldn't find the world file. This means one of two things: 1) the Witch has successfully wiped out all of mankind or 2) the client didn't download the world properly. Either way, we need to exit. Report this to @Pebsiee!!", "error")
    love.event.quit()
  end
end

function drawOverworld()

end
