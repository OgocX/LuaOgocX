--[[ 
Arquivo de sistema de Resets
]]--

Reset = {}

local RESET_NPC_CREATE = {}

function ResetNpcTalk(Npc, Player)
	if RESET_NPC_SWITCH == 0
	then
		return 0
	end
	
	for i in pairs(RESET_NPC_CREATE) do
		if RESET_NPC_CREATE[i].NpcIndex == Npc
		then
			Reset.Npc(Npc, Player)
			return 1
		end
	end
	
	return 0
end

function Reset.MonsterReload()
	if RESET_NPC_SWITCH == 0
	then
		return
	end
	
	for i in pairs(RESET_NPC_CREATE) do
		local npc = User.new(RESET_NPC_CREATE[i].NpcIndex)
		
		if npc:getConnected() > 0
		then
			gObjDel(RESET_NPC_CREATE[i].NpcIndex)
		end
	end

	RESET_NPC_CREATE = {}
	
	for i in ipairs(RESET_NPC) do
		Reset.CreateNpc(RESET_NPC[i].Class, RESET_NPC[i].Map, RESET_NPC[i].CoordX, RESET_NPC[i].CoordY, RESET_NPC[i].Dir)
	end
end

function Reset.ReloadLuaMonster()
	if RESET_NPC_SWITCH == 0
	then
		return
	end

	for i in pairs(RESET_NPC_CREATE) do
		gObjDel(RESET_NPC_CREATE[i].NpcIndex)
	end

	RESET_NPC_CREATE = {}
end

function Reset.Init()
	if RESET_NPC_SWITCH == 0
	then
		return
	end
	
	for i, key in ipairs(RESET_NPC_CREATE) do
		local npc = User.new(RESET_NPC_CREATE[key].NpcIndex)
		
		if npc:getConnected() >= 2
		then
			gObjDel(RESET_NPC_CREATE[key].NpcIndex)
		end
	end
	
	RESET_NPC_CREATE = {}
	
	for i in ipairs(RESET_NPC) do
		Reset.CreateNpc(RESET_NPC[i].Class, RESET_NPC[i].Map, RESET_NPC[i].CoordX, RESET_NPC[i].CoordY, RESET_NPC[i].Dir)
	end
end

function Reset.CreateNpc(class, map, x, y, dir)
	index = AddMonster(map)
	
	if index == -1
	then
		LogAdd(string.format("[Reset] Problema ao criar o Npc :%d", class))
		return
	end
	
	SetMapMonster(index, map, x, y)
	
	local npc = User.new(index)
	
	npc:setDir(dir)

	SetMonster(index, class)
	
	RESET_NPC_CREATE[index] = {NpcIndex = index}
end

function Reset.Npc(Npc, Player)
	if RESET_NPC_SWITCH == 0
	then
		return
	end
	
	local pl = User.new(Player)
	local Language = pl:getLanguage()
	
	if Reset.Make(pl) == 0
	then
		ChatTargetSend(Npc, RESET_MESSAGES[Language][7], Player)
	else
		ChatTargetSend(Npc, RESET_MESSAGES[Language][8], Player)
		
		SendMessage(string.format(RESET_MESSAGES[Language][9], pl:getReset()), Player, 0)
	end
	
	pl = nil
end

function Reset.Command(aIndex, Arguments)
	if RESET_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if Reset.Make(player) == 0
	then
		SendMessage(string.format(RESET_MESSAGES[Language][10]), aIndex, 1)
	else
		SendMessage(string.format(RESET_MESSAGES[Language][11]), aIndex, 1)
	end
	
	player = nil
end

function Reset.Make(player)
	local Language = player:getLanguage()
	local aIndex = player:getIndex()

	if MAX_RESET ~= -1
	then
		local Resets = player:getReset()
		
		if Resets >= MAX_RESET
		then
			SendMessage(string.format(RESET_MESSAGES[Language][12], MAX_RESET), aIndex, 0)
			return 0
		end
	end
	
	if RESET_TYPE == 0
	then
		return Reset.Acumulative(player)
	elseif RESET_TYPE == 1
	then
		return Reset.Tabulated(player)
	end
end

function Reset.Acumulative(player)
	local aIndex = player:getIndex()
	local Language = player:getLanguage()

	if MAX_RESET ~= -1
	then
		local Resets = player:getReset()
		
		if Resets >= MAX_RESET
		then
			SendMessage(string.format(RESET_MESSAGES[Language][12], MAX_RESET), aIndex, 0)
			return 0
		end
	end

	local vip = player:getVip()
	local level = RESET_ACUMULATIVE_LEVEL[vip]
	
	if player:getLevel() < level
	then
		SendMessage(string.format(RESET_MESSAGES[Language][13], level), aIndex, 1)
		return 0
	end
	
	local money = RESET_ACUMULATIVE_MONEY[vip]
	if player:getMoney() < money
	then
		SendMessage(string.format(RESET_MESSAGES[Language][14], money), aIndex, 1)
		return 0
	end
	
	local levelafter = RESET_ACUMULATIVE_LEVEL_AFTER[vip]
	local ret = RESET_ACUMULATIVE_RETURN[vip]
	
	local retmap = RESET_ACUMULATIVE_RETURN_MAP_CLASS[player:getClass()]
	local retx = RESET_ACUMULATIVE_RETURN_MAP_X_CLASS[player:getClass()]
	local rety = RESET_ACUMULATIVE_RETURN_MAP_Y_CLASS[player:getClass()]
	
	player:setMoney(player:getMoney() - money)
	
	player:setLevel(levelafter)
	
	for i = 0 , #COLUMN_RESET do
		DataBase.SetAddValue(TABLE_RESET, COLUMN_RESET[i], RESET_ACUMULATIVE_RESETS[vip], WHERE_RESET, player:getName())
	end

	player:setReset(player:getReset() + RESET_ACUMULATIVE_RESETS[vip])
	
	SendMessage(string.format(RESET_MESSAGES[Language][9], player:getReset()), aIndex, 0)

	local rel = RESET_ACUMULATIVE_RELOGAR[vip]
	
	if rel == 1
	then
		if ret == 1
		then
			player:setMapNumber(retmap)
			player:setX(retx)
			player:setY(rety)
		end
	
		CloseChar(aIndex, 1)
	else
		CalCharacter(aIndex)
		SetBP(aIndex)
		MoneySend(aIndex)
		RefreshCharacter(aIndex)
		LevelUpSend(aIndex)
		
		if ret == 1
		then
			Teleport(aIndex, retmap, retx, rety)
		end
	end
	
	return 1
end

function Reset.Tabulated_GetResetLevel(Resets, Vip)
	for i in pairs(RESET_TABLE) do
		if (Resets+1) >= RESET_TABLE[i].MinReset and (Resets+1) <= RESET_TABLE[i].MaxReset
		then
			if Vip == 0
			then
				return RESET_TABLE[i].Level_Free
			elseif Vip == 1
			then
				return RESET_TABLE[i].Level_Vip1
			elseif Vip == 2
			then
				return RESET_TABLE[i].Level_Vip2
			elseif Vip == 3
			then
				return RESET_TABLE[i].Level_Vip3
			end
		end
	end
	
	return RESET_TABLE_LEVEL[Vip]
end

function Reset.Tabulated_GetResetMoney(Resets, Vip)
	for i in pairs(RESET_TABLE) do
		if (Resets+1) >= RESET_TABLE[i].MinReset and (Resets+1) <= RESET_TABLE[i].MaxReset
		then
			if Vip == 0
			then
				return RESET_TABLE[i].Money_Free
			elseif Vip == 1
			then
				return RESET_TABLE[i].Money_Vip1
			elseif Vip == 2
			then
				return RESET_TABLE[i].Money_Vip2
			elseif Vip == 3
			then
				return RESET_TABLE[i].Money_Vip3
			end
		end
	end

	return RESET_TABLE_MONEY[Vip]
end

function Reset.Tabulated_GetResetPoint(Resets, Vip)
	local point = 0
	
	for n=1,Resets do
		local AddPoints = RESET_TABLE_POINTS[Vip]
		
		for i in pairs(RESET_TABLE) do
			if n >= RESET_TABLE[i].MinReset and n <= RESET_TABLE[i].MaxReset
			then
				if Vip == 0
				then
					AddPoints = RESET_TABLE[i].Points_Free
					break
				elseif Vip == 1
				then
					AddPoints = RESET_TABLE[i].Points_Vip1
					break
				elseif Vip == 2
				then
					AddPoints = RESET_TABLE[i].Points_Vip2
					break
				elseif Vip == 3
				then
					AddPoints = RESET_TABLE[i].Points_Vip3
					break
				end
			end
		end
		
		point = point + AddPoints
	end
	
	return point
end

function Reset.Tabulated(player)
	local aIndex = player:getIndex()
	local Language = player:getLanguage()
	local Resets = player:getReset()

	if MAX_RESET ~= -1
	then
		if Resets >= MAX_RESET
		then
			SendMessage(string.format(RESET_MESSAGES[Language][12], MAX_RESET), aIndex, 0)
			return 0
		end
	end
	
	local vip = player:getVip()
	local leveluser = player:getLevel()
	
	local level = Reset.Tabulated_GetResetLevel(Resets, vip)
	
	if leveluser < level
	then
		SendMessage(string.format(RESET_MESSAGES[Language][13], level), aIndex, 1)
		return 0
	end
	
	local moneyuser = player:getMoney()
	
	local money = Reset.Tabulated_GetResetMoney(Resets, vip)
	
	if moneyuser < money
	then
		SendMessage(string.format(RESET_MESSAGES[Language][14], money), aIndex, 1)
		return 0
	end
	
	local levelafter = RESET_TABLE_AFTER[vip]
	local ret = RESET_TABLE_RETURN[vip]
	
	local retmap = RESET_TABLE_RETURN_MAP_CLASS[player:getClass()]
	local retx = RESET_TABLE_RETURN_MAP_X_CLASS[player:getClass()]
	local rety = RESET_TABLE_RETURN_MAP_Y_CLASS[player:getClass()]
	
	player:setMoney(player:getMoney() - money)
	
	player:setLevel(levelafter)
	
	local leveluppoints = Reset.Tabulated_GetResetPoint(Resets, vip)
	
	player:setLevelUpPoint(leveluppoints)
	
	local points_status = RESET_TABLE_POINTS_STATUS[vip]
	
	player:setStrength(points_status)
	player:setDexterity(points_status)
	player:setEnergy(points_status)
	player:setVitality(points_status)
	
	if player:getClass() == 4
	then
		player:setLeaderShip(points_status)
	end
	
	for i = 0 , #COLUMN_RESET do
		DataBase.SetAddValue(TABLE_RESET, COLUMN_RESET[i], RESET_TABLE_RESETS[vip], WHERE_RESET, player:getName())
	end

	player:setReset(player:getReset() + RESET_TABLE_RESETS[vip])
	
	SendMessage(string.format(RESET_MESSAGES[Language][9], player:getReset()), aIndex, 0)
	
	local rel = RESET_TABLE_RELOGAR[vip]
	
	if rel == 1
	then
		if ret == 1
		then
			player:setMapNumber(retmap)
			player:setX(retx)
			player:setY(rety)
		end
	
		CloseChar(aIndex, 1)
	else
		CalCharacter(aIndex)
		SetBP(aIndex)
		MoneySend(aIndex)
		RefreshCharacter(aIndex)
		LevelUpSend(aIndex)
		
		if ret == 1
		then
			Teleport(aIndex, retmap, retx, rety)
		end
	end
	
	return 1
end

Reset.Init()
Commands.Register(RESET_COMMAND, Reset.Command)
GameServerFunctions.NpcTalk(ResetNpcTalk)
GameServerFunctions.MonsterReload(Reset.MonsterReload)
GameServerFunctions.ReloadLuaMonster(Reset.ReloadLuaMonster)

return Reset