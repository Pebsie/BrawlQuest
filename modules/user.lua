pl = {}
pl.cinput = ""
pl.name = ""
pl.x = 0
pl.y = 0
pl.hp = 100
pl.en = 100
pl.gold = 0
pl.lvl = 0
pl.wep = "None"
pl.arm = "None"

function login() --we'll attempt to login
  ui.selected = "logging in"
  netSend("login", pl.name..","..pl.cinput)
end

function enterGame()
  phase = "game"
  ui.selected = "none"
end
