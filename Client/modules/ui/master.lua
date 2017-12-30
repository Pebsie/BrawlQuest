--This is the master UI file where all UI modules will be setup and updated. This file WILL be messy, but it'll save a tremendous amount of mess in other files.
require "modules/ui/loot"
require "modules/ui/item"

function drawUI(dt)
  drawLootBox(sw/2-100,(sh/3)*2-(72/2))
end

function updateUI(dt)
  updateLootBox(dt)
end
