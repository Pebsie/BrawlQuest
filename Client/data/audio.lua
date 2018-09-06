music = {}
sfx = {}

music["title"] = love.audio.newSource("sound/music/title.mp3","stream")
music["title"]:setLooping(true)

sfx["hit"] = love.audio.newSource("sound/sfx/hit.ogg","static")
sfx["hit"]:setPitch(1.5)
sfx["kill"] = love.audio.newSource("sound/sfx/kill.wav","static")
sfx["kill"]:setVolume(0.5)
sfx["awake"] = love.audio.newSource("sound/sfx/awake.wav","static")
sfx["victory"] = love.audio.newSource("sound/sfx/victory.mp3","static")
sfx["loot"] = love.audio.newSource("sound/sfx/loot.mp3","static")
sfx["lightning"] = love.audio.newSource("sound/sfx/weather/flash.mp3","static")
sfx["teleport"] = love.audio.newSource("sound/sfx/teleport.mp3","static")
sfx["xp"] = love.audio.newSource("sound/sfx/xp.mp3","static")

buddySnd = {}
buddySnd["Baby Bat"] = love.audio.newSource("sound/sfx/pet/bat.mp3","static")
buddySnd["Beholder"] = love.audio.newSource("sound/sfx/pet/beholder.mp3","static")
buddySnd["Beholdling"] = love.audio.newSource("sound/sfx/pet/beholder.mp3","static")
buddySnd["Dog"] = love.audio.newSource("sound/sfx/pet/dog.mp3","static")
buddySnd["Dragonling"] = love.audio.newSource("sound/sfx/mob/Dragon/1.mp3","static")
buddySnd["Snake"] = love.audio.newSource("sound/sfx/pet/snake.mp3","static")
buddySnd["Horse"] = love.audio.newSource("sound/sfx/pet/horse.mp3","static")
