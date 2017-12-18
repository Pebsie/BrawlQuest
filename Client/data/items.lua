item = {}
item.type = {}
item.desc = {} --optional
item.val = {} --for spells this is cooldown in seconds then requirements
item.lvl = {}
item.price = {}
item.img = {}

--nil
local ti = ""
item.type[ti] = "none"
item.val[ti] = 1
item.lvl[ti] = 1
item.price[ti] = 0
item.img[ti] = love.graphics.newImage("img/empty.png")

local ti = "None"
item.type[ti] = "none"
item.val[ti] = "1,1,1"
item.lvl[ti] = 1
item.price[ti] = 0
item.img[ti] = love.graphics.newImage("img/empty.png")

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
item.price[ti] = 50
item.img[ti] = love.graphics.newImage("img/human/Clean Adventurer.png")

local ti = "Leather Armour"
item.type[ti] = "arm"
item.val[ti] = 2
item.lvl[ti] = 3
item.price[ti] = 150
item.img[ti] = love.graphics.newImage("img/human/Clothed Adventurer.png")

local ti = "Chainmail Armour"
item.type[ti] = "arm"
item.val[ti] = 4
item.lvl[ti] = 7
item.price[ti] = 400
item.img[ti] = love.graphics.newImage("img/human/Warrior.png")

local ti = "Guardian's Padding"
item.type[ti] = "arm"
item.val[ti] = 8
item.lvl[ti] = 10
item.price[ti] = 1000
item.img[ti] = love.graphics.newImage("img/human/Guardian.png")

local ti = "Legendary Padding"
item.type[ti] = "arm"
item.val[ti] = 15
item.lvl[ti] = 15
item.price[ti] = 25000
item.img[ti] = love.graphics.newImage("img/human/Legend.png")

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
item.lvl[ti] = 3
item.price[ti] = 50
item.img[ti] = love.graphics.newImage("img/items/weapons/Short Sword.png")

local ti = "Bastard Sword" --NEEDS REWORKING
item.type[ti] = "wep"
item.val[ti] = 3
item.lvl[ti] = 5
item.price[ti] = 250
item.img[ti] = love.graphics.newImage("img/items/weapons/Short Sword.png")

local ti = "Long Sword"
item.type[ti] = "wep"
item.val[ti] = 5
item.lvl[ti] = 8
item.price[ti] = 750
item.img[ti] = love.graphics.newImage("img/items/weapons/Long Sword.png")

local ti = "Guardian's Blade"
item.type[ti] = "wep"
item.val[ti] = 10
item.lvl[ti] = 10
item.price[ti] = 1500
item.img[ti] = love.graphics.newImage("img/items/weapons/Guardians Blade.png")

local ti = "Legendary Sword"
item.type[ti] = "wep"
item.val[ti] = 30
item.lvl[ti] = 15
item.price[ti] = 25000
item.img[ti] = love.graphics.newImage("img/items/weapons/Legendary Blade.png")


--potions
local ti = "Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 70
item.lvl[ti] = 11
item.price[ti] = 20
item.img[ti] = love.graphics.newImage("img/items/consumables/Healing Potion.png")

local ti = "Potent Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 100
item.lvl[ti] = 12
item.price[ti] = 50
item.img[ti] = love.graphics.newImage("img/items/consumables/Potent Healing Potion.png")

--spells
local ti = "Recovery"
item.type[ti] = "Spell"
item.desc[ti] = "Recover 30% health"
item.val[ti] = "120,50"
item.lvl[ti] = 500
item.price[ti] = 10
item.img[ti] = love.graphics.newImage("img/items/scrolls/Recovery.png")

local ti = "Slam"
item.type[ti] = "Spell"
item.desc[ti] = "Deal ATK*2 damage to all enemies within 5 meters"
item.val[ti] = "30,100,1"
item.lvl[ti] = 10
item.price[ti] = 100
item.img[ti] = love.graphics.newImage("img/items/scrolls/Ground Slam.png")

  local ti = "Enrage"
  item.type[ti] = "Spell"
  item.desc[ti] = "Taunt all enemies within 10 meters, causing them to change target and attack you"
  item.val[ti] = "20,20"
  item.lvl[ti] = 10
  item.price[ti] = 500
  item.img[ti] = love.graphics.newImage("img/items/scrolls/Enrage.png")

  local ti = "Phase Shift"
  item.type[ti] = "Spell"
  item.desc[ti] = "All enemies target you switch to the nearest friendly"
  item.val[ti] = "60,50"
  item.lvl[ti] = 10
  item.price[ti] = 500
  item.img[ti] = love.graphics.newImage("img/items/scrolls/Flash of Light.png")

  local ti = "Polymorph"
  item.type[ti] = "Spell"
  item.desc[ti] = "All enemies within 3 meters with HP equal to or less than your weapon's attack turn into Angry Chickens that attack opponents and explode after 5 seconds."
  item.val[ti] = "60,50"
  item.lvl[ti] = 10
  item.price[ti] = 500
  item.img[ti] = love.graphics.newImage("img/items/scrolls/Polymorph.png")


--buddy (Wolf, Snake, Beholder, Baby Bat, Earth Elementling, Fire Elementling, Dragonling)
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

local ti = "Dog"
item.type[ti] = "buddy"
item.desc[ti] = "Left behind by the wolf pack, rejected for its domestic tendencies."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = buddy[ti]

local ti = "Snake"
item.type[ti] = "buddy"
item.desc[ti] = "Don't step on it!"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = buddy[ti]

local ti = "Beholder"
item.type[ti] = "buddy"
item.desc[ti] = "He might look at you funny, but, it's okay: his teeth aren't fully formed just yet."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = buddy[ti]

local ti = "Baby Bat"
item.type[ti] = "buddy"
item.desc[ti] = "Click click click"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = buddy[ti]

local ti = "Earth Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = buddy[ti]

local ti = "Fire Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = buddy[ti]

local ti = "Dragonling"
item.type[ti] = "buddy"
item.desc[ti] = "Like a dragon, but smol."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = buddy[ti]

--special
  local ti = "A letter addressed to you"
  item.type[ti] = "Letter"
  item.val[ti] = "Hey!\n\nThanks so much for playing the BrawlQuest alpha.\n\nSincerely, Pebsie."
  item.lvl[ti] = 10
  item.price[ti] = 0
  item.img[ti] = love.graphics.newImage("img/items/letter.png")

  local ti = "Skeleton Key"
  item.type[ti] = "Key"
  item.val[ti] = "Opens the doorway to the Skeleton King's castle! Attack!"
  item.lvl[ti] = "??"
  item.price[ti] = 0
  item.img[ti] = love.graphics.newImage("img/items/key.png")

shop = {}
shop["Armour"] = {"Basic Cloth", "Leather Armour", "Chainmail Armour", "Guardian's Padding", "Legendary Padding"}
shop["Weapons"] = {"Short Sword", "Bastard Sword", "Long Sword", "Guardian's Blade", "Legendary Sword"}
shop["Potions"] = {"Healing Potion", "Potent Healing Potion"}
shop["Spells"] = {"Recovery","Slam","Enrage","Phase Shift"}
