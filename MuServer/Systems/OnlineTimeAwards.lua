local ONLINE_TIME_AWARDS_PLAYERS = { }

OnlineTimeAwards = {}

function OnlineTimeAwards.RewardPlayerOnline(aIndex)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	local Account = player:getAccountID()
	
	for i = 1, #ONLINE_TIME_AWARDS_COINS_CONFIG do
		local rewardInfo = ONLINE_TIME_AWARDS_COINS_CONFIG[i]
		
		DataBase.SetAddValue(rewardInfo.Table, rewardInfo.Column, rewardInfo.Coins, rewardInfo.Where, Account)
		SendMessage(string.format(ONLINE_TIME_AWARDS_MESSAGES[Language][1], rewardInfo.CoinName, rewardInfo.Coins), aIndex, 1)
	end
	
	player = nil
end

function OnlineTimeAwards.MainProc()
	for keys in pairs(ONLINE_TIME_AWARDS_PLAYERS) do
		local info = ONLINE_TIME_AWARDS_PLAYERS[keys]
		
		if gObjIsConnectedGP(info.PlayerIndex) == 0
		then
			ONLINE_TIME_AWARDS_PLAYERS[keys] = nil
		else
			if ONLINE_TIME_AWARDS_OFFATTACK == 0
			then
				if gObjCheckOffAttack(info.PlayerIndex) == 1
				then
					goto continue
				end
			end
			
			if ONLINE_TIME_AWARDS_OFFSTORE == 0
			then
				if gObjCheckOffStore(info.PlayerIndex) == 1
				then
					goto continue
				end
			end
		
			if info.TimeCount >= 60
			then
				info.MinutesOnline = info.MinutesOnline + 1
				info.TimeCount = 0
			else
				info.TimeCount = info.TimeCount + 1
			end
			
			if info.MinutesOnline >= ONLINE_TIME_AWARDS_TIME
			then
				OnlineTimeAwards.RewardPlayerOnline(info.PlayerIndex)
				info.TimeCount = 0
				info.MinutesOnline = 0
			end
		end
		
		::continue::
	end
end

function OnlineTimeAwards.PlayerJoin(aIndex)
	ONLINE_TIME_AWARDS_PLAYERS[aIndex] = { PlayerIndex = aIndex, MinutesOnline = 0, TimeCount = 0 }
end

function OnlineTimeAwards.PlayerLoggout(aIndex)
	if ONLINE_TIME_AWARDS_PLAYERS[aIndex] ~= nil
	then
		ONLINE_TIME_AWARDS_PLAYERS[aIndex] = nil
	end
end

function OnlineTimeAwards.RegisterUsersOnline()
	for i = OBJECT_START_USER, MAX_OBJECT do
		if gObjIsConnectedGP(i) ~= 0
		then
			ONLINE_TIME_AWARDS_PLAYERS[i] = { PlayerIndex = i, MinutesOnline = 0, TimeCount = 0 }
		end
	end
end

function OnlineTimeAwards.Init()
	if ONLINE_TIME_AWARDS_SWITCH == 0
	then
		return
	end
	
	OnlineTimeAwards.RegisterUsersOnline()
	Timer.Interval(1, OnlineTimeAwards.MainProc)
	GameServerFunctions.EnterCharacter(OnlineTimeAwards.PlayerJoin)
	GameServerFunctions.PlayerLogout(OnlineTimeAwards.PlayerLoggout)
end

OnlineTimeAwards.Init()

return OnlineTimeAwards