--[[ Evo System ]]--

Evo = {}

function Evo.Command(aIndex, Arguments)
	if EVO_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(EVO_MESSAGE[Language][1]), aIndex, 1)
		return
	end
	
	if player:getLevel() < EVO_LEVEL
	then
		SendMessage(string.format(EVO_MESSAGE[Language][2], EVO_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < EVO_MONEY
	then
		SendMessage(string.format(EVO_MESSAGE[Language][3], EVO_MONEY), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < EVO_VIP
	then
		SendMessage(string.format(EVO_MESSAGE[Language][4]), aIndex, 1)
		return
	end
	
	local Name = player:getName()
	
	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < EVO_RESETS
	then
		SendMessage(string.format(EVO_MESSAGE[Language][5], EVO_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < EVO_MRESETS
	then
		SendMessage(string.format(EVO_MESSAGE[Language][6], EVO_MRESETS), aIndex, 1)
		return
	end
	
	local ChangeUp = player:getChangeUP()
	
	if(player:getClass() == CLASS_MG or player:getClass() == CLASS_DL or player:getClass() == CLASS_RF)
	then
		ChangeUp = ChangeUp + 1
	end
	
	if ChangeUp >= EVO_LIMIT
	then
		SendMessage(string.format(EVO_MESSAGE[Language][7]), aIndex, 1)
		return
	end
	
	player:setMoney((money - EVO_MONEY))
	MoneySend(aIndex)
	
	local loop = 3
	
	if ChangeUp == 0
	then
		loop = 3
	else
		loop = 6
	end
	
	for n = 0, loop do
		if(CheckQuestListState(aIndex,n,2) == 0)
		then
			if(n ~= 3 or player:getClass() == CLASS_DK)
			then
				AddQuestList(aIndex,n,1)
				InsertQuestReward(aIndex,n)
				AddQuestList(aIndex,n,2)
			end
		end
	end
	
	player:setSendQuestInfo(0)
	GCQuestInfoSend(aIndex)
	
	MakePreview(aIndex)
	ClearViewPort(aIndex)
	ViewportCreate(aIndex)
	
	SendMessage(string.format(EVO_MESSAGE[Language][8]), aIndex, 1)
end

Commands.Register(COMMAND_EVO, Evo.Command)

return Evo