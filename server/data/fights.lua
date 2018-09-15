fs = {}
fs.spawnTime = {}
fs.rewards = {} --item,amount,percentage chance

--fs["Boar Hunt"] = "Boar;5;Reward;Boar Hide|3|80"
fs["default"] = "Ghost;1"--default fight
fs.spawnTime["default"] = 0.01
fs.rewards["default"] = "Gold,100,100"

fs["Hungry Bear"] = "Bear;4"
fs.spawnTime["Hungry Bear"] = 0.5
fs.rewards["Hungry Bear"] = "Bear Meat,1,100,Pelt,1,10,Small Dagger,1,20,XP,20,100"--"Bear Meat,1,100,Small Dagger,1,20"

fs["Forest Bandits"] = "Bandit;1;speak,Bandit,FOR THE FOREST ALLIANCE!,3;3;Bandit;9"
fs.spawnTime["Forest Bandits"] = 0.5
fs.rewards["Forest Bandits"] = "Small Dagger,1,10,Red Facemask,1,50,Gold,3,100,Gold,2,50,XP,35,100"

fs["Ogres"] = "speak,Ogre,It face bonk time!,3;3;Ogre;3"
fs.spawnTime["Ogres"] = 2
fs.rewards["Ogres"] = "Ogre's Head,3,100,XP,60,100"

fs["Undead Lurkers"] = "Undead Lurker;10"
fs.spawnTime["Undead Lurkers"] = 1
fs.rewards["Undead Lurkers"] = "Gold,4,100,XP,50,100"

fs["Spiders"] = "Spider;10"
fs.spawnTime["Spiders"] = 0.5
fs.rewards["Spiders"] = "String,5,100,String,2,50,XP,30,100"

fs["Wolves"] = "Wolf;5;Mother Wolf;1"
fs.spawnTime["Wolves"] = 0.25
fs.rewards["Wolves"] = "Tooth,1,50,Pelt,1,20,Dog,1,25,XP,40,100"

fs["Twisted Students"] = "Confused Student;5;Senior Student;3;Confused Student;2"
fs.spawnTime["Twisted Students"] = 4
fs.rewards["Twisted Students"] = "Mana,4,100,Beholder,1,10"

fs["The Arena"] = "Skeleton;999"
fs.spawnTime["The Arena"] = 0.1
fs.rewards["The Arena"] = "Trophy,1,100"

fs["Desert Winds"] = "Mystical Sand Wind;10"
fs.spawnTime["Desert Winds"] = 1
fs.rewards["Desert Winds"] = "Earth Elementling,1,100,Gold,15,100,XP,50,100"

fs["Desert Creatures"] = "Basilisk;5;Sand Worm;10;Basilisk;3"
fs.spawnTime["Desert Creatures"] = 0.25
fs.rewards["Desert Creatures"] = "Gold,15,100,XP,100,100"

fs["Desert Dwellers"] = "Desert Fanatic;1;speak,Desert Fanatic,The Wasteland is SACRED! HOW DARE YOU BARE YOUR DIRTY FEET HERE!,5;5;Desert Fanatic;4;Desert Fanatic Mage;3;Desert Fanatic;1"
fs.spawnTime["Desert Dwellers"] = 1
fs.rewards["Desert Creatures"] = "Gold,40,100,XP,160,100"


--crafting
fs["Gather: Wood"] = "Weak Tree;3"
fs.spawnTime["Gather: Wood"] = 0
fs.rewards["Gather: Wood"] = "Wood,5,100,Wood,3,50,Wood,2,25,Wood,5,10,Wood,10,1"

fs["Gather: Stone"] = "Weak Rock;2"
fs.spawnTime["Gather: Stone"] = 0
fs.rewards["Gather: Stone"] = "Stone,5,100,Stone,2,50,Stone,1,25,Stone,10,1,Iron,3,50,Iron,2,10,Iron,1,75"

fs["Gather: Mana"] = "Mana Crystal;4"
fs.spawnTime["Gather: Mana"] = 0
fs.rewards["Gather: Mana"] = "Mana,1,100,Mana,2,50,Mana,1,10"
