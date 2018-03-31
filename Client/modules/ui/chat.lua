chat = {}
chatPosition = 0

function newChatMsg(sender,message,id)
  local haveMessage = false --do we already have this chat message? based on id

  for i = 1, #chat do
    if chat[i].id == id then haveMessage = true end --we already have this message!
  end

  if haveMessage == false then
    local i = #chat + 1
    chat[i] = {}
    chat[i].sender = sender
    chat[i].msg = message
    chat[i].id = id
    chatPosition = i
  end
end

function sendChat(chatToSend)
  --TODO: send chat messages
  netSend("chat", pl.name..","..pl.cinput)
--  newChatMsg(pl.name,pl.cinput,love.math.random(10000,999999))
end

function drawChat(x,y,width,height)
  love.graphics.setColor(41,41,41)
  love.graphics.rectangle("fill",x,y,width,height)

  love.graphics.setFont(sFont)
  local chatOutput = ""

  for i = chatPosition-6, chatPosition do --display the last 5 messages
    if chat[i] then
      chatOutput = chatOutput..chat[i].sender..": "..chat[i].msg
    end
    chatOutput = chatOutput.."\n"
  end

  if ui.selected == "chat" then

    while (sFont:getWidth(pl.name..": "..pl.cinput) > width) do
      pl.cinput = string.sub(pl.cinput,1,string.len(pl.cinput)-1)
    end

    chatOutput = chatOutput..pl.cinput.."|"
  else
    chatOutput = chatOutput.."Press enter to chat..."
  end

  love.graphics.setColor(255,255,255)
  love.graphics.printf(chatOutput,x,y,width,"left")
end
