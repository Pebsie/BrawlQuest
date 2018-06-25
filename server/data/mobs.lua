mb = {} --identified by name
mb.hp = {}
mb.spd = {}
mb.atk = {}
mb.sp1 = {} --spell 1
mb.sp1t = {}
mb.sp2 = {} --spell 2
mb.sp2t = {}
mb.img = {} --width in this case
mb.rng = {}
mb.friend = {}
mb.atr = {} --atributes

--friendly
local tm = "speak"
mb.hp[tm] = 1
mb.spd[tm] = 0
mb.atk[tm] = 0
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 1 --instant
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 0
mb.friend[tm] = false

local tm = "Adventurer"
mb.hp[tm] = 10
mb.spd[tm] = 50
mb.atk[tm] = 0
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 32
mb.friend[tm] = true

local tm = "Guard"
mb.hp[tm] = 2000
mb.spd[tm] = 64
mb.atk[tm] = 1
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 60
mb.friend[tm] = true

local tm = "Mortus"
mb.hp[tm] = 99999
mb.spd[tm] = 128
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 60
mb.friend[tm] = true

local tm = "Angry Chicken"
mb.hp[tm] = 10000
mb.spd[tm] = 128
mb.atk[tm] = 230
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 25
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 32
mb.friend[tm] = true

local tm = "Ghost"
mb.hp[tm] = 100
mb.spd[tm] = 200
mb.atk[tm] = 100
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 69
mb.rng[tm] =  32

local tm = "Ship"
mb.hp[tm] = 500
mb.spd[tm] = 100
mb.atk[tm] = 20
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  32
mb.friend[tm] = true

--opponents

local tm = "Ghostly Ship"
mb.hp[tm] = 100000
mb.spd[tm] = 64
mb.atk[tm] = 50
mb.sp1[tm] = "spawn:Cannon Ball"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  128

local tm = "Pirate Ship"
mb.hp[tm] = 10
mb.spd[tm] = 80
mb.atk[tm] = 0
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 32

local tm = "Cannon Ball"
mb.hp[tm] = 100000
mb.spd[tm] = 256
mb.atk[tm] = 100
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 1
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 16
mb.rng[tm] =  32

local tm = "Friendly Cannon Ball"
mb.hp[tm] = 100000
mb.spd[tm] = 256
mb.atk[tm] = 100
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 1
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 16
mb.rng[tm] =  32
mb.friend[tm] = true

local tm = "Spider"
mb.hp[tm] = 3
mb.spd[tm] = 64
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  32

local tm = "Scorpion"
mb.hp[tm] = 10
mb.spd[tm] = 40
mb.atk[tm] = 8
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 16
mb.rng[tm] =  16

local tm = "Sand Worm"
mb.hp[tm] = 1
mb.spd[tm] = 32
mb.atk[tm] = 1
mb.sp1[tm] = "spawn:Sand"
mb.sp1t[tm] = 8
mb.sp2[tm] = "suicide"
mb.sp2t[tm] = 8
mb.img[tm] = 32
mb.rng[tm] =  16

local tm = "Manamite"
mb.hp[tm] = 25
mb.spd[tm] = 64
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 20
mb.rng[tm] =  16

local tm = "Sand"
mb.hp[tm] = 99999
mb.spd[tm] = 128
mb.atk[tm] = 0
mb.sp1[tm] = "spawn:Sand Worm"
mb.sp1t[tm] = 1
mb.sp2[tm] = "suicide"
mb.sp2t[tm] = 1
mb.img[tm] = 32
mb.rng[tm] =  16

local tm = "Cannibal Tribesman"
mb.hp[tm] = 30
mb.spd[tm] = 40
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  16
mb.atr[tm] = "spawnRandom"

local tm = "Cannibal Hunter"
mb.hp[tm] = 30
mb.spd[tm] = 60
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  16

local tm = "Cannibal Leader"
mb.hp[tm] = 100
mb.spd[tm] = 50
mb.atk[tm] = 10
mb.sp1[tm] = "doOnce:stat;hp;20;spawn:speak,Cannibal Leader,WE EAT NOT WE BE EAT!!!,4"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  16

local tm = "Mysterious Figure"
mb.hp[tm] = 999999
mb.spd[tm] = 40
mb.atk[tm] = 10
mb.sp1[tm] = "spawn:Image of a Phoenix"
mb.sp1t[tm] = 20
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 128
mb.friend[tm] = true

local tm = "Image of a Phoenix"
mb.hp[tm] = 99999
mb.spd[tm] = 120
mb.atk[tm] = 50
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 10
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 100
mb.friend[tm] = true

local tm = "Demon"
mb.hp[tm] = 5000
mb.spd[tm] = 40
mb.atk[tm] = 5
mb.sp1[tm] = "spawnRandom,Hellfire"
mb.sp1t[tm] = 0.5
mb.sp2[tm] = "spawnRandom,Minion"
mb.sp2t[tm] = 4
mb.img[tm] = 128
mb.rng[tm] = 64

local tm = "Hellfire"
mb.hp[tm] = 999999
mb.spd[tm] = 0
mb.atk[tm] = 30
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 10
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 32

local tm = "Minion"
mb.hp[tm] = 30
mb.spd[tm] = 80
mb.atk[tm] = 10
mb.sp1[tm] = "spawnRandom,Minion"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 32

--crafting
local tm = "Weak Tree"
mb.hp[tm] = 20
mb.spd[tm] = 0.1
mb.atk[tm] = 0
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 0
mb.atr[tm] = "spawnRandom"

local tm = "Weak Rock"
mb.hp[tm] = 40
mb.spd[tm] = 0.1
mb.atk[tm] = 0
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 0
mb.atr[tm] = "spawnRandom"

local tm = "Mana Crystal"
mb.hp[tm] = 100
mb.spd[tm] = 0.1
mb.atk[tm] = 0
mb.sp1[tm] = "stat;hp;50;spawn:Manamite"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 0
mb.atr[tm] = "spawnRandom"

function mobHasAttribute(name,attribute)
  local result = false
  if mb.atr[name] then
    for i, v in pairs(atComma(mb.atr[name])) do
      if v == attribute then
        result = true
      end
    end
  end

  return result
end
