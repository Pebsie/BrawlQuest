fs = {}
fs.spawnTime = {}
fs.rewards = {} --item,amount,percentage chance

--fs["Boar Hunt"] = "Boar;5;Reward;Boar Hide|3|80"
fs["default"] = "Ghost;1"--default fight
fs.spawnTime["default"] = 0.01
fs.rewards["default"] = "Gold,100,100"

fs["Shipwreck"] = "Ship;3;speak,Mortus,We've been travelling for 2 weeks West and are yet to encounter any land mass.,5;5;speak,Mortus,I'm beginning to think that there is nothing else out here...,5;5;speak,Guard,M'am! Black sails!,3;3;speak,Mortus,Pirates? But we're miles from land!,5;5;Ghostly Ship;1"
fs.spawnTime["Shipwreck"] = 0
fs.rewards["Shipwreck"] = "Gold,5,100"

fs["Spiders"] = "Spider;15"
fs.spawnTime["Spiders"] = 1
fs.rewards["Spiders"] = "Gold,5,100,Old Cloth,1,100,Potent Healing Potion,10,100"

fs["Crabs"] = "Scorpion;5;Sand Worm;15;Scorpion;2;Sand Worm;5;Scorpion;1"
fs.spawnTime["Crabs"] = 1.5
fs.rewards["Crabs"] = "Gold,10,100,Potent Healing Potion,1,50,Snake,1,25,Short Sword,1,10"
