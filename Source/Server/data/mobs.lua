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
  b, c, h = http.request("https://brawlquest.com/dl/scripts/getMobs.php")
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
      if string.sub(line,1,1) ~= "<" then
        local mbInfo = atComma(line,"=")
        local name = mbInfo[2]
        mobData[name] = {}
        for i = 1, #mbInfo, 2 do
          mobData[name][mbInfo[i]] = mbInfo[i+1]
        end

        if not mobData[name].sp1 then mobData[name].sp1 = "None" mobData[name].sp1t = 0 end
        if not mobData[name].sp2 then mobData[name].sp2 = "None" mobData[name].sp2t = 0 end

        newMob(mobData[name].name,tonumber(mobData[name].hp),tonumber(mobData[name].spd),tonumber(mobData[name].atk),mobData[name].sp1,tonumber(mobData[name].sp1t),mobData[name].sp2,tonumber(mobData[name].sp2t),mobData[name].imgPath,tonumber(mobData[name].rng),toboolean(mobData[name].friend),mobData[name].atr) --convert to old system
        --addMsg("new mob: "..name)
      end
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
