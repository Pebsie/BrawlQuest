fs = {}
fs.spawnTime = {}
fs.rewards = {} --item,amount,percentage chance

--fs["Boar Hunt"] = "Boar;5;Reward;Boar Hide|3|80"
fs["Ghostly Haunting"] = "Ghost;1"--default fight
fs.spawnTime["Ghostly Haunting"] = 0.01
fs.rewards["Ghostly Haunting"] = 100000

fs["Ambush"] = "Adventurer;3;Guard;2;speak,Guard,Attention!,4;4;speak,Guard,You're probably wondering why you're being sent south of Swordbreak with such a... diverse group of people.,6;6;speak,Guard,12 months ago we sent an expedition - similar to yourselves - to the mountains to try and expand man's domain south.,6;6;speak,Guard,We haven't heard from them since then.,4;4;speak,Guard,So we're being sent to find out exactly what happened and see if we can recover any of our people or assets.,5;5;speak,Tutorial,WELCOME TO BRAWLQUEST! BrawlQuest is a game about fighting hundreds of adversaries with giant sticks.,5;5;speak,Tutorial,Use WASD to move and the arrow keys to attack. You're about to start fighting... good luck!,5;5;speak,Guard,We've got no idea what we're up against here so... be car-,4;4;speak,Savage Wolf,AWOOOOOOOO!,2;2;speak,Guard,W-What was that?,3;3;speak,Guard,WOLF PACK!,2;2;Savage Wolf;3;speak,Guard,These aren't regular wolves... something is off here...,5;5;Savage Wolf;4;Mortus;1;speak,Mortus,YOU THERE! Why on earth would you venture to here?,5;5;speak,Mortus,Find my camp to the south if you want to live.,4;4;"
fs.spawnTime["Ambush"] = 1
fs.rewards["Ambush"] = "Gold,5,100,Dog,1,25"

fs["Camp"] = "Adventurer;5;Guard;1;Mortus;1;speak,Mortus,I'm glad that at least some of you made it.,3;3;speak,Guard,What on earth happened here?,3;3;speak,Mortus,It's a long and sad tale.,2;2;speak,Mortus,Centuries ago - when Swordbreak was first established - our ancestors tried expanding here.,6;6;speak,Mortus,A terrible curse lies over this place: it infects everything and everyone who enters.,5;5;speak,Guard,A curse?,2;2;speak,Mortus,The dead rise again as unendingly hungry Savages. You've seen it in those Wolves already.,5;5;speak,Mortus,And now that you've entered these mountains... you're infected too.,4;4;speak,Adventurer,There must be SOMETHING that can be done?,4;4;speak,Mortus,We've tried everything. The 6 of us at this camp are all that remain.,4;4;speak,Mortus,At first we investigated but now we can do nothing but protect eachother against the onslaught of Savage beasts from the south.,6;6;speak,Mortus,The other warriors are long dead... I am all that remains,3;3;speak,Guard,What did you find?,3;3;speak,Mortus,A great Sorcerer is behind all of this. His lair lies south in the White Forest.,4;4;speak,Mortus,The old tribe created fortifications to the East. We haven't been able to investigate there yet either.,4;4;speak,Guard,I would go myself but... I am too injured,3;3;speak,Adventurer,Then I will go!,3;3;speak,Mortus,...,2;2;speak,Mortus,Forgive me but you are no warrior.,3;3;speak,Adventurer,But I am our only hope... all of our last hope.,4;4;speak,Mortus,Then so be it. Head East. See if those ancient souls found anything before their demise.,6;6;speak,Guard,Adventurer. It would be dangerous to go alone. Please take my sword.,4;4;speak,Mortus,Good luck. Our fate rests on you alone.,3;3"
fs.spawnTime["Camp"] = 0.1
fs.rewards["Camp"] = "Short Sword,1,100"

fs["Boar Hunt"] = "Boar;250;Big Boar;10;Boar;50;Big Boar;20;Biggest Boar;5"
fs.spawnTime["Boar Hunt"] = 0.01
fs.rewards["Boar Hunt"] = 10

fs["Wolf Hunt"] = "Wolf;250;Alpha Wolf;1;Mother Wolf;1"
fs.spawnTime["Wolf Hunt"] = 0.01
fs["Wolfpack"] = "Alpha Wolf;sAWOOOO;Wolf;10;Alpha Wolf;1;Reward;Broken Tooth|3|50"
fs.rewards["Wolf Hunt"] = "Gold,30"

fs["Ancient Humans"] = "Cursed Human;20;Cursed Guard;5;Cursed Human;10;Cursed Guard;10;Cursed King;1"
fs.spawnTime["Ancient Humans"] = 1
fs.rewards["Ancient Humans"] = "Gold,2,100,Snake,1,5,Crypt Key,1,15"

fs["The Crypt"] = "Cursed Human;30;Cursed Guard;15;Cursed King;2"
fs.spawnTime["The Crypt"] = 0.25
fs.rewards["The Crypt"] = "Gold,4,100,Gold,6,50,Snake,1,25"

fs["Adver Mine"] = "Savage Bat;30;Cursed Human;20;Savage Bat;40;Cursed Miner;10"
fs.spawnTime["Adver Mine"] = 0.5
fs.rewards["Adver Mine"] = "Gold,20,100,Adver,1,90,Baby Bat,1,50"

fs["Savage Creatures"] = "speak,Sorcerer,Who DARES enter my forest? Feast my beautiful eternal creations!,3;3;Savage Wolf;5;Savage Bat;10;Savage Bear;5;Savage Hydra;2;speak,Savage Golem,UGHHHHHHH,2;2;Savage Golem;1"
fs.spawnTime["Savage Creatures"] = 1
fs.rewards["Savage Creatures"] = "Gold,35,100,Adver,5,90,Adver,2,50,Fire Elementling,1,10,Water Elementling,1,10"
