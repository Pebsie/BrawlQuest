toboolean = require "libraries/toboolean"

function atComma(str, md)
  if not md then md = "," end
	local word = {}
	local thisWord = 1
	for wordd in string.gmatch(str, '([^'..md..']+)') do
    	word[thisWord] = wordd
    	thisWord = thisWord + 1
    end

    return word
end

function round(x)
  if x%2 ~= 0.5 then
    return math.floor(x+0.5)
  end
  return x-0.5
end

function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end

function isMouseOver(xpos, width, ypos, height)
  if cx > xpos and cx < xpos+width and cy > ypos and cy < ypos+height then
    return true
  else
    return false
  end
end


local oldSetColor = love.graphics.setColor
 love.graphics.setColor = function (r, g, b, a)
   if type(r)=="table" then
       g = r[2] / 255
       b = r[3] / 255
       a = (r[4] or 255) / 255
       r = r[1] / 255
   else
     r = r / 255
     g = g / 255
     b = b / 255
     a = (a or 255) / 255
   end
   oldSetColor(r,g,b,a)
 end

 local oldSetBackgroundColor = love.graphics.setBackgroundColor
 love.graphics.setBackgroundColor = function (r, g, b, a)
   if type(r)=="table" then
       g = r[2] / 255
       b = r[3] / 255
       a = (r[4] or 255) / 255
       r = r[1] / 255
   else
     r = r / 255
     g = g / 255
     b = b / 255
     a = (a or 255) / 255
   end
   oldSetBackgroundColor(r,g,b,a)
 end

function love.errorhandler(msg)
  msg = tostring(msg)

  netSend("error",pl.name.."::"..msg)
  love.filesystem.write("errorlog-"..os.time()..".txt","BrawlQuest encountered an error and had to close!\n\nWe've reported the error and the dev team will work on it. Relaunch the game and things should be okay!\n\n"..msg)

  love.window.setFullscreen(false) --this is necessary so that the error message is visible on Windows
  love.window.showMessageBox("ERROR!","BrawlQuest encountered an error and had to close!\n\nWe've reported the error and the dev team will work on it. Relaunch the game and things should be okay!\n\n"..msg)
end
