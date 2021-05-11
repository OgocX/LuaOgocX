--[[

Configs

--]]

local CUSTOM_MONSTER_CONFIG = { 
	{ MonsterID = 580, MonsterType = 1, Size = 1.0, Map = -1, PosX = -1, PosY = -1, MonsterName = "Chaos Machine Genesis 1", MonsterModel = "ChaosBoxGenesis"},
	{ MonsterID = 581, MonsterType = 1, Size = 0.75, Map = -1, PosX = -1, PosY = -1, MonsterName = "Npc Rescue", MonsterModel = "NpcRescue"},
}

--[[

System working don't touch

--]]

MODEL_MONSTER_MAX = 644

function GET_MONSTER_MODEL(index)
	return index + MODEL_MONSTER_MAX
end

function GET_MONSTER_ID(index)
	return index - MODEL_MONSTER_MAX
end

function CreateMonster(MonsterID, PosX, PosY, Key)
	for i = 1, #CUSTOM_MONSTER_CONFIG do
		local monster = CUSTOM_MONSTER_CONFIG[i]
	
		if monster.MonsterID == MonsterID 
			and (monster.Map == -1 or getMapNumber() == monster.Map) 
			and (monster.PosX == -1 or monster.PosX == PosX)
			and (monster.PosY == -1 or monster.PosY == PosY)
		then
			LoadMonster(MonsterID)
			
			local monsterObj = CreateMonsterStruct(Key, GET_MONSTER_MODEL(monster.MonsterID), PosX, PosY, monster.MonsterType, monster.Size, monster.MonsterName)
			return 1, monsterObj
		end
	end

	return 0, 0
end

function LooadModelMonster(MonsterID)
	for i = 1, #CUSTOM_MONSTER_CONFIG do
		local monster = CUSTOM_MONSTER_CONFIG[i]
		
		if GET_MONSTER_MODEL(monster.MonsterID) == MonsterID
		then
			LoadModel(MonsterID, "Monster\\", monster.MonsterModel, -1)
			return 1
		end
	end

	return
end

function LooadTextureMonster(MonsterID)
	for i = 1, #CUSTOM_MONSTER_CONFIG do
		local monster = CUSTOM_MONSTER_CONFIG[i]
		
		if GET_MONSTER_MODEL(monster.MonsterID) == MonsterID
		then
			LoadTexture(MonsterID, "Monster\\", monster.MonsterModel, -1)
			return 1
		end
	end

	return
end