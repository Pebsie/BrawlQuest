worldImg = {} --so called here so it doesn't conflict with the editor
worldImg["Grass"] = love.graphics.newImage("img/world/floors/Grass.png")
worldImg["Sandy Grass"] = love.graphics.newImage("img/world/floors/Sandy Grass.png")
worldImg["Sandstone"] = love.graphics.newImage("img/world/floors/Sandstone.png")
worldImg["Camp"] = love.graphics.newImage("img/world/objects/Camp.png")
worldImg["Boulder"] = love.graphics.newImage("img/world/objects/Boulder.png")
worldImg["Dead Tree"] = love.graphics.newImage("img/world/objects/Dead Tree.png")
worldImg["Dungeon"] = love.graphics.newImage("img/world/objects/Dungeon.png")
worldImg["Farm"] = love.graphics.newImage("img/world/objects/Farm.png")
worldImg["Marsh"] = love.graphics.newImage("img/world/objects/Marsh.png")
worldImg["Mountain"] = love.graphics.newImage("img/world/objects/Mountain.png")
worldImg["Raid"] = love.graphics.newImage("img/world/objects/Raid.png")
worldImg["Ruins"] = love.graphics.newImage("img/world/objects/Ruins.png")
worldImg["Sand"] = love.graphics.newImage("img/world/floors/Sand.png")
worldImg["Tree"] = love.graphics.newImage("img/world/objects/Tree.png")
worldImg["Village"] = love.graphics.newImage("img/world/objects/Village.png")
worldImg["Water"] = love.graphics.newImage("img/world/floors/Water.png")
worldImg["castle1"] = love.graphics.newImage("img/world/objects/castle1.png")
worldImg["castle2"] = love.graphics.newImage("img/world/objects/castle2.png")
worldImg["castle3"] = love.graphics.newImage("img/world/objects/castle3.png")
worldImg["castle4"] = love.graphics.newImage("img/world/objects/castle4.png")
worldImg["Bridge"] = love.graphics.newImage("img/world/floors/Bridge.png")
worldImg["Cactus"] = love.graphics.newImage("img/world/objects/Cactus.png")
worldImg["Graveyard"] = love.graphics.newImage("img/world/objects/Graveyard.png")
worldImg["Desert Village"] = love.graphics.newImage("img/world/objects/Desert Village.png")
worldImg["Wall"] = love.graphics.newImage("img/world/objects/Wall.png")
worldImg["PU"] = love.graphics.newImage("img/world/objects/pathway/Up.png")
worldImg["PDL"] = love.graphics.newImage("img/world/objects/pathway/Down Left.png")
worldImg["PDR"] = love.graphics.newImage("img/world/objects/pathway/Down Right.png")
worldImg["PS"] = love.graphics.newImage("img/world/objects/pathway/Side.png")
worldImg["PUL"] = love.graphics.newImage("img/world/objects/pathway/Up Left.png")
worldImg["PUR"] = love.graphics.newImage("img/world/objects/pathway/Up Right.png")



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
  elseif wname == "castle1" or wname == "castle2" or wname == "castle3" or wname == "castle4" then
    love.graphics.setColor(200,200,200)
  elseif wname == "Bridge" then
    love.graphics.setColor(255,249,150)
  elseif wname == "Cacuts" then
    love.graphics.setColor(0,100,0)
  end
end
