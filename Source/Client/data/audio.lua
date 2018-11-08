music = {title = {}, world = {}, fight = {}, raid = {}, weather = {}, curPlay = 0, curWet = 0}
sfx = {}

music.title[1] = love.audio.newSource("sound/music/title-old.mp3", "stream")
music.title[2] = love.audio.newSource("sound/music/title-old.mp3", "stream")

music.world[1] = love.audio.newSource("sound/music/beach1.mp3", "stream") -- Squall's End
music.world[2] = love.audio.newSource("sound/music/world1.mp3", "stream")
music.world[3] = love.audio.newSource("sound/music/beach-mystery.mp3", "stream") 
music.world[4] = love.audio.newSource("sound/music/world4.mp3", "stream")
music.world[5] = love.audio.newSource("sound/music/world5.mp3", "stream")
music.world[6] = love.audio.newSource("sound/music/world6.mp3", "stream")
music.world[7] = love.audio.newSource("sound/music/world7.mp3", "stream")
music.world[8] = love.audio.newSource("sound/music/twistedmountains.mp3","stream") -- TODO: find out where this is used
music.world[9] = love.audio.newSource("sound/music/world-snow.mp3","stream") -- Northern Heights
music.world[10] = love.audio.newSource("sound/music/desert.mp3","stream") -- Eastern Wasteland
music.world[11] = love.audio.newSource("sound/music/shadows.mp3","stream") -- Newton
music.world[12] = love.audio.newSource("sound/music/forest.mp3","stream")
music.world[13] = love.audio.newSource("sound/music/mining.mp3","stream")
music.world[14] = love.audio.newSource("sound/music/posh.mp3","stream")
music.world[15] = love.audio.newSource("sound/music/sax.mp3","stream")


music.fight[1] = love.audio.newSource("sound/music/fight1.mp3", "stream")
music.fight[2] = love.audio.newSource("sound/music/fight2.mp3", "stream")
music.fight[3] = love.audio.newSource("sound/music/battle1.mp3", "stream")
music.fight[4] = love.audio.newSource("sound/music/sax.mp3", "stream")

music.fight[5] = love.audio.newSource("sound/music/arena.mp3","stream")

music.raid[1] = love.audio.newSource("sound/music/boss.mp3","stream")
music.raid[2] = love.audio.newSource("sound/music/battle2.mp3","stream")
  --music.raid[2] = love.audio.newSource("sound/music/raid2.mp3","stream")
  --music.raid[3] = love.audio.newSource("sound/music/raid3.mp3","stream")



music.weather["snow"] = love.audio.newSource("sound/sfx/snow.mp3","stream")
music.weather["rain"] = love.audio.newSource("sound/sfx/weather/rain.mp3","static")
music.weather["storm"] = love.audio.newSource("sound/sfx/weather/rain.mp3","static")


music.curWet = music.weather["snow"]
music.curPlay = music.title[love.math.random(1, #music.title)]


if dev == false then love.audio.play(music.curPlay) end

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

