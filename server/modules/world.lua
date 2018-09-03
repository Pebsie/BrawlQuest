world = {}
worldUpdate = 500

require "data/zones"


function loadOverworld(thisZone)
--  if not love.filesystem.exists("map.txt") then
    addMsg("Setting up "..thisZone)
    addMsg("Downloading world...")
    b, c, h = http.request("http://brawlquest.com/dl/"..zone[thisZone])
    if b then
      love.filesystem.write(zone[thisZone], b)
    else
      addMsg("Failed to download world file.")
    end
  --end

  --unpack
  addMsg("Unpacking world...")
  world[thisZone] = {}
  if love.filesystem.exists(zone[thisZone]) then
    local x = 0
    local y = 0
    for line in love.filesystem.lines(zone[thisZone]) do
      word = atComma(line)
      i = #world[thisZone] + 1
      world[thisZone][i] = {}
      world[thisZone][i].tile = word[1]
      world[thisZone][i].fight = word[2]
      world[thisZone][i].fightc = tonumber(word[3])
      if word[4] == "true" then world[thisZone][i].collide = true else world[thisZone][i].collide = false end
      world[thisZone][i].name = word[5]
      world[thisZone][i].bg = word[6]
      world[thisZone][i].isFight = false
      world[thisZone][i].players = ""
      world[thisZone][i].x = x
      world[thisZone][i].y = y
      world[thisZone][i].spawned = false
      if word[8] == "true" then world[thisZone][i].rest = true else world[thisZone][i].rest = false end
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

function updateWorld(dt)
  worldUpdate = worldUpdate - 1*dt
  if worldUpdate < 0 then
    simulateWeather()
    for k,v in pairs(zone) do
      addMsg("Simulating "..k)
      for i = 1, 100*100 do
        if love.math.random(1, 50) < world[k][i].fightc or world[k][i].fightc > 90 then
          world[k][i].spawned = true
        else
          world[k][i].spawned = false
        end
      end
    end
    worldUpdate = 300
  end
end
