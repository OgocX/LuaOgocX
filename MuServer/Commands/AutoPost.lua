local AutoPost = {}
local AUTO_POST_USER_DATE = {}

function AutoPost.Command(aIndex, Arguments)
	if AUTO_POST_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	local prefix = command:getString(Arguments, 1, 0)
	
	if string.lower(prefix) == "off"
	then
		if AUTO_POST_USER_DATE[player:getName()]
		then
			SendMessage(string.format(AUTO_POST_MESSAGES[Language][1]), aIndex, 1)
			AUTO_POST_USER_DATE[player:getName()] = nil
		end
		return
	end
	
	if AUTO_POST_USER_DATE[player:getName()]
	then
		SendMessage(string.format(AUTO_POST_MESSAGES[Language][2], AUTO_POST_COMMAND), aIndex, 1)
		return
	end
	
	if player:getLevel() < AUTO_POST_LEVEL
	then
		SendMessage(string.format(AUTO_POST_MESSAGES[Language][3], AUTO_POST_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < AUTO_POST_MONEY
	then
		SendMessage(string.format(AUTO_POST_MESSAGES[Language][4], AUTO_POST_MONEY), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < AUTO_POST_VIP
	then
		SendMessage(string.format(AUTO_POST_MESSAGES[Language][5]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < AUTO_POST_RESET
	then
		SendMessage(string.format(AUTO_POST_MESSAGES[Language][6], AUTO_POST_RESET), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < AUTO_POST_MRESET
	then
		SendMessage(string.format(AUTO_POST_MESSAGES[Language][7], AUTO_POST_MRESET), aIndex, 1)
		return
	end
	
	local setmoney = money - AUTO_POST_MONEY
	
	player:setMoney(setmoney)
	MoneySend(aIndex)
	
	local post_string = command:getString(Arguments, 1, 1)
	
	AUTO_POST_USER_DATE[player:getName()] = {index = aIndex, timer = AUTO_POST_TIMER, text = post_string}
	
	SendMessageGlobal(string.format(AUTO_POST_STRING, player:getName(), post_string), AUTO_POST_COLOR)
	
	
end

function AutoPost.MainProc()
	for name, tab in pairs(AUTO_POST_USER_DATE) do
		local u = AUTO_POST_USER_DATE[name]
		local player = User.new(u.index)
		
		if player:getConnected() == 3
		then
			u.timer = u.timer - 1
			
			if u.timer <= 0
			then
				SendMessageGlobal(string.format(AUTO_POST_STRING, player:getName(), u.text), AUTO_POST_COLOR)
				u.timer = AUTO_POST_TIMER
			end
		end
	end
end

function AutoPost.PlayerLoggout(aIndex, Name)
	local player = User.new(aIndex)

	if AUTO_POST_USER_DATE[player:getName()]
	then
		AUTO_POST_USER_DATE[player:getName()] = nil
	end
end

Commands.Register(AUTO_POST_COMMAND, AutoPost.Command)
GameServerFunctions.PlayerLogout(AutoPost.PlayerLoggout)
Timer.Interval(1, AutoPost.MainProc)

return AutoPost