tutorial = {
  overworld = "WELCOME TO BRAWLQUEST!\n\nThere are mysteries to be uncovered and evil forces to be stopped, but first we have to teach you how to walk.\n\nUse W,A,S and D to move around the overworld.",
  npc = "Walk onto NPC's to hear what they have to say. This may provide clues on what to do next, locations of secrets or ask you to complete tasks for them in exchange for experience, gold and loot!",
  fight = "You're in a fight!\n\nUse W,A,S and D to move around and the arrow keys to attack!\n\nAttacking reduces your energy which is restored gradually over time.",
  death = "When you die you'll respawn at whichever graveyard you last prayed.\n\nTo pray at a graveyard and set your spawn point, walk over a Gravestone tile and click 'Pray' on the window that appears.",
  crafting = "You can craft gear at an Anvil. Each item has a crafting recipe that requires several items. Look around for natural resources that you can harvest. You can also pickup new recipes by being victorious in battle!",
  potion = "You've equipped a potion!\n\nPress R in a fight or in the overworld to use it.",
  hp = "You're low on health!\n\nReturn to a bar or church and your health will regen.\n\nIf you run out of health then you'll die and awake at the last graveyard you prayed but your armour will be damaged."
}

tutorialDone = {}

tutorialContent = ""

function loadTutorial()
  if love.filesystem.getInfo("tutorial.txt") then
    for line in love.filesystem.lines("tutorial.txt") do
      tutorialDone[line] = true
    end
  end
end

function saveTutorial()
  local msg = ""
  for i, v in pairs(tutorialDone) do
    msg = msg..i.."\n"
  end
  love.filesystem.write("tutorial.txt",msg)
end

function updateTutorial()
  --NOTE: these triggers are for the Shipwrecked map and MUST be changed before we move into beta
  if pl.state == "world" then
    triggerTutorial("overworld")
  end
  if pl.state == "fight" then
    triggerTutorial("fight")
  end
  if pl.pot ~= "None" then
    triggerTutorial("potion")
  end
  if world[pl.t] and world[pl.t].tile == "Anvil" then
    triggerTutorial("crafting")
  end
end

function triggerTutorial(tutorialSection)
  if gameUI[8] and not tutorialDone[tutorialSection] then --if the player hasn't already received this tutorial
    gameUI[8].isVisible = true
    tutorialContent = tutorial[tutorialSection]
    tutorialDone[tutorialSection] = true
    saveTutorial()
  end
end
