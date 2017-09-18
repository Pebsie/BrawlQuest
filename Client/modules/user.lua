pl = {}
pl.cinput = ""
pl.name = ""
pl.x = 0
pl.y = 0
pl.t = 0
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

function login() --we'll attempt to login
  ui.selected = "logging in"
  netSend("login", pl.name..","..pl.cinput)
end

function enterGame()
  requestUserInfo()

  --download map
  b, c, h = http.request("http://peb.si/bq/dl/map.txt")
  love.filesystem.write("map.txt", b)

  --load map
  loadOverworld()

  phase = "game"
  ui.selected = "map"
  music["title"]:stop()

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
