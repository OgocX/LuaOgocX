--[[ Post System ]]--

Post = {}

local TimerPost = {}

function Post.Running()
	if #TimerPost == 0
	then
		return
	end

	local i=1
	while i <= #TimerPost do
		if math.floor(math.abs(GetTick() - TimerPost[TimerPost[i]]) / 1000) > POST_TIMER 
		then
			RemoveKey(TimerPost, i)
		else
			i = i + 1
		end
	end
end

function Post.Command(aIndex, Arguments)
	if POST_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if TimerPost[player:getName()] ~= nil
	then
		local tick = math.floor(math.abs(GetTick() - TimerPost[player:getName()]) / 1000)

		if tick < POST_TIMER
		then
			SendMessage(string.format(POST_MESSAGES[Language][1], math.floor(POST_TIMER - tick), POST_COMMAND), aIndex, 1)
			return
		end
	end
	
	if player:getLevel() < POST_LEVEL
	then
		SendMessage(string.format(POST_MESSAGES[Language][2], POST_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < POST_MONEY
	then
		SendMessage(string.format(POST_MESSAGES[Language][3], POST_MONEY), aIndex, 1)
		return
	end
	
	if player:getVip() < POST_VIP
	then
		SendMessage(string.format(POST_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if player:getReset() < POST_RESET
	then
		SendMessage(string.format(POST_MESSAGES[Language][5], POST_RESET), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < POST_MRESET
	then
		SendMessage(string.format(POST_MESSAGES[Language][6], POST_MRESET), aIndex, 1)
		return
	end
	
	local setmoney = money - POST_MONEY
	
	player:setMoney(setmoney)
	MoneySend(aIndex)
	SendMessageGlobal(string.format(POST_STRING, player:getName(), command:getString(Arguments, 1, 1)), POST_COLOR)
	
	--[[Insert Timer Post]]--
	
	if TimerPost[player:getName()] == nil
	then
		InsertKey(TimerPost, player:getName())
		TimerPost[player:getName()] = GetTick()
	else
		TimerPost[player:getName()] = GetTick()
	end
	
	
end

Commands.Register(POST_COMMAND, Post.Command)
Timer.Interval(1, Post.Running)

return Post