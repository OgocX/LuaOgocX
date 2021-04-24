--[[ Rules System ]]--

Rules = {}

function Rules.Command(aIndex, Command, Arguments)
	if RULES_EVENTS_SWITCH == 0
	then
		return false
	end
	
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
	then
		return false
	end
	
	for i in ipairs(RULES_EVENTS_CONFIG) do
		if Command == RULES_EVENTS_CONFIG[i].Command
		then
			if #RULES_EVENTS_CONFIG[i].Section_1 > 0
			then
				SendMessageGlobal(string.format("%s", RULES_EVENTS_CONFIG[i].Section_1), 0)
			end
			if #RULES_EVENTS_CONFIG[i].Section_2 > 0
			then
				SendMessageGlobal(string.format("%s", RULES_EVENTS_CONFIG[i].Section_2), 0)
			end
			if #RULES_EVENTS_CONFIG[i].Section_3 > 0
			then
				SendMessageGlobal(string.format("%s", RULES_EVENTS_CONFIG[i].Section_3), 0)
			end
			if #RULES_EVENTS_CONFIG[i].Section_4 > 0
			then
				SendMessageGlobal(string.format("%s", RULES_EVENTS_CONFIG[i].Section_4), 0)
			end
			if #RULES_EVENTS_CONFIG[i].Section_5 > 0
			then
				SendMessageGlobal(string.format("%s", RULES_EVENTS_CONFIG[i].Section_5), 0)
			end
			if #RULES_EVENTS_CONFIG[i].Section_6 > 0
			then
				SendMessageGlobal(string.format("%s", RULES_EVENTS_CONFIG[i].Section_6), 0)
			end
			
			return true
		end
	end
	
	
	
	return false
end

Commands.CallCommand(Rules.Command)

return Rules