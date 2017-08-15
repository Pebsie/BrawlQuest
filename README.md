# love-network
Extremely simple Lua UDP networking based on the LOVE Wiki guide. Made this for myself to save time later but thought I'd keep it so as to possibly help others. You'll need a basic understanding of Lua to use this, obviously. I've just removed all of the stuff that everyone has to fill out to use socket.
## Usage
### Client
Include `require "client"` at the top of your code. In love.load() put put `netConnect(address, port, updaterate)` with your server's address, port and your updaterate of choice. 0.1 is usually a good shout. In love.update(dt) put `netUpdate(dt)`. Whenever you want to send a message use `netSend(cmd,var1,var2)`. CMD is the command you want to execute (which must be set up on the server), var1 is what the data is that you want to send and var2 is more data to send (this parameter is optional).<br>You'll want to modify the netUpdate function in client.lua to do stuff with the data it receives from the server.
### Server
Add your game's variables and what not. Add responses to commands where it says. Change the second parameter at `udp:setsockname("*", 26656)` to the port you're using. Add game behaviour where it says.
