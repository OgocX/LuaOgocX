--[[ Event PvP ]]--

EventPvP = {}

--[[ Functions and Variables ]]

local EVENTPVP_PARTICIPANTS = {}
local command_open = false
local started = false
local timer_check = -1
local timer = 0
local timer_finish = nil
local timer_kills = -1
local first_player = 'Sem ganhador'
local second_player = 'Sem ganhador'
local thrid_player = 'Sem ganhador'
local first_player_points = 0
local second_player_points = 0
local thrid_player_points = 0
local first_player_account = nil
local second_player_account = nil
local thrid_player_account = nil

function EventPvP.Init()
	GameServerFunctions.PlayerDie(EventPvP.PlayerDie)
	GameServerFunctions.PlayerAttack(EventPvP.PlayerAttack)
	GameServerFunctions.RespawnUser(EventPvP.RespawnUser)
	GameServerFunctions.PlayerLogout(EventPvP.PlayerLogout)

	Commands.Register(EVENT_PVP_COMMAND_OPEN, EventPvP.CommandOpen)
	Commands.Register(EVENT_PVP_COMMAND_GO, EventPvP.CommandGo)
	
	for i in ipairs(EVENT_PVP_CRON) do
		if EVENT_PVP_CRON[i].DayOfWeek ~= -1
		then
			Schedule.SetDayOfWeek(EVENT_PVP_CRON[i].DayOfWeek, EVENT_PVP_CRON[i].Hour, EVENT_PVP_CRON[i].Minute, EventPvP.Start)
		elseif EVENT_PVP_CRON[i].Day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(EVENT_PVP_CRON[i].Day, EVENT_PVP_CRON[i].Hour, EVENT_PVP_CRON[i].Minute, EventPvP.Start)
		else
			Schedule.SetHourAndMinute(EVENT_PVP_CRON[i].Hour, EVENT_PVP_CRON[i].Minute, EventPvP.Start)
		end
	end
end

function EventPvP.Start()
	EVENTPVP_PARTICIPANTS = {}
	command_open = false
	timer_check = -1
	timer_finish = -1
	timer_kills = -1
	first_player = 'Sem ganhador'
	second_player = 'Sem ganhador'
	thrid_player = 'Sem ganhador'
	first_player_points = 0
	second_player_points = 0
	thrid_player_points = 0
	first_player_account = nil
	second_player_account = nil
	thrid_player_account = nil
	
	timer = EVENT_PVP_TIMER_FOR_START
	EventPvP.StartTimer()
	Timer.Repeater(60, timer, EventPvP.StartTimer)
end

function EventPvP.StartTimer()
	if timer == 0
	then
		Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 1, 0)
		
		command_open = true
		timer = EVENT_PVP_TIMER_COMMAND_OPEN
		Timer.Repeater(1, timer, EventPvP.OpenCommand)
	else
		Message.SendMessageGlobalMultLangArgs(EVENT_PVP_MESSAGE, 2, 0, timer)
		timer = timer - 1
	end
end

function EventPvP.OpenCommand()
	if timer == 0
	then
		command_open = false
		started = true
		
		Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 3, 0)
		
		for key in ipairs(EVENTPVP_PARTICIPANTS) do
			
			local player = EVENTPVP_PARTICIPANTS[key].player
			
			if player:getConnected() ~= 3
			then
				EVENTPVP_PARTICIPANTS[key] = nil
				goto continue
			end
			
			Teleport(EVENTPVP_PARTICIPANTS[key].Index, EVENT_PVP_MAP, EVENT_PVP_COORD_X, EVENT_PVP_COORD_Y)

			::continue::
		end
		
		timer_finish = Timer.TimeOut(EVENT_PVP_DURATION * 60, EventPvP.FinishEvent)
		timer_check = Timer.Interval(1, EventPvP.CheckUser)
		timer_kills = Timer.Interval(EVENT_PVP_TIMER_KILLS, EventPvP.KillsPlayer)
	else
		Message.SendMessageGlobalMultLangArgs(EVENT_PVP_MESSAGE, 4, 0, timer)
		Message.SendMessageGlobalMultLangArgs(EVENT_PVP_MESSAGE, 5, 0, EVENT_PVP_COMMAND_GO)
		timer = timer - 1
	end
end

function EventPvP.RemoveUser(aIndex)
	if EVENTPVP_PARTICIPANTS[aIndex] ~= nil
	then
		EVENTPVP_PARTICIPANTS[aIndex] = nil
	end
end

function EventPvP.Clear()
	EVENTPVP_PARTICIPANTS = {}
	command_open = false
	started = false
	first_player = 'Sem ganhador'
	second_player = 'Sem ganhador'
	thrid_player = 'Sem ganhador'
	first_player_points = 0
	second_player_points = 0
	thrid_player_points = 0
	first_player_account = nil
	second_player_account = nil
	thrid_player_account = nil

	if timer_finish ~= -1
	then
		Timer.Cancel(timer_finish)
		timer_finish = -1
	end
	
	if timer_check ~= -1
	then
		Timer.Cancel(timer_check)
		timer_check = -1
	end
	
	if timer_kills ~= -1
	then
		Timer.Cancel(timer_kills)
		timer_kills = -1
	end
end

function EventPvP.GetCountUsers()
	local count = 0

	for key in pairs(EVENTPVP_PARTICIPANTS) do
		count = count + 1
	end

	return count
end

function EventPvP.GetRanking()
	local users = EventPvP.GetCountUsers()
	local i = 0

	for key in pairs(EVENTPVP_PARTICIPANTS) do
		local rank = users

		local n = 0
		
		for keyn in pairs(EVENTPVP_PARTICIPANTS) do
			if EVENTPVP_PARTICIPANTS[key].Index == EVENTPVP_PARTICIPANTS[keyn].Index
			then
				rank = rank -1
			elseif EVENTPVP_PARTICIPANTS[key].Points > EVENTPVP_PARTICIPANTS[keyn].Points
			then
				rank = rank -1
			elseif EVENTPVP_PARTICIPANTS[key].Points == EVENTPVP_PARTICIPANTS[keyn].Points and i < n
			then
				rank = rank -1
			end

			n = n + 1
		end
		
		EVENTPVP_PARTICIPANTS[key].rank = (rank + 1)

		i = i + 1
	end
	
	EventPvP.RegisterPlayers()
end

function EventPvP.GetPlayerRanking(ranking)
	for key in pairs(EVENTPVP_PARTICIPANTS) do
		if EVENTPVP_PARTICIPANTS[key].rank == ranking
		then
			return EVENTPVP_PARTICIPANTS[key]
		end
	end
	
	return -1
end

function EventPvP.RegisterPlayers()
	local usersOn = EventPvP.GetCountUsers()

	if usersOn >= 3
	then
		local third = EventPvP.GetPlayerRanking(3)
		if third ~= -1
		then
			thrid_player = tostring(third.UserName)
			thrid_player_points = tonumber(third.Points)
			thrid_player_account = tostring(third.Account)
		end
		
		local second = EventPvP.GetPlayerRanking(2)
		if second ~= -1
		then
			second_player = tostring(second.UserName)
			second_player_points = tonumber(second.Points)
			second_player_account = tostring(second.Account)
		end
		
		local first = EventPvP.GetPlayerRanking(1)
		if first ~= -1
		then
			first_player = tostring(first.UserName)
			first_player_points = tonumber(first.Points)
			first_player_account = tostring(first.Account)
		end
	elseif usersOn == 2
	then
		local second = EventPvP.GetPlayerRanking(2)
		if second ~= -1
		then
			second_player = tostring(second.UserName)
			second_player_points = tonumber(second.Points)
			second_player_account = tostring(second.Account)
		end
		
		local first = EventPvP.GetPlayerRanking(1)
		if first ~= -1
		then
			first_player = tostring(first.UserName)
			first_player_points = tonumber(first.Points)
			first_player_account = tostring(first.Account)
		end
	elseif usersOn == 1
	then
		local first = EventPvP.GetPlayerRanking(1)
		if first ~= -1
		then
			first_player = tostring(first.UserName)
			first_player_points = tonumber(first.Points)
			first_player_account = tostring(first.Account)
		end
	end
end

function EventPvP.ResultGlobal()
	Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 6, 0)
	Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 7, 0)
	Message.SendMessageGlobalMultLangArgs(EVENT_PVP_MESSAGE, 8, 0, { tostring(first_player), tonumber(first_player_points) })
	Message.SendMessageGlobalMultLangArgs(EVENT_PVP_MESSAGE, 9, 0,  { tostring(second_player), tonumber(second_player_points) })
	Message.SendMessageGlobalMultLangArgs(EVENT_PVP_MESSAGE, 10, 0, { tostring(second_player), tonumber(second_player_points) })
	Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 11, 0)
	
	EventPvP.RewardPlayer()
end

function EventPvP.RewardPlayer()
	if first_player ~= 'Sem ganhador'
	then
		if EVENT_PVP_REWARD_PLAYER_FIRST == 1
		then
			for i = 0 , #EVENT_PVP_REWARD_COLUMNS do
				DataBase.SetAddValue(EVENT_PVP_REWARD_TABLE, EVENT_PVP_REWARD_COLUMNS[i], EVENT_PVP_REWARD_POINTS_RANKING_FIRST, EVENT_PVP_REWARD_WHERE, first_player)
			end
			
			for i = 0 , #EVENT_PVP_REWARD_AMOUNTS_COLUMNS do
				DataBase.SetAddValue(EVENT_PVP_REWARD_AMOUNTS_TABLE, EVENT_PVP_REWARD_AMOUNTS_COLUMNS[i], EVENT_PVP_REWARD_AMOUNT_RANKING_FIRST, EVENT_PVP_REWARD_AMOUNTS_WHERE, first_player_account)
			end
		end
	end
	
	if second_player ~= 'Sem ganhador'
	then
		if EVENT_PVP_REWARD_PLAYER_SECOND == 1
		then
			for i = 0 , #EVENT_PVP_REWARD_COLUMNS do
				DataBase.SetAddValue(EVENT_PVP_REWARD_TABLE, EVENT_PVP_REWARD_COLUMNS[i], EVENT_PVP_REWARD_POINTS_RANKING_SECOND, EVENT_PVP_REWARD_WHERE, second_player)
			end
			
			for i = 0 , #EVENT_PVP_REWARD_AMOUNTS_COLUMNS do
				DataBase.SetAddValue(EVENT_PVP_REWARD_AMOUNTS_TABLE, EVENT_PVP_REWARD_AMOUNTS_COLUMNS[i], EVENT_PVP_REWARD_AMOUNT_RANKING_SECOND, EVENT_PVP_REWARD_AMOUNTS_WHERE, second_player_account)
			end
		end
	end
	
	if thrid_player ~= 'Sem ganhador'
	then
		if EVENT_PVP_REWARD_PLAYER_THIRD == 1
		then
			for i = 0 , #EVENT_PVP_REWARD_COLUMNS do
				DataBase.SetAddValue(EVENT_PVP_REWARD_TABLE, EVENT_PVP_REWARD_COLUMNS[i], EVENT_PVP_REWARD_POINTS_RANKING_THIRD, EVENT_PVP_REWARD_WHERE, thrid_player)
			end
			
			for i = 0 , #EVENT_PVP_REWARD_AMOUNTS_COLUMNS do
				DataBase.SetAddValue(EVENT_PVP_REWARD_AMOUNTS_TABLE, EVENT_PVP_REWARD_AMOUNTS_COLUMNS[i], EVENT_PVP_REWARD_AMOUNT_RANKING_THIRD, EVENT_PVP_REWARD_AMOUNTS_WHERE, thrid_player_account)
			end
		end
	end
end

function EventPvP.FinishEvent()
	Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 12, 0)
	
	EventPvP.GetRanking()
	EventPvP.ResultGlobal()
	EventPvP.Clear()
end

function EventPvP.FinishCancel()
	Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 13, 0)
	Message.SendMessageGlobalMultLang(EVENT_PVP_MESSAGE, 14, 0)
	
	EventPvP.Clear()
end

function EventPvP.KillsPlayer()
	for key in pairs(EVENTPVP_PARTICIPANTS) do
		local index = EVENTPVP_PARTICIPANTS[key].Index
		local player = EVENTPVP_PARTICIPANTS[key].player
		
		if player:getConnected() == 3
		then
			local Language = player:getLanguage()
			SendMessage(string.format(EVENT_PVP_MESSAGE[Language][15], EVENTPVP_PARTICIPANTS[key].Points), index, 1)
			SendMessage(string.format(EVENT_PVP_MESSAGE[Language][16]), index, 1)
		end
	end
end

function EventPvP.CheckUser()
	local usersOn = 0

	for key in pairs(EVENTPVP_PARTICIPANTS) do
		local index = EVENTPVP_PARTICIPANTS[key].Index
		local player = EVENTPVP_PARTICIPANTS[key].player
		local Language = player:getLanguage()
	
		if player:getConnected() ~= 3
		then
			EventPvP.RemoveUser(key)
			goto continue
		end
		
		if player:getMapNumber() ~= EVENT_PVP_MAP
		then
			SendMessage(string.format(EVENT_PVP_MESSAGE[Language][17]), index, 1)
			EventPvP.RemoveUser(key)
			goto continue
		end
		
		if player:getX() <= EVENT_PVP_COORD_CHECK_X_1 or player:getY() <= EVENT_PVP_COORD_CHECK_Y_1 or player:getX() >= EVENT_PVP_COORD_CHECK_X_2 or player:getY() >= EVENT_PVP_COORD_CHECK_Y_2
		then
			SendMessage(string.format(EVENT_PVP_MESSAGE[Language][18]), index, 1)
			Teleport(index, 0, 125, 125)
			EventPvP.RemoveUser(key)
			goto continue
		end

		usersOn = usersOn + 1
		
		::continue::
	end
	
	if EVENT_PVP_CHECK_INVASOR ~= 0
	then
		for i = OBJECT_START_USER, MAX_OBJECT do
			local player = User.new(i)
			
			if player:getConnected() == 3
			then
				if player:getMapNumber() == EVENT_PVP_MAP
				then
					if EventPvP.CheckIsParticipantIndex(i) ~= 1
					then
						if player:getX() >= EVENT_PVP_COORD_CHECK_X_1 and player:getY() >= EVENT_PVP_COORD_CHECK_Y_1 and player:getX() <= EVENT_PVP_COORD_CHECK_X_2 and player:getY() <= EVENT_PVP_COORD_CHECK_Y_2
						then
							local Language = player:getLanguage()
							
							Teleport(i, 0, 125, 125)
							SendMessage(string.format(EVENT_PVP_MESSAGE[Language][19]), i, 1)
						end
					end
				end
			end
			
			player = nil
		end
	end
	
	if usersOn < EVENT_PVP_MIN_USERS and EVENT_PVP_MIN_USERS ~= -1
	then
		if timer_finish ~= -1
		then
			Timer.Cancel(timer_finish)
			timer_finish = -1
		end
		
		EventPvP.FinishCancel()
	end
	
	collectgarbage()
end

function EventPvP.CheckIsParticipantIndex(aIndex)

	local user = EVENTPVP_PARTICIPANTS[aIndex]

	if user ~= nil
	then
		return 1
	end
	
	return 0
end

function EventPvP.CommandOpen(aIndex, Arguments)
	local player = User.new(aIndex)

	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), EVENT_PVP_GAME_MASTER_LEVEL) == 0
	then
		return
	end
	
	local Language = player:getLanguage()
	
	EVENTPVP_PARTICIPANTS = {}
	command_open = false
	timer_check = -1
	
	timer = EVENT_PVP_TIMER_FOR_START
	EventPvP.StartTimer()
	Timer.Repeater(60, timer, EventPvP.StartTimer)
	
	SendMessage(string.format(EVENT_PVP_MESSAGE[Language][20]), aIndex, 1)
end

function EventPvP.CommandGo(aIndex, Arguments)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if command_open == false
	then
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][21], EVENT_PVP_COMMAND_GO), aIndex, 1)
		return
	end
	
	if player:getLevel() < EVENT_PVP_LEVEL
	then
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][22], EVENT_PVP_LEVEL), aIndex, 1)
		return
	end
	
	if player:getClass() ~= EVENT_PVP_CLASS and EVENT_PVP_CLASS ~= -1
	then
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][23]), aIndex, 1)
		return
	end
	
	if player:getReset() < EVENT_PVP_RESETS
	then
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][24], EVENT_PVP_RESETS), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < EVENT_PVP_MRESETS
	then
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][25], EVENT_PVP_MRESETS), aIndex, 1)
		return
	end
	
	if player:getAuthority() ~= 1
	then
		Teleport(aIndex, EVENT_PVP_MAP, EVENT_PVP_COORD_X, EVENT_PVP_COORD_Y)
		return
	end
	
	if EVENTPVP_PARTICIPANTS[player:getIndex()]
	then
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][26]), aIndex, 1)
		
		Teleport(aIndex, EVENT_PVP_MAP, EVENT_PVP_COORD_X, EVENT_PVP_COORD_Y)
	else
		EVENTPVP_PARTICIPANTS[player:getIndex()] = {player = player, Index = aIndex, Account = player:getAccountID(), UserName = player:getName(), Points = 0, rank = 0}
		
		Teleport(aIndex, EVENT_PVP_MAP, EVENT_PVP_COORD_X, EVENT_PVP_COORD_Y)
		
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][27]), aIndex, 1)
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][28]), aIndex, 1)
	end
end

function EventPvP.AddPoints(aIndex, points)
	local user = EVENTPVP_PARTICIPANTS[aIndex]

	if user ~= nil
	then
		user.Points = user.Points + points
	end
end

function EventPvP.DecPoints(aIndex, points)
	local user = EVENTPVP_PARTICIPANTS[aIndex]

	if user ~= nil
	then
		user.Points = user.Points - points
	end
end

function EventPvP.SendMessagePlayer(message, messageKey, ...)
	local arg = {...}

	for key in pairs(EVENTPVP_PARTICIPANTS) do
		local player = EVENTPVP_PARTICIPANTS[key].player

		if player:getConnected() == 3
		then
			SendMessage(string.format(message[player:getLanguage()][messageKey], unpack(arg)), EVENTPVP_PARTICIPANTS[key].Index, 0)
		end
	end
end

function EventPvP.PlayerDie(aIndex, TargetIndex)
	if started == false
	then
		return
	end

	if EventPvP.CheckIsParticipantIndex(aIndex) == 1 and EventPvP.CheckIsParticipantIndex(TargetIndex) == 1
	then
		local player = User.new(aIndex)
		local Language = player:getLanguage()
		local target_player = User.new(TargetIndex)
		local LanguageTarget = target_player:getLanguage()
		
		EventPvP.AddPoints(aIndex, EVENT_PVP_POINTS_KILL)
		SendMessage(string.format(EVENT_PVP_MESSAGE[Language][29], target_player:getName(), EVENT_PVP_POINTS_KILL), aIndex, 1)
		
		if EVENT_PVP_DECREASE_POINTS == 1
		then
			EventPvP.DecPoints(TargetIndex, EVENT_PVP_POINTS_DECREASE_KILL)
			SendMessage(string.format(EVENT_PVP_MESSAGE[LanguageTarget][30], player:getName(), EVENT_PVP_POINTS_DECREASE_KILL), TargetIndex, 1)
		end
		
		if EVENT_PVP_ANNOUNCE_KILL == 1
		then
			EventPvP.SendMessagePlayer(EVENT_PVP_MESSAGE, 31, player:getName(), target_player:getName())
		end
		
		if EVENT_PVP_RESPAWN == 1
		then
			target_player:setKillerType(5)
		end
	end
end

function EventPvP.PlayerLogout(aIndex)
	if EVENTPVP_PARTICIPANTS[aIndex] ~= nil
	then
		EVENTPVP_PARTICIPANTS[aIndex] = nil
	end
end

function EventPvP.PlayerAttack(aIndex, TargetIndex)
	if command_open == false or started == true
	then
		return
	end
	
	if EventPvP.CheckIsParticipantIndex(aIndex) == 1 and EventPvP.CheckIsParticipantIndex(TargetIndex) == 1
	then
		return 1
	end
	
	return
end

function EventPvP.RespawnUser(aIndex)
	if EventPvP.CheckIsParticipantIndex(aIndex) == 1
	then
		TeleportMap(aIndex, EVENT_PVP_RESPAWN_DISTANCE)
	end
end

EventPvP.Init()

return EventPvP