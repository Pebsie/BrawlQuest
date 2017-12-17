
spells = {}
spellId = {}

function newSpell(type,animName)
  i = #spells + 1
  spells[i] = newAnimation(love.graphics.newImage("img/spell/"..animName..".png"),31,32,0.75)
  spellId[type] = i
end

function updateSpells(dt)
  for i = 1, #spells do
    animation = spells[i]
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end

    spells[i] = animation
  end
end

function drawSpell(type,x,y)
    local i = spellId[type]

    if i then
      animation = spells[i]
      local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
      love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], x, y, 0, 2, 2, 9, 8)
    end
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

newSpell("Weak Red Potion","heal")
newSpell("Red Potion","heal")
newSpell("Weak Healing Potion","heal")
newSpell("Healing Potion","heal")
newSpell("Potent Healing Potion","heal")
newSpell("Second Wind","white-vortex")
newSpell("Tornado","black-vortex")
newSpell("Recovery","cross-skull")
newSpell("Slam","orange-burst")
newSpell("Rend","blood")
newSpell("Grace","green-burst")
newSpell("Flash of Light","yellow-stars")
newSpell("Enrage","green-skull")
newSpell("Phase Shift","shield")
newSpell("Polymorph","web")
