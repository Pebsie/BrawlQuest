fs = {}
fs.spawnTime = {}
fs.rewards = {} --item,amount,percentage chance

--fs["Boar Hunt"] = "Boar;5;Reward;Boar Hide|3|80"
fs["Ghostly Haunting"] = "Ghost;1"--default fight
fs.spawnTime["Ghostly Haunting"] = 0.01
fs.rewards["Ghostly Haunting"] = "Gold,100"

fs["Wolf Pack"] = "speak,Wolf,AWOOOOO,2;2;Wolf;5;Alpha Wolf;2;Wolf;2;Mother Wolf;1;"
fs.spawnTime["Wolf Pack"] = 1
fs.rewards["Wolf Pack"] = "Gold,5,100,Dog,1,50"

fs["Bandit Camp East"] = "speak,Bandit Leader,We're under attack! STOP THIS INTRUDER!,4;4;Bandit;3;Bandit Mage;6;Bandit;2;Bandit Leader;1"
fs.spawnTime["Bandit Camp East"] = 2
fs.rewards["Bandit Camp East"] = "Gold,15,100,Leather Armour,1,25,Basic Cloth,1,75,Short Sword,1,80,Slam,1,25,Polymorph,1,25"

fs["Bandit Camp West"] = "speak,Bandit Leader,INTRUDER!!,3;3;Bandit;10;Bandit Leader;1"
fs.spawnTime["Bandit Camp West"] = 1
fs.rewards["Bandit Camp West"] = "Gold,30,100,Leather Armour,1,50,Bastard Sword,1,25,Recovery,1,25,Potent Healing Potion,2,50"

fs["Bandit Camp South"] = "speak,Bandit Leader,You'll regret coming here! SEND IN THE RATS!,4;4;Starved Rat;25;speak,Bandit,Uh... boss... snakes are coming to eat the rats!!,3;3;Friendly Snake;10;Starved Rat;20;Friendly Snake;5;Bandit;1;Bandit Leader;1"
fs.spawnTime["Bandit Camp South"] = 0.25
fs.rewards["Bandit Camp South"] = "Snake,1,100,Summon 5 Friendly Snake,1,100"
