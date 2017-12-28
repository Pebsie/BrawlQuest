--This is the master UI file where all UI modules will be setup and updated. This file WILL be messy, but it'll save a tremendous amount of mess in other files.
require "modules/ui/loot"
require "modules/ui/item"

function updateUI(dt)
  updateLootBox(dt)
end
