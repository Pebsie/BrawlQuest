function drawQuestWindow(x,y)
    love.graphics.draw(worldImg[world[pl.t].bg],x+32,y,0,2,2)
    love.graphics.draw(worldImg[world[pl.t].tile],x+32,y,0,2,2)
    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",x+32,y,64,64)

    if string.sub(world[pl.t].fight,1,5) == "quest" and not hasPlayerCompletedQuest(pl.t,pl.zone) then
        local word = atComma(world[pl.t].fight,"|")
        love.graphics.setFont(sFont)
        love.graphics.setColor(255,255,255)
        love.graphics.printf(word[5],x,y+64,128,"left")

        love.graphics.setColor(50,50,50)
        love.graphics.rectangle("fill",x,y+160,128,128)
        love.graphics.setColor(255,255,255)
        love.graphics.setFont(font)
        love.graphics.printf("Task",x,y+160,128,"center")
        local taskMsg = ""
        if word[2] == "item" then
            taskMsg = "Acquire "
            local itemReq = atComma(word[3],";")
            for i = 1, #itemReq, 2 do
                taskMsg = taskMsg..itemReq[i+1].."x "..itemReq[i]
                if (#itemReq - i) > 1 then
                    taskMsg = taskMsg..", "
                end
            end
        elseif word[2] == "tile" then
            local questReq = atComma(word[3],";")
            taskMsg = "Travel to "..world[tonumber(questReq[1])].name
        elseif word[2] == "deliver" then
            local itemReq = atComma(word[3],";")
            taskMsg = "Deliver "..itemReq[1].." to "..world[tonumber(itemReq[2])].name
        end
        
        love.graphics.setFont(sFont)
        love.graphics.printf(taskMsg,x,y+160+font:getHeight(),128,"left")

        love.graphics.setFont(font)
        love.graphics.printf("Reward",x,y+200,128,"center")
        local reward = atComma(word[4],";")
        for i = 1, #reward, 2 do
            drawItem(reward[i],reward[i+1],x+32*i/2 - 16,y+200+font:getHeight())
        end

        if drawButton("Accept",x,y+200+font:getHeight()+32,gameUI[10].width,font:getHeight()) then
            netSend("questAccept",pl.name)
          --  pl.activeQuests = pl.activeQuests..","..pl.t    
        end
    elseif string.sub(world[pl.t].fight,1,5) == "quest" and hasPlayerCompletedQuest(pl.t,pl.zone) == "active" then
        local taskMsg = ""
        local word = atComma(world[pl.t].fight,"|")

        finishedQuest = true

        if word[2] == "item" then
            taskMsg = "Acquired "
            local itemReq = atComma(word[3],";")
            for i = 1, #itemReq, 2 do
                taskMsg = taskMsg..itemReq[i+1].."x "..itemReq[i]

                if playerHasItem( itemReq[i] , tonumber( itemReq[i+1] ) ) == false then
                    finishedQuest = false
                end

                if (#itemReq - i) > 1 then
                    taskMsg = taskMsg..", "
                end
            end
        elseif word[2] == "tile" then
            local questReq = atComma(word[3],";")
            taskMsg = "Traveled to "..world[tonumber(questReq[1])].name
            finishedQuest = false
        elseif word[2] == "deliver" then
            local itemReq = atComma(word[3],";")
            taskMsg = "Delivered "..itemReq[1].." to "..world[tonumber(itemReq[2])].name
            finishedQuest = false
        end
        love.graphics.setColor(255,255,255)
        love.graphics.setFont(sFont)
        love.graphics.printf(taskMsg.." yet?",x,y+64,gameUI[10].width,"left")

        if finishedQuest then
            if drawButton("Complete Quest",x,y+200+font:getHeight()+32,gameUI[10].width,font:getHeight()) then
                netSend("questFinish",pl.name)
              --  pl.activeQuests = pl.activeQuests..","..pl.t    
            end
        end
    end  
end

function getQuestInfo( i )
    local questInfo = atComma( world[zone][i].fight , "|" ) -- extract quest information from the tile

    return { type=questInfo[2] , requirement=questInfo[3] , reward=questInfo[4] }
end


function hasPlayerCompletedQuest(tile,zone)
    if not zone then zone = pl.zone end
    local completeQuests = atComma(pl.completedQuests)
  
    for i = 1, #completeQuests,2 do
      if tonumber(completeQuests[i]) == tonumber(tile) and zone == completeQuests[i+1] then
        return "completed"
      end
    end
  
    local activeQuests = atComma(pl.activeQuests)
    for i = 1, #activeQuests,2 do
      if tonumber(activeQuests[i]) == tonumber(tile) and zone == activeQuests[i+1] then
        return "active"
      end
    end
  
    return false
  end
  
--quest|type (item/tile/deliver)|requireditem;amount/requiredtile;rewardtext/requireditem;tile;rewardtext|reward item;amount;reward item2;amount|quest text|recommended level|thanks text