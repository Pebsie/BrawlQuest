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

    gameUI.x["char"] = 800-160
    gameUI.y["char"] = 0
    gameUI.isDrag["char"] = false

    gameUI.x["deb"] = 0
    gameUI.y["deb"] = 0
    gameUI.isDrag["deb"] = false
end

function requestUserInfo()
  netSend("char", pl.name)
end
