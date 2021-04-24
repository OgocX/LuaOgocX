--[[
System Prizes
]]--

Prizes = {}

function Prizes.CommandAdd(aIndex, Command, Arguments)
	if PRIZES_SWITCH == 0
	then
		return false
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if player:getAuthority() == 1
	then
		return false
	end

	local cmd = Command
	
	for i in ipairs(PRIZES_COMMANDS) do
		if PRIZES_COMMANDS[i].Command == cmd
		then
			if PRIZES_COMMANDS[i].Players == 1
			then
				local Name = command:getString(Arguments, 1, 0)
				
				local TargetIndex = GetIndex(Name)
	
				if TargetIndex == -1
				then
					SendMessage(string.format(PRIZES_MESSAGES[Language][1], Name), aIndex, 1)
					return true
				end
				
				local target_player = User.new(TargetIndex)
				local target_language = target_player:getLanguage()
				
				SendMessageGlobal(string.format("========================="), 0)
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 2, 0, player:getName())
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 3, 0, PRIZES_COMMANDS[i].Name)
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 4, 0, target_player:getName())
				SendMessageGlobal(string.format("========================="), 0)
				
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableE, PRIZES_COMMANDS[i].ColumnE, PRIZES_COMMANDS[i].Points_1, PRIZES_COMMANDS[i].WhereE, target_player:getName())
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableA, PRIZES_COMMANDS[i].ColumnA, PRIZES_COMMANDS[i].Amounts_1, PRIZES_COMMANDS[i].WhereA, target_player:getAccountID())
				
				SendMessage(string.format(PRIZES_MESSAGES[target_language][5]), TargetIndex, 1)
				
				Message.SendMessageGlobalMultLang(PRIZES_MESSAGES, 6, 1)
			end
			
			if PRIZES_COMMANDS[i].Players == 2
			then
				local Name = command:getString(Arguments, 1, 0)
				
				local TargetIndex = GetIndex(Name)
	
				if TargetIndex == -1
				then
					SendMessage(string.format(PRIZES_MESSAGES[Language][1], Name), aIndex, 1)
					return true
				end
				
				local target_player = User.new(TargetIndex)
				local target_language = target_player:getLanguage()
				
				local Name2 = command:getString(Arguments, 2, 0)
				
				local TargetIndex2 = GetIndex(Name2)
	
				if TargetIndex2 == -1
				then
					SendMessage(string.format(PRIZES_MESSAGES[Language][1], Name2), aIndex, 1)
					return true
				end
				
				local target_player2 = User.new(TargetIndex2)
				local target_language2 = target_player2:getLanguage()
				
				SendMessageGlobal(string.format("========================="), 0)
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 2, 0, player:getName())
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 3, 0, PRIZES_COMMANDS[i].Name)
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 7, 0, target_player:getName(), target_player2:getName())
				SendMessageGlobal(string.format("========================="), 0)
				
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableE, PRIZES_COMMANDS[i].ColumnE, PRIZES_COMMANDS[i].Points_1, PRIZES_COMMANDS[i].WhereE, target_player:getName())
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableA, PRIZES_COMMANDS[i].ColumnA, PRIZES_COMMANDS[i].Amounts_1, PRIZES_COMMANDS[i].WhereA, target_player:getAccountID())
				
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableE, PRIZES_COMMANDS[i].ColumnE, PRIZES_COMMANDS[i].Points_2, PRIZES_COMMANDS[i].WhereE, target_player2:getName())
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableA, PRIZES_COMMANDS[i].ColumnA, PRIZES_COMMANDS[i].Amounts_2, PRIZES_COMMANDS[i].WhereA, target_player2:getAccountID())
				
				SendMessage(string.format(PRIZES_MESSAGES[target_language][5]), TargetIndex, 1)
				SendMessage(string.format(PRIZES_MESSAGES[target_language2][5]), TargetIndex2, 1)
				
				Message.SendMessageGlobalMultLang(PRIZES_MESSAGES, 6, 1)
			end
			
			if PRIZES_COMMANDS[i].Players == 3
			then
				local Name = command:getString(Arguments, 1, 0)
				
				local TargetIndex = GetIndex(Name)
	
				if TargetIndex == -1
				then
					SendMessage(string.format(PRIZES_MESSAGES[Language][1], Name), aIndex, 1)
					return true
				end
				
				local target_player = User.new(TargetIndex)
				local target_language = target_player:getLanguage()
				
				local Name2 = command:getString(Arguments, 2, 0)
				
				local TargetIndex2 = GetIndex(Name2)
	
				if TargetIndex2 == -1
				then
					SendMessage(string.format(PRIZES_MESSAGES[Language][1], Name2), aIndex, 1)
					return true
				end
				
				local target_player2 = User.new(TargetIndex2)
				local target_language2 = target_player2:getLanguage()
				
				local Name3 = command:getString(Arguments, 3, 0)
				
				local TargetIndex3 = GetIndex(Name3)
	
				if TargetIndex3 == -1
				then
					SendMessage(string.format(PRIZES_MESSAGES[Language][1], Name3), aIndex, 1)
					return true
				end
				
				local target_player3 = User.new(TargetIndex3)
				local target_language3 = target_player3:getLanguage()
				
				SendMessageGlobal(string.format("========================="), 0)
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 2, 0, player:getName())
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 3, 0, PRIZES_COMMANDS[i].Name)
				Message.SendMessageGlobalMultLangArgs(PRIZES_MESSAGES, 8, 0, target_player:getName(), target_player2:getName(), target_player3:getName())
				SendMessageGlobal(string.format("========================="), 0)
				
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableE, PRIZES_COMMANDS[i].ColumnE, PRIZES_COMMANDS[i].Points_1, PRIZES_COMMANDS[i].WhereE, target_player:getName())
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableA, PRIZES_COMMANDS[i].ColumnA, PRIZES_COMMANDS[i].Amounts_1, PRIZES_COMMANDS[i].WhereA, target_player:getAccountID())
				
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableE, PRIZES_COMMANDS[i].ColumnE, PRIZES_COMMANDS[i].Points_2, PRIZES_COMMANDS[i].WhereE, target_player2:getName())
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableA, PRIZES_COMMANDS[i].ColumnA, PRIZES_COMMANDS[i].Amounts_2, PRIZES_COMMANDS[i].WhereA, target_player2:getAccountID())
				
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableE, PRIZES_COMMANDS[i].ColumnE, PRIZES_COMMANDS[i].Points_3, PRIZES_COMMANDS[i].WhereE, target_player3:getName())
				DataBase.SetAddValue(PRIZES_COMMANDS[i].TableA, PRIZES_COMMANDS[i].ColumnA, PRIZES_COMMANDS[i].Amounts_3, PRIZES_COMMANDS[i].WhereA, target_player3:getAccountID())
				
				SendMessage(string.format(PRIZES_MESSAGES[target_language][5]), TargetIndex, 1)
				SendMessage(string.format(PRIZES_MESSAGES[target_language2][5]), TargetIndex2, 1)
				SendMessage(string.format(PRIZES_MESSAGES[target_language3][5]), TargetIndex3, 1)
				
				Message.SendMessageGlobalMultLang(PRIZES_MESSAGES, 6, 1)
			end
			return true
		end
	end
	
	
	
	return false
end

Commands.CallCommand(Prizes.CommandAdd)

return Prizes