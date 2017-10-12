loginImg = {}
loginImg.x = {}
loginImg["ground"] = love.graphics.newImage("img/cinematic/login/ground.png")
loginImg.x["ground"] = 0
loginImg["mountain"] = love.graphics.newImage("img/cinematic/login/mountain.png")
loginImg["cloud"] = love.graphics.newImage("img/cinematic/login/cloud.png")
loginImg["tree"] = love.graphics.newImage("img/cinematic/login/tree.png")
logo = love.graphics.newImage("img/logo.png")

bli = {}
bli[1] = buddy["Baby Bat"]
bli[2] = buddy["Beholder"]
bli[3] = buddy["Beholdling"]
bli[4] = buddy["Chicken"]
bli[5] = buddy["Dog"]
bli[6] = buddy["Dragonling"]
bli[7] = buddy["Earth Elementling"]
bli[8] = buddy["Fire Elementling"]
bli[9] = buddy["Scorpion"]
bli[10] = buddy["Sheep"]
bli[11] = buddy["Snake"]
bli[12] = buddy["Water Elementling"]



litems = {}
lclouds = {}
lclouds.x = {}
lclouds.y = {}

lclouds.x[1] = 28
lclouds.y[1] = 97

lclouds.x[2] = 292
lclouds.y[2] = 273

lclouds.x[3] = 793
lclouds.y[3] = 238

litems["mountains"] = 0

litems["ground"] = 0

bli.s = love.math.random(1, 12)
litems["player"] = 1000


uiImg = {}
uiImg["atk"] = love.graphics.newImage("img/ui/atk.png")
uiImg["def"] = love.graphics.newImage("img/ui/armor.png")
uiImg["portrait"] = love.graphics.newImage("img/ui/portrait.png")
uiImg["target"] = love.graphics.newImage("img/ui/target.png")
uiImg["fight"] = love.graphics.newImage("img/ui/fight.png")
uiImg["error"] = love.graphics.newImage("img/ui/error.png")
