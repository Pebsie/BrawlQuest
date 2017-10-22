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
pl.pot = "None"
pl.s1 = ""
pl.s2 = ""
pl.msg = ""
pl.wis = 0
pl.str = 0
pl.state = "world"

function login() --we'll attempt to login
  ui.selected = "logging in"
  netSend("login", pl.name..","..pl.cinput)
end

function enterGame()
  requestUserInfo()

  stopMusic() --stop title music
  --download map
--  if not love.filesystem.exists("map.txt") then
    b, c, h = http.request("http://peb.si/bq/dl/map.txt")
    love.filesystem.write("map.txt", b)
 --end
      loadFog()
  --load map
    loadOverworld()


    phase = "game"
    ui.selected = "map"

    gameUI[1] = {}
    gameUI[1].x = 800-160 --character info
    gameUI[1].y = 0
    gameUI[1].isDrag = false
    gameUI[1].isVisible = true
    gameUI[1].width = 160
    gameUI[1].height = 300

    gameUI[2] = {}
    gameUI[2].x = 0 --debug info
    gameUI[2].y = 0
    gameUI[2].isDrag = false
    gameUI[2].isVisible = false
    gameUI[2].width = 160
    gameUI[2].height = 46

    gameUI[3] = {}
    gameUI[3].x = 0 --inventory
    gameUI[3].y = 0
    gameUI[3].isDrag = false
    gameUI[3].isVisible = true
    gameUI[3].width = 148
    gameUI[3].height = 148
end

function requestUserInfo()
  netSend("char", pl.name)
end
