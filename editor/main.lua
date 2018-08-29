--map editor
--requires access to img/ and data/fights
---ensure that the map.txt file is in the filesystem directory before running or a new map will be created
utf8 = require("utf8")
require "data/world"

require "light"

http = require("socket.http")

world = {}
world.bg = {}
world.name = {}
world.fight = {}
world.fightc = {}
world.collide = {}
world.isFight = {}
world.music = {}
world.x = {}
world.y = {}
world.rest = {}

mapname = "map-forest.txt"


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
curMusic = "*"
curRest = false

isType = false
ts = 1

displayTiles = false

function love.load()

--  b, c, h = http.request("http://brawlquest.com/dl/map-snow.txt")
--  love.filesystem.write("map-snow.txt", b)
  love.filesystem.setIdentity("editor")

  heroImg = love.graphics.newImage("img/human/Legend.png")
  --load map data
  if love.filesystem.exists(mapname) then
    print("Found world file!")
    for line in love.filesystem.lines(mapname) do
      word = atComma(line)
      i = #world + 1
      world[i] = word[1]
      world.fight[i] = word[2]
      world.fightc[i] = tonumber(word[3])
      if word[4] == "true" then world.collide[i] = true else world.collide[i] = false end
      world.name[i] = word[5]
      world.bg[i] = word[6]
      world.isFight[i] = false
      if word[7] then
        world.music[i] = word[7]
      else
        world.music[i] = "1"
      end
      world.rest[i] = false
      if word[8] and word[8] == "true" then
        world.rest[i] = true
      end
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
      --  if love.math.random(1,200) == 1 then
        --  world[i] = "Tree"
      --  else
          world[i] = "Grass"
        --end
        world.name[i] = "West Shore"
        world.fight[i] = "None"
        world.fightc[i] = 0 --5%
        world.collide[i] = false
        world.bg[i] = "Grass"
        world.music[i] = "*"
        world.rest[i] = false
  --    end

      world.isFight[i] = false
    end
    print("Done.")
  end

  lightmap = {}
  local x = 0
  local y = 0
  for i = 1, 100*100 do
    if world[i] and lightsource[world[i]] then lightmap[i] = lightsource[world[i]]
    else lightmap[i] = 0 end
    world.x[i] = x
    world.y[i] = y
    x = x + 32
    if x > 100*32 then
      x = 0
      y = y + 32
    end
  end
end

function love.draw()
  local x = 0
  local y = 0

  --v = round(((cx+camX)/32)*((cy+camY)/32))
  for i = 1, 100*100 do
    if x-camX > -32 and x-camX < love.graphics.getWidth() and y-camY > -32 and y-camY < love.graphics.getHeight() then
      local cx, cy = love.mouse.getPosition()
      if cx+camX > x and cx+camX < x+32 and cy+camY > y and cy+camY < y+32 then
        selT = i
      end
      if worldImg[world[i]] then
        --if world.isFight[i] == true then love.graphics.setColor(255,0,0) else love.graphics.setColor(255,255,255) end
        if selT == i then love.graphics.setColor(255,255,255,50) else love.graphics.setColor(255,255,255) end
        if view == 2 then if world.collide[i] == true then love.graphics.setColor(255,0,0) end end
        if view == 3 then
          local rs = 0
           for k = 1, #world.name[i] do
             local char = world.name[i]:sub(k,k)
             rs = rs + string.byte(char)
           end

          love.math.setRandomSeed(rs)
          love.graphics.setColor(love.math.random(100,255),love.math.random(100,255),love.math.random(100,255))
        end
        if worldImg[world.bg[i]] then
          love.graphics.draw(worldImg[world.bg[i]], x-camX, y-camY)
        else
          love.graphics.setColor(100,0,0)
          love.graphics.rectangle("fill",x-camX,y-camY,32,32)
        end
        love.graphics.draw(worldImg[world[i]], x-camX, y-camY)
        if love.keyboard.isDown("l") then
          drawLight(x-camX,y-camY,i)
        end

        if world.isFight[i] == true then love.graphics.draw(heroImg, x-camX, y-camY) end
        if view == 1 then
          love.graphics.setColor(0,0,0)
          love.graphics.print(world.fightc[i].."%", x-camX, y-camY)
        elseif view == 4 and world.music[i] ~= "*" then
          love.graphics.setColor(0,0,0)
          love.graphics.print(world.music[i], x-camX, y-camY)
        elseif view == 5 and world.rest[i] then
          love.graphics.setColor(0,0,0)
          love.graphics.print(tostring(world.rest[i]),x-camX,y-camY)
        end
          love.graphics.setColor(1,1,1)
      else
        love.graphics.setColor(1,0,0)
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

  if uiPhase == "select" then
    drawSelect(200,200)
  end

  love.graphics.setColor(1,0,0)
  love.graphics.rectangle("line",ox+(camX/32),oy+(camY/32),25,18.75)

  love.graphics.setColor(0,0,0,100)
  love.graphics.rectangle("fill",0,0,250,14*10)
  love.graphics.setColor(255,255,255)
  love.graphics.print("Camera: "..round(camX)..","..round(camY).."\nSelected tile: "..selT.."\nPlacing tile "..curTile.."\nPlacing fight '"..curFight.."'\n"..curFightC.."% Chance\nCollide="..tostring(curCollide).."\nTitle '"..curName.."'\nFloor is "..curBG.."\nMusic is "..curMusic.."\nRest zone="..tostring(curRest).."\n"..info)

  if isType == true then
    love.graphics.rectangle("line", 0, 14+(14*ts), 200,14)
  end

  if displayTiles then
    local x = 200
    local y = 100
    for i, v in pairs (worldImg) do
      love.graphics.draw(v,x,y)
      if isMouseOver(x,32,y,32) then
        love.graphics.print(i,love.mouse.getX( ),love.mouse.getY( ))
      end
      x = x + 32
      if x > 200 + (32 * 6) then
        x = 200
        y = y + 32
      end
    end
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
  world.bg[selT] = curBG
  world.music[selT] = curMusic
  world.rest[selT] = true end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    world[selT] = curTile
    world.fight[selT] = curFight
    world.fightc[selT] = curFightC
    world.collide[selT] = curCollide
    world.name[selT] = curName
    world.music[selT] = curMusic
    world.rest[selT] = curRest
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
  elseif key == "escape" then
    if uiPhase == "world" then uiPhase = "select" else uiPhase = "world" end
  end



  if isType == true then
    if key == "down" then
      ts = ts + 1
      if ts == 1 then pl.cinput = curTile
      elseif ts == 2 then pl.cinput = curFight
      elseif ts == 3 then pl.cinput = curFightC
      elseif ts == 6 then pl.cinput = curBG
      elseif ts == 7 then pl.cinput = curMusic  end
      if ts == 9 then ts = 1 end
    elseif key == "up" then
      ts = ts - 1
      if ts == 1 then pl.cinput = curTile
      elseif ts == 2 then pl.cinput = curFight
      elseif ts == 3 then pl.cinput = curFightC
      elseif ts == 5 then pl.cinput = curName
      elseif ts == 7 then pl.cinput = curMusic end
      if ts == 0 then ts = 8 end
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
          elseif ts == 7 then
            curMusic = pl.cinput
          end
      end
    end

  else
    if key == "v" then
      view = view + 1
      if view > 5 then view = 0 end
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
       curMusic = world.music[selT]
       curRest = world.rest[selT]
    end
    if key == "e" then saveWorld() end
    if key == "y" and displayTiles == false then displayTiles = true elseif key == "y" then displayTiles = false end
--    if key == "]" then weather.time = weather.time + 1 if weather.time > 24 then weather.time = 0 end elseif key == "[" then weather.time = weather.time - 1 if weather.time == -1 then weather.time = 24 end end
    if key == "r" and love.keyboard.isDown("l") then resetLightmap() end
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
    elseif ts == 8 then
      if t == "t" then curRest = true elseif t == "f" then curRest = false end
    elseif ts == 5 then
      curName = pl.cinput
    elseif ts == 6 then
      curBG = pl.cinput
    elseif ts == 7 then
      curMusic = pl.cinput
    end
  end
end

function saveWorld()
  local fp = mapname
  local fs = ""
  for i = 1, 100*100 do
    if not world[i] then print("Missing tile info.") end
    if not world.fight[i] then print("Missing fight script.") end
    if not world.fightc[i] then print("Missing fight chance.") end
    if not tostring(world.collide[i]) then print("Missing collision info.") end
    if not world.name[i] then print("Missing world name.") end
    if world[i] and world.fight[i] and world.fightc[i] and tostring(world.collide[i]) and world.name[i] and world.music[i] then
      fs = fs..world[i]..","..world.fight[i]..","..world.fightc[i]..","..tostring(world.collide[i])..","..world.name[i]..","..world.bg[i]..","..world.music[i]..","..tostring(world.rest[i]).."\n"
    else
      fs = fs.."error,none,0,false,The Great Plains,error\n"
      print("ERROR! WRITING CURRENT WORLD TO ALTERNATE FILE!! (Error tile is "..i..")")
      fp = "map-new.txt"
    end
  end

  love.filesystem.write(fp, fs)
  love.filesystem.write(fp.."-backup-"..os.time()..".txt",fs)
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


local oldSetColor = love.graphics.setColor
 love.graphics.setColor = function (r, g, b, a)
   if type(r)=="table" then
       g = r[2] / 255
       b = r[3] / 255
       a = (r[4] or 255) / 255
       r = r[1] / 255
   else
     r = r / 255
     g = g / 255
     b = b / 255
     a = (a or 255) / 255
   end
   oldSetColor(r,g,b,a)
 end

 local oldSetBackgroundColor = love.graphics.setBackgroundColor
 love.graphics.setBackgroundColor = function (r, g, b, a)
   if type(r)=="table" then
       g = r[2] / 255
       b = r[3] / 255
       a = (r[4] or 255) / 255
       r = r[1] / 255
   else
     r = r / 255
     g = g / 255
     b = b / 255
     a = (a or 255) / 255
   end
   oldSetBackgroundColor(r,g,b,a)
 end

 function isMouseOver(xpos, width, ypos, height)
   cx,cy = love.mouse.getPosition()
   if cx > xpos and cx < xpos+width and cy > ypos and cy < ypos+height then
     return true
   else
     return false
   end
 end

 function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end

function resetLightmap()
  lightmap = {}
  local x = 0
  local y = 0
  for i = 1, 100*100 do
    if world[i] and lightsource[world[i]] then lightmap[i] = lightsource[world[i]]
    else lightmap[i] = 0 end
    world.x[i] = x
    world.y[i] = y
    x = x + 32
    if x > 100*32 then
      x = 0
      y = y + 32
    end
  end

  for i = 1, 100*100 do
    weather.time = tonumber(weather.time)
    local tileDarkness = 0


    if weather.time == 0 then tileDarkness = 160
    elseif weather.time == 1 then tileDarkness = 150
    elseif weather.time == 2 then tileDarkness = 150
    elseif weather.time == 3 then tileDarkness = 120
    elseif weather.time == 4 then tileDarkness = 100
    elseif weather.time == 5 then tileDarkness = 90
    elseif weather.time == 6 then tileDarkness = 75
    elseif weather.time == 7 then tileDarkness = 30
    elseif weather.time == 8 then tileDarkness = 15
    elseif weather.time == 16 then tileDarkness = 20
    elseif weather.time == 17 then tileDarkness = 40
    elseif weather.time == 18 then tileDarkness = 50
    elseif weather.time == 19 then tileDarkness = 70
    elseif weather.time == 20 then tileDarkness = 90
    elseif weather.time == 21 then tileDarkness = 120
    elseif weather.time == 22 then tileDarkness = 130
    elseif weather.time == 23 then tileDarkness = 150
    elseif weather.time == 24 then tileDarkness = 150 end



        local val = 0
        local calc = 0
        for k = -195,305,101 do
          for t = -9, -5 do
            if lightmap[t+i+k] then
              print(lightmap[t+i+k])
              val = val + (lightmap[t+i+k]*20 - distanceFrom(world.x[i],world.y[i],world.x[t+i+k],world.y[t+i+k])/32)
              calc = calc + 1
            end
          end
        end

      if val > 0 then
        tileDarkness = tileDarkness - val
      end

      weather.tileDarkness[i] = tileDarkness
    end
end
