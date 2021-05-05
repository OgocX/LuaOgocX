--[[
Sistema Master Reset 
]]--

MReset = {}

local MRESET_NPC_CREATE = {}

function MResetNpcTalk(Npc, Player)
	if MRESET_NPC_SWITCH == 0
	then
		return 0
	end

	for i in pairs(MRESET_NPC_CREATE) do
		if MRESET_NPC_CREATE[i].NpcIndex == Npc
		then
			MReset.Npc(Npc, Player)
			return 1
		end
	end
	
	return 0
end

function MReset.MonsterReload()
	if MRESET_NPC_SWITCH == 0
	then
		return
	end

	for i, key in ipairs(MRESET_NPC_CREATE) do
		local player = User.new(MRESET_NPC_CREATE[key].NpcIndex)
		
		if player:getConnected() > 0
		then
			gObjDel(MRESET_NPC_CREATE[key].NpcIndex)
		end
	end

	MRESET_NPC_CREATE = {}
	
	for i in ipairs(MRESET_NPC) do
		MReset.CreateNpc(MRESET_NPC[i].Class, MRESET_NPC[i].Map, MRESET_NPC[i].CoordX, MRESET_NPC[i].CoordY, MRESET_NPC[i].Dir)
	end
end

function MReset.ReloadLuaMonster()
	if MRESET_NPC_SWITCH == 0
	then
		return
	end

	for i in pairs(MRESET_NPC_CREATE) do
		gObjDel(MRESET_NPC_CREATE[i].NpcIndex)
	end

	MRESET_NPC_CREATE = {}
end

function MReset.Init()
	if MRESET_NPC_SWITCH == 0
	then
		return
	end
	
	for i, key in ipairs(MRESET_NPC_CREATE) do
		if UserGetConnected(MRESET_NPC_CREATE[key].NpcIndex) >= 2
		then
			gObjDel(MRESET_NPC_CREATE[key].NpcIndex)
		end
	end
	
	local MRESET_NPC_CREATE = {}
	
	for i in ipairs(MRESET_NPC) do
		MReset.CreateNpc(MRESET_NPC[i].Class, MRESET_NPC[i].Map, MRESET_NPC[i].CoordX, MRESET_NPC[i].CoordY, MRESET_NPC[i].Dir)
	end
end

function MReset.CreateNpc(class, map, x, y, dir)
	index = AddMonster(map)
	
	if index == -1
	then
		LogAdd(string.format("[Master Reset] Problema ao criar o Npc :%d", class))
		return
	end
	
	SetMapMonster(index, map, x, y)
	
	local monster = User.new(index)
	
	monster:setDir(dir)

	SetMonster(index, class)

	MRESET_NPC_CREATE[index] = {NpcIndex = index}
end

function MReset.Npc(Npc, Player)
	if MRESET_NPC_SWITCH == 0
	then
		return
	end
	
	local pl = User.new(Player)
	
	if MReset.Command(Player) == 0
	then
		ChatTargetSend(Npc, MRESETS_MESSAGES[pl:getLanguage()][9], Player)
	else
		ChatTargetSend(Npc, MRESETS_MESSAGES[pl:getLanguage()][8], Player)
	end
	
	pl = nil
end

function MReset.Command(aIndex)
	if MRESET_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language =  player:getLanguage()
	
	local vip = DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID())
	local level = MRESET_LEVEL[vip]
	
	if player:getLevel() < level
	then
		SendMessage(string.format(MRESETS_MESSAGES[Language][1], level), aIndex, 1)
		return
	end
	
	local money = MRESET_MONEY[vip]
	
	if player:getMoney() < money
	then
		SendMessage(string.format(MRESETS_MESSAGES[Language][2], money), aIndex, 1)
		return
	end
	
	local Strength = MRESET_POINTS_STRENGTH[vip]
	if player:getStrength() < Strength
	then
		SendMessage(string.format(MRESETS_MESSAGES[Language][3], Strength), aIndex, 1)
		return
	end
	
	local Dexterity = MRESET_POINTS_DEXTERITY[vip]
	if player:getDexterity() < Dexterity
	then
		SendMessage(string.format(MRESETS_MESSAGES[Language][4], Dexterity), aIndex, 1)
		return
	end
	
	local Vitality = MRESET_POINTS_VITALITY[vip]
	if player:getVitality() < Vitality
	then
		SendMessage(string.format(MRESETS_MESSAGES[Language][5], Vitality), aIndex, 1)
		return
	end
	
	local Energy = MRESET_POINTS_ENERGY[vip]
	if player:getEnergy() < Energy
	then
		SendMessage(string.format(MRESETS_MESSAGES[Language][6], Energy), aIndex, 1)
		return
	end
	
	if player:getClass() == CLASS_DL
	then
		local LeaderShip = MRESET_POINTS_LEADERSHIP[vip]
		
		if player:getLeaderShip() < LeaderShip
		then
			SendMessage(string.format(MRESETS_MESSAGES[Language][10], LeaderShip), aIndex, 1)
			return
		end
	end
	
	local Resets = DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, player:getName())
	local MinReses = MRESET_MIN_RESETS[vip]
	if Resets < MinReses
	then
		SendMessage(string.format(MRESETS_MESSAGES[Language][7], MinReses), aIndex, 1)
		return
	end
	
	local setmoney = player:getMoney() - money
	player:setMoney(setmoney)
	
	local LevelAfter = MRESET_LEVEL_AFTER[vip]
	local StrengthAfter = MRESET_POINTS_STRENGTH_AFTER[vip]
	local DexterityAfter = MRESET_POINTS_DEXTERITY_AFTER[vip]
	local VitalityAfter = MRESET_POINTS_VITALITY_AFTER[vip]
	local EnergyAfter = MRESET_POINTS_ENERGY_AFTER[vip]
	local LeaderShipAfter = MRESET_POINTS_LEADERSHIP_AFTER[vip]
	local LevelUpPointsReset = MRESET_LEVEL_UP_POINTS_RESET[vip]
	local LevelUpPoints = MRESET_POINTS_LEVEL_UP_AFTER[vip]
	local ChargeResets = MRESET_CHARGE_RESETS[vip]
	local ResetsRemove = MRESETS_REMOVE_RESETS[vip]
	
	player:setStrength(StrengthAfter)
	player:setDexterity(DexterityAfter)
	player:setVitality(VitalityAfter)
	player:setEnergy(EnergyAfter)
	
	if player:getClass() == CLASS_DL
	then
		player:setLeaderShip(LeaderShipAfter)
	else
		player:setLeaderShip(0)
	end
	
	player:setLevel(LevelAfter)
	player:setExp(0)
	
	if LevelUpPointsReset == 1
	then
		player:setLevelUpPoint(LevelUpPoints)
	end
	
	local ret = MRESET_RETURN[vip]
	local retmap = MRESET_RETURN_MAP[vip]
	local retx = MRESET_RETURN_MAP_X[vip]
	local rety = MRESET_RETURN_MAP_Y[vip]
	local rel = MRESET_RELOGAR[vip]
	
	--Reward coins
	for i = 0 , #MRESET_AMOUNT_TABLES do
		DataBase.SetAddValue(MRESET_AMOUNT_TABLES[i], MRESET_AMOUNT_COLUNS[i], MRESET_AMOUNT[vip][i], MRESET_AMOUNT_WHERE[i], player:getAccountID())
	end
	
	--Reward ranking
	for i = 0 , #COLUMN_MRESET do
		DataBase.SetAddValue(TABLE_MRESET, COLUMN_MRESET[i], MRESET_COUNTS[vip], WHERE_MRESET, player:getName())
	end
	
	if ChargeResets == 1
	then
		for i = 0 , #COLUMN_RESET do
		DataBase.SetDecreaseValue(TABLE_RESET, COLUMN_RESET[i], ResetsRemove, WHERE_RESET, player:getName())
		end
	end
	
	SendMessage(string.format(MRESETS_MESSAGES[Language][8]), aIndex, 1)
	
	if ret == 1
	then
		player:setMapNumber(retmap)
		player:setX(retx)
		player:setY(rety)
		
		if rel == 0
		then
			Teleport(aIndex, retmap, retx, rety)
		end
	end
	
	if rel == 1
	then
		CloseChar(aIndex, 1)
	else
		NextExpCalc(aIndex)
		SetBP(aIndex)
		LevelUpSend(aIndex)
		MoneySend(aIndex)
		CalCharacter(aIndex)
	end
	
	
end

MReset.Init()
Commands.Register(MRESET_COMMAND, MReset.Command)
GameServerFunctions.NpcTalk(MResetNpcTalk)
GameServerFunctions.MonsterReload(MReset.MonsterReload)
GameServerFunctions.ReloadLuaMonster(MReset.ReloadLuaMonster)

return MReset