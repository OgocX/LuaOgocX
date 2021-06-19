--[[ Configurações System Block Area ]]--
BlockArea = {}

local Players = {}
local timer = -1
local checkusers = false

function BlockArea.CommandOpen(aIndex, Arguments)
	if BLOCK_AREA_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), BLOCK_AREA_GAME_MASTER_LEVEL) == 0
	then
		return
	end
	
	SendMessageGlobal(string.format(BLOCK_AREA_MESSAGES[Language][1], player:getName()), 0)
	SendMessageGlobal(string.format(BLOCK_AREA_MESSAGES[Language][2]), 0)
	SendMessageGlobal(string.format(BLOCK_AREA_MESSAGES[Language][3]), 0)
	
	for i = OBJECT_START_USER, MAX_OBJECT do
		local players_stack = User.new(i)
		
		if players_stack:getAuthority() == 1
		then
			if BlockArea.InArea(players_stack:getMapNumber(), players_stack:getX(), players_stack:getY()) == 1
			then
				InsertKey(Players, players_stack:getName())
			
				Players[players_stack:getName()] = {Index = i, Time = BLOCK_AREA_TIME, Block = true}
				
				SendMessage(string.format(BLOCK_AREA_MESSAGES[Language][4]), i, 1)
			end
		end
	end
	
	
	
	checkusers = true
	timer = Timer.Interval(1, BlockArea.Running)
end

function BlockArea.CommandClose(aIndex, Arguments)
	if BLOCK_AREA_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	SendMessageGlobal(string.format(BLOCK_AREA_MESSAGES[Language][5], player:getName()), 0)
	
	Players = {}
	checkusers = false
	
	if timer ~= -1
	then
		Timer.Cancel(timer)
		timer = -1
	end
	
	
end

function BlockArea.Running()
	for i, key in ipairs(Players) do
		local player = User.new(Players[key].Index)
		local playertime = Players[key].Time
		
		if player:getConnected() ~= 3
		then
			RemoveKey(Players, i)
		end
		
		if player:getAuthority() ~= 1
		then
			RemoveKey(Players, i)
		end
		
		local Language = player:getLanguage()
		
		if playertime > 0
		then
			playertime = playertime - 1
			
			Players[key].Time = playertime
		
			SendMessage(string.format(BLOCK_AREA_MESSAGES[Language][6], playertime), Players[key].Index, 1)
		else
			SendMessageGlobal(string.format(BLOCK_AREA_MESSAGES[Language][7], player:getName()), 1)
			Teleport(Players[key].Index, 0, 125, 125)
			RemoveKey(Players, i)
		end
		
		
	end
end

function BlockArea.PlayerMove(aIndex, map, x, y, sx, sy)
	if checkusers == false
	then
		return
	end
	
	if BLOCK_AREA_SWITCH == 0
	then
		return
	end
	
	if map ~= BLOCK_AREA_MAP
	then
		return
	end
	
	local player = User.new(aIndex)
	
	if player:getAuthority() ~= 1
	then
		return
	end
	
	local Language = player:getLanguage()
	
	if BlockArea.InArea(map, x, y) == 1
	then
		if Players[player:getName()] == nil
		then
			InsertKey(Players, player:getName())
			
			Players[player:getName()] = {Index = aIndex, Time = BLOCK_AREA_TIME, Block = true}
			
			SendMessage(string.format(BLOCK_AREA_MESSAGES[Language][4]), aIndex, 1)
		else
			if Players[player:getName()].Block == false and Players[player:getName()].Index ~= aIndex
			then
				InsertKey(Players, player:getName())
				
				Players[player:getName()].Index = aIndex
				
				Players[player:getName()].Time = BLOCK_AREA_TIME
				
				Players[player:getName()].Block = true

				SendMessage(string.format(BLOCK_AREA_MESSAGES[Language][4]), aIndex, 1)
			end
		end
	else
		if Players[player:getName()] ~= nil
		then
			if Players[player:getName()].Index == aIndex
			then
				SendMessage(string.format(BLOCK_AREA_MESSAGES[Language][8]), aIndex, 1)
				BlockArea.RemoveUser(player:getName())
			end
		end
	end
	
	
end

function BlockArea.InArea(map, x, y)
	if map == BLOCK_AREA_MAP
	then
		if x >= BLOCK_AREA_CHECK_COORD_X_1 and y >= BLOCK_AREA_CHECK_COORD_Y_1 and x <= BLOCK_AREA_CHECK_COORD_X_2 and y <= BLOCK_AREA_CHECK_COORD_Y_2
		then
			if x >= BLOCK_AREA_CHECK_FREE_COORD_X_1 and y >= BLOCK_AREA_CHECK_FREE_COORD_Y_1 and x <= BLOCK_AREA_CHECK_FREE_COORD_X_2 and y <= BLOCK_AREA_CHECK_FREE_COORD_Y_2
			then
				return 0
			end
			
			return 1
		end
	end

	return 0
end

function BlockArea.RemoveUser(Name)
	for i, key in ipairs(Players) do
		if key == Name
		then
			Players[Name].Index = 0
			Players[Name].Block = false
			RemoveKey(Players, i)
			break
		end
	end
end

Commands.Register(BLOCK_AREA_OPEN_COMMAND, BlockArea.CommandOpen)
Commands.Register(BLOCK_AREA_CLOSE_COMMAND, BlockArea.CommandClose)
GameServerFunctions.PlayerMove(BlockArea.PlayerMove)

return BlockArea