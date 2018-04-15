--map editor
--requires access to img/ and data/fights
---ensure that the map.txt file is in the filesystem directory before running or a new map will be created
utf8 = require("utf8")
require "data/world"
http = require("socket.http")

world = {}
world.bg = {}
world.name = {}
world.fight = {}
world.fightc = {}
world.collide = {}
world.isFight = {}

info = ""
view = 0

pl = {}
pl.cinput = ""

camX = 0
camY = 0
selT = 0

curName = "Forest"
curBG = "Grass"
curTile = "Mountain"
curFight = "Boar Hunt"
curFightC = 5
curCollide = false

isType = false
ts = 1

function love.load()

--  b, c, h = http.request("http://brawlquest.com/dl/map-snow.txt")
--  love.filesystem.write("map-snow.txt", b)
  heroImg = love.graphics.newImage("img/human/Legend.png")
  --load map data
  if love.filesystem.exists("map.txt") then
    print("Found world file!")
    for line in love.filesystem.lines("map.txt") do
      word = atComma(line)
      i = #world + 1
      world[i] = word[1]
      world.fight[i] = word[2]
      world.fightc[i] = tonumber(word[3])
      if word[4] == "true" then world.collide[i] = true else world.collide[i] = false end
      world.name[i] = word[5]
      world.bg[i] = word[6]
      world.isFight[i] = false
      --print("Tile #"..i..", '"..world.name[i].."', fight is "..world.fight[i].." ("..world.fightc[i].."% chance). Collide="..tostring(world.collide[i]))
    end
  else
    print("Generating new map...")
    for i = 1, 100*100 do
    --  if i < 100*20 then --top 20 rows are all trees
  --      world[i] = "Tree"
  --      world.name[i] = "The Great Forest"
  --      world.fight[i] = "None"
--        world.fightc[i] = 0
--        world.collide[i] = true
--        world.bg[i] = "Grass"
--      else
        world[i] = "Water"
        world.name[i] = "The Lost Island"
        world.fight[i] = "None"
        world.fightc[i] = 0 --5%
        world.collide[i] = true
        world.bg[i] = "Water"
  --    end

      world.isFight[i] = false
    end
    print("Done.")
  end
end

function love.draw()
  local x = 0
  local y = 0

  --v = round(((cx+camX)/32)*((cy+camY)/32))
  for i = 1, 100*100 do
    if x-camX > -32 and x-camX < 800 and y-camY > -32 and y-camY < 600 then
      local cx, cy = love.mouse.getPosition()
      if cx+camX > x and cx+camX < x+32 and cy+camY > y and cy+camY < y+32 then
        selT = i
      end
      if worldImg[world[i]] then
        --if world.isFight[i] == true then love.graphics.setColor(255,0,0) else love.graphics.setColor(255,255,255) end
        if selT == i then love.graphics.setColor(255,255,255,50) else love.graphics.setColor(255,255,255) end
        if view == 2 then if world.collide[i] == true then love.graphics.setColor(255,0,0) end end
        love.graphics.draw(worldImg[world.bg[i]], x-camX, y-camY)
        love.graphics.draw(worldImg[world[i]], x-camX, y-camY)

        if world.isFight[i] == true then love.graphics.draw(heroImg, x-camX, y-camY) end
        if view == 1 then
          love.graphics.setColor(0,0,0)
          love.graphics.print(world.fightc[i].."%", x-camX, y-camY)
        end
          love.graphics.setColor(255,255,255)
      else
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("line", x-camX, y-camY, 32, 32)
      end
    end
    x = x + 32
    if x > 32*100 then
      y = y + 32
      x = 0
    end


  end

  ox = 640-100
  oy = 480-100
  x = 0
  y = 0
  for i = 1, 100*100 do
    setWColour(world[i])
    love.graphics.rectangle("fill",x+ox,y+oy,1,1)
    x = x + 1
    if x > 100 then
      y = y + 1
      x = 0
    end
  end

  love.graphics.setColor(255,0,0)
  love.graphics.rectangle("line",ox+(camX/32),oy+(camY/32),25,18.75)

  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",0,0,250,14*8)
  love.graphics.setColor(255,255,255)
  love.graphics.print("Camera: "..round(camX)..","..round(camY).."\nSelected tile: "..selT.."\nPlacing tile "..curTile.."\nPlacing fight '"..curFight.."'\n"..curFightC.."% Chance\nCollide="..tostring(curCollide).."\nTitle '"..curName.."'\nFloor is "..curBG.."\n"..info)

  if isType == true then
    love.graphics.rectangle("line", 0, 14+(14*ts), 200,14)
  end
end

function love.update(dt)
  if love.keyboard.isDown("lshift") then
    speed = 512*dt
  elseif love.keyboard.isDown("lctrl") then
    speed = 32*dt
  else
    speed = 128*dt
  end
  if love.keyboard.isDown("w") then camY = camY - speed end
  if love.keyboard.isDown("s") then camY = camY +  speed end
  if love.keyboard.isDown("d") then camX = camX +  speed end
  if love.keyboard.isDown("a") then camX = camX -  speed end

  if love.mouse.isDown(1) then world[selT] = curTile
  world.fight[selT] = curFight
  world.fightc[selT] = curFightC
  world.collide[selT] = curCollide
  world.name[selT] = curName
  world.bg[selT] = curBG end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    world[selT] = curTile
    world.fight[selT] = curFight
    world.fightc[selT] = curFightC
    world.collide[selT] = curCollide
    world.name[selT] = curName
  end
end

function love.mousereleased(x,y,button,istouch)
end

function love.keypressed(key)
  if key == "return" then
    if isType == false then
      isType = true
    elseif isType == true then
      isType = false
    end
  elseif key == "f" and isType == false then
    for i = 1, 100*100 do
      if love.math.random(1, 100) < world.fightc[i] then
              world.isFight[i] = true


      else
        world.isFight[i] = false
      end
    end
  end



  if isType == true then
    if key == "down" then
      ts = ts + 1
      if ts == 1 then pl.cinput = curTile
      elseif ts == 2 then pl.cinput = curFight
      elseif ts == 3 then pl.cinput = curFightC
      elseif ts == 6 then pl.cinput = curBG end

      if ts == 7 then ts = 1 end
    elseif key == "up" then
      ts = ts - 1
      if ts == 1 then pl.cinput = curTile
      elseif ts == 2 then pl.cinput = curFight
      elseif ts == 3 then pl.cinput = curFightC
      elseif ts == 5 then pl.cinput = curName end
      if ts == 0 then ts = 6 end
    end



    if key == "backspace" then

         -- get the byte offset to the last UTF-8 character in the string.
      local byteoffset = utf8.offset(pl.cinput, -1)

      if byteoffset then
             -- remove the last UTF-8 character.
             -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
          pl.cinput = string.sub(pl.cinput, 1, byteoffset - 1)
          if ts == 1 then --this should probably be its own function to save us having to repeat it 4 times, ah well
            curTile = pl.cinput
          elseif ts == 2 then
            curFight = pl.cinput
          elseif ts == 6 then
            curBG = pl.cinput
          elseif ts == 5 then
            curName = pl.cinput
          end
      end
    end

  else
    if key == "v" then
      view = view + 1
      if view > 2 then view = 0 end
    end
    if key == "i" then
      info = world.name[selT]..","..world.fight[selT].." ("..world.fightc[selT].."%)"
    end
    if key == "o" then
        curTile = world[selT]
       curFight = world.fight[selT]
       curFightC = world.fightc[selT]
       curCollide =  world.collide[selT]
       curName = world.name[selT]
       curBG = world.bg[selT]
    end
    if key == "e" then saveWorld() end
  end
end

function love.textinput(t)
  if isType == true then
    pl.cinput = pl.cinput..t
    if ts == 1 then
      curTile = pl.cinput
    elseif ts == 2 then
      curFight = pl.cinput
    elseif ts == 3 then
      if t == "e" then
        curFightC = curFightC + 5

        if curFightC > 100 then curFightC = 0 end
      elseif t == "q" then
        curFightC = curFightC - 5

        if curFightC < 0 then curFightC = 100 end
      end
    elseif ts == 4 then
      if t == "t" then curCollide = true elseif t == "f" then curCollide = false end
    elseif ts == 5 then
      curName = pl.cinput
    elseif ts == 6 then
      curBG = pl.cinput
    end
  end
end

function saveWorld()
  local fp = "map-beach.txt"
  local fs = ""
  for i = 1, 100*100 do
    if not world[i] then print("Missing tile info.") end
    if not world.fight[i] then print("Missing fight script.") end
    if not world.fightc[i] then print("Missing fight chance.") end
    if not tostring(world.collide[i]) then print("Missing collision info.") end
    if not world.name[i] then print("Missing world name.") end
    if world[i] and world.fight[i] and world.fightc[i] and tostring(world.collide[i]) and world.name[i] then
      fs = fs..world[i]..","..world.fight[i]..","..world.fightc[i]..","..tostring(world.collide[i])..","..world.name[i]..","..world.bg[i].."\n"
    else
      fs = fs.."error,none,0,false,The Great Plains,error\n"
      print("ERROR! WRITING CURRENT WORLD TO ALTERNATE FILE!! (Error tile is "..i..")")
      --fp = "map-new.txt"
    end
  end

  love.filesystem.write(fp, fs)
  print("Saved world to "..fp..".")
end

function atComma(str, md)
  if not md then md = "," end
	local word = {}
	local thisWord = 1
	for wordd in string.gmatch(str, '([^'..md..']+)') do
    	word[thisWord] = wordd
    	thisWord = thisWord + 1
    end

    return word
end

function round(x)
  if x%2 ~= 0.5 then
    return math.floor(x+0.5)
  end
  return x-0.5
end
