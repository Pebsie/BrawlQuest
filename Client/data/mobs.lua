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

tm = "Mortus"
mb.img["Mortus"] = love.graphics.newImage("img/human/Mortus.png")
mb.sfx[tm] = {}
mb.sfx[tm][1] = love.audio.newSource("sound/sfx/mob/"..tm.."/1.mp3","static")
mb.sfx[tm][2] = love.audio.newSource("sound/sfx/mob/"..tm.."/2.mp3","static")
mb.sfx[tm][3] = love.audio.newSource("sound/sfx/mob/"..tm.."/3.mp3","static")
mb.sfx[tm][4] = love.audio.newSource("sound/sfx/mob/"..tm.."/4.mp3","static")
mb.sfx[tm][5] = love.audio.newSource("sound/sfx/mob/"..tm.."/5.mp3","static")
mb.friend[tm] = true

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
mb.sfx[tm] = {}
mb.sfx[tm][1] = love.audio.newSource("sound/sfx/mob/"..tm.."/1.mp3","static")
mb.sfx[tm][2] = love.audio.newSource("sound/sfx/mob/"..tm.."/2.mp3","static")
mb.sfx[tm][3] = love.audio.newSource("sound/sfx/mob/"..tm.."/3.mp3","static")
mb.sfx[tm][4] = love.audio.newSource("sound/sfx/mob/"..tm.."/4.mp3","static")
mb.sfx[tm][5] = love.audio.newSource("sound/sfx/mob/"..tm.."/5.mp3","static")
mb.sfx[tm][6] = love.audio.newSource("sound/sfx/mob/"..tm.."/6.mp3","static")
mb.sfx[tm][7] = love.audio.newSource("sound/sfx/mob/"..tm.."/7.mp3","static")

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
mb.sfx[tm] = {}
mb.sfx[tm][1] = love.audio.newSource("sound/sfx/mob/"..tm.."/1.mp3","static")
mb.sfx[tm][2] = love.audio.newSource("sound/sfx/mob/"..tm.."/2.mp3","static")
mb.sfx[tm][3] = love.audio.newSource("sound/sfx/mob/"..tm.."/3.mp3","static")
mb.sfx[tm][4] = love.audio.newSource("sound/sfx/mob/"..tm.."/4.mp3","static")
mb.sfx[tm][5] = love.audio.newSource("sound/sfx/mob/"..tm.."/5.mp3","static")
mb.sfx[tm][6] = love.audio.newSource("sound/sfx/mob/"..tm.."/6.mp3","static")
mb.sfx[tm][7] = love.audio.newSource("sound/sfx/mob/"..tm.."/7.mp3","static")
mb.sfx[tm][8] = love.audio.newSource("sound/sfx/mob/"..tm.."/8.mp3","static")
mb.sfx[tm][9] = love.audio.newSource("sound/sfx/mob/"..tm.."/9.mp3","static")
mb.sfx[tm][10] = love.audio.newSource("sound/sfx/mob/"..tm.."/11.mp3","static")

local tm = "Boar"
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


local tm = "Ship"
mb.hp[tm] = 500
mb.spd[tm] = 100
mb.atk[tm] = 20
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/world/objects/Boat.png")
mb.rng[tm] =  32
mb.friend[tm] = true

local tm = "Ghostly Ship"
mb.hp[tm] = 100000
mb.spd[tm] = 64
mb.atk[tm] = 50
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/world/objects/Pirate Boat.png")
mb.rng[tm] =  64

local tm = "Pirate Ship"
mb.hp[tm] = 20
mb.spd[tm] = 80
mb.atk[tm] = 10
mb.sp1[tm] = "spawn:Cannon Ball"
mb.sp1t[tm] = 15
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/world/objects/Pirate Boat.png")
mb.rng[tm] =  64

local tm = "Cannon Ball"
mb.hp[tm] = 100000
mb.spd[tm] = 256
mb.atk[tm] = 100
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 1
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Cannonball.png")
mb.rng[tm] =  32

local tm = "Friendly Cannon Ball"
mb.hp[tm] = 100000
mb.spd[tm] = 256
mb.atk[tm] = 100
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 1
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Cannonball.png")
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
mb.img[tm] = love.graphics.newImage("img/mob/Spider.png")
mb.rng[tm] =  32

local tm = "Scorpion"
mb.hp[tm] = 10
mb.spd[tm] = 40
mb.atk[tm] = 8
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Scorpion.png")
mb.rng[tm] =  16

local tm = "Sand Worm"
mb.hp[tm] = 1
mb.spd[tm] = 32
mb.atk[tm] = 1
mb.sp1[tm] = "spawn:Sand"
mb.sp1t[tm] = 3
mb.sp2[tm] = "suicide"
mb.sp2t[tm] = 3
mb.img[tm] = love.graphics.newImage("img/mob/Sand Worm.png")
mb.rng[tm] =  16

local tm = "Manamite"
mb.hp[tm] = 25
mb.spd[tm] = 64
mb.atk[tm] = 10
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Manamite.png")
mb.rng[tm] =  16

local tm = "Sand"
mb.hp[tm] = 99999
mb.spd[tm] = 128
mb.atk[tm] = 0
mb.sp1[tm] = "spawn:Sand Worm"
mb.sp1t[tm] = 1
mb.sp2[tm] = "suicide"
mb.sp2t[tm] = 1
mb.img[tm] = uiImg["none"]
mb.rng[tm] =  16

local tm = "Cannibal Tribesman"
mb.hp[tm] = 30
mb.spd[tm] = 40
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Cannibal Tribesman.png")
mb.rng[tm] =  16

local tm = "Cannibal Hunter"
mb.hp[tm] = 30
mb.spd[tm] = 60
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Cannibal Hunter.png")
mb.rng[tm] =  16

local tm = "Cannibal Leader"
mb.hp[tm] = 100
mb.spd[tm] = 50
mb.atk[tm] = 10
mb.sp1[tm] = "doOnce:stat;hp;20;spawn:speak,Cannibal Leader,WE EAT NOT WE BE EAT!!!,4"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Cannibal Leader.png")
mb.rng[tm] =  16

local tm = "Mysterious Figure"
mb.hp[tm] = 500
mb.spd[tm] = 40
mb.atk[tm] = 5
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Tarquin.png")
mb.rng[tm] = 100
mb.friend[tm] = true

local tm = "Image of a Phoenix"
mb.hp[tm] = 999999
mb.spd[tm] = 120
mb.atk[tm] = 50
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 10
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Phoenix Image.png")
mb.rng[tm] = 32
mb.friend[tm] = true

local tm = "Demon"
mb.hp[tm] = 5000
mb.spd[tm] = 40
mb.atk[tm] = 5
mb.sp1[tm] = "spawnFeet:Hellfire"
mb.sp1t[tm] = 10
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Demon.png")
mb.rng[tm] = 64

local tm = "Hellfire"
mb.hp[tm] = 999999
mb.spd[tm] = 0
mb.atk[tm] = 30
mb.sp1[tm] = "suicide"
mb.sp1t[tm] = 10
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Hellfire.png")
mb.rng[tm] = 32

local tm = "Minion"
mb.hp[tm] = 10
mb.spd[tm] = 80
mb.atk[tm] = 10
mb.sp1[tm] = "spawnRandom:Minion"
mb.sp1t[tm] = 5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = love.graphics.newImage("img/mob/Minion.png")
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
mb.img[tm] = worldImg["Beach Tree"]
mb.rng[tm] = 0

local tm = "Weak Rock"
mb.hp[tm] = 40
mb.spd[tm] = 0.1
mb.atk[tm] = 0
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = worldImg["Rock"]
mb.rng[tm] = 0

local tm = "Mana Crystal"
mb.hp[tm] = 100
mb.spd[tm] = 0.1
mb.atk[tm] = 0
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = worldImg["Crystal"]
mb.rng[tm] = 0
