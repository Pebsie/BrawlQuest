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
        mb.sp1[tm] = "spawn:Cub"
        mb.sp1t[tm] = 2
        mb.sp2[tm] = "None"
        mb.sp2t[tm] = 0
        mb.img[tm] = 16
        mb.rng[tm] = 32
