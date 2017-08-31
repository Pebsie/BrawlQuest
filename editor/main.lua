--map editor
--requires access to img/ and data/fights
---ensure that the map.txt file is in the filesystem directory before running or a new map will be created

require "data/world"

world = {}
world.fight = {}
world.fightc = {}
world.collide = {}

camX = 0
camY = 0
selT = 0

curTile = "Mountain"

function love.load()
  --load map data
  if love.filesystem.exists("map.txt") then

  else
    print("Generating new map...")
    for i = 1, 100*100 do
      if i < 100*20 then --top 20 rows are all trees
        world[i] = "Tree"
        world.fight[i] = "None"
        world.fightc[i] = 0
        world.collide[i] = true
      else
        world[i] = "Grass"
        world.fight[i] = "Boar Hunt"
        world.fightc[i] = 5 --5%
        world.collide[i] = false
      end
    end
    print("Done.")
  end
end

function love.draw()
  local x = 0
  local y = 0

  --v = round(((cx+camX)/32)*((cy+camY)/32))
  for i = 1, 100*100 do
    local cx, cy = love.mouse.getPosition()
    if cx+camX > x and cx+camX < x+32 and cy+camY > y and cy+camY < y+32 then
      selT = i
    end
    if worldImg[world[i]] then
      if selT == i then love.graphics.setColor(255,255,255,50) else love.graphics.setColor(255,255,255) end
      love.graphics.draw(worldImg[world[i]], x-camX, y-camY)
    else
      love.graphics.setColor(255,0,0)
      love.graphics.rectangle("line", x-camX, y-camY, 32, 32)
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

  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",0,0,150,14*3)
  love.graphics.setColor(255,255,255)
  love.graphics.print("Camera: "..round(camX)..","..round(camY).."\nSelected tile: "..selT.."\nPlacing tile "..curTile)
end

function love.update(dt)
  if love.keyboard.isDown("lshift") then
    speed = 512*dt
  else
    speed = 128*dt
  end
  if love.keyboard.isDown("w") then camY = camY - speed end
  if love.keyboard.isDown("s") then camY = camY +  speed end
  if love.keyboard.isDown("d") then camX = camX +  speed end
  if love.keyboard.isDown("a") then camX = camX -  speed end

  if love.mouse.isDown(1) then world[selT] = curTile end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    world[selT] = curTile
  end
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
