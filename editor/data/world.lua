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
worldImg["Well"] = love.graphics.newImage("img/world/objects/Well.png")
worldImg["Snow"] = love.graphics.newImage("img/world/floors/Snow.png")
worldImg["Cart"] = love.graphics.newImage("img/world/objects/Cart.png")
worldImg["Cold Door"] = love.graphics.newImage("img/world/objects/Cold Door.png")
worldImg["Cold Wall"] = love.graphics.newImage("img/world/objects/Cold Wall.png")
worldImg["Fell Tree"] = love.graphics.newImage("img/world/objects/Fell Tree.png")
worldImg["Snowy Dead Tree"] = love.graphics.newImage("img/world/objects/Snowy Dead Tree.png")
worldImg["Snowy Tree"] = love.graphics.newImage("img/world/objects/Snowy Tree.png")
worldImg["Stone Floor"] = love.graphics.newImage("img/world/floors/Stone Floor.png")
worldImg["Cave Floor"] = love.graphics.newImage("img/world/floors/Cave Floor.png")
worldImg["Blacksmith"] = love.graphics.newImage("img/world/objects/Blacksmith.png")
worldImg["Boat"] = love.graphics.newImage("img/world/objects/Boat.png")
worldImg["Chest"] = love.graphics.newImage("img/world/objects/Chest.png")
worldImg["Crystal"] = love.graphics.newImage("img/world/objects/Crystal.png")
worldImg["Knight"] = love.graphics.newImage("img/world/objects/Knight.png")
worldImg["Lantern"] = love.graphics.newImage("img/world/objects/Lantern.png")
worldImg["Pillar"] = love.graphics.newImage("img/world/objects/Pillar.png")
worldImg["Red Walkway"] = love.graphics.newImage("img/world/objects/Red Walkway.png")
worldImg["Wall Mounted Torch"] = love.graphics.newImage("img/world/objects/Wall Mounted Torch.png")
worldImg["Curse"] = love.graphics.newImage("img/world/objects/Curse.png")
worldImg["Hole"] = love.graphics.newImage("img/world/objects/Hole.png")
worldImg["Beach Tree"] = love.graphics.newImage("img/world/objects/Beach Tree.png")
worldImg["Campfire"] = love.graphics.newImage("img/world/objects/Campfire.png")
worldImg["Jungle Tree"] = love.graphics.newImage("img/world/objects/Jungle Tree.png")
worldImg["Rock"] = love.graphics.newImage("img/world/objects/Rock.png")
worldImg["Supplies"] = love.graphics.newImage("img/world/objects/Supplies.png")
worldImg["Mortus"] = love.graphics.newImage("img/world/objects/Mortus.png")
worldImg["Skeleton"] = love.graphics.newImage("img/world/objects/Skeleton1.png")
worldImg["Skeleton2"] = love.graphics.newImage("img/world/objects/Skeleton2.png")
worldImg["Skull"] = love.graphics.newImage("img/world/objects/Skull.png")
worldImg["Skulls"] = love.graphics.newImage("img/world/objects/Skulls.png")
worldImg["Web"] = love.graphics.newImage("img/world/objects/Web.png")
worldImg["Carus"] = love.graphics.newImage("img/world/objects/Carus.png")
worldImg["Glyph"] = love.graphics.newImage("img/world/objects/Glyph.png")
worldImg["Mushroom"] = love.graphics.newImage("img/world/objects/Mushroom.png")
worldImg["Barrel"] = love.graphics.newImage("img/world/objects/Barrel.png")
worldImg["Big Chest"] = love.graphics.newImage("img/world/objects/Big Chest.png")
worldImg["Huts"] = love.graphics.newImage("img/world/objects/Huts.png")

function setWColour(wname)
  if wname == "Grass" or wname == "Snow" or wname == "Curse" or wname == "Cave Floor" then
    love.graphics.setColor(0,1,0)
  elseif wname == "Camp" or wname == "Blacksmith" then
    love.graphics.setColor(255/255,100/255,100/255)
  elseif wname == "Boulder" then
    love.graphics.setColor(150/255,150/255,150/255)
  elseif wname == "Dead Tree" then
    love.graphics.setColor(140/255, 65/255, 19/255)
  elseif wname == "Dungeon" or wname == "Stone Floor" or wname == "Red Walkway" then
    love.graphics.setColor(255/255,100/255,100/255)
  elseif wname == "Farm" then
    love.graphics.setColor(232/255, 182/255, 76/255)
  elseif wname == "Marsh" then
    love.graphics.setColor(41/255, 142/255, 95/255)
  elseif wname == "Mountain" then
    love.graphics.setColor(100/255,100/255,100/255)
  elseif wname == "Raid" then
    love.graphics.setColor(255/255,255/255,255/255)
  elseif wname == "Ruins" then
    love.graphics.setColor(200/255,200/255,200/255)
  elseif wname == "Sand" then
    love.graphics.setColor(255/255, 249/255, 96/255)
  elseif wname == "Tree" or wname == "Snowy Tree" or wname == "Jungle Tree" or wname == "Beach Tree" then
    love.graphics.setColor(0,150/255,0)
  elseif wname == "Village" then
    love.graphics.setColor(109/255, 73/255, 35/255)
  elseif wname == "Water" then
    love.graphics.setColor(0,0,255/255)
  elseif wname == "castle1" or wname == "castle2" or wname == "castle3" or wname == "castle4" then
    love.graphics.setColor(200/255,200/255,200/255)
  elseif wname == "Bridge" then
    love.graphics.setColor(255/255,249/255,150/255)
  elseif wname == "Cacuts" then
    love.graphics.setColor(0,100/255,0)
  else
    love.graphics.setColor(0,0,0)
  end
end
