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

function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end

function round(num, idp) local mult = 10^(idp or 0) return math.floor(num * mult + 0.5) / mult end

function love.graphics.newImage(one,two)
  --to stop dumb errors
end
