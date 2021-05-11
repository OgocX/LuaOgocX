--[[
System Catch
]]--

PegaPega = {}

local Players = {}
local Participantes = {}
local idtimercheck = -1
local idtimer = -1
local timer = 0
local started = false
local open = false
local firstplayer = '(1º Sem ganhador)'
local secondplayer = '(2º Sem ganhador)'
local thirdplayer = '(3º Sem ganhador)'

function PegaPega.Running()
	if timer == 0
	then
		for i, name in ipairs(Players) do 
			local index = Players[name]
			local player = User.new(index)
			
			if player:getConnected() < 3
			then
				RemoveKey(Players, i)
			else
			
				Teleport(index, CATCH_MAP, CATCH_COORDX, CATCH_COORDY)
				
				InsertKey(Participantes, name)
				Participantes[name] = index
			end
		end
		
		open = false
		Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 1, 0, CATCH_COMMAND_GO)
		
		if idtimercheck == -1
		then
			idtimercheck = Timer.Interval(5, PegaPega.CheckParticipantes)
		else
			Timer.Cancel(idtimercheck)
			
			idtimercheck = Timer.Interval(5, PegaPega.CheckParticipantes)
		end
	else
		Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 2, 0, CATCH_COMMAND_GO, timer)
		timer = timer - 1
	end
end

function PegaPega.CheckParticipantes()
	for i, name in ipairs(Participantes) do 
		local index = Participantes[name]
		local player = User.new(index)
		local Language = player:getLanguage()
		
		if player:getConnected() < 3
		then
			Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 3, 1, name)
			RemoveKey(Participantes, i)
		end
		
		if player:getMapNumber() ~= CATCH_MAP
		then
			Teleport(index, 0, 125, 125)
			Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 4, 1, name)
			RemoveKey(Participantes, i)
		end
		
		local pInv = Inventory.new(index)
		
		for i, number in ipairs({0, 1, 2, 3, 4, 5, 7}) do
			if pInv:isItem(number) == 1
			then
				SendMessage(CATCH_MESSAGE[Language][6], index, 1)
				
				Teleport(index, 0, 125, 125)
				Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 5, 1, name)
				RemoveKey(Participantes, i)
				return
			end
		end
		
		if pInv:isItem(8) == 1
		then
			if pInv:getIndex(8) == GET_ITEM(13, 2) or pInv:getIndex(8) == GET_ITEM(13, 3)
			then
				SendMessage(CATCH_MESSAGE[Language][6], index, 1)
				
				Teleport(index, 0, 125, 125)
				Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 5, 1, name)
				RemoveKey(Participantes, i)
				return
			end
		end
		
	end
	
	if CountTable(Participantes) < 1
	then
		Timer.Cancel(idtimercheck)
		idtimercheck = -1
	end
end

function PegaPega.RunningStart()
	if timer == 0
	then
		Message.SendMessageGlobalMultLang(CATCH_MESSAGE, 7, 0)
		Message.SendMessageGlobalMultLang(CATCH_MESSAGE, 8, 0)
		
		started = true
	else
		Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 9, 0, timer)
		timer = timer - 1
	end
end

function PegaPega.CommandInit(aIndex, Arguments)
	if CATCH_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if started == true
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][10], aIndex, 1))
		return
	end
	
	timer = CATCH_TIME_INIT
	
	idtimer = Timer.Repeater(1, timer, PegaPega.RunningStart)
	
	
end

function PegaPega.CommandOpen(aIndex, Arguments)
	if CATCH_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	timer = command:getNumber(Arguments, 1)
	
	if timer == 0
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][11], CATCH_COMMAND_OPEN), aIndex, 1)
		return
	end
	
	Players = {}
	Participantes = {}
	open = true
	started = false
	firstplayer = '(1º Sem ganhador)'
	secondplayer = '(2º Sem ganhador)'
	thirdplayer = '(3º Sem ganhador)'
	
	idtimer = Timer.Repeater(1, timer, PegaPega.Running)
	
	SendMessageGlobal(string.format(CATCH_MESSAGE[Language][12], player:getName(), CATCH_COMMAND_GO), 1)
end

function PegaPega.CommandResult(aIndex, Arguments)
	if CATCH_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	SendMessageGlobal(string.format("===================="), 0)
	Message.SendMessageGlobalMultLang(CATCH_MESSAGE, 13, 0)
	Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 14, 0, firstplayer)
	Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 15, 0, secondplayer)
	Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 16, 0, thirdplayer)
	SendMessageGlobal(string.format("===================="), 0)
	
	
end

function PegaPega.CommandFinish(aIndex, Arguments)
	if CATCH_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	SendMessageGlobal(string.format("===================="), 0)
	Message.SendMessageGlobalMultLang(CATCH_MESSAGE, 17, 0)
	SendMessageGlobal(string.format("===================="), 0)
	
	Timer.Cancel(idtimercheck)
	idtimercheck = -1
	started = false
	Players = {}
	Participantes = {}
end

function PegaPega.CommandGo(aIndex, Arguments)
	if CATCH_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if open == false
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][18], CATCH_COMMAND_GO), aIndex, 1)
		return
	end
	
	if player:getLevel() < CATCH_LEVEL
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][19], CATCH_LEVEL), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < CATCH_VIP
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][20]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < CATCH_RESETS
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][21], CATCH_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < CATCH_MRESETS
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][22], CATCH_MRESETS), aIndex, 1)
		return
	end
	
	if player:getAuthority(aIndex) == 1
	then
		local pInv = Inventory.new(aIndex)

		for i, number in ipairs({0, 1, 2, 3, 4, 5, 7}) do
			if pInv:isItem(number) == 1
			then
				SendMessage(string.format(CATCH_MESSAGE[Language][23]), aIndex, 1)
				SendMessage(string.format(CATCH_MESSAGE[Language][24]), aIndex, 1)
				return
			end
		end
		
		if pInv:isItem(8) == 1
		then
			if pInv:getIndex(8) == GET_ITEM(13, 2) or pInv:getIndex(8) == GET_ITEM(13, 3)
			then
				SendMessage(string.format(CATCH_MESSAGE[Language][23]), aIndex, 1)
				SendMessage(string.format(CATCH_MESSAGE[Language][24]), aIndex, 1)
				return
			end
		end
	else
		Teleport(aIndex, CATCH_MAP, CATCH_COORDX, CATCH_COORDY)
		return
	end
	
	if Players[player:getName()] == nil
	then
		InsertKey(Players, player:getName())
		
		Players[player:getName()] = aIndex
		
		SendMessage(string.format(CATCH_MESSAGE[Language][25]), aIndex, 1)
		SendMessage(string.format(CATCH_MESSAGE[Language][26]), aIndex, 1)
	else
		SendMessage(string.format(CATCH_MESSAGE[Language][25]), aIndex, 1)
	end
end

function PegaPega.Move(aIndex, map, x, y, sx, sy)
	if started == false
	then
		return
	end

	if map ~= CATCH_MAP
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if sx < CATCH_CHECK_COORDX1 or sy > CATCH_CHECK_COORDY1 or sx > CATCH_CHECK_COORDX2 or sy < CATCH_CHECK_COORDY2
	then
		SendMessage(string.format(CATCH_MESSAGE[Language][27]), aIndex, 1)
		Teleport(aIndex, 0, 125, 125)
		RemoverTable(Participantes, player:getName())
		return
	end

	if player:getAuthority() == 1
	then
		return
	end

	playercatch = {}
	
	for i = 0, 74 do
		if (player:getTargetState(i) == 1 or player:getTargetState(i) == 2) and player:getTargetType(i) == 1
		then
			local TargetIndex = player:getTargetNumber(i)
			local viewport_target = User.new(TargetIndex)
			
			if viewport_target:getAuthority() == 1
			then
				local distanc = Distance(player:getX(), viewport_target:getX(), player:getY(), viewport_target:getY())
				
				if distanc ~= 0 and distanc < 3
				then
					InsertKey(playercatch, viewport_target:getName())
					playercatch[viewport_target:getName()] = TargetIndex
				end
			end

			viewport_target = nil
		end
	end
	
	table.sort(playercatch)
	
	if CountTable(playercatch) > 0
	then
		local target = playercatch[1]
		local TargetIndex = playercatch[target]
		local target_player = User.new(TargetIndex)
		local target_Language = target_player:getLanguage()
		
		if Participantes[target] ~= nil
		then
			SendMessage(string.format(CATCH_MESSAGE[target_Language][28], player:getName()), TargetIndex, 1)
			SendMessage(string.format(CATCH_MESSAGE[Language][29], target), aIndex, 1)
			
			local total = CountTable(Participantes)
			
			SkillSend(aIndex, 3, TargetIndex, 1)
			
			Teleport(TargetIndex, 0, 125, 125)
			
			RemoverTable(Participantes, target)
			
			if total > 3
			then
				Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 30, 0, target, player:getName())
			elseif total == 3
			then
				Message.SendMessageGlobalMultLang(CATCH_MESSAGE, 31, 0)
				Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 32, 0, target, player:getName())
				
				thirdplayer = target
				
			elseif total == 2
			then
				Message.SendMessageGlobalMultLang(CATCH_MESSAGE, 33, 0)
				Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 34, 0, target, player:getName())
				
				secondplayer = target
				
			elseif total == 1
			then
				SendMessageGlobal(string.format("===================="), 0)
				Message.SendMessageGlobalMultLangArgs(CATCH_MESSAGE, 35, 0, target)
				SendMessageGlobal(string.format("===================="), 0)
				
				firstplayer = target
			else
				SendMessageGlobal(string.format("===================="), 0)
				Message.SendMessageGlobalMultLangArgs(sCATCH_MESSAGE, 35, 0, target)
				SendMessageGlobal(string.format("===================="), 0)
				
				firstplayer = target
			end
		end
	end
end

Commands.Register(CATCH_COMMAND_OPEN, PegaPega.CommandOpen)
Commands.Register(CATCH_COMMAND_GO, PegaPega.CommandGo)
Commands.Register(CATCH_COMMAND_INIT, PegaPega.CommandInit)
Commands.Register(CATCH_COMMAND_RESULT, PegaPega.CommandResult)
Commands.Register(CATCH_COMMAND_FINISH, PegaPega.CommandFinish)

GameServerFunctions.PlayerMove(PegaPega.Move)

return PegaPega