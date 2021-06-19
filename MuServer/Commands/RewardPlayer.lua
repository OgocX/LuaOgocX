RewardPlayer = { }

function RewardPlayer.Command(aIndex, Arguments)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), REWARD_PLAYERS_GAME_MASTER_LEVEL) == 0
	then
		return
	end
	
	local TargetName = command:getString(Arguments, 1, 0)
	local RewardNumber = command:getNumber(Arguments, 2)
	local RewardAmount = command:getNumber(Arguments, 3)
	
	if #TargetName <= 0 or RewardNumber <= 0 or RewardAmount <= 0
	then
		SendMessage(string.format(REWARD_PLAYERS_MESSAGES[Language][1]), aIndex, 1)
		return
	end
	
	if RewardNumber > #REWARD_PLAYERS_CONFIGS
	then
		SendMessage(string.format(REWARD_PLAYERS_MESSAGES[Language][2]), aIndex, 1)
		return
	end
	
	local rewardInfo = REWARD_PLAYERS_CONFIGS[RewardNumber]
	
	if rewardInfo == nil
	then
		SendMessage(string.format(REWARD_PLAYERS_MESSAGES[Language][3]), aIndex, 1)
		return
	end
	
	if rewardInfo.MaxReward ~= -1 and RewardAmount > rewardInfo.MaxReward
	then
		SendMessage(string.format(REWARD_PLAYERS_MESSAGES[Language][4], rewardInfo.MaxReward), aIndex, 1)
		return
	end
	
	local TargetIndex = GetIndex(TargetName)
	
	if TargetIndex == -1
	then
		SendMessage(string.format(REWARD_PLAYERS_MESSAGES[Language][5], TargetName), aIndex, 1)
		return
	end
	
	local player_target = User.new(TargetIndex)
	local Language_target = player_target:getLanguage()
	
	if REWARD_ANNOUNCE_GLOBAL == 1
	then
		SendMessageGlobal(string.format("========================"), 0)
		Message.SendMessageGlobalMultLangArgs(REWARD_PLAYERS_GLOBAL_MESSAGES, 1, 0, player:getName())
		Message.SendMessageGlobalMultLangArgs(REWARD_PLAYERS_GLOBAL_MESSAGES, 2, 0, RewardAmount, rewardInfo.CoinName, TargetName)
		SendMessageGlobal(string.format("========================"), 0)
	end
	
	DataBase.SetAddValue(rewardInfo.Table, rewardInfo.Column, RewardAmount, rewardInfo.Where, player_target:getAccountID())
	SendMessage(string.format(REWARD_PLAYERS_MESSAGES[Language_target][6], RewardAmount, rewardInfo.CoinName), TargetIndex, 1)
end

function RewardPlayer.Init()
	if REWARD_PLAYERS_SWITCH == 0
	then
		return
	end
	
	Commands.Register(REWARD_PLAYERS_COMMAND, RewardPlayer.Command)
end

RewardPlayer.Init()

return RewardPlayer