music = {}
sfx = {}

music["title"] = love.audio.newSource("sound/music/title.mp3")
music["title"]:setLooping(true)

sfx["hit"] = love.audio.newSource("sound/sfx/hit.wav")
sfx["kill"] = love.audio.newSource("sound/sfx/kill.wav")

fredSound = {}
fredSound[1] = love.audio.newSource("sound/sfx/fred/1.ogg")
fredSound[2] = love.audio.newSource("sound/sfx/fred/2.ogg")
fredSound[3] = love.audio.newSource("sound/sfx/fred/3.ogg")
fredSound[4] = love.audio.newSource("sound/sfx/fred/4.ogg")
fredSound[5] = love.audio.newSource("sound/sfx/fred/5.ogg")
fredSound[6] = love.audio.newSource("sound/sfx/fred/6.ogg")
fredSound[7] = love.audio.newSource("sound/sfx/fred/7.ogg")
fredSound[8] = love.audio.newSource("sound/sfx/fred/8.ogg")
fredSound[9] = love.audio.newSource("sound/sfx/fred/9.ogg")
fredSound[10] = love.audio.newSource("sound/sfx/fred/10.ogg")
fredSound[11] = love.audio.newSource("sound/sfx/fred/11.ogg")
fredSound[12] = love.audio.newSource("sound/sfx/fred/12.ogg")

questSound = {}
questSound[1] = love.audio.newSource("sound/sfx/quest/1.ogg")
questSound[2] = love.audio.newSource("sound/sfx/quest/2.ogg")
questSound[3] = love.audio.newSource("sound/sfx/quest/3.ogg")
questSound[4] = love.audio.newSource("sound/sfx/quest/4.ogg")
questSound[5] = love.audio.newSource("sound/sfx/quest/5.ogg")
