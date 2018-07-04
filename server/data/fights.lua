fs = {}
fs.spawnTime = {}
fs.rewards = {} --item,amount,percentage chance

--fs["Boar Hunt"] = "Boar;5;Reward;Boar Hide|3|80"
fs["default"] = "Ghost;1"--default fight
fs.spawnTime["default"] = 0.01
fs.rewards["default"] = "Gold,100,100"

fs["Shipwreck"] = "Ship;3;speak,Mortus,We've been travelling for 2 weeks West and are yet to encounter any land mass.,5;5;speak,Mortus,I'm beginning to think that there is nothing else out here...,5;5;speak,Guard,M'am! Black sails! All hands on deck!,3;3;Pirate Ship;2;speak,Mortus,Pirates? But we're miles from land!,5;5;Pirate Ship;12;speak,Guard,We're cutting through them like paper!,4;4;speak,Mortus,HAH! These fools are no match for us. Prepare a feast! We've fought valiantly today.,6;6;speak,Carus,I'm not sure it's quite over yet Mortus! My parrot continues to twitch...,5;5;Ghostly Ship;1;speak,Guard,BACK TO YOUR STATIONS! ANOTHER PIRATE SHIP APPROACHES!,4;4;speak,Mortus,Is it just me or is that ship somewhat... transparent? Hazy?,4;4;"
fs.spawnTime["Shipwreck"] = 1
fs.rewards["Shipwreck"] = "Gold,5,100"

fs["Spiders"] = "Spider;15"
fs.spawnTime["Spiders"] = 1
fs.rewards["Spiders"] = "String,3,100,String,2,50"

fs["Chest: String"] = "Spider;30"
fs.spawnTime["Chest: String"] = 0.2
fs.rewards["Chest: String"] = "String,15,100"

fs["Crabs"] = "Scorpion;5;Sand Worm;15;Scorpion;2;Sand Worm;5;Scorpion;1"
fs.spawnTime["Crabs"] = 1.5
fs.rewards["Crabs"] = "Potent Healing Potion,1,50,Snake,1,25,Short Sword,1,10,Blueprint: Polymorph,1,100"

fs["Cannibals"] = "speak,Cannibal Leader,FRESH MEAT!! SMELL GOOD!! BRING HEAD!!,2;2;Cannibal Hunter;15;Cannibal Leader;1"
fs.spawnTime["Cannibals"] = 1
fs.rewards["Cannibals"] = "Blueprint: Bastard Sword,1,10,Suspicious Meat,3,50,Dog,1,50,Hilt,1,100"

fs["Cannibal Hut"] = "Cannibal Tribesman;30;speak,Cannibal Tribesman,INTRUDE! INTRUDE! DEFENSE! GO!,3;3;"
fs.spawnTime["Cannibal Hut"] = 0
fs.rewards["Cannibal Hut"] = "Wood,1,100,Suspicious Meat,5,50,Blueprint: Long Sword,1,50,Blueprint: Bastard Sword,1,25"

fs["Hell's Creatures"] = "Spider;5"
fs.spawnTime["Hell's Creatures"] = 1
fs.rewards["Hell's Creatures"] = "Fly,1,30,Mana,2,100,Baby Bat,1,40"

fs["Dungeon: Demon"] = "Mysterious Figure;1;speak,**player**,WHO ARE YOU?,2;2;speak,**player**,WHERE DID YOU COME FROM?,3;3;speak,Mysterious Figure,Me? Where did YOU come from? Humans... I've been following you since I saw your ship crash... this is not your place.,7;7;speak,**player**,What's that meant to mean?,4;4;speak,Mysterious Figure,You should not have come here. You especially should not have started abusing our natural resources.,6;6;speak,**player**,We're trying to build a ship... we're trying to leave!,5;5;speak,Mysterious Figure,Your intentions may have been pure... but the demon that lurks in this cave will likely not accept your excuses.,6;6;speak,Mysterious Figure,And I fear that I sense him just a moment away... I will help protect you foolish humans.,6;6;speak,**player**,*You hear heavy stomps and a defeaning roar*,3;3;Demon;1"
fs.spawnTime["Dungeon: Demon"] = 0
fs.rewards["Dungeon: Demon"] = "Iron,20,100,Mana Crystal,10,100,Beholder,1,25,Iron Chestplate,1,10,Iron Leggings,1,10,Iron Helmet,1,10,Blueprint: Guardian's Chestplate,1,50,Blueprint: Guardian's Helmet,1,50,Blueprint: Guardian's Leggings,1,50,Blueprint: Guardian's Blade,1,50"

--crafting
fs["Gather: Wood"] = "Weak Tree;3"
fs.spawnTime["Gather: Wood"] = 0
fs.rewards["Gather: Wood"] = "Wood,5,100,Wood,3,50,Wood,2,25,Wood,5,10,Wood,10,1"

fs["Gather: Stone"] = "Weak Rock;2"
fs.spawnTime["Gather: Stone"] = 0
fs.rewards["Gather: Stone"] = "Stone,5,100,Stone,2,50,Stone,1,25,Stone,10,1,Iron,3,50,Iron,2,10"

fs["Gather: Mana"] = "Mana Crystal;4"
fs.spawnTime["Gather: Mana"] = 0
fs.rewards["Gather: Mana"] = "Mana Crystal,1,100,Mana Crystal,2,50,Mana Crystal,1,10"
