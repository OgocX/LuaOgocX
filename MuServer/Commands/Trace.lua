--[[ Trace System ]]--

Trace = {}

function Trace.Command(aIndex, Arguments)
	if TRACE_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	local Name = command:getString(Arguments, 1, 0)
	local TargetIndex = GetIndex(Name)
	
	if TargetIndex == -1
	then
		SendMessage(string.format(TRACE_MESSAGES[Language][1], Name), aIndex, 1)
		return
	end
	
	local player_target = User.new(TargetIndex)
	
	Teleport(aIndex,player_target:getMapNumber(), player_target:getX(), player_target:getY())
	
	
end

Commands.Register(TRACE_COMMAND, Trace.Command)

return Trace