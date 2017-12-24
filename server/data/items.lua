item = {}
item.type = {}
item.desc = {} --optional
item.val = {} --for spells this is cooldown in seconds then requirements
item.lvl = {}
item.price = {}
item.img = {}

local ti = "Old Cloth"
item.type[ti] = "arm"
item.val[ti] = 0
item.lvl[ti] = 1
item.price[ti] = 0
item.img[ti] = ""

local ti = "Basic Cloth"
item.type[ti] = "arm"
item.val[ti] = 1
item.lvl[ti] = 1
item.price[ti] = 50
item.img[ti] = ""

local ti = "Leather Armour"
item.type[ti] = "arm"
item.val[ti] = 2
item.lvl[ti] = 3
item.price[ti] = 150
item.img[ti] = ""

local ti = "Chainmail Armour"
item.type[ti] = "arm"
item.val[ti] = 4
item.lvl[ti] = 7
item.price[ti] = 400
item.img[ti] = ""

local ti = "Guardian's Padding"
item.type[ti] = "arm"
item.val[ti] = 8
item.lvl[ti] = 10
item.price[ti] = 1000
item.img[ti] = ""

local ti = "Legendary Padding"
item.type[ti] = "arm"
item.val[ti] = 15
item.lvl[ti] = 15
item.price[ti] = 25000
item.img[ti] = ""

--weapons
local ti = "Long Stick"
item.type[ti] = "wep"
item.val[ti] = 1
item.lvl[ti] = 1
item.price[ti] = 0
item.img[ti] = ""

local ti = "Short Sword"
item.type[ti] = "wep"
item.val[ti] = 2
item.lvl[ti] = 3
item.price[ti] = 50
item.img[ti] = ""

local ti = "Bastard Sword" --NEEDS REWORKING
item.type[ti] = "wep"
item.val[ti] = 3
item.lvl[ti] = 5
item.price[ti] = 250
item.img[ti] = ""

local ti = "Long Sword"
item.type[ti] = "wep"
item.val[ti] = 5
item.lvl[ti] = 8
item.price[ti] = 750
item.img[ti] = ""

local ti = "Guardian's Blade"
item.type[ti] = "wep"
item.val[ti] = 10
item.lvl[ti] = 10
item.price[ti] = 1500
item.img[ti] = ""

local ti = "Legendary Sword"
item.type[ti] = "wep"
item.val[ti] = 30
item.lvl[ti] = 15
item.price[ti] = 25000
item.img[ti] = ""

--potions
local ti = "Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 70
item.lvl[ti] = 11
item.price[ti] = 20
item.img[ti] = ""

local ti = "Potent Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 100
item.lvl[ti] = 12
item.price[ti] = 50
item.img[ti] = ""

--spells
local ti = "Recovery"
item.type[ti] = "Spell"
item.desc[ti] = "Recover 50% health"
item.val[ti] = "120,50"
item.lvl[ti] = 500
item.price[ti] = 10
item.img[ti] = ""

local ti = "Slam"
item.type[ti] = "Spell"
item.desc[ti] = "Deal ATK*2 damage to all enemies within 5 meters"
item.val[ti] = "30,100,1"
item.lvl[ti] = 10
item.price[ti] = 100
item.img[ti] = ""

  local ti = "Enrage"
  item.type[ti] = "Spell"
  item.desc[ti] = "Taunt all enemies within 10 meters, causing them to change target and attack you"
  item.val[ti] = "20,20"
  item.lvl[ti] = 10
  item.price[ti] = 500
item.img[ti] = ""

  local ti = "Phase Shift"
  item.type[ti] = "Spell"
  item.desc[ti] = "All enemies target you switch to the nearest friendly and you cannot take damage for 5 seconds"
  item.val[ti] = "60,50"
  item.lvl[ti] = 10
  item.price[ti] = 500
item.img[ti] = ""

local ti = "Polymorph"
item.type[ti] = "Spell"
item.desc[ti] = "All enemies within 3 meters turn into Angry Chickens that explode after 3 seconds."
item.val[ti] = "20,50"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = ""


local ti = "Dog"
item.type[ti] = "buddy"
item.desc[ti] = "Left behind by the wolf pack, rejected for its domestic tendencies."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = 32

local ti = "Snake"
item.type[ti] = "buddy"
item.desc[ti] = "Don't step on it!"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = 32

local ti = "Beholder"
item.type[ti] = "buddy"
item.desc[ti] = "He might look at you funny, but, it's okay: his teeth aren't fully formed just yet."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = 32

local ti = "Baby Bat"
item.type[ti] = "buddy"
item.desc[ti] = "Click click click"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = 32

local ti = "Earth Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = 32

local ti = "Fire Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = 32

local ti = "Dragonling"
item.type[ti] = "buddy"
item.desc[ti] = "Like a dragon, but smol."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = 500
item.img[ti] = 32

--special
  local ti = "A letter addressed to you"
  item.type[ti] = "Letter"
  item.val[ti] = "Hey!\n\nThanks so much for playing the BrawlQuest alpha.\n\nSincerely, Pebsie."
  item.lvl[ti] = 10
  item.price[ti] = 0
item.img[ti] = ""

local ti = "Skeleton Key"
item.type[ti] = "Key"
item.val[ti] = 0
item.lvl[ti] = "??"
item.price[ti] = 0
item.img[ti] = ""

local ti = "Adver Ring"
item.type[ti] = "Key"
item.val[ti] = "Allows you to pass through cursed areas of The Southern Mountains"
item.lvl[ti] = "??"
item.price[ti] = 0
item.img[ti] = ""

local ti = "Gold"
item.type[ti] = "currency"
item.val[ti] = "1"
item.lvl[ti] = 1
item.price[ti] = 0
item.img[ti] = ""
