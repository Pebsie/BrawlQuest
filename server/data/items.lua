item = {}
item.type = {}
item.desc = {} --optional
item.val = {} --for spells this is cooldown in seconds then requirements
item.lvl = {}
item.price = {}
item.img = {}

local ti = "Boat"
item.type[ti] = "arm"
item.val[ti] = 0
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Naked"
item.type[ti] = "arm"
item.val[ti] = 0
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Old Cloth"
item.type[ti] = "arm"
item.val[ti] = 1
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Basic Cloth"
item.type[ti] = "arm"
item.val[ti] = 2
item.lvl[ti] = 1
item.price[ti] = "5,Gold"
item.img[ti] = ""

local ti = "Leather Armour"
item.type[ti] = "arm"
item.val[ti] = 3
item.lvl[ti] = 3
item.price[ti] = "25,Gold"
item.img[ti] = ""

local ti = "Chainmail Armour"
item.type[ti] = "arm"
item.val[ti] = 4
item.lvl[ti] = 7
item.price[ti] = "100,Gold"
item.img[ti] = ""

local ti = "Guardian's Padding"
item.type[ti] = "arm"
item.val[ti] = 8
item.lvl[ti] = 10
item.price[ti] = "20,Adver"
item.img[ti] = ""

local ti = "Legendary Padding"
item.type[ti] = "arm"
item.val[ti] = 15
item.lvl[ti] = 15
item.price[ti] = "100,Adver"
item.img[ti] = ""

local ti = "Eldertouched Plate"
item.type[ti] = "arm"
item.val[ti] = 50
item.lvl[ti] = 30
item.price[ti] = "500,Adver"
item.img[ti] = ""

--weapons
local ti = "Long Stick"
item.type[ti] = "wep"
item.val[ti] = 1
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Short Sword"
item.type[ti] = "wep"
item.val[ti] = 2
item.lvl[ti] = 3
item.price[ti] = "5,Gold"
item.img[ti] = ""

local ti = "Bastard Sword"
item.type[ti] = "wep"
item.val[ti] = 3
item.lvl[ti] = 5
item.price[ti] = "15,Gold"
item.img[ti] = ""

local ti = "Long Sword"
item.type[ti] = "wep"
item.val[ti] = 5
item.lvl[ti] = 8
item.price[ti] = "25,Gold"
item.img[ti] = ""

local ti = "Guardian's Blade"
item.type[ti] = "wep"
item.val[ti] = 10
item.lvl[ti] = 10
item.price[ti] = "20,Adver"
item.img[ti] = ""

local ti = "Legendary Sword"
item.type[ti] = "wep"
item.val[ti] = 30
item.lvl[ti] = 15
item.price[ti] = "100,Adver"
item.img[ti] = ""

--potions
local ti = "Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 70
item.lvl[ti] = 11
item.price[ti] = "1,Gold"
item.img[ti] = ""

local ti = "Potent Healing Potion"
item.type[ti] = "hp"
item.val[ti] = 100
item.lvl[ti] = 12
item.price[ti] = "3,Gold"
item.img[ti] = ""

--spells
local ti = "Recovery"
item.type[ti] = "Spell"
item.desc[ti] = "Recover 100% health"
item.val[ti] = "30,50"
item.lvl[ti] = 500
item.price[ti] = "50,Gold"
item.img[ti] = ""

local ti = "Slam"
item.type[ti] = "Spell"
item.desc[ti] = "Deal ATK*4 damage to all enemies within 5 meters"
item.val[ti] = "20,50,1"
item.lvl[ti] = 10
item.price[ti] = "100,Gold"
item.img[ti] = ""

  local ti = "Enrage"
  item.type[ti] = "Spell"
  item.desc[ti] = "Taunt all enemies within 10 meters, causing them to change target and attack you"
  item.val[ti] = "20,20"
  item.lvl[ti] = 10
  item.price[ti] = "100,Gold"
item.img[ti] = ""

  local ti = "Phase Shift"
  item.type[ti] = "Spell"
  item.desc[ti] = "All enemies target you switch to the nearest friendly and you cannot take damage for 5 seconds"
  item.val[ti] = "60,50"
  item.lvl[ti] = 10
  item.price[ti] = "100,Gold"
item.img[ti] = ""

local ti = "Polymorph"
item.type[ti] = "Spell"
item.desc[ti] = "All enemies within 3 meters turn into Angry Chickens that explode after 3 seconds."
item.val[ti] = "20,50"
item.lvl[ti] = 10
item.price[ti] = "200,Gold"
item.img[ti] = ""

local ti = "Summon 5 Friendly Snake"
item.type[ti] = "Spell"
item.desc[ti] = "Make 5 Friendly Snakes appear around you to assist you in battle!"
item.val[ti] = "300,75"
item.lvl[ti] = 10
item.price[ti] = "200,Gold"
item.img[ti] = ""

local ti = "Dog"
item.type[ti] = "buddy"
item.desc[ti] = "Left behind by the wolf pack, rejected for its domestic tendencies."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Snake"
item.type[ti] = "buddy"
item.desc[ti] = "Don't step on it!"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Beholder"
item.type[ti] = "buddy"
item.desc[ti] = "He might look at you funny, but, it's okay: his teeth aren't fully formed just yet."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Baby Bat"
item.type[ti] = "buddy"
item.desc[ti] = "Click click click"
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Earth Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Fire Elementling"
item.type[ti] = "buddy"
item.desc[ti] = "These little guys appeared after the mana spill."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Dragonling"
item.type[ti] = "buddy"
item.desc[ti] = "Like a dragon, but smol."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Protector"
item.type[ti] = "buddy"
item.desc[ti] = "He might be whispering things... dark things."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Fly"
item.type[ti] = "buddy"
item.desc[ti] = "Bzzzzzz..."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Horse"
item.type[ti] = "buddy"
item.desc[ti] = "It's a shame that you don't have a saddle. Yet."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32

local ti = "Spirit of Death"
item.type[ti] = "buddy"
item.desc[ti] = "Not to be confused with Face of Death or Heart of Death."
item.val[ti] = "0"
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = 32


--special
  local ti = "A letter addressed to you"
  item.type[ti] = "Letter"
  item.val[ti] = "Hey!\n\nThanks so much for playing the BrawlQuest alpha.\n\nSincerely, Pebsie."
  item.lvl[ti] = 10
  item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Eastern Tribe Secrets"
item.type[ti] = "Letter"
item.val[ti] = "Hey!\n\nThanks so much for playing the BrawlQuest alpha.\n\nSincerely, Pebsie."
item.lvl[ti] = 10
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Crypt Key"
item.type[ti] = "Key"
item.val[ti] = 0
item.lvl[ti] = "??"
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Lair Key"
item.type[ti] = "Key"
item.val[ti] = 0
item.lvl[ti] = "??"
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Adver Ring"
item.type[ti] = "Key"
item.val[ti] = "Allows you to pass through cursed areas of The Southern Mountains"
item.lvl[ti] = "??"
item.price[ti] = "4,Adver"
item.img[ti] = ""

local ti = "Gold"
item.type[ti] = "currency"
item.val[ti] = "1"
item.lvl[ti] = 1
item.price[ti] = "0,Gold"
item.img[ti] = ""

local ti = "Adver"
item.type[ti] = "currency"
item.val[ti] = "1"
item.lvl[ti] = 1
item.price[ti] = "0,Adver"
item.img[ti] = ""

local ti = "Quia"
item.type[ti] = "currency"
item.val[ti] = "1"
item.lvl[ti] = 1
item.price[ti] = "5,Adver"
item.img[ti] = ""

local ti = "Orb of Power"
item.type[ti] = "upgrade"
item.val[ti] = "1,ATK"
item.lvl[ti] = 10
item.price[ti] = "350,Quia"
item.img[ti] = ""

--craftable
local ti = "Wood"
item.type[ti] = "reagent"
item.val[ti] = ""
item.lvl[ti] = 1
item.price[ti] = "1,Gold"
item.img[ti] = ""

local ti = "Stone"
item.type[ti] = "Reagent"
item.val[ti] = ""
item.lvl[ti] = 1
item.price[ti] = "1,Gold"
item.img[ti] = ""
