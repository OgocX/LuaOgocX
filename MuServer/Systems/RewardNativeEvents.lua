RewardNativeEvents = {}

function RewardNativeEvents.ReceiveEventReward(aIndex, EventType)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	local CoinReward = REWARD_NATIVE_EVENTS_COINS[EventType]
	
	if CoinReward ~= nil
	then
		for i = 1, #CoinReward do
			local CoinInfo = CoinReward[i]
			
			if CoinInfo == nil
			then
				goto continue
			end
			
			DataBase.SetAddValue(CoinInfo.Table, CoinInfo.Column, CoinInfo.Amount, CoinInfo.Where, player:getAccountID())
			SendMessage(string.format(REWARD_NATIVE_EVENTS_MESSAGES[Language][1], CoinInfo.Amount, CoinInfo.Name), aIndex, 1)
			
			::continue::
		end
	end
	
	local ItensReward = REWARD_NATIVE_EVENTS_ITENS[EventType]
	
	if ItensReward ~= nil
	then
		for i = 1, #ItensReward do
			local ItemInfo = ItensReward[i]
			
			if ItemInfo == nil
			then
				goto continue
			end
			
			for i = 1, ItemInfo.Count do
				NpcRescueItem.InsertItem(player:getAccountID(), ItemInfo.ItemIndex, ItemInfo.Level, ItemInfo.Op1, ItemInfo.Op2, ItemInfo.Life, ItemInfo.Exc, ItemInfo.Ancient, ItemInfo.JoH, ItemInfo.SocketBonus, ItemInfo.Sock1, ItemInfo.Sock2, ItemInfo.Sock3, ItemInfo.Sock4, ItemInfo.Sock5, ItemInfo.DaysExpire)
			end
			
			SendMessage(string.format(REWARD_NATIVE_EVENTS_MESSAGES[Language][2], ItemInfo.Count, ItemInfo.Name), aIndex, 1)
			
			::continue::
		end
	end
end

function RewardNativeEvents.Init()
	if REWARD_NATIVE_EVENTS_SWITCH ~= 1
	then
		return
	end
	
	GameServerFunctions.ReceiveEventReward(RewardNativeEvents.ReceiveEventReward)
end

RewardNativeEvents.Init()

return RewardNativeEvents