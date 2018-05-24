--This is the master UI file where all UI modules will be setup and updated. This file WILL be messy, but it'll save a tremendous amount of mess in other files.
require "modules/ui/loot"
require "modules/ui/item"
require "modules/ui/speak"

function drawUI(dt)
  drawLootBox(realScreenWidth/2-100,realScreenHeight-200)
  drawSpeak(realScreenWidth/2-100, realScreenHeight/2)
end

function updateUI(dt)
  updateLootBox(dt)
  updateSpeak(dt)
end
