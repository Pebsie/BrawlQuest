--new mob functions

mobData = {}
mfs = ""

function newMob(name,hp,speed,attack,sp1,sp1t,sp2,sp2t,img,rng,friend)
  if not friend then friend = false end

  print("New mob: "..name)
  local i = name

  local imgData = love.image.newImageData(mobData[name].imgPath)
  mfs = mfs.."name="..name.."=hp="..hp.."=spd="..speed.."=atk="..attack.."=sp1="..sp1.."=sp1t="..sp1t.."=sp2="..sp2.."=sp2t="..sp2t.."=imgPath="..img.."=rng="..rng.."=friend="..tostring(friend).."\n"
--  mobData[name] = {name=name,hp=hp,atk=attack,sp1=sp1,sp1t=sp1t,sp2=sp2,sp2t=sp2t,imgPath=img,imgData=imgData,img=love.graphics.newImage(imgData),rng=rng,friend=friend}
  mobData[name].imgData = imgData
  --OLD FILE FORMAT TODO: CONVERT ALL SYSTEMS TO USE THE TABLE ABOVE
  mb.hp[i] = name
  mb.spd[i] = speed
  mb.atk[i] = attack
  mb.sp1[i] = sp1
  mb.sp1t[i] = sp1t
  mb.sp2[i] = sp2
  mb.sp2t[i] = sp2t
  mb.img[i] = love.graphics.newImage(imgData)
  mb.rng[i] = rng
  mb.friend[i] = friend
  mb.imgData[i] = imgData
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

      newMob(mobData[name].name,tonumber(mobData[name].hp),tonumber(mobData[name].spd),tonumber(mobData[name].atk),mobData[name].sp1,tonumber(mobData[name].sp1t),mobData[name].sp2,tonumber(mobData[name].sp2t),mobData[name].imgPath,tonumber(mobData[name].rng),toboolean(mobData[name].friend)) --convert to old system
    end
  end
end




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
mb.imgData = {}

local tm = "Player" --for bones
mb.img[tm] = "img/dragon/Red.png"

tm = "Mortus"
mb.img["Mortus"] = "img/human/Mortus.png"
mb.sfx[tm] = {}
mb.sfx[tm][1] = love.audio.newSource("sound/sfx/mob/"..tm.."/1.mp3","static")
mb.sfx[tm][2] = love.audio.newSource("sound/sfx/mob/"..tm.."/2.mp3","static")
mb.sfx[tm][3] = love.audio.newSource("sound/sfx/mob/"..tm.."/3.mp3","static")
mb.sfx[tm][4] = love.audio.newSource("sound/sfx/mob/"..tm.."/4.mp3","static")
mb.sfx[tm][5] = love.audio.newSource("sound/sfx/mob/"..tm.."/5.mp3","static")
mb.friend[tm] = true

function downloadMobs()
--  addMsg("Downloading mobs list...")
  b, c, h = http.request("http://brawlquest.com/dl/scripts/getMobs.php")
  if b then
    love.filesystem.write("mobs-beta.txt", b)
  else
    --addMsg("Failed to download mobs list.")
  end
end
