world = {}

function loadOverworld()
  addMsg("Downloading world...")
  b, c, h = http.request("http://peb.si/bq/dl/map.txt")
  love.filesystem.write("map.txt", b)

  --unpack
  addMsg("Unpacking world...")
  if love.filesystem.exists("map.txt") then
    local x = 0
    local y = 0
    for line in love.filesystem.lines("map.txt") do
      word = atComma(line)
      i = #world + 1
      world[i] = {}
      world[i].tile = word[1]
      world[i].fight = word[2]
      if word[4] == "true" then world[i].collide = true else world[i].collide = false end
      world[i].name = word[5]
      world[i].bg = word[6]
      world[i].isFight = false
      world[i].players = ""
      world[i].x = x
      world[i].y = y
      world[i].i = i --I don't like this, but I couldn't do A* pathfinding myself so this is it :'(
      x = x + 32
      if x > 100*32 then
        x = 0
        y = y + 32
      end
    end
  else
    love.window.showMessageBox("World doesn't exist!", "We couldn't find the world file. This means one of two things: 1) the Witch has successfully wiped out all of mankind or 2) the client didn't download the world properly. Either way, we need to exit. Report this to @Pebsiee!!", "error")
    love.event.quit()
  end

  addMsg("Done.")
end
