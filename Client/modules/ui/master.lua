--This is the master UI file where all UI modules will be setup and updated. This file WILL be messy, but it'll save a tremendous amount of mess in other files.
require "modules/ui/loot"
require "modules/ui/item"
require "modules/ui/speak"
require "modules/ui/inventory"
require "modules/ui/xp"
require "modules/ui/character"

function drawUI(dt) --TODO: find out what is causing this to draw things strangely (to do with zooming or resolution?)
  drawLootBox(realScreenWidth/2-100,realScreenHeight-200)
  drawSpeak(realScreenWidth/2-100, realScreenHeight/2)
end

function updateUI(dt)
  updateLootBox(dt)
  updateSpeak(dt)
  updateXP(dt)
  updateMenu(dt)

  for i = 1, #gameUI do
    if isMouseDown then
      if isMouseOver(gameUI[i].x+gameUI[i].width-16,16,gameUI[i].y,16) and gameUI[i].closeButton then
        gameUI[i].isVisible = false
      elseif cy < gameUI[i].y+12 and cy > gameUI[i].y and cx > gameUI[i].x and cx < gameUI[i].x+gameUI[i].width and gameUI[i].isDrag == false then
        gameUI[i].isDrag = true
        gameUI[i].xoff = gameUI[i].x-cx
      end
    else
      gameUI[i].isDrag = false
    end
    if gameUI[i].isDrag == true then
      gameUI[i].x = cx+gameUI[i].xoff
      gameUI[i].y = cy
    end

    if gameUI[i].x+gameUI[i].width > sw+1 then --avoid leaving boundaries of the window
        gameUI[i].x = sw-gameUI[i].width
    end
    if   gameUI[i].y+gameUI[i].height > sh+1 then
      gameUI[i].y = sh-gameUI[i].height
    end
  end

  updateTT(dt)
  whiteOut = whiteOut - 100*dt --this is a white rectangle displayed above all UI and overworld in case of teleportation
  titleScreen = titleScreen - 200*dt
end
