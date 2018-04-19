music = {}
sfx = {}

music["title"] = love.audio.newSource("sound/music/title.mp3","stream")
music["title"]:setLooping(true)

sfx["hit"] = love.audio.newSource("sound/sfx/hit.wav","static")
sfx["hit"]:setVolume(0.25)
sfx["kill"] = love.audio.newSource("sound/sfx/kill.wav","static")
sfx["kill"]:setVolume(0.5)
