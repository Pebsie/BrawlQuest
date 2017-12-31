function loadMusic()
  music = {}
  music.title = {}
  music.world = {}
  music.fight = {}
  music.weather = {}

  music.title[1] = love.audio.newSource("sound/music/title.mp3", "stream")
  --music.title[2] = love.audio.newSource("sound/music/title2.mp3", "stream")

  music.world[1] = love.audio.newSource("sound/music/world1.mp3", "stream")
  music.world[2] = love.audio.newSource("sound/music/world2.mp3", "stream")
  music.world[3] = love.audio.newSource("sound/music/world3.mp3", "stream")
  music.world[4] = love.audio.newSource("sound/music/world4.mp3", "stream")
  music.world[5] = love.audio.newSource("sound/music/world5.mp3", "stream")
  music.world[6] = love.audio.newSource("sound/music/world6.mp3", "stream")
  music.world[7] = love.audio.newSource("sound/music/world7.mp3", "stream")

  music.fight[1] = love.audio.newSource("sound/music/fight1.mp3", "stream")
  music.fight[2] = love.audio.newSource("sound/music/fight2.mp3", "stream")
  music.fight[3] = love.audio.newSource("sound/music/fight3.mp3", "stream")
  music.fight[4] = love.audio.newSource("sound/music/fight4.mp3", "stream")

  music.weather["snow"] = love.audio.newSource("sound/sfx/snow.mp3","stream")

  music.curPlay = music.title[love.math.random(1, #music.title)]
  music.curWet = music.weather["snow"]

  love.audio.play(music.curPlay)
end

function updateMusic(dt)
  if phase == "game" and setting.audio == true and music[pl.state] then --diff code for each type
    if not music.curPlay:isPlaying() then
      if love.math.random(1, 200) == 1 then
        music.curPlay = music[pl.state][love.math.random(1, #music[pl.state])]
        music.curPlay:setLooping(false)
      --love   music.curPlay:setVolume(0.05)
        love.audio.play(music.curPlay)
      end
    end

    if not music.curWet:isPlaying() then
      if music.weather[world.weather] then
        music.curWet = music.weather[world.weather]
        love.audio.play(music.curWet)
      end
    end

    if not music.weather[world.weather] then
      love.audio.stop(music.curWet)
    end
  end
end

function stopMusic()
  love.audio.stop(music.curPlay)
end
