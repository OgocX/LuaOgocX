--[[ Command Zen ]]--

ZenSystem = {}

function ZenSystem.Command(aIndex, Arguments)
	if ZEN_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getLevel() < ZEN_LEVEL
	then
		SendMessage(string.format(ZEN_MESSAGES[Language][1], ZEN_LEVEL), aIndex, 1)
		return
	end
	
	if player:getVip() < ZEN_VIP
	then
		SendMessage(string.format(ZEN_MESSAGES[Language][2]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if player:getReset() < ZEN_RESETS
	then
		SendMessage(string.format(ZEN_MESSAGES[Language][3], ZEN_RESETS), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < ZEN_MRESETS
	then
		SendMessage(string.format(ZEN_MESSAGES[Language][4], ZEN_MRESETS), aIndex, 1)
		return
	end
	
	local setmoney = player:getMoney() + ZEN_MAXMONEY
	
	if setmoney >= ZEN_MAXMONEY
	then
		setmoney = ZEN_MAXMONEY
	end
	
	player:setMoney(setmoney)
	MoneySend(aIndex)
	
	SendMessage(string.format(ZEN_MESSAGES[Language][5]), aIndex, 1)
	
	
end

Commands.Register(ZEN_COMMAND, ZenSystem.Command)

return ZenSystem