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
pl.s1 = ""
pl.s2 = ""
pl.msg = ""

function login() --we'll attempt to login
  ui.selected = "logging in"
  netSend("login", pl.name..","..pl.cinput)
end

function enterGame()
  requestUserInfo()

  --download map
  local body, code = http.request("http://peb.si/b/map.txt")
  if not body then error(code) end
  local f = assert(io.open('map.txt', 'wb'))
  f:write(body)
  f:close()

  phase = "game"
  ui.selected = "map"
  music["title"]:stop()


end

function requestUserInfo()
  netSend("char", pl.name)
end
