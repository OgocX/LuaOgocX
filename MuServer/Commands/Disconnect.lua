--[[ Disconnect System ]]--

Disconnect = {}

function Disconnect.Command(aIndex, Arguments)
	if DISCONNECT_SWITCH == 0
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
		SendMessage(string.format(DISCONNECT_MESSAGES[Language][1], Name), aIndex, 1)
		return
	end
	
	if DISCONNECT_GLOBAL == 1
	then
		Message.SendMessageGlobalMultLang(DISCONNECT_MESSAGES, 2, 0)
		Message.SendMessageGlobalMultLangArgs(DISCONNECT_MESSAGES, 3, 0, player:getName(), Name)
	end
	
	CloseChar(TargetIndex, 0)
	
	
end

Commands.Register(DISCONNECT_COMMAND, Disconnect.Command)

return Disconnect