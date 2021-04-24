--[[ Configurações Reward Player ]]--

Reward = {}

function Reward.GetReward(aIndex, Arguments)
	if REWARD_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if DataBase.GetValue(TABLE_REWARD_PLAYER, COLUMN_REWARD_PLAYER, WHERE_REWARD_PLAYER, player:getAccountID()) >= REWARD_COUNTS
	then
		SendMessage(string.format(REWARD_MESSAGES[Language][1]), aIndex, 1)
		return
	end
	
	local pInv = Inventory.new(aIndex)
	
	if REWARD_INVENTORY == 1
	then
		for i = 12, MAX_INVENTORY_RANGE do
			if pInv:isItem(i) ~= 0
			then
				SendMessage(string.format(REWARD_MESSAGES[Language][2]), aIndex, 1)
				return
			end
		end
	end
	
	for i, key in ipairs(REWARD_ITEMS) do 
		if REWARD_ITEMS[i].Class == player:getClass()
		then
			local exc = 0
				
			if REWARD_ITEMS[i].Exc1 ~= 0
			then
				exc = exc + 1
			end
			if REWARD_ITEMS[i].Exc2 ~= 0
			then
				exc = exc + 2
			end
			if REWARD_ITEMS[i].Exc3 ~= 0
			then
				exc = exc + 4
			end
			if REWARD_ITEMS[i].Exc4 ~= 0
			then
				exc = exc + 8
			end
			if REWARD_ITEMS[i].Exc5 ~= 0
			then
				exc = exc + 16
			end
			if REWARD_ITEMS[i].Exc6 ~= 0
			then
				exc = exc + 32
			end
			
			if REWARD_INVENTORY == 1
			then
				ItemSerialCreate(aIndex,236, 0, 0, GET_ITEM(REWARD_ITEMS[i].ItemSection, REWARD_ITEMS[i].ItemIndex), REWARD_ITEMS[i].Level, 255, REWARD_ITEMS[i].Luck, REWARD_ITEMS[i].Skill, REWARD_ITEMS[i].Option, exc)
			else
				ItemSerialCreate(aIndex, player:getMapNumber(), player:getX() + 1, player:getY(), GET_ITEM(REWARD_ITEMS[i].ItemSection, REWARD_ITEMS[i].ItemIndex), REWARD_ITEMS[i].Level, 255, REWARD_ITEMS[i].Luck, REWARD_ITEMS[i].Skill, REWARD_ITEMS[i].Option, exc)
			end
		end
	end
	
	if REWARD_INVENTORY == 1
	then
		SendMessage(string.format(REWARD_MESSAGES[Language][3]), aIndex, 1)
	else
		SendMessage(string.format(REWARD_MESSAGES[Language][4]), aIndex, 1)
	end
	
	DataBase.SetAddValue(TABLE_REWARD_PLAYER, COLUMN_REWARD_PLAYER, 1, WHERE_REWARD_PLAYER, player:getAccountID())
	
	
end

Commands.Register(REWARD_COMMAND, Reward.GetReward)

return Reward