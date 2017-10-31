function initItems()
  item = {}
  item.type = {}
  item.val = {}
  item.lvl = {}
  item.price = {}
  item.img = {}
  item.desc = {}

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
  item.lvl[ti] = 1
  item.price[ti] = 1
  item.img[ti] = ""

  local ti = "Bastard Sword"
  item.type[ti] = "wep"
  item.val[ti] = 3
  item.lvl[ti] = 2
  item.price[ti] = 4
  item.img[ti] = ""

  local ti = "Long Sword"
  item.type[ti] = "wep"
  item.val[ti] = 5
  item.lvl[ti] = 3
  item.price[ti] = 10
  item.img[ti] = ""

  local ti = "Masterwork Long Sword"
  item.type[ti] = "wep"
  item.val[ti] = 8
  item.lvl[ti] = 4
  item.price[ti] = 25
  item.img[ti] = ""

  local ti = "Guardian's Blade"
  item.type[ti] = "wep"
  item.val[ti] = 10
  item.lvl[ti] = 5
  item.price[ti] = 50
  item.img[ti] = ""

  local ti = "King's Blade"
  item.type[ti] = "wep"
  item.val[ti] = 15
  item.lvl[ti] = 10
  item.price[ti] = 200
  item.img[ti] = ""

    --legendary weapons
    local ti = "Legendary Blade"
    item.type[ti] = "wep"
    item.val[ti] = 25
    item.lvl[ti] = 15
    item.price[ti] = 500
    item.img[ti] = ""

  --armour
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
  item.price[ti] = 2
  item.img[ti] = ""

  local ti = "Basic Leather"
  item.type[ti] = "arm"
  item.val[ti] = 2
  item.lvl[ti] = 2
  item.price[ti] = 5
  item.img[ti] = ""

  local ti = "Leather Armour"
  item.type[ti] = "arm"
  item.val[ti] = 3
  item.lvl[ti] = 3
  item.price[ti] = 15
  item.img[ti] = ""

  local ti = "Basic Chain"
  item.type[ti] = "arm"
  item.val[ti] = 5
  item.lvl[ti] = 5
  item.price[ti] = 25
  item.img[ti] = ""

  local ti = "Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 8
  item.lvl[ti] = 7
  item.price[ti] = 50
  item.img[ti] = ""

  local ti = "Masterwork Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 10
  item.lvl[ti] = 9
  item.price[ti] = 75
  item.img[ti] = ""

  local ti = "Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] = 12
  item.lvl[ti] = 10
  item.price[ti] = 100
  item.img[ti] = ""

  local ti = "Exotic Masterwork Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 15
  item.lvl[ti] = 11
  item.price[ti] = 200
  item.img[ti] = ""

  local ti = "Masterwork Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] =  17
  item.lvl[ti] = 11
  item.price[ti] = 200
  item.img[ti] = ""

  local ti = "Exotic Masterwork Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] = 20
  item.lvl[ti] = 12
  item.price[ti] = 200
  item.img[ti] = ""

  local ti = "Ascended Masterwork Chainmail Armour"
  item.type[ti] = "arm"
  item.val[ti] = 22
  item.lvl[ti] = 12
  item.price[ti] = 200
  item.img[ti] = ""

  local ti = "Ascended Masterwork Steel Armour"
  item.type[ti] = "arm"
  item.val[ti] = 25
  item.lvl[ti] = 12
  item.price[ti] = 200
  item.img[ti] = ""

  local ti = "Guardian's Padding"
  item.type[ti] = "arm"
  item.val[ti] = 30
  item.lvl[ti] = 13
  item.price[ti] = 210
  item.img[ti] = ""

  local ti = "King's Padding"
  item.type[ti] = "arm"
  item.val[ti] = 32
  item.lvl[ti] = 13
  item.price[ti] = 210
  item.img[ti] = ""

  local ti = "Legacy of Forest Heroes"
  item.type[ti] = "arm"
  item.val[ti] = 50
  item.lvl[ti] = 15
  item.price[ti] = 220
  item.img[ti] = ""

    --legendary armour
    local ti = "Legendary Padding"
    item.type[ti] = "arm"
    item.val[ti] = 50
    item.lvl[ti] = 15
    item.price[ti] = 500

  --consumables
  local ti = "Weak Red Potion"
  item.type[ti] = "hp"
  item.val[ti] = 10
  item.lvl[ti] = 1
  item.price[ti] = 1
  item.img[ti] = ""

  local ti = "Red Potion"
  item.type[ti] = "hp"
  item.val[ti] = 20
  item.lvl[ti] = 5
  item.price[ti] = 2
  item.img[ti] = ""

  local ti = "Weak Healing Potion"
  item.type[ti] = "hp"
  item.val[ti] = 40
  item.lvl[ti] = 10
  item.price[ti] = 3
  item.img[ti] = ""

  local ti = "Healing Potion"
  item.type[ti] = "hp"
  item.val[ti] = 70
  item.lvl[ti] = 11
  item.price[ti] = 5
  item.img[ti] = ""

  local ti = "Potent Healing Potion"
  item.type[ti] = "hp"
  item.val[ti] = 100
  item.lvl[ti] = 12
  item.price[ti] = 8
  item.img[ti] = ""

  local ti = "Weak Yellow Potion"
  item.type[ti] = "en"
  item.val[ti] = 10
  item.lvl[ti] = 1
  item.price[ti] = 1
  item.img[ti] = ""

  local ti = "Yellow Potion"
  item.type[ti] = "en"
  item.val[ti] = 20
  item.lvl[ti] = 5
  item.price[ti] = 2
  item.img[ti] = ""

  local ti = "Weak Energising Potion"
  item.type[ti] = "en"
  item.val[ti] = 40
  item.lvl[ti] = 10
  item.price[ti] = 3
  item.img[ti] = ""

  local ti = "Energising Potion"
  item.type[ti] = "en"
  item.val[ti] = 70
  item.lvl[ti] = 11
  item.price[ti] = 5
  item.img[ti] = ""

  local ti = "Potent Energising Potion"
  item.type[ti] = "en"
  item.val[ti] = 100
  item.lvl[ti] = 12
  item.price[ti] = 8
  item.img[ti] = ""

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

  --spells VAL is seconds cool down, energy consumed, duration
  local ti = "Second Wind"
  item.type[ti] = "Spell"
  item.desc[ti] = "Recover 10% health and move at 200% speed for 3 seconds"
  item.val[ti] = "100,50,3"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Tornado"
  item.type[ti] = "Spell"
  item.desc[ti] = "Turn into a powerful tornado, increasing movement speed to 300% and causing damage to every opponent you touch for 5 seconds"
  item.val[ti] = "30,100,5"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Recovery"
  item.type[ti] = "Spell"
  item.desc[ti] = "Recover 30% health"
  item.val[ti] = "120,50,1"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Ground Slam"
  item.type[ti] = "Spell"
  item.desc[ti] = "Deal ATK*2 damage to all enemies within 5 meters"
  item.val[ti] = "30,100,1"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Rend"
  item.type[ti] = "Spell"
  item.desc[ti] = "Next attack applies bleeding to all enemies hit"
  item.val[ti] = "10,20,10"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Grace"
  item.type[ti] = "Spell"
  item.desc[ti] = "Heal all friendlies for 30% their max health"
  item.val[ti] = "60,50,2"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Flash of Light"
  item.type[ti] = "Spell"
  item.desc[ti] = "Turn into a flash of light, increasing movement speed to 200% and healing all friendlies you touch for 10 seconds"
  item.val[ti] = "30,100,10"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Enrage"
  item.type[ti] = "Spell"
  item.desc[ti] = "Taunt all enemies within 10 meters, causing them to change target and attack you"
  item.val[ti] = "20,20,2"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = "Phase Shift"
  item.type[ti] = "Spell"
  item.desc[ti] = "All enemies target you switch to the nearest friendly and you cannot take damage for 5 seconds"
  item.val[ti] = "60,50,5"
  item.lvl[ti] = 10
  item.price[ti] = 10
  item.img[ti] = 32

  local ti = ""
  item.type[ti] = ""
  item.val[ti] = 0
  item.lvl[ti] = 0
  item.price[ti] = 0
  item.img[ti] = ""
end
