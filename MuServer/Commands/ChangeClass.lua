--[[ Change Class System ]]--
ChangeClass = {}

function ChangeClass.Command(aIndex, Arguments, Type)
	if COMMAND_CHANGE_CLASS_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][1]), aIndex, 1)
		return
	end
	
	if player:getLevel() < COMMAND_CHANGE_CLASS_LEVEL
	then
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][2], COMMAND_CHANGE_CLASS_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < COMMAND_CHANGE_CLASS_MONEY
	then
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][3], COMMAND_CHANGE_CLASS_MONEY), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < COMMAND_CHANGE_CLASS_VIP
	then
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < COMMAND_CHANGE_CLASS_RESETS
	then
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][5], COMMAND_CHANGE_CLASS_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < COMMAND_CHANGE_CLASS_MRESETS
	then
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][6], COMMAND_CHANGE_CLASS_MRESETS), aIndex, 1)
		return
	end
	
	local pInv = Inventory.new(aIndex)
	
	for i = 0, 11 do
		if pInv:isItem(i) == 1
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][7]), aIndex, 1)
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][8]), aIndex, 1)
			return
		end
	end
	
	local refresh = 0
	local class = 0
	local dbclass = 0
	
	if Type == 1 --SM
	then
		if player:getClass() == CLASS_DW
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][9]), aIndex, 1)
			return
		end
		
		class = CLASS_DW
		dbclass = DB_CLASS_DW
		refresh = 1
		
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][10]), aIndex, 1)
		
	elseif Type == 2 --BK
	then
		if player:getClass() == CLASS_DK
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][11]), aIndex, 1)
			return
		end
		
		class = CLASS_DK
		dbclass = DB_CLASS_DK
		refresh = 1
		
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][12]), aIndex, 1)
		
	elseif Type == 3 --ELF
	then
		if player:getClass() == CLASS_FE
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][13]), aIndex, 1)
			return
		end
		
		class = CLASS_FE
		dbclass = DB_CLASS_FE
		refresh = 1
		
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][14]), aIndex, 1)
		
	elseif Type == 4 --MG
	then
		if player:getClass() == CLASS_MG
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][15]), aIndex, 1)
			return
		end
		
		class = CLASS_MG
		dbclass = DB_CLASS_MG
		refresh = 1
		
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][16]), aIndex, 1)
		
	elseif Type == 5 --DL
	then
		if player:getClass() == CLASS_DL
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][17]), aIndex, 1)
			return
		end
		
		class = CLASS_DL
		dbclass = DB_CLASS_DL
		refresh = 1

		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][18]), aIndex, 1)
		
	elseif Type == 6 --SUM
	then
		if player:getClass() == CLASS_SU
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][19]), aIndex, 1)
			return
		end
		
		class = CLASS_SU
		dbclass = DB_CLASS_SU
		refresh = 1
		
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][20]), aIndex, 1)
		
	elseif Type == 7 --RF
	then
		if player:getClass() == CLASS_RF
		then
			SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][21]), aIndex, 1)
			return
		end
		
		class = CLASS_RF
		dbclass = DB_CLASS_RF
		refresh = 1
		
		SendMessage(string.format(CHANGE_CLASS_MESSAGES[Language][22]), aIndex, 1)
	end
	
	if (refresh == 1)
	then
		
		player:setClass(class)
		player:setDbClass(dbclass)
		player:setChangeUP(player:getDbClass()%16)
		
		local NewClass = player:getDbClass() * 16
		NewClass = NewClass - (NewClass/32);
		NewClass = NewClass + (player:getClass()*32);
		
		SendQuestPrize(aIndex, 201, NewClass)
		ResetQuest(aIndex)
		GCQuestInfoSend(aIndex)
		
		player:setMasterLevel(0)
		player:setMasterPoint(0)
		player:setMasterExperience(0)
	
		--Refresh
		ClearAllBuff(aIndex)
		MakePreview(aIndex)
		ClearViewPort(aIndex)
		ViewportCreate(aIndex)
		ResetSkills(aIndex)
		CalCharacter(aIndex)
	end
	
	
end

Commands.Register(COMMAND_CHANGE_CLASS_SM, ChangeClass.Command, 1)
Commands.Register(COMMAND_CHANGE_CLASS_BK, ChangeClass.Command, 2)
Commands.Register(COMMAND_CHANGE_CLASS_ELF, ChangeClass.Command, 3)
Commands.Register(COMMAND_CHANGE_CLASS_MG, ChangeClass.Command, 4)
Commands.Register(COMMAND_CHANGE_CLASS_DL, ChangeClass.Command, 5)
Commands.Register(COMMAND_CHANGE_CLASS_SUM, ChangeClass.Command, 6)
Commands.Register(COMMAND_CHANGE_CLASS_RF, ChangeClass.Command, 7)

return ChangeClass