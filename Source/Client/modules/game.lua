require "modules/submodules/players"
require "modules/submodules/fight"
require "modules/submodules/overworld"
require "modules/submodules/buddy"
require "modules/submodules/aspects"

mx = 0
my = 0

gameUI = {}

timeToMove = 0.5
timeToUpdate = 0.5
thisUpdate = "world"

frequentlyUpdate = false

function drawGame()
  if pl.state == "world" then
   drawOverworld()
   drawActionBar(gameUI[1].x,gameUI[1].y)

  elseif pl.state == "fight" or pl.state == "afterfight" then
    drawFight()
    drawActionBar(gameUI[1].x,gameUI[1].y)
  else
    love.graphics.setFont(sFont)
    love.graphics.printf("Your character is presently floating through the void!\n\nSeriously, though, screenshot this and send it to @Pebsiee on Twitter.\nUsername: "..pl.name.."\nState: "..tostring(pl.state).."\n\nThere's also a possibility that we're just waiting on the next character update and this might be caused by a slow connection.\nIn that case - if you've had enough time to read this fully - you're not going to be able to play this game. Try changing server, ISP or contact @Pebsiee on Twitter with your location asking for a new server location.\n\nYou can ask again for user info by hitting u now.",0,0,sw,"left")
  end
  love.graphics.setColor(255,255,255,255)
--  love.graphics.print(love.timer.getFPS().." FPS")
end

function updateGame(dt)
--    if joystick:isGamepadDown("dpup") then error("yep") end
  if pl.state == "world" then
    updateOverworld(dt)

    timeToUpdate = timeToUpdate - 1*dt
    if timeToUpdate < 0 then
    --[[  if thisUpdate == "world" then
        requestWorldInfo()
        thisUpdate = "players"
      elseif thisUpdate == "players" then
        requestPlayersInfo()
        thisUpdate = "world"
      end]]
      requestWorldInfo()
      requestPlayersInfo()
      requestUserInfo()

      if frequentlyUpdate == true then
        requestUserInfo()
        frequentlyUpdate = false
      end
      timeToUpdate = 0.5
    end

    timeToMove = timeToMove - 1*dt

    if ui.selected ~= "chat" then
      if timeToMove < 0 then
        if love.keyboard.isDown("w") or joystick:isGamepadDown(JS_UP) then movePlayer("up") timeToMove = 0.5
        elseif love.keyboard.isDown("s") or joystick:isGamepadDown(JS_DOWN) then movePlayer("down") timeToMove = 0.5
        elseif love.keyboard.isDown("d") or joystick:isGamepadDown(JS_RIGHT) then movePlayer("right") timeToMove = 0.5
        elseif love.keyboard.isDown("a") or joystick:isGamepadDown(JS_LEFT) then movePlayer("left") timeToMove = 0.5
        else timeToMove = 0.01 end
      end
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
  elseif pl.state == "fight" or pl.state == "afterfight" then
    updateFight(dt)
  end

  if item[pl.spell] and item[pl.spell].type == "hp" then
    pl.hp = pl.hp + (item[pl.spell].val/3)*dt
  end

  if pl.spell == "Recovery" then
    pl.hp = pl.hp + 10*dt --increase by 10% per second
  end

  if pl.hp > 100+5*pl.sta then pl.hp = 100+5*pl.sta end

  if pl.armd then
    pl.armd = pl.armd - 0.25*dt
    if pl.armd < 0 then pl.armd = 0 end
  end

  pl.s1t = pl.s1t - 1*dt
  pl.s2t = pl.s2t - 1*dt

  if world[pl.t].rest then
    pl.hp = pl.hp + 10*dt
  end

  updateBuddies(dt)
end
