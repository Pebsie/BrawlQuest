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
item.price[ti] = "0,Gold"
item.img[ti] = love.graphics.newImage("img/empty.png")

local ti = "None"
item.type[ti] = "none"
item.val[ti] = 0
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = love.graphics.newImage("img/empty.png")

--armour
local ti = "Legendary Helmet"
item.type[ti] = "head armour"
item.val[ti] = 10
item.lvl[ti] = 14
item.price[ti] = "20,Iron,10,String,10,Mana,1,Old World Crystal"
item.img[ti] = love.graphics.newImage("img/items/armour/Legendary Helmet.png")

local ti = "Legendary Chestplate"
item.type[ti] = "chest armour"
item.val[ti] = 25
item.lvl[ti] = 14
item.price[ti] = "30,Iron,20,String,20,Mana,1,Old World Crystal"
item.img[ti] = love.graphics.newImage("img/items/armour/Legendary Chestplate.png")

local ti = "Legendary Leggings"
item.type[ti] = "leg armour"
item.val[ti] = 15
item.lvl[ti] = 14
item.price[ti] = "20,Iron,10,String,10,Mana,1,Old World Crystal"
item.img[ti] = love.graphics.newImage("img/items/armour/Legendary Leggings.png")

local ti = "Wooden Helmet"
item.type[ti] = "head armour"
item.val[ti] = 2
item.lvl[ti] = 10
item.price[ti] = "10,Wood,5,String"
item.img[ti] = love.graphics.newImage("img/items/armour/"..ti..".png")

local ti = "Wooden Chestplate"
item.type[ti] = "chest armour"
item.val[ti] = 5
item.lvl[ti] = 10
item.price[ti] = "30,Wood,10,String"
item.img[ti] = love.graphics.newImage("img/items/armour/"..ti..".png")

local ti = "Wooden Leggings"
item.type[ti] = "leg armour"
item.val[ti] = 3
item.lvl[ti] = 10
item.price[ti] = "20,Wood,5,String"
item.img[ti] = love.graphics.newImage("img/items/armour/"..ti..".png")

local ti = "Iron Helmet"
item.type[ti] = "head armour"
item.val[ti] = 4
item.lvl[ti] = 10
item.price[ti] = "5,Iron,5,String"
item.img[ti] = love.graphics.newImage("img/items/armour/"..ti..".png")

local ti = "Iron Chestplate"
item.type[ti] = "chest armour"
item.val[ti] = 10
item.lvl[ti] = 10
item.price[ti] = "15,Iron,10,String"
item.img[ti] = love.graphics.newImage("img/items/armour/"..ti..".png")

local ti = "Iron Leggings"
item.type[ti] = "leg armour"
item.val[ti] = 6
item.lvl[ti] = 10
item.price[ti] = "10,Iron,5,String"
item.img[ti] = love.graphics.newImage("img/items/armour/"..ti..".png")



--old armour
local ti = "Boat"
item.type[ti] = "arm"
item.val[ti] = 0
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = love.graphics.newImage("img/world/objects/Boat.png")

local ti = "Naked"
item.type[ti] = "arm"
item.val[ti] = 0
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = love.graphics.newImage("img/human/base.png")

local ti = "Old Cloth"
item.type[ti] = "arm"
item.val[ti] = 1
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = love.graphics.newImage("img/human/Adventurer.png")

local ti = "Basic Cloth"
item.type[ti] = "arm"
item.val[ti] = 2
item.lvl[ti] = 1
item.price[ti] = "5,Gold"
item.img[ti] = love.graphics.newImage("img/human/Clean Adventurer.png")

local ti = "Leather Armour"
item.type[ti] = "arm"
item.val[ti] = 3
item.lvl[ti] = 3
item.price[ti] = "25,Gold"
item.img[ti] = love.graphics.newImage("img/human/Clothed Adventurer.png")

local ti = "Chainmail Armour"
item.type[ti] = "arm"
item.val[ti] = 4
item.lvl[ti] = 7
item.price[ti] = "100,Gold"
item.img[ti] = love.graphics.newImage("img/human/Warrior.png")

local ti = "Guardian's Padding"
item.type[ti] = "arm"
item.val[ti] = 8
item.lvl[ti] = 10
item.price[ti] = "20,Adver"
item.img[ti] = love.graphics.newImage("img/human/Guardian.png")

local ti = "Legendary Padding"
item.type[ti] = "arm"
item.val[ti] = 15
item.lvl[ti] = 15
item.price[ti] = "100,Adver"
item.img[ti] = love.graphics.newImage("img/human/Legend.png")

local ti = "Eldertouched Plate"
item.type[ti] = "arm"
item.val[ti] = 50
item.lvl[ti] = 30
item.price[ti] = "500,Adver"
item.img[ti] = love.graphics.newImage("img/human/Eldertouched Plate.png")

--weapons
local ti = "Long Stick"
item.type[ti] = "wep"
item.val[ti] = 1
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = love.graphics.newImage("img/items/weapons/Long Stick.png")

local ti = "Short Sword"
item.type[ti] = "wep"
item.val[ti] = 2
item.lvl[ti] = 3
item.price[ti] = "5,Gold"
item.img[ti] = love.graphics.newImage("img/items/weapons/Short Sword.png")

local ti = "Bastard Sword" --NEEDS REWORKING
item.type[ti] = "wep"
item.val[ti] = 3
item.lvl[ti] = 5
item.price[ti] = "15,Gold"
item.img[ti] = love.graphics.newImage("img/items/weapons/Short Sword.png")

local ti = "Long Sword"
item.type[ti] = "wep"
item.val[ti] = 5
item.lvl[ti] = 8
item.price[ti] = "25,Gold"
item.img[ti] = love.graphics.newImage("img/items/weapons/Long Sword.png")

local ti = "Guardian's Blade"
item.type[ti] = "wep"
item.val[ti] = 10
item.lvl[ti] = 10
item.price[ti] = "20,Adver"
item.img[ti] = love.graphics.newImage("img/items/weapons/Guardians Blade.png")

local ti = "Legendary Sword"
item.type[ti] = "wep"
item.val[ti] = 30
item.lvl[ti] = 15
item.price[ti] = "100,Adver"
item.img[ti] = love.graphics.newImage("img/items/weapons/Legendary Blade.png")


--potions
local ti = "Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 70
item.lvl[ti] = 11
item.price[ti] = "2,Mana"
item.img[ti] = love.graphics.newImage("img/items/consumables/Healing Potion.png")

local ti = "Potent Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 100
item.lvl[ti] = 12
item.price[ti] = "3,Gold"
item.img[ti] = love.graphics.newImage("img/items/consumables/Potent Healing Potion.png")

local ti = "Suspicious Meat"
item.type[ti] = "hp"
item.val[ti] = 80
item.lvl[ti] = 10
item.price[ti] = "3,Gold"
item.img[ti] = love.graphics.newImage("img/items/consumables/Suspicious Meat.png")

--spells
local ti = "Recovery"
item.type[ti] = "Spell"
item.desc[ti] = "Recover 100% health"
item.val[ti] = "30,50"
item.lvl[ti] = 500
item.price[ti] = "10,Mana"
item.img[ti] = love.graphics.newImage("img/items/scrolls/Recovery.png")

local ti = "Slam"
item.type[ti] = "Spell"
item.desc[ti] = "Deal ATK*8 damage to all enemies within 5 meters"
item.val[ti] = "20,50,1"
item.lvl[ti] = 10
item.price[ti] = "10,Mana"
item.img[ti] = love.graphics.newImage("img/items/scrolls/Ground Slam.png")

  local ti = "Enrage"
  item.type[ti] = "Spell"
  item.desc[ti] = "Taunt all enemies within 10 meters, causing them to change target and attack you"
  item.val[ti] = "20,20"
  item.lvl[ti] = 10
  item.price[ti] = "10,Mana"
  item.img[ti] = love.graphics.newImage("img/items/scrolls/Enrage.png")

  local ti = "Phase Shift"
  item.type[ti] = "Spell"
  item.desc[ti] = "All enemies target you switch to the nearest friendly"
  item.val[ti] = "60,50"
  item.lvl[ti] = 10
  item.price[ti] = "10,Mana"
  item.img[ti] = love.graphics.newImage("img/items/scrolls/Flash of Light.png")

  local ti = "Polymorph"
  item.type[ti] = "Spell"
  item.desc[ti] = "All enemies within 3 meters turn into Angry Chickens that explode after 3 seconds."
  item.val[ti] = "20,50"
  item.lvl[ti] = 10
  item.price[ti] = "20,Mana"
  item.img[ti] = love.graphics.newImage("img/items/scrolls/Polymorph.png")

  local ti = "Summon 5 Friendly Snake"
  item.type[ti] = "Spell"
  item.desc[ti] = "Make 5 Friendly Snakes appear around you to assist you in battle!"
  item.val[ti] = "300,75"
  item.lvl[ti] = 10
  item.price[ti] = "200,Gold"
  item.img[ti] = love.graphics.newImage("img/items/scrolls/Summon Snakes.png")

--buddy (Wolf, Snake, Beholder, Baby Bat, Earth Elementling, Fire Elementling, Dragonling)


local ti = "Dog"
item.type[ti] = "buddy"
item.desc[ti] = "Left behind by the wolf pack, rejected for its domestic tendencies."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Snake"
item.type[ti] = "buddy"
item.desc[ti] = "Don't step on it!"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Beholder"
item.type[ti] = "buddy"
item.desc[ti] = "He might look at you funny, but, it's okay: his teeth aren't fully formed just yet."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Baby Bat"
item.type[ti] = "buddy"
item.desc[ti] = "Click click click"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Earth Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Fire Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Dragonling"
item.type[ti] = "buddy"
item.desc[ti] = "Like a dragon, but smol."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Protector"
item.type[ti] = "buddy"
item.desc[ti] = "He might be whispering things... dark things."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Fly"
item.type[ti] = "buddy"
item.desc[ti] = "Bzzzzzz..."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Horse"
item.type[ti] = "buddy"
item.desc[ti] = "It's a shame that you don't have a saddle. Yet."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Spirit of Death"
item.type[ti] = "buddy"
item.desc[ti] = "Not to be confused with Face of Death or Heart of Death."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

--special
  local ti = "A letter addressed to you"
  item.type[ti] = "Letter"
  item.val[ti] = "Hey!\n\nThanks so much for playing the BrawlQuest alpha.\n\nSincerely, Pebsie."
  item.lvl[ti] = 10
  item.price[ti] = "0,Gold"
  item.img[ti] = love.graphics.newImage("img/items/letter.png")

  local ti = "Eastern Tribe Secrets"
  item.type[ti] = "Letter"
  item.val[ti] = "The note contains blueprints for a type of medallion that can be crafted by a Blacksmith.\nYou recognise the style from those the Blacksmith at Mortus’ camp uses.\nIt says that this will allow passage through the Sorcerer's cursed land and requires\n4 “Adver Crystals”, found in a mine to the South."
  item.lvl[ti] = 10
  item.price[ti] = "0,Gold"
  item.img[ti] = love.graphics.newImage("img/items/letter.png")

  local ti = "Crypt Key"
  item.type[ti] = "Key"
  item.val[ti] = "Opens the crypt that the Eastern tribe used to keep their dead in."
  item.lvl[ti] = "??"
  item.price[ti] = "0,Gold"
  item.img[ti] = love.graphics.newImage("img/items/key.png")

  local ti = "Lair Key"
  item.type[ti] = "Key"
  item.val[ti] = "Opens the Sorcerer's Lair, south East of the White Forest."
  item.lvl[ti] = "??"
  item.price[ti] = "0,Gold"
  item.img[ti] = love.graphics.newImage("img/items/key.png")

  local ti = "Adver Ring"
  item.type[ti] = "Key"
  item.val[ti] = "Allows you to pass through cursed areas of The Southern Mountains"
  item.lvl[ti] = "??"
  item.price[ti] = "4,Adver"
  item.img[ti] = love.graphics.newImage("img/items/Adver Ring.png")

  local ti = "Gold"
  item.type[ti] = "currency"
  item.val[ti] = "1"
  item.lvl[ti] = 1
  item.price[ti] = "0,Gold"
  item.img[ti] = love.graphics.newImage("img/items/gold.png")

  local ti = "Adver"
  item.type[ti] = "currency"
  item.val[ti] = "1"
  item.lvl[ti] = 1
  item.price[ti] = "0,Adver"
  item.img[ti] = love.graphics.newImage("img/world/objects/Crystal.png")

  local ti = "Quia"
  item.type[ti] = "currency"
  item.val[ti] = "1"
  item.lvl[ti] = 1
  item.price[ti] = "5,Adver"
  item.img[ti] = love.graphics.newImage("img/items/Quia.png")

  local ti = "Orb of Power"
  item.type[ti] = "upgrade"
  item.val[ti] = "1,ATK"
  item.lvl[ti] = 10
  item.price[ti] = "350,Quia"
  item.img[ti] = love.graphics.newImage("img/items/Orb of Power.png")

  --craftable
  local ti = "Wood"
  item.type[ti] = "Reagent"
  item.val[ti] = ""
  item.lvl[ti] = 1
  item.price[ti] = "1,Gold"
  item.img[ti] = love.graphics.newImage("img/items/reagent/Wood.png")

  local ti = "Stone"
  item.type[ti] = "Reagent"
  item.val[ti] = ""
  item.lvl[ti] = 1
  item.price[ti] = "1,Gold"
  item.img[ti] = love.graphics.newImage("img/items/reagent/Stone.png")

  local ti = "String"
  item.type[ti] = "Reagent"
  item.val[ti] = ""
  item.lvl[ti] = 1
  item.price[ti] = "1,Gold"
  item.img[ti] = love.graphics.newImage("img/items/reagent/String.png")

  local ti = "Mana Crystal"
  item.type[ti] = "Reagent"
  item.val[ti] = ""
  item.lvl[ti] = 1
  item.price[ti] = "1,Gold"
  item.img[ti] = love.graphics.newImage("img/world/objects/Crystal.png")

  local ti = "Iron"
  item.type[ti] = "Reagent"
  item.val[ti] = ""
  item.lvl[ti] = 1
  item.price[ti] = "1,Gold"
  item.img[ti] = love.graphics.newImage("img/items/reagent/Metal.png")

  local ti = "Hilt"
  item.type[ti] = "Reagent"
  item.val[ti] = ""
  item.lvl[ti] = 1
  item.price[ti] = "10,Wood,5,Stone,2,String"
  item.img[ti] = love.graphics.newImage("img/items/reagent/Hilt.png")

shop = {}
--[[
shop["Armour"] = {"Basic Cloth", "Leather Armour", "Chainmail Armour", "Guardian's Padding", "Legendary Padding"}
shop["Weapons"] = {"Short Sword", "Bastard Sword", "Long Sword", "Guardian's Blade", "Legendary Sword"}
shop["Misc"] = {"Healing Potion", "Potent Healing Potion", "Adver Ring", "Quia", "Orb of Power"}
shop["Spells"] = {"Recovery","Slam","Enrage","Phase Shift","Polymorph"}]]
shop["Head Armour"] = {"Wooden Helmet", "Iron Helmet", "Guardian's Helmet", "Legendary Helmet"}
shop["Chest Armour"] = {"Wooden Chestplate", "Iron Chestplate", "Guardian's Chestplate", "Legendary Chestplate"}
shop["Leg Armour"] = {"Wooden Leggings", "Iron Leggings", "Guardian's Leggings", "Legendary Leggings"}
shop["Weapons"] = {"Short Sword", "Long Sword", "Bastard Sword", "Guardian's Blade", "Legendary Blade"}
shop["Magic"] = {"Healing Potion","Recovery","Slam","Enrage","Phase Shift","Polymorph"}
