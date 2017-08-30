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
  phase = "game"
  ui.selected = "map"
end

function requestUserInfo()
  netSend("char", pl.name)
end
