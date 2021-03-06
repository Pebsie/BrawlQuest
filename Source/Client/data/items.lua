item = {}

function loadItems()
    if love.filesystem.getInfo("items.txt") then
      for line in love.filesystem.lines("items.txt") do
        local itInfo = atComma(line,"=")
        local name = itInfo[2]
        item[name] = {}
        for i = 1, #itInfo, 2 do
         item[name][itInfo[i]] = itInfo[i+1]
        end

        if love.filesystem.getInfo(item[name].imgPath) then
          item[name].img = love.graphics.newImage(item[name].imgPath)
        else
          item[name].img = uiImg["error"]
        end
      end
    end
end


  function downloadItems()
    b, c, h = http.request("http://brawlquest.com/dl/scripts/getItems.php")
    if b then
      love.filesystem.write("items.txt", b)
    end
  end
  