fs = {}
fs.spawnTime = {}
fs.rewards = {}

--fs["Boar Hunt"] = "Boar;5;Reward;Boar Hide|3|80"
fs["Ghostly Haunting"] = "Ghost;1"--default fight
fs.spawnTime["Ghostly Haunting"] = 0.01
fs.rewards["Ghostly Haunting"] = 100000

fs["Ambush"] = "Guard;3;speak,Guard,Attention!,4;4;speak,Guard,You're probably wondering why you're being sent south of Swordbreak with such a... diverse group of people.,6;6;speak,Guard,12 months ago we sent an expedition - similar to yourselves - to the mountains to try and expand man's domain south.,6;6;speak,Guard,We haven't heard from them since then.,4;4;speak,Guard,So we're being sent to find out exactly what happened and see if we can recover any of our people or assets.,5;5;speak,Tutorial,WELCOME TO BRAWLQUEST! BrawlQuest is a game about fighting hundreds of adversaries with giant sticks.,5;5;speak,Tutorial,Use WASD to move and the arrow keys to attack. You're about to start fighting... good luck!,5;5;speak,Guard,We've got no idea what we're up against here so... be car-,4;4;speak,Savage Wolf,AWOOOOOOOO!,2;2;speak,Guard,W-What was that?,3;3;speak,Guard,WOLF PACK!,2;2;Savage Wolf;3;speak,Guard,These aren't regular wolves... something is off here...,5;5;Savage Wolf;2;Mortus,1;1;speak,Mortus,YOU THERE! Why on earth would you venture to here?,5;5;speak,Mortus,Find my camp to the south if you want to live.,4;4;"
fs.spawnTime["Ambush"] = 3
fs.rewards["Ambush"] = 5

fs["Boar Hunt"] = "Boar;250;Big Boar;10;Boar;50;Big Boar;20;Biggest Boar;5"
fs.spawnTime["Boar Hunt"] = 0.01
fs.rewards["Boar Hunt"] = 10
fs["Wolf Hunt"] = "Wolf;250;Alpha Wolf;1;Mother Wolf;1"
fs.spawnTime["Wolf Hunt"] = 0.01
fs["Wolfpack"] = "Alpha Wolf;sAWOOOO;Wolf;10;Alpha Wolf;1;Reward;Broken Tooth|3|50"
fs.rewards["Wolf Hunt"] = 30

fs["Ancient Humans"] = "Cursed Human;20;Cursed Guard;5;Cursed Human;10;Cursed Guard;10;Cursed King;1"
fs.spawnTime["Ancient Humans"] = 1
fs.rewards["Ancient Humans"] = 2
