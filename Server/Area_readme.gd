extends Control

"""
Expanding:
	New science building/income building type
	
	Barrack		:	Spawns mobs based on Barrack level and Barrack researches, can spawn +1 a round for extra cash
		0. Select mob type
		1. LvL up
		2. Movement speed
		3. HP
		4. Resist
		5. Size +/-
		
	Castle		:	Basic HR tower researches, main building, enemies that get in can steal health
	Tower		:	Each tower belongs to a science family (Magic, Tech, Bio, Chemic, Human(oid) Resource)
		1. Can have 4 weapons, each can have 3 upgrades
		2. Can have 2 type of powerups, each can have 3 upgrades
	House & Farm:	create steady income, can have farm extension, but that's very slow to build and no income from the farm while building (or more)
		1. Both generate income based on LvL
	Armory 		:	Weapon R&D Types and upgrades
		1. Unlock base type for armory
			2. Unlock up to 6 weapons
			3. Unlock up to 6 upgrades (Upgrades apply for all weapons of the included types)
		4. Unlock secondary type for armory
			5. Unlock up to 2 weapons
			6. Unlock up to 2 upgrades
	Academy		:	Magic and Science powerup upgrades research for towers upgrades
		0. Has 4 upgrade slots
		1. Can have up to 4 primary powerup paths
		2. Can have up to 2 secondary powerup paths
	Market:
		1. Player select
		2-6. Show up to 5 random weapons available from players arsenal
"""
