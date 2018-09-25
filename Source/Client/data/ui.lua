loginImg = {}
loginImg.x = {}
loginImg["ground"] = love.graphics.newImage("img/cinematic/login/ground.png")
loginImg.x["ground"] = 0
loginImg["mountain"] = love.graphics.newImage("img/cinematic/login/mountain.png")
loginImg["cloud"] = love.graphics.newImage("img/cinematic/login/cloud.png")
loginImg["tree"] = love.graphics.newImage("img/cinematic/login/tree.png")
loginImg["king"] = love.graphics.newImage("img/cinematic/login/king.png")
logo = love.graphics.newImage("img/logo.png")

bli = {}

--[[bli = {}
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
bli[12] = buddy["Water Elementling"]]



litems = {}
lclouds = {}
lclouds.x = {}
lclouds.y = {}

for i = 1, 10 do
  lclouds.x[i] = love.math.random(1, 1920)
  lclouds.y[i] = love.math.random(1, 1080)
end

litems["mountains"] = 0

litems["ground"] = 0

bli.s = love.math.random(1, 12)
litems["player"] = 1000


uiImg = {}
uiImg["atk"] = love.graphics.newImage("img/ui/atk.png")
uiImg["def"] = love.graphics.newImage("img/ui/armor.png")
uiImg["portrait"] = love.graphics.newImage("img/ui/portrait.png")
uiImg["itemportrait"] = love.graphics.newImage("img/ui/itemportrait.png")
uiImg["smallportrait"] = love.graphics.newImage("img/ui/smallportrait.png")
uiImg["target"] = love.graphics.newImage("img/ui/target.png")
uiImg["fight"] = love.graphics.newImage("img/ui/fight.png")
uiImg["menu-character"] = love.graphics.newImage("img/ui/button/character.png")
uiImg["menu-inventory"] = love.graphics.newImage("img/ui/button/inventory.png")
uiImg["menu-buddy"] = love.graphics.newImage("img/ui/button/buddy.png")
uiImg["menu-exit"] = love.graphics.newImage("img/ui/button/exit.png")
uiImg["none"] = love.graphics.newImage("img/ui/none.png")
uiImg["error"] = love.graphics.newImage("img/ui/error.png")
uiImg["lvtmp"] = love.graphics.newImage("img/ui/lvtmp.png")
uiImg["atkdef"] = love.graphics.newImage("img/ui/atkdef.png")
uiImg["readme"] = love.graphics.newImage("img/ui/readme.png")
uiImg["cursor"] = love.graphics.newImage("img/ui/mouse.png")
uiImg["love"] = love.graphics.newImage("img/cinematic/love-logo.png")
uiImg["enhost"] = love.graphics.newImage("img/cinematic/enhost-logo.png")
uiImg["freshplay"] = love.graphics.newImage("img/freshplay.png")
uiImg["weather-clear"] = love.graphics.newImage("img/ui/weather/sunny.png")
uiImg["weather-rain"] = love.graphics.newImage("img/ui/weather/rain.png")
uiImg["weather-storm"] = love.graphics.newImage("img/ui/weather/storm.png")
uiImg["time-day"] = love.graphics.newImage("img/ui/weather/time/day.png")
uiImg["time-sunset"] = love.graphics.newImage("img/ui/weather/time/sunset.png")
uiImg["time-moonrise"] = love.graphics.newImage("img/ui/weather/time/moonrise.png")
uiImg["time-night"] = love.graphics.newImage("img/ui/weather/time/night.png")
uiImg["Old Cloth"] = love.graphics.newImage("img/ui/adventurer.png")
