StartEvent = {}

function StartEvent.Command(aIndex, Arguments)
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	local arg = command:getString(Arguments, 1, 0)
	
	if arg == START_EVENT_COMMAND_BC
	then
		StartBC()
	elseif arg == START_EVENT_COMMAND_DS
	then
		StartDS()
	elseif arg == START_EVENT_COMMAND_CC
	then
		StartCC()
	elseif arg == START_EVENT_COMMAND_IT
	then
		StartIT()
	end
	
	SendMessage(string.format('System %s try to start', arg), aIndex, 1)
end

function StartEvent.Init()
	if START_EVENT_SWITCH == 0
	then
		return
	end
	
	Commands.Register(START_EVENT_COMMAND_SYNTAX, StartEvent.Command)
end

StartEvent.Init()

return StartEvent