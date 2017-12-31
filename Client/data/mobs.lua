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
