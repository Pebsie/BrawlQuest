function drawQuestWindow(x,y)
    love.graphics.draw(worldImg[world[pl.t].bg],x+32,y,0,2,2)
    love.graphics.draw(worldImg[world[pl.t].tile],x+32,y,0,2,2)
    love.graphics.setColor(150,150,150)
    love.graphics.rectangle("line",x+32,y,64,64)

    if string.sub(world[pl.t].fight,1,5) == "quest" then
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
    end
end

--quest|type (item/tile/deliver)|requireditem;amount/requiredtile;rewardtext/requireditem;tile;rewardtext|reward item;amount;reward item2;amount|quest text|recommended level|thanks text