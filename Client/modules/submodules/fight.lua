----What interface elements do we need during a fight?
-- * My player INFO (HP/XP/Spell 1/Spell 2/ATK/DEF)
-- * Fight INFO (XP pool/Gold pool/Enemies remaining/Amount of players VS player cap)
----What gameplay elements do we need during a fight?
-- * All player info (X,Y,Armour,HP)
-- * All spell info (X,Y,Type)
-- * All mob info (X,Y,Type,HP)
----What does the client then need to receive from the server with each update?
-- * Number of players, mobs and spells in fight
-- * Player X,Y,Armour and HP
-- * Spell X,Y and type
-- * Mob X,Y,Type and HP
----NOTE: My player info will be requested with each update. This will be displayed on the UI, but for the sake of accuracy we'll use server side player movement (at least for testing)

updateFightTime = 0.2

fight = {}

function drawFight()
  love.graphics.setBackgroundColor(0,0,0)
  love.graphics.print("FIGHT!")
end

function requestFightInfo()
  netSend("fight",pl.name)
end

function updateFight(dt)
  updateFightTime = updateFightTime - 1*dt

  if updateFightTime < 0 then
    requestFightInfo()
    requestUserInfo()
    updateFightTime = 0.2
  end
end
