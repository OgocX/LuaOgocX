--[[ Command Hours ]]--

Hours = {}

function Hours.Command(aIndex, Arguments)
	if HORAS_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getLevel() < HORAS_LEVEL
	then
		SendMessage(string.format(HOUR_MESSAGE[Language][1], HORAS_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < HORAS_MONEY
	then
		SendMessage(string.format(HOUR_MESSAGE[Language][2], HORAS_MONEY), aIndex, 1)
		return
	end
	
	if player:getVip() < HORAS_VIP
	then
		SendMessage(string.format(HOUR_MESSAGE[Language][3]), aIndex, 1)
		return
	end
	
	if player:getReset() < HORAS_RESETS
	then
		SendMessage(string.format(HOUR_MESSAGE[Language][4], HORAS_RESETS), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < HORAS_MRESETS
	then
		SendMessage(string.format(HOUR_MESSAGE[Language][5], HORAS_MRESETS), aIndex, 1)
		return
	end
	
	local setmoney = money - HORAS_MONEY
	
	player:setMoney(setmoney)
	MoneySend(aIndex)
	
	SendMessage(string.format(os.date(HOUR_MESSAGE[Language][6])), aIndex, 1)
	
	player = nil
end

Commands.Register(HORAS_COMMAND, Hours.Command)

return Hours