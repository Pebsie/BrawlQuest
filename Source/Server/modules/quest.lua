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
        pl[name].activeQuests = pl[name].activeQuests..","..i..";"..zone -- add to active quests string for the player
        activeQuests[#activeQuests + 1] = { name = name , t = i , val = 0 , zone=zone } -- insert quest into quest module table
    end

end

function checkQuest(name,tile,zone) -- to be called when a player moves onto a "quest" tile of an active quest

    for i, v in pairs ( activeQuests ) do

        if v.name == name and v.t == tile and v.zone == zone then -- if this is the quest that we're wanting to check

            local q = getQuestInfo( v.t )
            local requirement = atComma( q.requirement , ";" ) -- get necessary quest information
            
            -- check if the quest has been completed
            if v.type == "tile" and tonumber( pl[v.name].tile ) == tonumber( requirement[1] ) and pl[v.name].zone == requirement[2] then

                completeQuest(i)

            elseif v.type == "item" and playerHasItem( name , requirement[1] , tonumber( requirement[2] ) ) then

                completeQuest(i)

            elseif v.type == "deliver" and playerHasItem( name, requirement[1] ) and tonumber( pl[name].t ) == tonumber( requirement[2] ) and pl[name].zone == requirement[3] then

                completeQuest(i)

            end

        end

    end

end

function completeQuest(i)

end

--editor quest format: quest|type (item/tile/deliver)|requireditem;amount/requiredtile;zone;rewardtext/requireditem;tile;zone;rewardtext|reward item;amount;reward item2;amount|quest text|recommended level|thanks text
