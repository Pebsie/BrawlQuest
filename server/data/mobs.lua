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

local tm = "Evil Figure"
mb.hp[tm] = 25000
mb.spd[tm] = 40
mb.atk[tm] = 20
mb.sp1[tm] = "spawnRandom,Minion Portal"
mb.sp1t[tm] = 10
mb.sp2[tm] = "spawnRandom,Minion Portal"
mb.sp2t[tm] = 10
mb.img[tm] = 64
mb.rng[tm] = 64

local tm = "Minion Portal"
mb.hp[tm] = 150
mb.spd[tm] = 1
mb.atk[tm] = 0
mb.sp1[tm] = "spawn,randomMob"
mb.sp1t[tm] = 3
mb.sp2[tm] = "suicide"
mb.sp2t[tm] = 20
mb.img[tm] = 54
mb.rng[tm] = 54


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

--previous alpha mobslocal tm = "Boar"
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

local tm = "Quake"
mb.hp[tm] = 100000
mb.spd[tm] = 0
mb.atk[tm] = 30
mb.sp1[tm] = "None"
mb.sp1t[tm] = 0
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 8
mb.friend[tm] = false

local tm = "Venom"
mb.hp[tm] = 100
mb.spd[tm] = 0
mb.atk[tm] = 0
mb.sp1[tm] = "dmg,1"
mb.sp1t[tm] = 0.5
mb.sp2[tm] = "None"
mb.sp2t[tm] = 0
mb.img[tm] = 32
mb.rng[tm] = 0
mb.friend[tm] = false



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

function downloadMobs()
  addMsg("Downloading mobs list...")
  b, c, h = http.request("http://brawlquest.com/dl/scripts/getMobs.php")
  if b then
    love.filesystem.write("mobs-beta.txt", b)
  else
    addMsg("Failed to download mobs list.")
  end
end


mobData = {}
mfs = ""

function newMob(name,hp,speed,attack,sp1,sp1t,sp2,sp2t,img,rng,friend,atr)
  if not friend then friend = false end

  print("New mob: "..name)
  local i = name
--  local imgData = love.image.newImageData(mobData[name].imgPath)
  mfs = mfs.."name="..name.."=hp="..hp.."=spd="..speed.."=atk="..attack.."=sp1="..sp1.."=sp1t="..sp1t.."=sp2="..sp2.."=sp2t="..sp2t.."=imgPath="..img.."=rng="..rng.."=friend="..tostring(friend).."\n"
--  mobData[name] = {name=name,hp=hp,atk=attack,sp1=sp1,sp1t=sp1t,sp2=sp2,sp2t=sp2t,imgPath=img,imgData=imgData,img=love.graphics.newImage(imgData),rng=rng,friend=friend}
--  mobData[name].imgData = imgData
  --OLD FILE FORMAT TODO: CONVERT ALL SYSTEMS TO USE THE TABLE ABOVE
  mb.hp[i] = tonumber(hp)
  mb.spd[i] = tonumber(speed)
  mb.atk[i] = tonumber(attack)
  mb.sp1[i] = sp1
  mb.sp1t[i] = tonumber(sp1t)
  mb.sp2[i] = sp2
  mb.sp2t[i] = tonumber(sp2t)
  mb.img[i] = rng
  mb.rng[i] = tonumber(rng)
  mb.friend[i] = friend
  mb.atr[i] = atr

end

function convertMob(i)
  if not mb.friend[i] then mb.friend[i] = false end
  newMob(i,mb.hp[i],mb.spd[i],mb.atk[i],mb.sp1[i],mb.sp1t[i],mb.sp2[i],mb.sp2t[i],mb.img[i],mb.rng[i],mb.friend[i])
end



function saveMobList(fn) --fn - file name
--[[  fs = ""
  for i,v in pairs(mobData) do
    for k,va in pairs(v) do
      if k ~= "img" and k ~= "imgData" then
        fs = fs..k.."="..tostring(va).."="
      end
    end
    fs = fs.."\n"
  end
]] -- the 'correct' way of doing this, which looked quite ugly in the file output. This is temporary code, so we used mfs above.
  love.filesystem.write(fn,mfs)
  print("Written mobs list to "..fn)
end

function loadMobs()
  if love.filesystem.getInfo("mobs-beta.txt") then
    for line in love.filesystem.lines("mobs-beta.txt") do
      local mbInfo = atComma(line,"=")
      local name = mbInfo[2]
      mobData[name] = {}
      for i = 1, #mbInfo, 2 do
        mobData[name][mbInfo[i]] = mbInfo[i+1]
      end

      newMob(mobData[name].name,tonumber(mobData[name].hp),tonumber(mobData[name].spd),tonumber(mobData[name].atk),mobData[name].sp1,tonumber(mobData[name].sp1t),mobData[name].sp2,tonumber(mobData[name].sp2t),mobData[name].imgPath,tonumber(mobData[name].rng),toboolean(mobData[name].friend),mobData[name].atr) --convert to old system
    end
  else
    error("FATAL ERROR: Unable to access mobs list.")
  end


  mobSet = {}
  for i,v in pairs(mb.hp) do
    if v and tonumber(v) < 800 and mb.spd[i] and mb.atk[i] and mb.sp1[i] and mb.sp1t[i] and mb.sp2[i] and mb.sp2t[i] and mb.img[i] and mb.rng[i] and not mb.friend[i] then
      mobSet[#mobSet+1] = i
    end
  end
end
