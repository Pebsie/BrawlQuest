--[[
BRAWLQUEST PARTY SYSTEM
by Thomas Lock 6/9/2018

This might be repurposed for the guild system too!

newParty(leader) - creates a new party with leader leader
inviteMemberToParty(inviter,invited) - Checks what party inviter is in and then creates an invite for invited if invited isn't already in a party. Returns "invited" or "partied" (player is already in a party). If the inviter isn't in a party then a new party is created.
addMemberToParty(inviteId,name) - Adds a player to a party after checking validity of invite ID
findPartyMemberIsIn(name) - Either returns the id of the party that that name is in or false if the member isn't in a party
getPartyInfo(name) - Finds which party name is in and then returns basic info about that party and its players. For format see function.

NOTE: the ID of the party that the player is in is stored as pl[name].party, which is why there is no dedicated index here.
NOTE: if pl[name].party is 0 then they aren't in a party, if it's -1 then they've been invited and haven't yet responded

TODO: make parties save and load (right now player loading is hardcoded to prevent loading in party ID)
TODO: make parties disband if inactive for a long period of time (or at least stop them from loading in)
]]

party = {}
partyInvites = {}

function newParty(leader)
  party[#party + 1] = {members = {leader}, exclusive = false}
  pl[leader].party = #party
end

function inviteMemberToParty(inviter,invited)
  local inviterPartyID = 0

  if not findPartyMemberIsIn(inviter) then newParty(inviter) inviterPartyID = #party --if the inviter isn't already in a party then set a new one up, otherwise find the ID of the party that they are in
  else inviterPartyID = findPartyMemberIsIn(inviter) end

  if findPartyMemberIsIn(invited) then
    return "partied"
  else --invite player to party
    partyInvites[invited] = {id = invitePartyID, inviter = inviter, invited = invited}
    pl[invited].party = -1
  end
end

function addMemberToParty(name) --name of member who invited
  if partyInvites[invited] then
    local id = partyInvites[invited].id
    pl[name].party = id
    party[id].members[#party[id].members+1] = name
  else
    addMsg(name.." tried to join a party that they weren't invited to!")
  end
end

function removeMemberFromParty(name)
  local id = findPartyMemberIsIn(name)
  if id then
    local newList = {}
    for i = 1, #party[id].members do
      if party[id].members[i] ~= name then
        newList[#newList+1] = party[id].members[i]
      end
    end

    party[id].members = newList
  end

  pl[name].party = 0

end

function findPartyMemberIsIn(name)
  if pl[name].party == 0 then
    return false
  else
    return pl[name].party
  end
end

function getPartyInfo(name) --returns 'none','invite;inviter name' or 'party;members;member1;hp;en;lvl;arm_head;arm_chest;arm_legs;wep;online;..'
  local id = findPartyMemberIsIn(name)
  if id then
    if id == -1 then
      return "invite;"..partyInvites[name].inviter
    else

      local msgToSend = "party;"..#party[id].members..";"
      for i,v in pairs(party[id].members) do --cycle through all party members
        msgToSend = msgToSend..v..";"..pl[v].hp..";"..pl[v].en..";"..pl[v].lvl..";"..pl[v].arm_head..";"..pl[v].arm_chest..";"..pl[v].arm_legs..";"..pl[v].wep..";"..tostring(pl[v].online)..";"
      end

    end
  else
    return "none"
  end
end

function handlePartyRequest(parms) --network commands
  param = atComma(parms)
  local name = param[1]
  local cmd = param[2]
  local target = param[3]

  if not cmd then
    udp:sendto(name.." partyInfo "..getPartyInfo(name),msg_or_ip,port_or_nil)
  elseif cmd == "invite" then
    inviteMemberToParty(name,target)
  elseif cmd == "accept" then
    addMemberToParty(name)
  elseif cmd == "leave" then
    removeMemberFromParty(name)
  end
end
