--[[
    BRAWL - QUEST SYSTEM
    Beta v1 (26/10/2018)

    This file contains a load of tools to make quests function server-side.
    There's a good chance that this will be converted to NOT be done by the realm server but by the database.
    For beta this works fine.

    FUNCTIONS:
        getQuestInfo(tile,zone) -- Returns a table with the following: {type=item/tile/deliver,requirement=reqString,reward=rewString}
        newQuest(name,tile,zone) -- Assign a player a quest (if they are not already on this quest!)
        checkQuest(name,tile,zone) -- Check if a quest's requirements have been met
        completeQuest(questID) -- Gives the rewards of the quest questID and all
]]

activeQuests = {} -- format: v.name = player name, v.t = quest tile, v.val = associated value, v.done = true or false

function getQuestInfo( i, zone )
    local questInfo = atComma( world[zone][i].fight , "|" ) -- extract quest information from the tile

    return { type=questInfo[2] , requirement=questInfo[3] , reward=questInfo[4] }
end

function newQuest(name,i,zone)

    if not hasPlayerCompletedQuest( name , i , zone ) then -- check if player is already on this quest or has already completed this quest
        pl[name].activeQuests = pl[name].activeQuests..i..","..zone.."," -- add to active quests string for the player
        activeQuests[#activeQuests + 1] = { name = name , t = i , val = 0 , zone=zone } -- insert quest into quest module table
        addMsg(name.." has embarked on quest "..i.." in zone "..zone.."! "..pl[name].activeQuests)
    end

end

function checkQuest(name,tile,zone) -- to be called when a player moves onto a "quest" tile of an active quest
    --addMsg("Checking quest "..name.."::"..tile.."::"..zone)
    for i, v in pairs ( activeQuests ) do

        if v.name == name and v.t == tile and v.zone == zone and not v.done then -- if this is the quest that we're wanting to check
          --  addMsg("Quest located! ID: "..i)
            local q = getQuestInfo( v.t, v.zone )
            local requirement = atComma( q.requirement , ";" ) -- get necessary quest information
            local complete = true -- will switch to false if conditions aren't met
            
            -- check if the quest has been completed
            if q.type == "tile" and tonumber( pl[v.name].tile ) == tonumber( requirement[1] ) and pl[v.name].zone == requirement[2] then

                completeQuest(i)

            elseif q.type == "item" then
                --addMsg("This is an item requirement quest.")
                for i = 1, #requirement, 2 do

                    if not playerHasItem( name , requirement[i] , tonumber( requirement[i+1] ) ) then
                        complete = false
                       -- addMsg("Player does not have "..requirement[i+1].."x "..requirement[i])
                    end

                end

                if complete then
                    completeQuest(i)
                    for i = 1, #requirement, 2 do
                        givePlayerItem( name, requirement[i], -tonumber( requirement[i+1] ) )
                    end
                else
                    addMsg(name.." attempted to check quest "..tile.." in zone "..zone.." but they haven't completed the requirements of that quest.")
                end

            elseif q.type == "deliver" and playerHasItem( name, requirement[1] ) and tonumber( pl[name].t ) == tonumber( requirement[2] ) and pl[name].zone == requirement[3] then

                completeQuest(i)

            end

        end

    end

end

function completeQuest(i)
    addMsg(activeQuests[i].name.." completed quest "..i.."!")

    local q = getQuestInfo(activeQuests[i].t, activeQuests[i].zone)

    local rewards = atComma(q.reward,";")

    for k = 1, #rewards, 2 do
        givePlayerItem(activeQuests[i].name,rewards[k],tonumber(rewards[k+1]))
    end

    activeQuests[i].done = true -- no longer actively check this quest

    local pq = atComma(pl[activeQuests[i].name].activeQuests) -- remove this quest from the player's active quest list
    local npq = "" -- new player active quest list  
    for k = 1, #pq, 2 do
        if tonumber(pq[k]) ~= tonumber(activeQuests[i].t) and pq[k+1] ~= activeQuests[i].zone then
            npq = npq..pq[k]..","..pq[k+1]..","
        end
    end

    pl[activeQuests[i].name].activeQuests = npq
    pl[activeQuests[i].name].completedQuests = pl[activeQuests[i].name].completedQuests..activeQuests[i].t..","..activeQuests[i].zone..","
end

function hasPlayerCompletedQuest(i,quest,zone)
    local completeQuests = atComma(pl[i].completedQuests)
  
    for k = 1, #completeQuests, 2 do
      if tonumber(completeQuests[k]) == tonumber(quest) and completeQuests[k+1] == zone then
        return "completed"
      end
    end
  
    local activeQuests = atComma(pl[i].activeQuests)
    for k = 1, #activeQuests, 2 do
      if tonumber(activeQuests[k]) == tonumber(quest) and activeQuests[k+1] == zone then
        return "active"
      end
    end
    

    return false
end

--editor quest format: quest|type (item/tile/deliver)|requireditem;amount/requiredtile;zone;rewardtext/requireditem;tile;zone;rewardtext|reward item;amount;reward item2;amount|quest text|recommended level|thanks text
