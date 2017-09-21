require "modules/submodules/pathfinding"

mx = 0
my = 0

gameUI = {}
gameUI.x = {}
gameUI.y = {}
gameUI.isDrag = {}

function drawGame()
  if ui.selected == "map" then
    drawOverworld()
  end
end

function updateGame(dt)
  updateGameUI(dt,"char")
  updateGameUI(dt,"deb")
end
