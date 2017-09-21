--This is done client side so that the server doesn't slow down, the client does. This trade off is made because we don't want the actions of one player to negatively impact all players.
function findPath(t1,t2) --start tile, end tile
  node = {}
  node.g = {}
  node.h = {}
  node.f = {}
  node.parent = {}
  node.tile = {}
  closed = {t1}
  open = {t1+101,t1-101,t1+1,t1-1}

  tileParent = {t1}

  ct = t1 --current tile
  directions = {}

  local finished = false
  while finished == false do

    if ct == t2 then
      return getDirections(t1,t2)
    else

      for i = 1, #open do --calculate current node values
        k = i
        if not node.tile[i] then --we don't want to reset the values of tiles already calculated
          node.parent[k] = ct
          node.tile[k] = open[i]
          node.g[k] = calculateG(k,ct)
          node.h[k] = calculateH(node.tile[k],t2)
          node.f[k] = node.g[k] + node.h[k]
        --  love.window.showMessageBox("Debug", node.tile[k].." (ct is "..ct..", et is "..t2..")\n"..node.g[k]..", "..node.h[k]..","..node.f[k], "error")
          print(node.g[k]..", "..node.h[k])
        end
      end
      --  love.window.showMessageBox("Debug", node.g[1]..", "..node.h[1]..","..node.f[1], "error")
        --find lowest F value
        curLowF = 1
        for i = 1, #open do
          if node.f[i] < node.f[curLowF] then curLowF = i
          elseif node.f[i] == node.f[curLowF] then
            if node.h[i] < node.h[curLowF] then curLowF = i
            elseif node.h[i] == node.h[curLowF] then
              if math.random(1, 2) == 1 then --this isn't right, probably, but it'll work
                curLowF = i
              end
            end
          end
        end



      tileParent[node.tile[curLowF]] = ct
      closed[node.tile[curLowF]] = true
      ct = node.tile[curLowF]

      table.remove(node.g,curLowF)
      table.remove(node.h,curLowF)
      table.remove(node.f,curLowF)
      table.remove(node.parent,curLowF)
      table.remove(node.tile,curLowF)
      table.remove(open,curLowF)

      open[#open + 1] = ct+1
      open[#open + 1] = ct-1
      open[#open + 1] = ct+101
      open[#open + 1] = ct-101
    end
  --loop back round
  end
end

function getDirections(st,et) --end tile
  local dir = ""

  if st == et or et-st == 1 or et-st == -1 then
    dir = tileParent[et]
  else
    dir = tileParent[et]..","..getDirections(st,tileParent[et])
  end


  return dir
end

function calculateG(i,st) --index,  start tile
  local g = 0
  if i ~= st then
    g = g + 10 + calculateG(node.parent[i],st)
  end
  return g
end

function calculateH(ct,et) --current tile / end tile
  local x = world.x[ct]
  local y = world.y[ct]
  local ex = world.x[et]
  local ey = world.y[et]

  local h = 0

  local finished = false
  while finished == false do
    if x > ex then x = x - 1 elseif x < ex then x = x + 1 end
    h = h + 10
    if x == ex then
      finished = true
    end
  end
  --we're in the right X position, now let's move to the right Y position
  finished = false
  while finished == false do
    if y > ey then y = y - 1 elseif y < ey then y = y + 1 end
    h = h + 10
    if y == ey then
      finished = true
    end
  end
  --done!!
  return h
end
