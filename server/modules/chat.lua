chat = {}

function updateChat(dt)
  for i = 1, #chat do
    chat[i].broadcastTime = chat[i].broadcastTime - 1*dt
  end
end

function countChats() --returns a number of chats that are still being broadcast
  local c = 0
  for i = 1, #chat do
    if chat[i].broadcastTime > 0 then
      c = c + 1
    end
  end

  return c
end

function getChats() --returns table with chats still being broadcast
  local c = {}

  for i = 1, #chat do
    if chat[i].broadcastTime > 0 then
      c[#c+1] = chat[i]
    end
  end

  return c
end

function addChatMsg(sender,msg)
  if sender and msg then
    local i = #chat + 1
    chat[i] = {}
    chat[i].sender = sender
    chat[i].msg = msg
    chat[i].id = love.math.random(1,99999)
    chat[i].broadcastTime = 10
    addMsg(sender..": "..msg)
  end
end
