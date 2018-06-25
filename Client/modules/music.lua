function loadMusic()
  music = {}
  music.title = {}
  music.world = {}
  music.fight = {}
  music.raid = {}
  music.weather = {}

  music.title[1] = love.audio.newSource("sound/music/title.mp3", "stream")
  music.title[2] = love.audio.newSource("sound/music/title-old.mp3", "stream")

  music.world[1] = love.audio.newSource("sound/music/beach1.mp3", "stream")
  music.world[2] = love.audio.newSource("sound/music/world1.mp3", "stream")
  music.world[3] = love.audio.newSource("sound/music/beach-mystery.mp3", "stream")
  music.world[4] = love.audio.newSource("sound/music/world4.mp3", "stream")
  music.world[5] = love.audio.newSource("sound/music/world5.mp3", "stream")
  music.world[6] = love.audio.newSource("sound/music/world6.mp3", "stream")
  music.world[7] = love.audio.newSource("sound/music/world7.mp3", "stream")

  music.fight[1] = love.audio.newSource("sound/music/fight1.mp3", "stream")
  music.fight[2] = love.audio.newSource("sound/music/fight2.mp3", "stream")
  music.fight[3] = love.audio.newSource("sound/music/fight3.mp3", "stream")
  music.fight[4] = love.audio.newSource("sound/music/fight4.mp3", "stream")

  music.raid[1] = love.audio.newSource("sound/music/boss.mp3","stream")
  --music.raid[2] = love.audio.newSource("sound/music/raid2.mp3","stream")
  --music.raid[3] = love.audio.newSource("sound/music/raid3.mp3","stream")

  music.weather["snow"] = love.audio.newSource("sound/sfx/snow.mp3","stream")
  music.weather["rain"] = love.audio.newSource("sound/sfx/weather/rain.mp3","static")
  music.weather["storm"] = love.audio.newSource("sound/sfx/weather/rain.mp3","static")

  music.curPlay = music.title[love.math.random(1, #music.title)]
  music.curWet = music.weather["snow"]

  if dev == false then love.audio.play(music.curPlay) end
end

function updateMusic(dt)
  if dev == false then
    if phase == "game" and setting.audio == true and music[pl.state] then --diff code for each type
      if not music.curPlay:isPlaying() then
        if love.math.random(1, 200) == 1 then
          if pl.state == "fight" and string.lower(string.sub(world[pl.t].fight,1,7)) == "dungeon" or string.lower(string.sub(world[pl.t].fight,1,4)) == "Raid" then
            music.curPlay = music["raid"][love.math.random(1, #music["raid"])]
          else
            if pl.state == "world" and world[pl.t].music == "*" then
              music.curPlay = music.world[love.math.random(1, #music[pl.state])]
            elseif pl.state == "world" then
              local musicChoices = atComma(world[pl.t].music,"|")
              local i = love.math.random(1, #musicChoices)
              music.curPlay = music.world[tonumber(musicChoices[i])]
            else
              music.curPlay = music[pl.state][love.math.random(1, #music[pl.state])]
            end
          end
          --if dev == false then music.curPlay:setLooping(false) end
        --love   music.curPlay:setVolume(0.05)
          if dev == false then love.audio.play(music.curPlay) end
        end
      end

      if not music.curWet:isPlaying() then
        if music.weather[weather.condition] then
          music.curWet = music.weather[weather.condition]
          love.audio.play(music.curWet)
        end
      end

      if not music.weather[weather.condition] then
        love.audio.stop(music.curWet)
      end
    end
  end
end

function stopMusic()
  love.audio.stop(music.curPlay)
end
