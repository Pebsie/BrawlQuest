music = {}
sfx = {}

music["title"] = love.audio.newSource("sound/music/title.mp3")
music["title"]:setLooping(true)

sfx["hit"] = love.audio.newSource("sound/sfx/hit.wav")
sfx["hit"]:setVolume(0.1)
sfx["kill"] = love.audio.newSource("sound/sfx/kill.wav")
sfx["kill"]:setVolume(0.25)
