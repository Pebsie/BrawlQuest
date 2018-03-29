require "modules/submodules/players"
require "modules/submodules/fight"
require "modules/submodules/overworld"
require "modules/submodules/buddy"

mx = 0
my = 0

gameUI = {}

timeToMove = 0.5
timeToUpdate = 0.5

frequentlyUpdate = false

function drawGame()
  if pl.state == "world" then
    drawOverworld()
  elseif pl.state == "fight" then
    drawFight()
  else
    love.graphics.setFont(sFont)
    love.graphics.printf("Your character is presently floating through the void!\n\nSeriously, though, screenshot this and send it to @Pebsiee on Twitter.\nUsername: "..pl.name.."\nState: "..tostring(pl.state).."\n\nThere's also a possibility that we're just waiting on the next character update and this might be caused by a slow connection.\nIn that case - if you've had enough time to read this fully - you're not going to be able to play this game. Try changing server, ISP or contact @Pebsiee on Twitter with your location asking for a new server location.\n\nYou can ask again for user info by hitting u now.",0,0,sw,"left")
  end
end

function updateGame(dt)
  if pl.state == "world" then
    updateOverworld(dt)
  --  if pl.t and moveQueue and #moveQueue > 0 then
  --    timeToMove = timeToMove - 1*dt
  --    if timeToMove < 0 then
  --      pl.t = moveQueue[#moveQueue]
  --      addFog(pl.t)
  --      table.remove(moveQueue, #moveQueue)
  --      centerCamera()
    --    timeToMove = 0.2
  --    end
  --  end

    timeToUpdate = timeToUpdate - 1*dt
    if timeToUpdate < 0 then
      requestWorldInfo()
      if frequentlyUpdate == true then
        requestUserInfo()
        frequentlyUpdate = false
      end
      timeToUpdate = 0.5
    end

    timeToMove = timeToMove - 1*dt
    if timeToMove < 0 then
      if love.keyboard.isDown("w") then movePlayer("up") timeToMove = 0.25
      elseif love.keyboard.isDown("s") then movePlayer("down") timeToMove = 0.25
      elseif love.keyboard.isDown("d") then movePlayer("right") timeToMove = 0.25
      elseif love.keyboard.isDown("a") then movePlayer("left") timeToMove = 0.25
      else timeTomove = 0.1 end
    end

    if pl.x then
      local pls = 64*dt
      if pl.x > world[pl.t].x then pl.x = pl.x - pls end
      if pl.x < world[pl.t].x then pl.x = pl.x + pls end
      if pl.y > world[pl.t].y then pl.y = pl.y - pls end
      if pl.y < world[pl.t].y then pl.y = pl.y + pls end
      if distanceFrom(pl.x,pl.y,world[pl.t].x,world[pl.t].y) < 0.2 or distanceFrom(pl.x,pl.y,world[pl.t].x,world[pl.t].y) > 64 then pl.x = world[pl.t].x pl.y = world[pl.t].y end
      centerCamera()

      updatePlayers(dt)
    end
  elseif pl.state == "fight" then
    updateFight(dt)
  end

  if item.type[pl.spell] == "hp" then
    pl.hp = pl.hp + (item.val[pl.spell]/3)*dt
  end

  if pl.spell == "Recovery" then
    pl.hp = pl.hp + 10*dt --increase by 10% per second
  end

  if pl.hp > 100 then pl.hp = 100 end

  if pl.armd then
    pl.armd = pl.armd - 0.25*dt
    if pl.armd < 0 then pl.armd = 0 end
  end

  pl.s1t = pl.s1t - 1*dt
  pl.s2t = pl.s2t - 1*dt

  updateBuddies(dt)
end
