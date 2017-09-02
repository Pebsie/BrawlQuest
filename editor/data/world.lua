worldImg = {} --so called here so it doesn't conflict with the editor
worldImg["Grass"] = love.graphics.newImage("img/world/Grass.png")
worldImg["Camp"] = love.graphics.newImage("img/world/Camp.png")
worldImg["Boulder"] = love.graphics.newImage("img/world/Boulder.png")
worldImg["Dead Tree"] = love.graphics.newImage("img/world/Dead Tree.png")
worldImg["Dungeon"] = love.graphics.newImage("img/world/Dungeon.png")
worldImg["Farm"] = love.graphics.newImage("img/world/Farm.png")
worldImg["Marsh"] = love.graphics.newImage("img/world/Marsh.png")
worldImg["Mountain"] = love.graphics.newImage("img/world/Mountain.png")
worldImg["Raid"] = love.graphics.newImage("img/world/Raid.png")
worldImg["Ruins"] = love.graphics.newImage("img/world/Ruins.png")
worldImg["Sand"] = love.graphics.newImage("img/world/Sand.png")
worldImg["Tree"] = love.graphics.newImage("img/world/Tree.png")
worldImg["Village"] = love.graphics.newImage("img/world/Village.png")
worldImg["Water"] = love.graphics.newImage("img/world/Water.png")

function setWColour(wname)
  if wname == "Grass" then
    love.graphics.setColor(0,255,0)
  elseif wname == "Camp" then
    love.graphics.setColor(255,100,100)
  elseif wname == "Boulder" then
    love.graphics.setColor(150,150,150)
  elseif wname == "Dead Tree" then
    love.graphics.setColor(140, 65, 19)
  elseif wname == "Dungeon" then
    love.graphics.setColor(255,100,100)
  elseif wname == "Farm" then
    love.graphics.setColor(232, 182, 76)
  elseif wname == "Marsh" then
    love.graphics.setColor(41, 142, 95)
  elseif wname == "Mountain" then
    love.graphics.setColor(100,100,100)
  elseif wname == "Raid" then
    love.graphics.setColor(255,255,255)
  elseif wname == "Ruins" then
    love.graphics.setColor(200,200,200)
  elseif wname == "Sand" then
    love.graphics.setColor(255, 249, 96)
  elseif wname == "Tree" then
    love.graphics.setColor(0,150,0)
  elseif wname == "Village" then
    love.graphics.setColor(109, 73, 35)
  elseif wname == "Water" then
    love.graphics.setColor(0,0,255)
  end
end
