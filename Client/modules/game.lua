require "modules/submodules/players"

mx = 0
my = 0

gameUI = {}
gameUI.x = {}
gameUI.y = {}
gameUI.isDrag = {}

timeToMove = 0.5
timeToUpdate = 0.5

function drawGame()
  if ui.selected == "map" then
    drawOverworld()
  end
end

function updateGame(dt)
  updateGameUI(dt,"char")
  updateGameUI(dt,"deb")
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
    timeToUpdate = 0.5
  end

  timeToMove = timeToMove - 1*dt
  if timeToMove < 0 then
    if love.keyboard.isDown("w") then movePlayer("up") timeToMove = 0.5
    elseif love.keyboard.isDown("s") then movePlayer("down") timeToMove = 0.5
    elseif love.keyboard.isDown("d") then movePlayer("right") timeToMove = 0.5
    elseif love.keyboard.isDown("a") then movePlayer("left") timeToMove = 0.5
    else timeTomove = 0.1 end
  end

  local pls = 64*dt
  if pl.x > world[pl.t].x then pl.x = pl.x - pls end
  if pl.x < world[pl.t].x then pl.x = pl.x + pls end
  if pl.y > world[pl.t].y then pl.y = pl.y - pls end
  if pl.y < world[pl.t].y then pl.y = pl.y + pls end
  if distanceFrom(pl.x,pl.y,world[pl.t].x,world[pl.t].y) < 0.2 or distanceFrom(pl.x,pl.y,world[pl.t].x,world[pl.t].y) > 64 then pl.x = world[pl.t].x pl.y = world[pl.t].y end
  centerCamera()

  updatePlayers(dt)
end

function movePlayer(dir)
--  local valid_node_func = function ( node, neighbor )
------    return true
--  end

--  if pl.t then
--    if world[et].collide == false then
--      moveQueue = atComma(findPath(pl.t,et))
    --  moveQueue = astar.path(world[pl.t],world[et],world,valid_node_func)
  --    for i, node in ipairs ( moveQueue ) do
		       -- love.window.showMessageBox("Debug","Step " .. i .. " >> " ..node, "error")
	--     end
  --  else
--        love.window.showMessageBox("Debug","You can't move over a solid tile!", "error")
--    end
--  end

  netSend("move", pl.name..","..dir)
  requestUserInfo()

  --perform on client side pre-confirmation to make things smoother
  if dir == "up" then pl.t = pl.t - 101
  elseif dir == "down" then pl.t = pl.t + 101
  elseif dir == "left" then pl.t = pl.t - 1
  elseif dir == "right" then pl.t = pl.t + 1 end
  addFog(pl.t)

  createWorldCanvas()
end
