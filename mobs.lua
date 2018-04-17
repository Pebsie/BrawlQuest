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
mb.sfx = {}
mb.friend = {}

local tm = "Player" --for bones
mb.img[tm] = love.graphics.newImage("img/dragon/Red.png")

mb.img["Mortus"] = love.graphics.newImage("img/human/Mortus.png")

local tm = "Adventurer"
mb.hp[tm] = 1
mb.spd[tm] = 50
mb.atk[tm] = 1
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/human/Adventurer.png")
mb.rng[tm] = 32
mb.friend[tm] = true

local tm = "Guard"
mb.hp[tm] = 5
mb.spd[tm] = 64
mb.atk[tm] = 1
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/human/Guard.png")
mb.rng[tm] = 64
mb.friend[tm] = true

local tm = "Mortus"
mb.hp[tm] = 100
mb.spd[tm] = 128
mb.atk[tm] = 4
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/human/Mortus.png")
mb.rng[tm] = 60
mb.friend[tm] = true

local tm = "Angry Chicken"
mb.hp[tm] = 1
mb.spd[tm] = 128
mb.atk[tm] = 2
mb.sp1[tm] = "Suicide"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Chicken.png")
mb.rng[tm] = 16
mb.friend[tm] = true

local tm = "Boar"
mb.hp[tm] = 1
mb.spd[tm] = 64
mb.atk[tm] = 2
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Boar.png")
mb.rng[tm] = 16
mb.sfx[tm] = {}
  mb.sfx[tm][1] = love.audio.newSource("sound/sfx/mob/Boar/1.ogg")
  mb.sfx[tm][2] = love.audio.newSource("sound/sfx/mob/Boar/2.ogg")
  mb.sfx[tm][3] = love.audio.newSource("sound/sfx/mob/Boar/3.ogg")
  mb.sfx[tm][4] = love.audio.newSource("sound/sfx/mob/Boar/4.ogg")

  local tm = "Big Boar"
  mb.hp[tm] = 5
  mb.spd[tm] = 35
  mb.atk[tm] = 4
  mb.sp1[tm] = "None"
  mb.sp1t[tm] = 0
  mb.sp2[tm] = "None"
  mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Big Boar.png")
mb.rng[tm] = 16
mb.sfx[tm] = {}
  mb.sfx[tm][1] = love.audio.newSource("sound/sfx/mob/Boar/1.ogg")
  mb.sfx[tm][2] = love.audio.newSource("sound/sfx/mob/Boar/2.ogg")
  mb.sfx[tm][3] = love.audio.newSource("sound/sfx/mob/Boar/3.ogg")
  mb.sfx[tm][4] = love.audio.newSource("sound/sfx/mob/Boar/4.ogg")

  local tm = "Biggest Boar"
    mb.hp[tm] = 20
    mb.spd[tm] = 16
    mb.atk[tm] = 50
    mb.sp1[tm] = "None"
    mb.sp1t[tm] = 0
    mb.sp2[tm] = "None"
    mb.sp2t[tm] = 0
  mb.img[tm] = love.graphics.newImage("img/mob/Biggest Boar.png")
  mb.rng[tm] = 16
  mb.sfx[tm] = {}
    mb.sfx[tm][1] = love.audio.newSource("sound/sfx/mob/Boar/1.ogg")
    mb.sfx[tm][2] = love.audio.newSource("sound/sfx/mob/Boar/2.ogg")
    mb.sfx[tm][3] = love.audio.newSource("sound/sfx/mob/Boar/3.ogg")
    mb.sfx[tm][4] = love.audio.newSource("sound/sfx/mob/Boar/4.ogg")

  local tm = "Ghost"
    mb.hp[tm] = 100
    mb.spd[tm] = 200
    mb.atk[tm] = 100
    mb.sp1[tm] = "None"
    mb.sp1t[tm] = 0
    mb.sp2[tm] = "None"
    mb.sp2t[tm] = 0
    mb.img[tm] = love.graphics.newImage("img/mob/Ghost.png")
    mb.rng[tm] = 16

    local tm = "Savage Wolf"
        mb.hp[tm] = 1
        mb.spd[tm] = 100
        mb.atk[tm] = 1
        mb.sp1[tm] = "None"
        mb.sp1t[tm] = 0
        mb.sp2[tm] = "None"
        mb.sp2t[tm] = 0
        mb.img[tm] = love.graphics.newImage("img/mob/Savage Wolf.png")
        mb.rng[tm] = 16

    local tm = "Wolf"
        mb.hp[tm] = 5
        mb.spd[tm] = 80
        mb.atk[tm] = 25
        mb.sp1[tm] = "None"
        mb.sp1t[tm] = 0
        mb.sp2[tm] = "None"
        mb.sp2t[tm] = 0
        mb.img[tm] = love.graphics.newImage("img/mob/Wolf.png")
        mb.rng[tm] = 16

        local tm = "Alpha Wolf"
            mb.hp[tm] = 20
            mb.spd[tm] = 65
            mb.atk[tm] = 30
            mb.sp1[tm] = "None"
            mb.sp1t[tm] = 0
            mb.sp2[tm] = "None"
            mb.sp2t[tm] = 0
            mb.img[tm] = love.graphics.newImage("img/mob/Alpha Wolf.png")
            mb.rng[tm] = 16

        local tm = "Mother Wolf"
          mb.hp[tm] = 20
            mb.spd[tm] = 40
              mb.atk[tm] = 30
                mb.sp1[tm] = "spawn:Wolf"
                mb.sp1t[tm] = 20
                mb.sp2[tm] = "None"
                mb.sp2t[tm] = 0
                mb.img[tm] = love.graphics.newImage("img/mob/Mother Wolf.png")
                mb.rng[tm] = 16

                local tm = "Cub"
                  mb.hp[tm] = 1
                  mb.spd[tm] = 120
                  mb.atk[tm] = 1
                  mb.sp1[tm] = "None"
                  mb.sp1t[tm] = 0
                  mb.sp2[tm] = "None"
                  mb.sp2t[tm] = 0
                  mb.img[tm] = love.graphics.newImage("img/mob/Cub.png")
                  mb.rng[tm] = 16

local tm = "Sorcerer"
mb.hp[tm] = 1
mb.spd[tm] = 64
mb.atk[tm] = 2
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Sorcerer.png")
mb.rng[tm] = 16

local tm = "Cursed Human"
mb.hp[tm] = 1
mb.spd[tm] = 96
mb.atk[tm] = 2
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] =  32

local tm = "Cursed Guard"
mb.hp[tm] = 5
mb.spd[tm] = 70
mb.atk[tm] = 4
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] =  32

local tm = "Cursed King"
mb.hp[tm] = 25
mb.spd[tm] = 60
mb.atk[tm] = 8
mb.sp1[tm] = "spawn:Cursed Human"
mb.sp1t[tm] = 10
mb.sp2[tm] = "spawn:Cursed Guard"
mb.sp2t[tm] = 30
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] =  32

local tm = "Cursed Miner"
mb.hp[tm] = 15
mb.spd[tm] = 30
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] =  32

local tm = "Savage Bat"
mb.hp[tm] = 3
mb.spd[tm] = 120
mb.atk[tm] = 2
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] = 16

local tm = "Savage Bear"
mb.hp[tm] = 30
mb.spd[tm] = 70
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] = 16

local tm = "Savage Hydra"
mb.hp[tm] = 50
mb.spd[tm] = 60
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] = 32

local tm = "Savage Golem"
mb.hp[tm] = 100
mb.spd[tm] = 40
mb.atk[tm] = 20
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/"..tm..".png")
mb.rng[tm] = 64

local tm = "Quake"
mb.hp[tm] = 100000
mb.spd[tm] = 0
mb.atk[tm] = 30
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Quake.png")
mb.rng[tm] = 8
mb.friend[tm] = false

local tm = "Venom"
mb.hp[tm] = 100
mb.spd[tm] = 0
mb.atk[tm] = 0
mb.sp1[tm] = "dmg,20"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Venom.png")
mb.rng[tm] = 0
mb.friend[tm] = false

local tm = "Savage Giant"
mb.hp[tm] = 4000
mb.spd[tm] = 18
mb.atk[tm] = 10
mb.sp1[tm] = "spawnFeet,Quake"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Savage Giant.png")
mb.rng[tm] = 80
mb.friend[tm] = false

local tm = "Hydra"
mb.hp[tm] = 4000
mb.spd[tm] = 32
mb.atk[tm] = 20
mb.sp1[tm] = "spawn,Venom"
mb.sp1t[tm] = 5
mb.sp2[tm] = "spawn,Savage Hydra"
mb.sp2t[tm] = 15
mb.img[tm] = love.graphics.newImage("img/mob/Hydra.png")
mb.rng[tm] = 32
mb.friend[tm] = false

local tm = "Skeleton King"
mb.hp[tm] = 6000
mb.spd[tm] = 20
mb.atk[tm] = 15
mb.sp1[tm] = "spawnFeet,Venom"
mb.sp1t[tm] = 30
mb.sp2[tm] = "spawnFeet,Quake"
mb.sp2t[tm] = 20
mb.img[tm] = love.graphics.newImage("img/mob/Skeleton King.png")
mb.rng[tm] = 32
mb.friend[tm] = false

local tm = "The Skeleton King"
mb.img[tm] = love.graphics.newImage("img/mob/Mini Skeleton King.png")

local tm = "Giant"
mb.hp[tm] = 6000
mb.spd[tm] = 20
mb.atk[tm] = 15
mb.sp1[tm] = "spawnFeet,Quake"
mb.sp1t[tm] = 3
mb.sp2[tm] = "spawn,Golem"
mb.sp2t[tm] = 10
mb.img[tm] = love.graphics.newImage("img/mob/Giant.png")
mb.rng[tm] = 50
mb.friend[tm] = false

local tm = "Ice Giant"
mb.hp[tm] = 4000
mb.spd[tm] = 10
mb.atk[tm] = 5
mb.sp1[tm] = "spawnFeet,Ice"
mb.sp1t[tm] = 3
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Ice Giant.png")
mb.rng[tm] = 50
mb.friend[tm] = false

local tm = "Ice"
mb.hp[tm] = 60000
mb.spd[tm] = 5
mb.atk[tm] = 30
mb.sp1[tm] = "None"
mb.sp1t[tm] = 30
mb.sp2[tm] = "None"
mb.sp2t[tm] = 20
mb.img[tm] = love.graphics.newImage("img/mob/Ice.png")
mb.rng[tm] = 32
mb.friend[tm] = false

local tm = "Fire Giant"
mb.hp[tm] = 2000
mb.spd[tm] = 30
mb.atk[tm] = 10
mb.sp1[tm] = "spawn,Fire"
mb.sp1t[tm] = 2
mb.sp2[tm] = "spawn,Fire"
mb.sp2t[tm] = 5
mb.img[tm] = love.graphics.newImage("img/mob/Fire Giant.png")
mb.rng[tm] = 50
mb.friend[tm] = false

local tm = "Fire"
mb.hp[tm] = 2000000
mb.spd[tm] = 120
mb.atk[tm] = 40
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 3
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Fire.png")
mb.rng[tm] = 32
mb.friend[tm] = false