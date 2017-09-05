
  item = {}
  item.type = {}
  item.val = {}
  item.lvl = {}
  item.price = {}
  item.img = {}

  --weapons
  local ti = "Long Stick"
  item.type[ti] = "wep"
  item.val[ti] = 1
  item.lvl[ti] = 1
  item.price[ti] = 0
  item.img[ti] = love.graphics.newImage("img/items/weapons/Long Stick.png")

  local ti = "Short Sword"
  item.type[ti] = "wep"
  item.val[ti] = 2
  item.lvl[ti] = 1
  item.price[ti] = 1
  item.img[ti] = love.graphics.newImage("img/items/weapons/Short Sword.png")

  local ti = "Bastard Sword" --NEEDS REWORKING
  item.type[ti] = "wep"
  item.val[ti] = 3
  item.lvl[ti] = 2
  item.price[ti] = 4
  item.img[ti] = love.graphics.newImage("img/items/weapons/Short Sword.png")

  local ti = "Long Sword"
  item.type[ti] = "wep"
  item.val[ti] = 5
  item.lvl[ti] = 3
  item.price[ti] = 10
  item.img[ti] = love.graphics.newImage("img/items/weapons/Long Sword.png")

  local ti = "Masterwork Long Sword"
  item.type[ti] = "wep"
  item.val[ti] = 8
  item.lvl[ti] = 4
  item.price[ti] = 25
  item.img[ti] = love.graphics.newImage("img/items/weapons/Masterwork Long Sword.png")

  local ti = "Guardian's Blade"
  item.type[ti] = "wep"
  item.val[ti] = 10
  item.lvl[ti] = 5
  item.price[ti] = 50
  item.img[ti] = love.graphics.newImage("img/items/weapons/Guardians Blade.png")


  local ti = "King's Blade"
  item.type[ti] = "wep"
  item.val[ti] = 15
  item.lvl[ti] = 10
  item.price[ti] = 200
  item.img[ti] = love.graphics.newImage("img/items/weapons/Kings Blade.png")


    --legendary weapons
    local ti = "Legendary Blade"
    item.type[ti] = "wep"
    item.val[ti] = 25
    item.lvl[ti] = 15
    item.price[ti] = 500
    item.img[ti] = love.graphics.newImage("img/items/weapons/Legendary Blade.png")


  --armour
  local ti = "Old Cloth"
  item.type[ti] = "arm"
  item.val[ti] = 0
  item.lvl[ti] = 1
  item.price[ti] = 0
  item.img[ti] = love.graphics.newImage("img/human/Adventurer.png")

  local ti = "Basic Cloth"
  item.type[ti] = "arm"
  item.val[ti] = 1
  item.lvl[ti] = 1
  item.price[ti] = 2
  item.img[ti] = love.graphics.newImage("img/human/Clean Adventurer.png")

  local ti = "Basic Leather"
  item.type[ti] = "arm"
  item.val[ti] = 2
  item.lvl[ti] = 2
  item.price[ti] = 5
  item.img[ti] = love.graphics.newImage("img/human/Fancy Adventurer.png")

  local ti = "Leather Armour"
  item.type[ti] = "arm"
  item.val[ti] = 3
  item.lvl[ti] = 3
  item.price[ti] = 15
  item.img[ti] = love.graphics.newImage("img/human/Clothed Adventurer.png")

  local ti = "Basic Chain"
  item.type[ti] = "arm"
  item.val[ti] = 5
  item.lvl[ti] = 5
  item.price[ti] = 25
  item.img[ti] = love.graphics.newImage("img/human/Soldier.png")

  local ti = "Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 8
  item.lvl[ti] = 7
  item.price[ti] = 50
  item.img[ti] = love.graphics.newImage("img/human/Warrior.png")

  local ti = "Masterwork Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 10
  item.lvl[ti] = 9
  item.price[ti] = 75
  item.img[ti] = love.graphics.newImage("img/human/Master Warrior.png")

  local ti = "Exotic Masterwork Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 15
  item.lvl[ti] = 11
  item.price[ti] = 200
  item.img[ti] = love.graphics.newImage("img/human/Exotic Warrior.png")

  local ti = "Ascended Masterwork Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 22
  item.lvl[ti] = 12
  item.price[ti] = 200
  item.img[ti] = love.graphics.newImage("img/human/Ascended Warrior.png")


  local ti = "Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] = 12
  item.lvl[ti] = 10
  item.price[ti] = 100
  item.img[ti] = love.graphics.newImage("img/human/Champion.png")

  local ti = "Masterwork Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] =  17
  item.lvl[ti] = 11
  item.price[ti] = 200
  item.img[ti] = love.graphics.newImage("img/human/Master Champion.png")

  local ti = "Exotic Masterwork Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] = 20
  item.lvl[ti] = 12
  item.price[ti] = 200
  item.img[ti] = love.graphics.newImage("img/human/Exotic Champion.png")


  local ti = "Ascended Masterwork Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] = 25
  item.lvl[ti] = 12
  item.price[ti] = 200
  item.img[ti] = love.graphics.newImage("img/human/Ascended Champion.png")

  local ti = "Guardian's Padding"
  item.type[ti] = "arm"
  item.val[ti] = 30
  item.lvl[ti] = 13
  item.price[ti] = 210
  item.img[ti] = love.graphics.newImage("img/human/Guardian.png")

  local ti = "King's Padding"
  item.type[ti] = "arm"
  item.val[ti] = 32
  item.lvl[ti] = 13
  item.price[ti] = 210
  item.img[ti] = love.graphics.newImage("img/human/King.png")

  local ti = "Legacy of Forest Heroes"
  item.type[ti] = "arm"
  item.val[ti] = 50
  item.lvl[ti] = 15
  item.price[ti] = 220
  item.img[ti] = love.graphics.newImage("img/human/Forest Hero.png")

    --legendary armour
    local ti = "Legendary Padding"
    item.type[ti] = "arm"
    item.val[ti] = 55
    item.lvl[ti] = 15
    item.price[ti] = 500
    item.img[ti] = love.graphics.newImage("img/human/Legend.png")

  --consumables
  local ti = "Weak Red Potion"
  item.type[ti] = "hp"
  item.val[ti] = 10
  item.lvl[ti] = 1
  item.price[ti] = 1
  item.img[ti] = love.graphics.newImage("img/items/consumables/Weak Red Potion.png")

  local ti = "Red Potion"
  item.type[ti] = "hp"
  item.val[ti] = 20
  item.lvl[ti] = 5
  item.price[ti] = 2
  item.img[ti] = love.graphics.newImage("img/items/consumables/Red Potion.png")

  local ti = "Weak Healing Potion"
  item.type[ti] = "hp"
  item.val[ti] = 40
  item.lvl[ti] = 10
  item.price[ti] = 3
  item.img[ti] = love.graphics.newImage("img/items/consumables/Weak Healing Potion.png")

  local ti = "Healing Potion"
  item.type[ti] = "hp"
  item.val[ti] = 70
  item.lvl[ti] = 11
  item.price[ti] = 5
  item.img[ti] = love.graphics.newImage("img/items/consumables/Healing Potion.png")

  local ti = "Potent Healing Potion"
  item.type[ti] = "hp"
  item.val[ti] = 100
  item.lvl[ti] = 12
  item.price[ti] = 8
  item.img[ti] = love.graphics.newImage("img/items/consumables/Potent Healing Potion.png")


  local ti = "Weak Yellow Potion"
  item.type[ti] = "en"
  item.val[ti] = 10
  item.lvl[ti] = 1
  item.price[ti] = 1
  item.img[ti] = love.graphics.newImage("img/items/consumables/Weak Yellow Potion.png")

  local ti = "Yellow Potion"
  item.type[ti] = "en"
  item.val[ti] = 20
  item.lvl[ti] = 5
  item.price[ti] = 2
  item.img[ti] = love.graphics.newImage("img/items/consumables/Yellow Potion.png")

  local ti = "Weak Energising Potion"
  item.type[ti] = "en"
  item.val[ti] = 40
  item.lvl[ti] = 10
  item.price[ti] = 3
    item.img[ti] = love.graphics.newImage("img/items/consumables/Weak Energising Potion.png")

  local ti = "Energising Potion"
  item.type[ti] = "en"
  item.val[ti] = 70
  item.lvl[ti] = 11
  item.price[ti] = 5
    item.img[ti] = love.graphics.newImage("img/items/consumables/Energising Potion.png")

  local ti = "Potent Energising Potion"
  item.type[ti] = "en"
  item.val[ti] = 100
  item.lvl[ti] = 12
  item.price[ti] = 8
    item.img[ti] = love.graphics.newImage("img/items/consumables/Potent Energising Potion.png")

  --craftable
  local ti = "Boar Hide"
  item.type[ti] = "Craftable"
  item.val[ti] = 1
  item.lvl[ti] = 10
  item.price[ti] = 2
  item.img[ti] = ""

  local ti = "Broken Tooth"
  item.type[ti] = "Craftable"
  item.val[ti] = 1
  item.lvl[ti] = 10
  item.price[ti] = 3
  item.img[ti] = ""

  local ti = "Cloth"
  item.type[ti] = "Craftable"
  item.val[ti] = 1
  item.lvl[ti] = 10
  item.price[ti] = 2
  item.img[ti] = ""

  local ti = "Blue Potion"
  item.type[ti] = "Craftable"
  item.val[ti] = 1
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = ""

  local ti = "Potent Blue Potion"
  item.type[ti] = "Craftable"
  item.val[ti] = 1
  item.lvl[ti] = 10
  item.price[ti] = 50
  item.img[ti] = ""

  buddy = {}
  buddy["Baby Bat"] = love.graphics.newImage("img/pet/Baby Bat.png")
  buddy["Beholder"] = love.graphics.newImage("img/pet/Beholder.png")
  buddy["Beholdling"] = love.graphics.newImage("img/pet/Beholdling.png")
  buddy["Chicken"] = love.graphics.newImage("img/pet/Chicken.png")
  buddy["Dog"] = love.graphics.newImage("img/pet/Dog.png")
  buddy["Dragonling"] = love.graphics.newImage("img/pet/Dragonling.png")
  buddy["Earth Elementling"] = love.graphics.newImage("img/pet/Earth Elementling.png")
  buddy["Fire Elementling"] = love.graphics.newImage("img/pet/Fire Elementling.png")
  buddy["Scorpion"] = love.graphics.newImage("img/pet/Scorpion.png")
  buddy["Sheep"] = love.graphics.newImage("img/pet/Sheep.png")
  buddy["Snake"] = love.graphics.newImage("img/pet/Snake.png")
  buddy["Water Elementling"] = love.graphics.newImage("img/pet/Water Elementling.png")
