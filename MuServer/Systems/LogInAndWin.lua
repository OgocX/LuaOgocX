--[[
Configs system, if you don't know don't touch!
--]]
LogInAndWin = { }

LogInAndWinPlayers = {}
LogInAndWinPlayersCanGetReward = {}

function LogInAndWin.SendGetReward(aIndex, RewardDay)
	local player = User.new(aIndex)
	
	local packetIdentification = string.format('%s-%s', LOG_IN_AND_WIN_PACKET_NAME, player:getName())
	
	CreatePacket(packetIdentification, LOG_IN_AND_WIN_PACKET)
	
	SetWordPacket(packetIdentification, RewardDay)
	
	SendPacket(packetIdentification, aIndex)
	
	ClearPacket(packetIdentification)
	
	player = nil
end

function LogInAndWin.RewardItem(playerInfo, ItensReward)
	if ItensReward ~= nil
	then
		for i = 1, #ItensReward do
			local ItemInfo = ItensReward[i]
			
			if ItemInfo == nil
			then
				goto continue
			end
			
			for i = 1, ItemInfo.Count do
				NpcRescueItem.InsertItem(playerInfo.Account, ItemInfo.ItemIndex, ItemInfo.Level, ItemInfo.Op1, ItemInfo.Op2, ItemInfo.Life, ItemInfo.Exc, ItemInfo.Ancient, ItemInfo.JoH, ItemInfo.SocketBonus, ItemInfo.Sock1, ItemInfo.Sock2, ItemInfo.Sock3, ItemInfo.Sock4, ItemInfo.Sock5, ItemInfo.DaysExpire, 0)
			end
			
			SendMessage(string.format(LOG_IN_AND_WIN_MESSAGES[playerInfo.Language][1], ItemInfo.Count, ItemInfo.Name), playerInfo.Index, 1)
			
			::continue::
		end
	end
end

function LogInAndWin.RewardCoins(playerInfo, CoinsReward)
	if CoinsReward ~= nil
	then
		for i = 1, #CoinsReward do
			local CoinInfo = CoinsReward[i]
			
			if CoinInfo == nil
			then
				goto continue
			end
			
			DataBase.SetAddValue(CoinInfo.Table, CoinInfo.Column, CoinInfo.Amounts, CoinInfo.Where, playerInfo.Account)
			SendMessage(string.format(LOG_IN_AND_WIN_MESSAGES[playerInfo.Language][1], CoinInfo.Amounts, CoinInfo.Name), playerInfo.Index, 1)
			
			::continue::
		end
	end
end

function LogInAndWin.UpdatePlayer(playerInfo)
	DataBase.SetAddValue(LOG_IN_AND_WIN_TABLE_DAY, LOG_IN_AND_WIN_COLUMN_DAY, 1, LOG_IN_AND_WIN_WHERE_DAY, playerInfo.Account)
	DataBase.SetAddValue(LOG_IN_AND_WIN_TABLE_CHECK, LOG_IN_AND_WIN_COLUMN_CHECK, 1, LOG_IN_AND_WIN_WHERE_CHECK, playerInfo.Account)
	
	local aIndex = playerInfo.Index
	
	if LogInAndWinPlayersCanGetReward[aIndex] ~= nil
	then
		LogInAndWinPlayersCanGetReward[aIndex] = nil
	end
	
	if LogInAndWinPlayers[aIndex] ~= nil
	then
		LogInAndWinPlayers[aIndex] = nil
	end
end

function LogInAndWin.RecvGetReward(aIndex, RewardDay)
	if LogInAndWinPlayersCanGetReward[aIndex] ~= nil
	then
		local player = User.new(aIndex)
		
		if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
		then
			SendMessage(string.format(LOG_IN_AND_WIN_MESSAGES[playerInfo.Language][2]), playerInfo.Index, 1)
			return
		end
		
		local playerInfo = LogInAndWinPlayersCanGetReward[aIndex]
		
		local RewardInfo = LOG_IN_AND_WIN_REWARD_BY_DAYS[playerInfo.DayPlayer]
		
		if RewardInfo ~= nil
		then
			local getReward = LOG_IN_AND_WIN_REWARDS_PLAYER[RewardInfo.Day]
			
			if getReward ~= nil
			then
				for i = 1, #getReward do
					local getInfoReward = getReward[i]
					
					if getInfoReward.RewardType == 0
					then
						LogInAndWin.RewardItem(playerInfo, LOG_IN_AND_WIN_REWARD_ITENS[getInfoReward.RewardIdentification])
					else
						LogInAndWin.RewardCoins(playerInfo, LOG_IN_AND_WIN_REWARD_COINS[getInfoReward.RewardIdentification])
					end
				end
				
				LogInAndWin.UpdatePlayer(playerInfo)
			else
				SendMessage(string.format(LOG_IN_AND_WIN_MESSAGES[playerInfo.Language][3]), aIndex, 1)
			end
		else
			SendMessage(string.format(LOG_IN_AND_WIN_MESSAGES[playerInfo.Language][4]), aIndex, 1)
		end
	end
end

function LogInAndWin.MainProc()
	if LOG_IN_AND_WIN_GET_REWARD_MIN_TIME <= 0
	then
		return
	end
	
	for keys in pairs(LogInAndWinPlayers) do
		local info = LogInAndWinPlayers[keys]
		
		if info ~= nil
		then
			local timeOnline = math.floor((GetTick() - info.LogTime) / 1000)
			
			if info.TimeOn >= LOG_IN_AND_WIN_GET_REWARD_MIN_TIME
			then
				LogInAndWinPlayersCanGetReward[info.Index] = { Index = info.Index, DayPlayer = info.DayPlayer, Name = info.Name, Account = info.Account, Language = info.Language, SendTime = GetTick() }
				
				LogInAndWin.SendGetReward(info.Index, info.DayPlayer-1)
				
				LogInAndWinPlayers[keys] = nil
				goto continue
			end
			
			if timeOnline >= 50
			then
				DataBase.SetAddValue(LOG_IN_AND_WIN_TABLE_TIMEONLINE, LOG_IN_AND_WIN_COLUMN_TIMEONLINE, timeOnline, LOG_IN_AND_WIN_WHERE_TIMEONLINE, info.Account)
				info.TimeOn = info.TimeOn + timeOnline
				info.LogTime = GetTick()
			end
			
			::continue::
		end
	end
	
	for keys in pairs(LogInAndWinPlayersCanGetReward) do
		local info = LogInAndWinPlayers[keys]
		
		if info ~= nil
		then
			local timeSend = math.floor((GetTick() - info.SendTime) / 1000)
			
			--if player don't get reward, resend in 15 minutes
			if timeSend >= 900
			then
				info.SendTime = GetTick()
				LogInAndWin.SendGetReward(info.Index, info.DayPlayer-1)
			end
		end
	end
end

function LogInAndWin.EnterCharacter(aIndex)
	local player = User.new(aIndex)
	
	local RewardDay = DataBase.GetValue(LOG_IN_AND_WIN_TABLE_DAY, LOG_IN_AND_WIN_COLUMN_DAY, LOG_IN_AND_WIN_WHERE_DAY, player:getAccountID())
	
	if RewardDay >= LOG_IN_AND_WIN_MAX_DAYS
	then
		return
	end
	
	local CheckReward = DataBase.GetValue(LOG_IN_AND_WIN_TABLE_CHECK, LOG_IN_AND_WIN_COLUMN_CHECK, LOG_IN_AND_WIN_WHERE_CHECK, player:getAccountID())
	
	if CheckReward == 0
	then
		local TimeOnline = DataBase.GetValue(LOG_IN_AND_WIN_TABLE_TIMEONLINE, LOG_IN_AND_WIN_COLUMN_TIMEONLINE, LOG_IN_AND_WIN_WHERE_TIMEONLINE, player:getAccountID())

		if TimeOnline >= LOG_IN_AND_WIN_GET_REWARD_MIN_TIME
		then
			LogInAndWinPlayersCanGetReward[aIndex] = { Index = aIndex, DayPlayer = RewardDay + 1, Name = player:getName(), Account = player:getAccountID(), Language = player:getLanguage(), SendTime = GetTick() }
			
			LogInAndWin.SendGetReward(aIndex, RewardDay)
		else
			LogInAndWinPlayers[aIndex] = { Index = aIndex, Name = player:getName(), Account = player:getAccountID(), Language = player:getLanguage(), DayPlayer = (RewardDay+1), LogTime = GetTick(), TimeOn = TimeOnline, CanReward = 0 }
		end
	end
end

function LogInAndWin.PlayerLogout(aIndex)
	if LogInAndWinPlayers[aIndex] ~= nil
	then
		local playerInfo = LogInAndWinPlayers[aIndex]
		local timeOnline = math.floor((GetTick() - playerInfo.LogTime) / 1000)
		
		if timeOnline > 5 and playerInfo.CanReward == 0
		then
			DataBase.SetAddValue(LOG_IN_AND_WIN_TABLE_TIMEONLINE, LOG_IN_AND_WIN_COLUMN_TIMEONLINE, timeOnline, LOG_IN_AND_WIN_WHERE_TIMEONLINE, playerInfo.Account)
			
			LogInAndWinPlayers[aIndex] = nil
		end
	end
	
	if LogInAndWinPlayersCanGetReward[aIndex] ~= nil
	then
		LogInAndWinPlayersCanGetReward[aIndex] = nil
	end
end

function LogInAndWin.Protocol(aIndex, Packet, PacketName)
	if Packet == LOG_IN_AND_WIN_PACKET
	then
		local player = User.new(aIndex)
		
		local packetIdentification = string.format('%s-%s', LOG_IN_AND_WIN_PACKET_NAME, player:getName())
		
		if PacketName == packetIdentification
		then
			LogInAndWin.RecvGetReward(aIndex, GetWordPacket(packetIdentification, -1))
			
			ClearPacket(PacketName)
		end
	end
end

function LogInAndWin.ResetColumn(Table, Colum)
	db = DataBase.getDb()
	
	db:exec(string.format("UPDATE %s SET %s=0", Table, Colum))
	
	db:clear()
end

function LogInAndWin.ResetDay()
	LogInAndWinPlayers = {}
	LogInAndWinPlayersCanGetReward = {}
	
	LogInAndWin.ResetColumn(LOG_IN_AND_WIN_TABLE_TIMEONLINE, LOG_IN_AND_WIN_COLUMN_TIMEONLINE)
	LogInAndWin.ResetColumn(LOG_IN_AND_WIN_TABLE_CHECK, LOG_IN_AND_WIN_COLUMN_CHECK)
	
	LogInAndWin.UpdateCharacterOnline()
end

function LogInAndWin.UpdateCharacterOnline()
	for i = OBJECT_START_USER, MAX_OBJECT do
		local player = User.new(i)
		
		if player:getConnected() == 3
		then
			LogInAndWin.EnterCharacter(i)
		end
	end
	
	collectgarbage()
end

function LogInAndWin.CreateColumns()
	DataBase.CreateColumn(LOG_IN_AND_WIN_TABLE_TIMEONLINE, LOG_IN_AND_WIN_COLUMN_TIMEONLINE, "INT NOT NULL DEFAULT 0")
	
	DataBase.CreateColumn(LOG_IN_AND_WIN_TABLE_CHECK, LOG_IN_AND_WIN_COLUMN_CHECK, "INT NOT NULL DEFAULT 0")
	
	DataBase.CreateColumn(LOG_IN_AND_WIN_TABLE_DAY, LOG_IN_AND_WIN_COLUMN_DAY, "INT NOT NULL DEFAULT 0")
end

function LogInAndWin.Init()
	if LOG_IN_AND_WIN_SWITCH == 0
	then
		return
	end
	
	--Set reset every day at: 00:00
	Schedule.SetHourAndMinute(0, 0, LogInAndWin.ResetDay)
	
	--if reload lua restart every player on
	LogInAndWin.UpdateCharacterOnline()
	
	--call functions
	GameServerFunctions.GameServerProtocol(LogInAndWin.Protocol)
	GameServerFunctions.EnterCharacter(LogInAndWin.EnterCharacter)
	GameServerFunctions.PlayerLogout(LogInAndWin.PlayerLogout)
	
	Timer.Interval(5, LogInAndWin.MainProc)
	
	--auto create columns
	Timer.TimeOut(5, LogInAndWin.CreateColumns)
end

LogInAndWin.Init()

return LogInAndWin