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

fs["Ancient Secrets"] = "speak,Adventurer,You open the chest to find a note detailing a rounded object made of some precious stone.,4;4;speak,Adventurer,'Adver: the sorcerers only known weakness.',3;3;speak,Adventurer,'A precious jewel found in large quantities in the mountain range south of our village.',5;5;speak,Adventurer,'We have started a mine but the further south we go the closer we come to his lair. It is not safe.',4;4;speak,Adventurer,'What little Adver we can carry back to the village doesn't stop the onslaught of his Savage creatures.',5;5;speak,Adventurer,'My hope is that whoever finds this can learn something of it and end this terrible curse.',4;4;Mortus;1;speak,Mortus,Adventurer! You've done well.,3;3;speak,Mortus,You've bought me enough time for the short walk here. I am already hugely grateful to you.,4;4;speak,Adventurer,*You hand her the note*,2;2;speak,Mortus,Adver? Interesting. Once again I must protect the camp. My free time is limited and almost up.,4;4;speak,Mortus,You will have to continue this quest without my assistance. I am sorry.,5;5;speak,Mortus,The Guard is still recovering but wants in on the fight as soon as possible.,4;4;speak,Cursed King,GGGEEEETTT AWAAAAAAAYYYY,2;2;speak,Mortus,That can't be good...,3;3;Cursed King;5"
fs.spawnTime["Ancient Secrets"] = 1
fs.rewards["Ancient Secrets"] = "Gold,5,100,Crypt Key,1,25"

fs["The Crypt"] = "Cursed Human;30;Cursed Guard;15;Cursed King;2"
fs.spawnTime["The Crypt"] = 0.25
fs.rewards["The Crypt"] = "Gold,4,100,Gold,6,50,Snake,1,25"

fs["Adver Mine"] = "Savage Bat;30;Cursed Human;20;Savage Bat;40;Cursed Miner;10"
fs.spawnTime["Adver Mine"] = 0.5
fs.rewards["Adver Mine"] = "Gold,20,100,Adver,1,90,Baby Bat,1,50"

fs["Savage Creatures"] = "speak,Sorcerer,Who DARES enter my forest? Feast my beautiful eternal creations!,3;3;Savage Bear;10;Savage Hydra;5;Savage Bear;3;Savage Golem;1;Savage Hydra;2;Savage Golem;2"
fs.spawnTime["Savage Creatures"] = 1
fs.rewards["Savage Creatures"] = "Gold,35,100,Adver,5,90,Fire Elementling,1,10,Earth Elementling,1,10"

fs["Prison"] = "Mortus;1;speak,Mortus,The Adver that you obtained is now able to protect our camp indefinitely. I cannot thank you enough.,5;5;speak,Mortus,Now we must set our sights to ending the Sorcerer's reign for good and ending this terrible curse,5;5;speak,Mortus,We are joined by your friends.,3;3;Adventurer;5;Guard;2;speak,Guard,I am sorry for doubting you friend.,2;2;speak,Mortus,This is the Sorcerer's prison... and my blacksmith tells me that it holds a more concentrated type of Adver: Quia.,4;4;speak,Mortus,It also holds a series of terrible beasts that are protecting those crystals: and possibly the key to the sorcerers lair itself.,4;4;speak,Mortus,If we can't kill these beasts and acquire this Quia then we stand no chance against the Sorcerer.,4;4;speak,Guard,We know what we need to do.,3;3;speak,Mortus,Hang on... what's that noise?,3;3;speak,Guard,...,2;2;Savage Golem;1;speak,Mortus,It begins...,3;3;Savage Golem;20"
fs.spawnTime["Prison"] = 1
fs.rewards["Prison"] = "Gold,50,100,Quia,10,100"

fs["Savage Giant"] = "Mortus;1;Guard;2;speak,Mortus,We lost many to those Golems...,3;3;speak,Mortus,But after seeing you all I couldn't tell them no. They were inspired. They died as heroes.,5;5;speak,Guard,So what's next?,3;3;speak,Mortus,We are about to be graced by the presence of another Savage. A giant.,4;4;speak,Mortus,He was once the protector of these mountains and was the first to be slain by the Sorcerer. Now he does his bidding here.,5;5;Savage Giant;1"
fs.spawnTime["Savage Giant"] = 2
fs.rewards["Savage Giant"] = "Gold,75,100,Quia,40,100"

fs["Hydra"] = "Guard;1;Mortus;1;speak,Mortus,The Hydra fought the sorcerer for supremecy but just wasn't strong enough.,4;4;speak,Mortus,It only makes sense that he'd brainwash the Hydra to protect Quia.,3;3;speak,Mortus,If we can't kill this Hydra then we stand no chance against the Sorcerers might.,3;3;Hydra;1"
fs.spawnTime["Hydra"] = 0.01
fs.rewards["Hydra"] = "Quia,40,100"

fs["Skeleton King"] = "Mortus;1;speak,Mortus,At least WE survived...,2;2;speak,Mortus,I've no idea what is next. Our scouting efforts didn't acknowledge this room in particular...,5;5;speak,The Skeleton King,So we meet again...,3;3;speak,Mortus,You... know this thing?,3;3;speak,The Skeleton King,I believe that your friends here are big fans of my... body of work.,4;4;speak,The Skeleton King,Remember Southvale? I can still hear the glorious screams of the innocent...,5;5;speak,The Skeleton King,Did you really think that all it would take to be rid of an undead Lord is a few hits with some swords? HAHA! You fool!,5;5;speak,The Skeleton King,No bother. It's time to finish what I started all those years ago.,5;5;Skeleton King;1"
fs.spawnTime["Skeleton King"] = 1
fs.rewards["Skeleton King"] = "Quia,150,100,Lair Key,1,100,Spirit Of Death,1,1,Horse,1,5,Gold,700,100"
