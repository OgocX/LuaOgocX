--[[
Sistema Pk Clear
]]--

PkClearSystem = {}

local PKCLEAR_NPC_CREATE = {}

function PkClearNpcTalk(Npc, Player)
	if PKCLEAR_NPC_SWITCH == 0
	then
		return 0
	end
	
	for i in pairs(PKCLEAR_NPC_CREATE) do
		if PKCLEAR_NPC_CREATE[i].NpcIndex == Npc
		then
			PkClearSystem.PkClearNpc(Npc, Player)
			return 1
		end
	end
	
	return 0
end

function PkClearSystem.MonsterReload()
	PKCLEAR_NPC_CREATE = {}
	
	for i in ipairs(PKCLEAR_NPC) do
		PkClearSystem.CreateNpc(PKCLEAR_NPC[i].Class, PKCLEAR_NPC[i].Map, PKCLEAR_NPC[i].CoordX, PKCLEAR_NPC[i].CoordY, PKCLEAR_NPC[i].Dir)
	end
end

function PkClearSystem.Init()
	if PKCLEAR_NPC_SWITCH == 0
	then
		return
	end
	
	for i, key in ipairs(PKCLEAR_NPC_CREATE) do
		local npc = User.new(PKCLEAR_NPC_CREATE[key].NpcIndex)
		
		if npc:getConnected() >= 2
		then
			gObjDel(PKCLEAR_NPC_CREATE[key].NpcIndex)
		end
	end
	
	PKCLEAR_NPC_CREATE = {}
	
	for i in ipairs(PKCLEAR_NPC) do
		PkClearSystem.CreateNpc(PKCLEAR_NPC[i].Class, PKCLEAR_NPC[i].Map, PKCLEAR_NPC[i].CoordX, PKCLEAR_NPC[i].CoordY, PKCLEAR_NPC[i].Dir)
	end
end

function PkClearSystem.CreateNpc(class, map, x, y, dir)
	index = AddMonster(map)
	
	if index == -1
	then
		LogAdd(string.format("[Pk Clear] Problema ao criar o Npc :%d", class))
		return
	end
	
	SetMapMonster(index, map, x, y)
	
	local npc = User.new(index)
	
	npc:setDir(dir)

	SetMonster(index, class)
	
	PKCLEAR_NPC_CREATE[index] = {NpcIndex = index}
end

function PkClearSystem.PkClearNpc(Npc, aIndex)
	if PKCLEAR_NPC_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getPKLevel() == 3
	then
		ChatTargetSend(Npc, string.format(PK_CLEAR_MESSAGES[Language][1]), aIndex)
		return
	end
	
	if player:getLevel() < PKCLEAR_LEVEL
	then
		ChatTargetSend(Npc, string.format(PK_CLEAR_MESSAGES[Language][2], PKCLEAR_LEVEL), aIndex)
		return
	end
	
	local money = player:getMoney()
	
	if money < PKCLEAR_MONEY
	then
		ChatTargetSend(Npc, string.format(PK_CLEAR_MESSAGES[Language][3], PKCLEAR_MONEY), aIndex)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < PKCLEAR_VIP
	then
		ChatTargetSend(Npc, string.format(PK_CLEAR_MESSAGES[Language][4]), aIndex)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < PKCLEAR_RESETS
	then
		ChatTargetSend(Npc, string.format(PK_CLEAR_MESSAGES[Language][5], PKCLEAR_RESETS), aIndex)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < PKCLEAR_MRESETS
	then
		ChatTargetSend(Npc, string.format(PK_CLEAR_MESSAGES[Language][6], PKCLEAR_MRESETS), aIndex)
		return
	end
	
	local setmoney = money - PKCLEAR_MONEY
	
	player:setMoney(setmoney)
	MoneySend(aIndex)
	
	player:setPKCount(0)
	player:setPKLevel(3)
	player:setPKTime(0)
	
	PkLevelSend(aIndex, player:getPKLevel())
	
	KillSystem.PlayerPkClear(aIndex)
	
	ChatTargetSend(Npc, string.format(PK_CLEAR_MESSAGES[Language][7]), aIndex)
	
	
end

function PkClearSystem.LimparPk(aIndex, Arguments)
	if PKCLEAR_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getPKLevel() == 3
	then
		SendMessage(string.format(PK_CLEAR_MESSAGES[Language][1]), aIndex, 1)
		return
	end
	
	if player:getLevel() < PKCLEAR_LEVEL
	then
		SendMessage(string.format(PK_CLEAR_MESSAGES[Language][2], PKCLEAR_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < PKCLEAR_MONEY
	then
		SendMessage(string.format(PK_CLEAR_MESSAGES[Language][3], PKCLEAR_MONEY), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < PKCLEAR_VIP
	then
		SendMessage(string.format(PK_CLEAR_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < PKCLEAR_RESETS
	then
		SendMessage(string.format(PK_CLEAR_MESSAGES[Language][5], PKCLEAR_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < PKCLEAR_MRESETS
	then
		SendMessage(string.format(PK_CLEAR_MESSAGES[Language][6], PKCLEAR_MRESETS), aIndex, 1)
		return
	end
	
	local setmoney = money - PKCLEAR_MONEY
	
	player:setMoney(setmoney)
	MoneySend(aIndex)
	
	player:setPKCount(0)
	player:setPKLevel(3)
	player:setPKTime(0)
	
	PkLevelSend(aIndex, player:getPKLevel())
	
	KillSystem.PlayerPkClear(aIndex)
	
	SendMessage(string.format(PK_CLEAR_MESSAGES[Language][7]), aIndex, 1)
	
	
end

PkClearSystem.Init()
Commands.Register(PKCLEAR_COMMAND, PkClearSystem.LimparPk)
GameServerFunctions.NpcTalk(PkClearNpcTalk)
GameServerFunctions.MonsterReload(PkClearSystem.MonsterReload)

return PkClearSystem