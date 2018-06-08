fs = {}
fs.spawnTime = {}
fs.rewards = {} --item,amount,percentage chance

--fs["Boar Hunt"] = "Boar;5;Reward;Boar Hide|3|80"
fs["default"] = "Ghost;1"--default fight
fs.spawnTime["default"] = 0.01
fs.rewards["default"] = "Gold,100,100"

fs["Shipwreck"] = "Ship;3;speak,Mortus,We've been travelling for 2 weeks West and are yet to encounter any land mass.,5;5;speak,Mortus,I'm beginning to think that there is nothing else out here...,5;5;speak,Guard,M'am! Black sails!,3;3;speak,Mortus,Pirates? But we're miles from land!,5;5;Pirate Ship;4;Ghostly Ship;1"
fs.spawnTime["Shipwreck"] = 1
fs.rewards["Shipwreck"] = "Gold,5,100"

fs["Spiders"] = "Spider;15"
fs.spawnTime["Spiders"] = 1
fs.rewards["Spiders"] = "Gold,5,100,Old Cloth,1,100,Potent Healing Potion,10,100"

fs["Crabs"] = "Scorpion;5;Sand Worm;15;Scorpion;2;Sand Worm;5;Scorpion;1"
fs.spawnTime["Crabs"] = 1.5
fs.rewards["Crabs"] = "Gold,10,100,Potent Healing Potion,1,50,Snake,1,25,Short Sword,1,10"

--crafting
fs["Gather: Wood"] = "Weak Tree;3"
fs.spawnTime["Gather: Wood"] = 0
fs.rewards["Gather: Wood"] = "Wood,3,100,Wood,2,50,Wood,1,25,Wood,5,10,Wood,10,1"

fs["Gather: Stone"] = "Weak Rock;2"
fs.spawnTime["Gather: Stone"] = 0
fs.rewards["Gather: Stone"] = "Stone,5,100,Stone,2,50,Stone,1,25,Stone,10,1"
