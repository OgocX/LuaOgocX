--[[
Sistema Count
]]--

local Count = {}
local timeofcount = 0

function Count.Command(aIndex, Arguments)
	if COUNT_COMMAND_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	timeofcount = COUNT_TIME
	
	Timer.Repeater(1, timeofcount, Count.Init)
end

function Count.Init()
	if timeofcount == 0
	then
		Message.SendMessageGlobalMultLang(COUNT_MESSAGES, 1, 0)
	else
		SendMessageGlobal(string.format("%d", timeofcount), 0)
		timeofcount = timeofcount - 1
	end
end

Commands.Register(COUNT_COMMAND, Count.Command)

return Count