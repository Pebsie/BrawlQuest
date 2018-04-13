bones = {}
bonesDone = {}


function addBones(mobType, x, y, amount,bid)
  local canCreate = true
  if bid then
    if bonesDone[bid] == true then
      canCreate = false
    end
  end

  if canCreate then
    if not amount then amount = 32 end

    for i = #bones+1, #bones+amount do
      bones[i] = {}
      bones[i].x = x + love.math.random(1, 32)
      bones[i].y = y + love.math.random(1, 32)
      bones[i].xv = love.math.random(-100, 100)
      bones[i].yv = love.math.random(-100, 100)
      bones[i].t = mobType
      bones[i].rotation = love.math.random(1, 360)
      bones[i].a = 255
      if bid then
        bonesDone[bid] = true
      end
    end
  end
end

function drawBones()
  for i = 1, #bones do
    if bones[i].a > 1 then
      love.graphics.setColor(255,255,255,bones[i].a)
      if bones[i].t == "Player" then
        love.graphics.setColor(100,0,0,bones[i].a)
        love.graphics.rectangle("line",bones[i].x+xoff,bones[i].y+yoff,2,2)
      else
        love.graphics.draw(mb.img[bones[i].t], bones[i].x+xoff, bones[i].y+yoff, math.rad(bones[i].rotation), 0.25, 0.25)
      end
    end
  end

  love.graphics.setColor(255,255,255,255)--reset colour
end

function updateBones(dt)
  for i = 1, #bones do
    bones[i].x = bones[i].x + bones[i].xv*dt
    bones[i].y = bones[i].y + bones[i].yv*dt

    local resist = 128*dt

    if bones[i].xv ~= 0 then
      if bones[i].xv > 2 then bones[i].xv = bones[i].xv - resist
      elseif bones[i].xv < -2 then bones[i].xv = bones[i].xv + resist
      else bones[i].xv = 0 end
    end

    if bones[i].yv ~= 0 then
      if bones[i].yv > 2 then bones[i].yv = bones[i].yv - resist
      elseif bones[i].yv < -2 then bones[i].yv = bones[i].yv + resist
      else bones[i].yv = 0 end
    end

    if bones[i].t ~= "Player" then
      bones[i].a = bones[i].a - 50*dt
      if bones[i].a < 0 and #bones > 1 then
        bones[i] = bones[#bones]
        bones[i].x = bones[#bones].x
        bones[i].y = bones[#bones].y
        bones[i].rotation = bones[#bones].rotation
        bones[i].xv = bones[#bones].xv
        bones[i].yv = bones[#bones].yv
        bones[i].a = bones[#bones].a
        bones[i].t = bones[#bones].t
      end

    elseif #bones == 1 then
      bones = {}
    end
  --  bones[i].rotation = bones[i].rotation + bones[i].xv
  end
end
