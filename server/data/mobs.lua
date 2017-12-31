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

local tm = "speak"
mb.hp[tm] = 1
mb.spd[tm] = 0
mb.atk[tm] = 0
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 1
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 0
mb.friend[tm] = false

local tm = "Adventurer"
mb.hp[tm] = 1
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
mb.hp[tm] = 1
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
mb.hp[tm] = 100
mb.spd[tm] = 128
mb.atk[tm] = 4
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 60
mb.friend[tm] = true

local tm = "Angry Chicken"
mb.hp[tm] = 1
mb.spd[tm] = 128
mb.atk[tm] = 2
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 5
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

local tm = "Boar"
mb.hp[tm] = 1
mb.spd[tm] = 64
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 16

local tm = "Big Boar"
mb.hp[tm] = 5
mb.spd[tm] = 35
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 16

local tm = "Biggest Boar"
  mb.hp[tm] = 20
  mb.spd[tm] = 16
  mb.atk[tm] = 30
  mb.sp1[tm] = "None"
  mb.sp1t[tm] = 0
  mb.sp2[tm] = "None"
  mb.sp2t[tm] = 0
  mb.img[tm] = 32
  mb.rng[tm] = 16

  local tm = "Savage Wolf"
      mb.hp[tm] = 1
      mb.spd[tm] = 100
      mb.atk[tm] = 1
      mb.sp1[tm] = "None"
      mb.sp1t[tm] = 0
      mb.sp2[tm] = "None"
      mb.sp2t[tm] = 0
      mb.img[tm] = 32
      mb.rng[tm] = 16

local tm = "Wolf"
    mb.hp[tm] = 5
    mb.spd[tm] = 80
    mb.atk[tm] = 25
    mb.sp1[tm] = "None"
    mb.sp1t[tm] = 0
    mb.sp2[tm] = "None"
    mb.sp2t[tm] = 0
    mb.img[tm] = 32
    mb.rng[tm] = 16

  local tm = "Alpha Wolf"
    mb.hp[tm] = 20
    mb.spd[tm] = 65
    mb.atk[tm] = 30
    mb.sp1[tm] = "None"
    mb.sp1t[tm] = 0
    mb.sp2[tm] = "None"
    mb.sp2t[tm] = 0
    mb.img[tm] = 32
    mb.rng[tm] = 16

    local tm = "Mother Wolf"
      mb.hp[tm] = 20
      mb.spd[tm] = 40
      mb.atk[tm] = 30
      mb.sp1[tm] = "spawn:Cub"
      mb.sp1t[tm] = 5
      mb.sp2[tm] = "None"
      mb.sp2t[tm] = 0
      mb.img[tm] = 32
      mb.rng[tm] = 16

      local tm = "Cub"
        mb.hp[tm] = 1
        mb.spd[tm] = 120
        mb.atk[tm] = 1
        mb.sp1[tm] = "spawn:Wolf"
        mb.sp1t[tm] = 5
        mb.sp2[tm] = "suicide"
        mb.sp2t[tm] = 5
        mb.img[tm] = 16
        mb.rng[tm] = 32

local tm = "Cursed Human"
mb.hp[tm] = 1
mb.spd[tm] = 96
mb.atk[tm] = 2
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  32

local tm = "Cursed Guard"
mb.hp[tm] = 5
mb.spd[tm] = 70
mb.atk[tm] = 4
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  32

local tm = "Cursed King"
mb.hp[tm] = 25
mb.spd[tm] = 60
mb.atk[tm] = 8
mb.sp1[tm] = "spawn:Cursed Human"
mb.sp1t[tm] = 10
mb.sp2[tm] = "spawn:Cursed Guard"
mb.sp2t[tm] = 30
mb.img[tm] = 32
mb.rng[tm] =  32

local tm = "Cursed Miner"
mb.hp[tm] = 15
mb.spd[tm] = 30
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] =  32

local tm = "Savage Bat"
mb.hp[tm] = 3
mb.spd[tm] = 120
mb.atk[tm] = 2
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 16

local tm = "Savage Bear"
mb.hp[tm] = 30
mb.spd[tm] = 70
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 16

local tm = "Savage Hydra"
mb.hp[tm] = 50
mb.spd[tm] = 60
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 32

local tm = "Savage Golem"
mb.hp[tm] = 100
mb.spd[tm] = 40
mb.atk[tm] = 20
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 63
mb.rng[tm] = 64
