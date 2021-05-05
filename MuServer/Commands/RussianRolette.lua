RussianRolette = {}

local RussianRolettePlayers = {}

local RussianRoletteOpen = false
local RussianRoletteStarted = false
local RussianRoletteIdTimerCheck = -1
local RussianRoletteIdTimer = -1
local RussianRoletteTimer = 0

function RussianRolette.TimeStart()
	if RussianRoletteTimer == 0
	then
		Message.SendMessageGlobalMultLang(RUSSIAN_ROLETTE_MESSAGES, 3, 0)
		
		RussianRoletteOpen = false
		RussianRoletteStarted = true
		
		RussianRolette.MoveUsers()
		RussianRolette.StartStand()
	else
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 1, 0, RussianRoletteTimer)
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 2, 0, RUSSIAN_ROLETTE_COMMAND)
		RussianRoletteTimer = RussianRoletteTimer - 1
	end
end

function RussianRolette.StartStand()
	local usersInEvent = RussianRolette.GetCountUser()
	
	if usersInEvent < RUSSIAN_ROLETTE_MIN_USERS
	then
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 29, 0, RUSSIAN_ROLETTE_MIN_USERS)
		return
	end
	
	RussianRoletteTimer = 5
	Timer.Repeater(1, RussianRoletteTimer, RussianRolette.TimeStand)
end

function RussianRolette.TimeStand()
	if RussianRoletteTimer == 0
	then
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 25, 0, RussianRoletteTimer)
		
		RussianRoletteIdTimerCheck = Timer.Interval(5, RussianRolette.TimeRunning)
	else
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 10, 0, RussianRoletteTimer)
		RussianRoletteTimer = RussianRoletteTimer - 1
	end
end

function RussianRolette.FinishEvent()
	if RussianRoletteIdTimerCheck ~= -1
	then
		Timer.Cancel(RussianRoletteIdTimerCheck)
	end
	
	RussianRolettePlayers = {}

	RussianRoletteOpen = false
	RussianRoletteStarted = false
	RussianRoletteIdTimerCheck = -1
	RussianRoletteIdTimer = -1
	RussianRoletteTimer = 0
	
	Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 24, 0)
end

function RussianRolette.GetUsersLucky()
	UsersLucky = {}
	
	local count = 1
	
	for i in pairs(RussianRolettePlayers) do
		local playerInfo = RussianRolettePlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 1
		then
			UsersLucky[count] = playerInfo.PlayerIndex
			count = count + 1
		end
	end
	
	return UsersLucky
end

function RussianRolette.HitPlayer(playerInfo)
	if playerInfo == nil
	then
		return
	end
	
	SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[playerInfo.Language][27]), playerInfo.PlayerIndex, 1)
	
	KillPlayer(playerInfo.PlayerIndex)
	
	--Teleport(playerInfo.PlayerIndex, RUSSIAN_ROLETTE_TELEPORT_LOSE_MAP, RUSSIAN_ROLETTE_TELEPORT_LOSE_X, RUSSIAN_ROLETTE_TELEPORT_LOSE_Y)
	
	playerInfo = nil
end

function RussianRolette.FireOnPlayer()
	local UsersLucky = RussianRolette.GetUsersLucky()
	
	if #UsersLucky > 0
	then
		math.randomseed(os.time())
		math.random(0, 200)
		
		hit = math.random(1, #UsersLucky)
		
		local player = RussianRolettePlayers[UsersLucky[hit]]
		
		if player ~= nil
		then
			testLucky = math.random(0, 2)
			
			if testLucky >= 1
			then
				--Hit player
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 11, 0)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 13, 0)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 17, 0, player.PlayerName)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 13, 0)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 12, 0)
				
				RussianRolette.HitPlayer(player)
			else
				--Unhurt
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 11, 0)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 13, 0)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 18, 0, player.PlayerName)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 13, 0)
				Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 12, 0)
				
				SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[playerInfo.Language][31]), playerInfo.PlayerIndex, 1)
			end
		end
	else
		Message.SendMessageGlobalMultLang(RUSSIAN_ROLETTE_MESSAGES, 26, 0)
		RussianRolette.FinishEvent()
	end
	
	UsersLucky = nil
end

function RussianRolette.TimeRunning()
	--Check users if are in map and areas
	RussianRolette.CheckUser()

	local usersInEvent = RussianRolette.GetCountUser()
	
	if (usersInEvent <= 0)
	then
		RussianRolette.FinishEvent()
		return
	end
	
	if (RussianRolette.CheckFinalists(usersInEvent) == 1)
	then
		RussianRolette.FinishEvent()
		return
	end
	
	if usersInEvent >= 2
	then
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 11, 0)
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 14, 0)
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 13, 0)
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 15, 0)
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 13, 0)
		Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 16, 0)
		
		Timer.TimeOut(2, RussianRolette.FireOnPlayer)
	end
end

function RussianRolette.CheckFinalists(usersInEvent)
	if usersInEvent == 1
	then
		local playerInfo = RussianRolette.GetLastUser()
		
		if playerInfo ~= -1
		then
			Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 11, 0)
			Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 20, 0)
			Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 21, 0, playerInfo.PlayerName)
			Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 12, 0)
			
			SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[playerInfo.Language][28]), playerInfo.PlayerIndex, 1)
			
			for i = 1, #RUSSIAN_ROLETTE_REWARD_TABLES do
				local reward = RUSSIAN_ROLETTE_REWARD_TABLES[i]
				
				DataBase.SetAddValue(reward.Table, reward.Column, reward.Amount, reward.Where, playerInfo.PlayerAccount)
				SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[playerInfo.Language][31], reward.Amount, reward.CoinName), playerInfo.PlayerIndex, 1)
			end
			return 1
		end
	end
end

function RussianRolette.GetLastUser()
	for i in pairs(RussianRolettePlayers) do
		local playerInfo = RussianRolettePlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 1
		then
			return playerInfo
		end
	end
	
	return -1
end

function RussianRolette.GetCountUser()
	local count = 0
	
	for i in pairs(RussianRolettePlayers) do
		local playerInfo = RussianRolettePlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 0
		then
			RussianRolettePlayers[i] = nil
			goto continue
		end
		
		count = count + 1
		
		::continue::
	end
	
	return count
end

function RussianRolette.CheckUser()
	for i in pairs(RussianRolettePlayers) do
		local playerInfo = RussianRolettePlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 0
		then
			RussianRolettePlayers[i] = nil
			goto continue
		end
		
		local player = User.new(playerInfo.PlayerIndex)
		
		if player:getConnected() < 3
		then
			RussianRolettePlayers[i] = nil
			goto continue
		end
		
		local Language = player:getLanguage()
		
		if player:getMapNumber() ~= RUSSIAN_ROLETTE_MAP
		then
			SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][22]), playerInfo.PlayerIndex, 1)
			RussianRolettePlayers[i] = nil
			goto continue
		end
		
		if RUSSIAN_ROLLETTE_CHECK_AREA == 1
		then
			if player:getX() <= RUSSIAN_ROLLETTE_CHECK_AREA_X1 or player:getY() <= RUSSIAN_ROLLETTE_CHECK_AREA_Y1
				or player:getX() >= RUSSIAN_ROLLETTE_CHECK_AREA_X2 or player:getY() >= RUSSIAN_ROLLETTE_CHECK_AREA_Y2
			then
				SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][22]), playerInfo.PlayerIndex, 1)
				RussianRolettePlayers[i] = nil
				goto continue
			end
		end
		
		::continue::
	end
end

function RussianRolette.MoveUsers()
	for i in pairs(RussianRolettePlayers) do
		local playerInfo = RussianRolettePlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 0
		then
			goto continue
		end
		
		Teleport(playerInfo.PlayerIndex, RUSSIAN_ROLETTE_MAP, RUSSIAN_ROLETTE_COORD_X, RUSSIAN_ROLETTE_COORD_Y)
		
		::continue::
	end
end

function RussianRolette.StartEvent()
	--Clear var
	RussianRolettePlayers = {}
	RussianRoletteStarted = false
	RussianRoletteIdTimerCheck = -1
	RussianRoletteIdTimer = -1
	
	--Set command open
	RussianRoletteOpen = true
	
	--Set time for start event
	RussianRoletteTimer = RUSSIAN_ROLETTE_TIME_START
	--Print player start event
	RussianRolette.TimeStart()
	--Create timer for count minutes for event open
	Timer.Repeater(60, RussianRoletteTimer, RussianRolette.TimeStart)
end

--[[
Enter in event when as open
]]--
function RussianRolette.CommandEnter(aIndex, Arguments)
	if RUSSIAN_ROLETTE_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if RussianRoletteOpen == false
	then
		SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	if player:getLevel() < RUSSIAN_ROLETTE_LEVEL
	then
		SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][5], RUSSIAN_ROLETTE_LEVEL), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < RUSSIAN_ROLETTE_RESET
	then
		SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][6], RUSSIAN_ROLETTE_RESET), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < RUSSIAN_ROLETTE_MRESET
	then
		SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][7], RUSSIAN_ROLETTE_MRESET), aIndex, 1)
		return
	end
	
	if (RussianRolettePlayers[aIndex] ~= nil)
	then
		SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][8]), aIndex, 1)
	else
		local usersInEvent = RussianRolette.GetCountUser()
		
		if usersInEvent >= RUSSIAN_ROLETTE_MAX_USERS
		then
			SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][30]), aIndex, 1)
			return
		end
		
		RussianRolettePlayers[aIndex] = { PlayerIndex = aIndex, PlayerName = Name, PlayerAccount = player:getAccountID(), Language = Language }
		
		SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][8]), aIndex, 1)
		SendMessage(string.format(RUSSIAN_ROLETTE_MESSAGES[Language][9]), aIndex, 1)
	end
end

--[[
Start command STAFF
]]--
function RussianRolette.CommandStart(aIndex, Arguments)
	if RUSSIAN_ROLETTE_COMMAND_STAFF_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if (RussianRoletteOpen == true or RussianRoletteStarted == true)
	then
		SendMessage(string.format('Russian rolette wash open now!'), aIndex, 1)
		return
	end
	
	Message.SendMessageGlobalMultLangArgs(RUSSIAN_ROLETTE_MESSAGES, 23, 1, player:getName())
	
	RussianRolette.StartEvent()
end

function RussianRolette.PlayerAttack(aIndex, TargetIndex)
	if RUSSIAN_ROLETTE_SWITCH == 0
	then
		return
	end
	
	if RussianRoletteOpen == false and RussianRoletteStarted == false
	then
		return
	end
	
	if RussianRolettePlayers[aIndex] ~= nil or RussianRolettePlayers[TargetIndex] ~= nil
	then
		return 1
	end
end

function RussianRolette.PlayerLogout(aIndex)
	if RUSSIAN_ROLETTE_SWITCH == 0
	then
		return
	end
	
	if RussianRoletteOpen == false and RussianRoletteStarted == false
	then
		return
	end
	
	if RussianRolettePlayers[aIndex] ~= nil
	then
		RussianRolettePlayers[aIndex] = nil
	end
end

function RussianRolette.Init()
	if RUSSIAN_ROLETTE_SWITCH == 0
	then
		return
	end
	
	--Register Funcs
	Commands.Register(RUSSIAN_ROLETTE_COMMAND_STAFF, RussianRolette.CommandStart)
	Commands.Register(RUSSIAN_ROLETTE_COMMAND, RussianRolette.CommandEnter)
	GameServerFunctions.PlayerAttack(RussianRolette.PlayerAttack)
	GameServerFunctions.PlayerLogout(RussianRolette.PlayerLogout)
	
	--Register Time Start
	for i in pairs(RUSSIAN_ROLETTE_DATE) do
		if RUSSIAN_ROLETTE_DATE[i].DayOfWeek ~= -1
		then
			Schedule.SetDayOfWeek(RUSSIAN_ROLETTE_DATE[i].DayOfWeek, RUSSIAN_ROLETTE_DATE[i].Hour, RUSSIAN_ROLETTE_DATE[i].Minute, RussianRolette.StartEvent)
		elseif RUSSIAN_ROLETTE_DATE[i].Day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(RUSSIAN_ROLETTE_DATE[i].Day, RUSSIAN_ROLETTE_DATE[i].Hour, RUSSIAN_ROLETTE_DATE[i].Minute, RussianRolette.StartEvent)
		else
			Schedule.SetHourAndMinute(RUSSIAN_ROLETTE_DATE[i].Hour, RUSSIAN_ROLETTE_DATE[i].Minute, RussianRolette.StartEvent)
		end
	end
end

RussianRolette.Init()

return RussianRolette