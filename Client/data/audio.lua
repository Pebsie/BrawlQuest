music = {}
sfx = {}

music["title"] = love.audio.newSource("sound/music/title.mp3","stream")
music["title"]:setLooping(true)

sfx["hit"] = love.audio.newSource("sound/sfx/hit.mp3","static")
sfx["hit"]:setPitch(1.5)
sfx["kill"] = love.audio.newSource("sound/sfx/kill.wav","static")
sfx["kill"]:setVolume(0.5)
sfx["awake"] = love.audio.newSource("sound/sfx/awake.wav","static")
sfx["victory"] = love.audio.newSource("sound/sfx/victory.mp3","static")
sfx["loot"] = love.audio.newSource("sound/sfx/loot.mp3","static")
sfx["lightning"] = love.audio.newSource("sound/sfx/weather/flash.mp3","static")
