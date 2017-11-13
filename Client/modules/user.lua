pl = {}
pl.cinput = ""
pl.name = ""
pl.x = 0
pl.y = 0
pl.t = nil
pl.dt = 0
pl.hp = 100
pl.en = 100
pl.gold = 0
pl.lvl = 0
pl.xp = 0
pl.wep = "None"
pl.arm = "None"
pl.armd = 0
pl.pot = "None"
pl.s1 = ""
pl.s1t = 0
pl.s2 = ""
pl.s2t = 0
pl.msg = ""
pl.wis = 0
pl.str = 0
pl.state = "world"
pl.selItem = "None"
pl.selSpell = 1

function login() --we'll attempt to login
  if pl.name ~= "" and pl.cinput ~= "" then
    ui.selected = "logging in"
    netSend("login", pl.name..","..pl.cinput)
  else
    phase = "login"
    pl.cinput = ""
    ui.selected = "username"
  end
end

function enterGame()
  requestUserInfo()

  stopMusic() --stop title music
  --download map
  --if not love.filesystem.exists("map.txt") then
    b, c, h = http.request("http://brawlquest.com/dl/skeleking-map-2.txt")
    love.filesystem.write("map.txt", b)
  --end
      loadFog()
  --load map
    loadOverworld()


    phase = "game"
    ui.selected = "map"

    gameUI[1] = {}
    gameUI[1].x = stdSH-160 --character info
    gameUI[1].y = 0
    gameUI[1].isDrag = false
    gameUI[1].isVisible = true
    gameUI[1].width = 160
    gameUI[1].height = 316+font:getHeight()+2
    gameUI[1].label = "Character"

    gameUI[2] = {}
    gameUI[2].x = 0 --debug info
    gameUI[2].y = 0
    gameUI[2].isDrag = false
    gameUI[2].isVisible = false
    gameUI[2].width = 160
    gameUI[2].height = 46+font:getHeight()+2
    gameUI[2].label = "Debug"

    gameUI[3] = {}
    gameUI[3].x = 0 --inventory
    gameUI[3].y = 0
    gameUI[3].isDrag = false
    gameUI[3].isVisible = true
    gameUI[3].width = 148
    gameUI[3].height = 148+font:getHeight()+2
    gameUI[3].label = "Inventory"

    gameUI[4] = {}
    gameUI[4].x = sw/2
    gameUI[4].y = sh/2
    gameUI[4].isDrag = false
    gameUI[4].isVisible = false
    gameUI[4].width = 1
    gameUI[4].height = 16
    gameUI[4].label = "Alert"
    gameUI[4].msg = ""
end

function requestUserInfo()
  netSend("char", pl.name)
end

function useItem(titem)
  if item.type[titem] == "Letter" or item.type[titem] == "Key" then
    gameUI[4].isVisible = true
    gameUI[4].msg = item.val[titem]
  else
    netSend("use", pl.name..","..titem..","..pl.selSpell)
  end
end
