-- load the ftp support
local ftp = require("socket.ftp")
local chars = {}

--This file uploads character info to the server!
function uploadCharacter(name)
  local dayString = "never"

  if pl.lastLogin[name] == 0 then dayString = "today" elseif pl.lastLogin[name] == 1 then dayString = "yesterday" else dayString = pl.lastLogin[name].." days ago" end

  filestring = '<html><head><style>image-rendering: pixelated;</style></head><center><h1>'..name..'</h1><img src="http://brawlquest.com/dl/img/human/'..pl.arm[name]..'.png" width="256" height="256"><br /><h2>Level 10</h2><h2>Gear</h2><img src="http://brawlquest.com/dl/img/items/weapons/'..pl.wep[name]..'.png" width="32" height="32">'..pl.wep[name]..' - <em>'..item.val[pl.wep[name]]..'+'..pl.str[name]..' <b>ATK</b></em><br /><img src="http://brawlquest.com/dl/img/human/'..pl.arm[name]..'.png">'..pl.arm[name].." - <em>"..item.val[pl.arm[name]]..' <b>DEF</b></em><br /><h2>Stats</h2><b>Playtime: </b>'..round(pl.playtime[name]/60, 0).."m<br /><b>Kills: </b>"..pl.kills[name].."<br /><b>Deaths: </b>"..pl.deaths[name].."<br /><b>Distance travelled: </b>"..pl.distance[name].."m<<br /><b>Last login:</b> "..dayString.."</html>"

-- Log as user "fulano" on server "ftp.example.com",
-- using password "silva", and store a file "README" with contents
-- "wrong password, of course"
--f, e = ftp.put("ftp://server:brawlquestserver@ftp.brawlquest.com/char/"..name..".html",filestring)

    local fp = "char/"..name..".html"
    love.filesystem.write(fp, filestring)

    chars[#chars + 1] = name
end

function outputCharacterList()
  filestring = "<h1>Characters</h1><ul>"
  for i = 1, #chars do
    filestring = filestring.."<li><a href='"..chars[i]..".html'>"..chars[i].."</a></li>"
  end
  filestring = filestring.."</ul>"

  love.filesystem.write("char/index.html", filestring)

  chars = {}
end
