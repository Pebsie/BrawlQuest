pl = {}
pl.cinput = ""
pl.name = ""
pl.x = 0
pl.y = 0
pl.t = 50
pl.dt = 0
pl.hp = 100
pl.en = 100
pl.gold = 0
pl.lvl = 1
pl.xp = 0
pl.xpt = 0
pl.wep = "None"
pl.arm = "None"
pl.arm_head = "None"
pl.arm_chest = "None"
pl.arm_legs = "None"
pl.armd = 0
pl.pot = "None"
pl.s1 = ""
pl.s1t = 0
pl.s2 = ""
pl.s2t = 0
pl.msg = ""
pl.str = 0
pl.int = 0
pl.sta = 0
pl.agl = 0
pl.cp = 0 --character points
pl.state = "world"
pl.selItem = "None"
pl.selSpell = 1
pl.str = 0
pl.owed = ""
pl.score = 0
pl.combo = 0
pl.aspectString = ""
pl.blueprints = ""
pl.zone = "Swordbreak"
pl.inv = {}
pl.completedQuests = ""
pl.activeQuests = ""

authcode = "1000" --this is used to verify with the server that we aren't username spoofing

function login() --we'll attempt to login

  if pl.name ~= "" and pl.cinput ~= "" then
    ui.selected = "logging in"
    --netSend("login", pl.name..","..pl.cinput)
    b, c, h = http.request("https://brawlquest.com/dl/api.php?a=login&username="..pl.name.."&password="..pl.cinput)
   -- love.window.showMessageBox("debug",b)
    netSend("login", b)
    authcode = b
  else
    phase = "login"
    pl.cinput = ""
    ui.selected = "username"
  end
end

function enterGame()
  requestUserInfo()
  loadFog()
  loadOverworld()
  stopMusic() --stop title music
  love.graphics.setBackgroundColor(0,0,0)
  --download map
  --if not love.filesystem.exists("map.txt") then

  --load map


    phase = "game"
    ui.selected = "map"

    gameUI[1] = {}
    gameUI[1].x = sw/2-320 --character info
    gameUI[1].y = sh-70
    gameUI[1].isDrag = false
    gameUI[1].isVisible = true
    gameUI[1].width = 640
    gameUI[1].height = 94
    gameUI[1].label = "Action Bar"
    gameUI[1].closeButton = true

    gameUI[2] = {}
    gameUI[2].x = 0 --debug info
    gameUI[2].y = 0
    gameUI[2].isDrag = false
    if dev then
      gameUI[2].isVisible = true
    else
      gameUI[2].isVisible = false
    end
    gameUI[2].width = 160
    gameUI[2].height = 46+font:getHeight()+2
    gameUI[2].label = "Debug"

    gameUI[3] = {}
    gameUI[3].x = 0 --inventory
    gameUI[3].y = 0
    gameUI[3].isDrag = false
    gameUI[3].isVisible = false
    gameUI[3].width = 36*5+4
    gameUI[3].height = 36*5+font:getHeight()+12
    gameUI[3].label = "Inventory"
    gameUI[3].closeButton = true

    gameUI[4] = {}
    gameUI[4].x = sw/2
    gameUI[4].y = sh/2
    gameUI[4].isDrag = false
    gameUI[4].isVisible = false
    gameUI[4].width = 1
    gameUI[4].height = 16
    gameUI[4].label = "Alert"
    gameUI[4].msg = ""
    gameUI[4].closeButton = true

    gameUI[5] = {}
    gameUI[5].x = love.graphics.getWidth()-100
    gameUI[5].y = -16
    gameUI[5].isDrag = false
    gameUI[5].isVisible = true
    gameUI[5].width = 100
    gameUI[5].height = 140
    gameUI[5].label = "World Map"

    gameUI[6] = {}
    gameUI[6].x = 300
    gameUI[6].y = 200
    gameUI[6].isDrag = false
    gameUI[6].isVisible = false
    gameUI[6].width = 96
    gameUI[6].height = 100
    gameUI[6].label = "Crafting"

    gameUI[7] = {}
    gameUI[7].x = 300
    gameUI[7].y = 200
    gameUI[7].isDrag = false
    gameUI[7].isVisible = false
    gameUI[7].width = 32*3
    gameUI[7].height = 100
    gameUI[7].label = "Buddies"
    gameUI[7].closeButton = true

    gameUI[8] = {}
    gameUI[8].x = 400
    gameUI[8].y = 300
    gameUI[8].isDrag = false
    gameUI[8].isVisible = false
    gameUI[8].width = 200
    gameUI[8].height = 100
    gameUI[8].label = "Tutorial"
    gameUI[8].closeButton = true

    gameUI[9] = {}
    gameUI[9].x = 400
    gameUI[9].y = 300
    gameUI[9].isDrag = false
    gameUI[9].isVisible = false
    gameUI[9].width = 128
    gameUI[9].height = 300
    gameUI[9].label = "Character"
    gameUI[9].closeButton = true

    gameUI[10] = {}
    gameUI[10].x = 600
    gameUI[10].y = 300
    gameUI[10].isDrag = false
    gameUI[10].isVisible = false
    gameUI[10].width = 128
    gameUI[10].height = 305
    gameUI[10].label = "Quest"
    gameUI[10].closeButton = true
    
    netSend("questInfo",pl.name)
end

function requestUserInfo()
  netSend("char", pl.name)
end

function useItem(titem)
  if item[titem].type == "Letter" or item[titem].type == "Key" then
    gameUI[4].isVisible = true
    gameUI[4].msg = item[titem].val
  elseif item[titem].type ~= "currency" and item[titem].type ~= "Reagent" and authcode then
    netSend("use", pl.name..","..titem..","..pl.selSpell..","..authcode)
  end
end

function movePlayer(dir)
  if authcode then
    netSend("move", pl.name..","..dir..","..authcode)
  else
    login()
  end
  requestUserInfo()

  if whiteOut > 255 then whiteOut = 255 end
  if titleScreen > 255 then titleScreen = 255 end --allow skipping of title screen

  curT = pl.t
  --perform on client side pre-confirmation to make things smoother
  if dir == "up" then pl.t = pl.t - 101
  elseif dir == "down" then pl.t = pl.t + 101
  elseif dir == "left" then pl.t = pl.t - 1
  elseif dir == "right" then pl.t = pl.t + 1 end

  if not world[curT].rest and world[pl.t].rest then
    createFloat("Resting...",0,200,0,centerX,centerY,love.math.random(1,9999),false)
  end

  if string.sub(world[pl.t].fight,1,5) == "speak" then
    sInfo = atComma(world[pl.t].fight,"|")
    triggerTutorial("npc")
    if sInfo[3] then
      mobSpeak(sInfo[2],sInfo[3],string.len(sInfo[3])/20)
    else
      mobSpeak(world[pl.t].tile,sInfo[2],string.len(sInfo[2])/20)
    end
  end

  if world[pl.t].collide == false then
    addFog(pl.t)
    if stepSnd[world[pl.t].tile] then
      local stepSound = stepSnd[world[pl.t].tile]
      stepSound:setPitch(love.math.random(100,140)/100)
      stepSound:setVolume(0.25)
      love.audio.play(stepSound)
    elseif stepSnd[world[pl.t].bg] then
      local stepSound = stepSnd[world[pl.t].bg]
      stepSound:setPitch(love.math.random(100,140)/100)
      stepSound:setVolume(0.25)
      love.audio.play(stepSound)
    end

    if world[pl.t].tile == "Anvil" then
      gameUI[6].isVisible  = true
      netSend("blueprints", pl.name)
    else
      gameUI[6].isVisible = false
    end
  end

  if pl.t == 9185 then
    phase = "read"
  end

  if pl.hp < 25 then
    triggerTutorial("hp")
  end

  if string.sub(world[pl.t].fight,1,5) == "quest" and not hasPlayerCompletedQuest(i) then
    gameUI[10].isVisible = true
  else
    gameUI[10].isVisible = false
  end
  --createWorldCanvas()
end

function playerHasItem(item,amount)
  local hasItem = false
  if not amount then amount = 1 end

  for i, v in pairs(pl.inv) do
    if v.name == item and v.amount >= amount then
      hasItem = true
    end
  end
  
  return hasitem
end

function getInventorySlot(item)
  local slot = 1
  for i, v in pairs(pl.inv) do
    if v.name == item then
      slot = i
    end
  end

  return slot
end

function resetUIPosition(i) --resets the position of the specified window to the default setting
  if i == 1 then
    gameUI[1].x = sw/2-320 --character info
    gameUI[1].y = sh-94
  elseif i == 5 then
    gameUI[5].x = love.graphics.getWidth()-100
    gameUI[5].y = -16
  end
end
