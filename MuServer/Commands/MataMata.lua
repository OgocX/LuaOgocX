--[[Configurações System Mata-Mata]]--

MataMata = {}

local Players = {}
local Participantes = {}
local started = false
local open = false
local idtimercheck = -1
local idtimerParticipante = -1
local idtimer = -1
local side = 0
local Fight1 = nil
local Fight2 = nil
local StepRunning = 0

function MataMata.CheckParticipantes()
	for i, name in ipairs(Participantes) do 
		local index = Participantes[name].Index
		local player = User.new(index)
		
		if player:getConnected() < 3
		then
			Message.SendMessageGlobalMultLangArgs(MATA_MATA_MESSAGE, 1, 1, name)
			Participantes[name].Index = -1
			RemoveKey(Participantes, i)
		end
		
		if player:getMapNumber() ~= KILL_MAP
		then
			Teleport(index, 0, 125, 125)
			Message.SendMessageGlobalMultLangArgs(MATA_MATA_MESSAGE, 2, 1, name)
			Participantes[name].Index = -1
			RemoveKey(Participantes, i)
		end
		
		if player:getMapNumber() == KILL_MAP
		then
			if player:getX() <= KILL_AREA_CHECK_COORD_X_1 or player:getY() <= KILL_AREA_CHECK_COORD_Y_1 or player:getX() >= KILL_AREA_CHECK_COORD_X_2 or player:getY() >= KILL_AREA_CHECK_COORD_Y_2
			then
				Teleport(index, 0, 125, 125)
				Message.SendMessageGlobalMultLangArgs(MATA_MATA_MESSAGE, 3, 1, name)
				Participantes[name].Index = -1
				RemoveKey(Participantes, i)
			end
		end
		
		
	end
	
	if CountTable(Participantes) < 1
	then
		if idtimercheck ~= -1
		then
			Timer.Cancel(idtimercheck)
			idtimercheck = -1
		end
		
		if idtimerParticipante ~= -1
		then
			Timer.Cancel(idtimerParticipante)
			idtimerParticipante = -1
		end
	end
end

function MataMata.CheckIntruders()
	if KILL_CHECK_USERS == 1
	then
		for i = OBJECT_START_USER, MAX_OBJECT do
			local player = User.new(i)
			
			if player:getConnected() == 3
			then
				if player:getAuthority() == 1
				then
					if player:getMapNumber() == KILL_MAP
					then
						if MataMata.IsParticipante() == 0
						then
							if player:getX() >= KILL_AREA_CHECK_COORD_X_1 and player:getY() >= KILL_AREA_CHECK_COORD_Y_1 and player:getX() <= KILL_AREA_CHECK_COORD_X_2 and player:getY() <= KILL_AREA_CHECK_COORD_Y_2
							then
								Teleport(i, 0, 125, 125)
								SendMessage(MATA_MATA_MESSAGE[player:getLanguage()][4], i, 1)
							end
						end
					end
				end
			end
			
			
		end
	end
	
	collectgarbage()
end

function MataMata.IsParticipante(index)
	local IsParticipante = 0
	
	for i, name in ipairs(Participantes) do 
		if Participantes[name].Index == index
		then
			IsParticipante = 1
			break
		end
	end
	
	return IsParticipante
end

function MataMata.Running()
	if timer == 0
	then
		for i, name in ipairs(Players) do 
			local index = Players[name]
			local player = User.new(index)
			
			if player:getConnected() < 3
			then
				RemoveKey(Players, i)
			else
				Teleport(index, KILL_MAP, KILL_COORD_X, KILL_COORD_Y)
				
				InsertKey(Participantes, name)
				Participantes[name] = {Index = index, Step = 1}
			end
			
			
		end
		
		open = false
		Message.SendMessageGlobalMultLangArgs(MATA_MATA_MESSAGE, 5, 0, KILL_COMMAND_GO)
		
		if idtimercheck == -1
		then
			idtimercheck = Timer.Interval(5, MataMata.CheckParticipantes)
		else
			Timer.Cancel(idtimercheck)
			
			idtimercheck = Timer.Interval(5, MataMata.CheckParticipantes)
		end
		
		if idtimerParticipante == -1
		then
			idtimerParticipante = Timer.Interval(10, MataMata.CheckIntruders)
		else
			Timer.Cancel(idtimerParticipante)
			
			idtimerParticipante = Timer.Interval(10, MataMata.CheckIntruders)
		end
	else
		Message.SendMessageGlobalMultLangArgs(MATA_MATA_MESSAGE, 6, 0, KILL_COMMAND_GO, timer)
		timer = timer - 1
	end
end

function MataMata.CommandOpen(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	local Language = player:getLanguage()
	
	timer = command:getNumber(Arguments, 1)
	
	if timer == 0
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][7], KILL_COMMAND_OPEN), aIndex, 1)
		return
	end
	
	open = true
	started = false
	Players = {}
	Participantes = {}
	Fight1 = nil
	Fight2 = nil
	
	idtimer = Timer.Repeater(1, timer, MataMata.Running)
	
	Message.SendMessageGlobalMultLangArgs(MATA_MATA_MESSAGE, 8, 1, player:getName(), KILL_COMMAND_GO)
	
	
end

function MataMata.CommandGo(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if open == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][9], KILL_COMMAND_GO), aIndex, 1)
		return
	end
	
	if player:getLevel() < KILL_LEVEL
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][10], KILL_LEVEL), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < KILL_VIP
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][11]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < KILL_RESETS
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][12], KILL_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < KILL_MRESETS
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][13], KILL_MRESETS), aIndex, 1)
		return
	end
	
	if player:getAuthority() ~= 1
	then
		Teleport(aIndex, KILL_MAP, KILL_COORD_X, KILL_COORD_Y)
		return
	end
	
	if Players[player:getName()] == nil
	then
		InsertKey(Players, player:getName())
		
		Players[player:getName()] = aIndex
		
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][14]), aIndex, 1)
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][15]), aIndex, 1)
	else
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][14]), aIndex, 1)
	end
	
	
end

function MataMata.CommandInit(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	SendMessageGlobal(string.format("========================"), 0)
	Message.SendMessageGlobalMultLang(MATA_MATA_MESSAGE, 16, 0)
	SendMessageGlobal(string.format("========================"), 0)
	
	started = true
end

function MataMata.CommandFinish(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if started == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][17]), aIndex, 1)
		return
	end
	
	SendMessageGlobal(string.format("========================"), 0)
	Message.SendMessageGlobalMultLang(MATA_MATA_MESSAGE, 18, 0)
	SendMessageGlobal(string.format("========================"), 0)
	
	Timer.Cancel(idtimercheck)
	Timer.Cancel(idtimerParticipante)
	idtimercheck = -1
	idtimerParticipante = -1
	started = false
	Players = {}
	Participantes = {}
	StepRunning = 0
	
	
end

function MataMata.CommandStep(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	local Step = command:getNumber(Arguments, 1)
	
	if started == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][19]), aIndex, 1)
		return
	end
	
	if Step == 0
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][20], KILL_COMMAND_STEP), aIndex, 1)
		return
	end
	
	if Step % 2 == 0
	then
		side = 2
	else
		side = 1
	end
	
	StepRunning = Step
	
	SendMessageGlobal(string.format("========================"), 0)
	Message.SendMessageGlobalMultLang(string.format(MATA_MATA_MESSAGE, 21, 0, Step))
	SendMessageGlobal(string.format("========================"), 0)
	
	
end

function MataMata.CommandWins(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if started == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][22]), aIndex, 1)
		return
	end
	
	if Fight1 == nil or Fight2 == nil
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][23]), aIndex, 1)
		return
	end
	
	local Name = command:getString(Arguments, 1, 0)
	local TargetIndex = GetIndex(Name)
	
	if TargetIndex == -1
	then
		Fight1 = nil
		Fight2 = nil
		
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][24], Name), aIndex, 1)
		return
	end
	
	if KILL_PLAYER_WINS_GUILD == 0
	then
		SendMessageGlobal(string.format(MATA_MATA_MESSAGE[Language][25], Name), 0)
	else
		if UserGuildNumber(TargetIndex) == 0
		then
			SendMessageGlobal(string.format(MATA_MATA_MESSAGE[Language][26], Name), 0)
		else
			SendMessageGlobal(string.format(MATA_MATA_MESSAGE[Language][27], Name, UserGuildName(TargetIndex)), 0)
		end
	end
		
	if TargetIndex == Fight1
	then
		local p_Fight2 = User.new(Fight2)
		MataMata.RemoverPlayer(p_Fight2:getName())
	
		Teleport(Fight2, 0, 125, 125)
	elseif TargetIndex == Fight2
	then
		local p_Fight1 = User.new(Fight1)
		MataMata.RemoverPlayer(p_Fight1:getName())
	
		Teleport(Fight1, 0, 125, 125)
	end
	
	Fight1 = nil
	Fight2 = nil
	
	MataMata.MovePlayerWins(TargetIndex, Name)
	
	
end

function MataMata.MovePlayerWins(aIndex, Name)
	Participantes[Name].Step = Participantes[Name].Step + 1
	
	if side == 1
	then
		Teleport(aIndex, KILL_MAP, KILL_COORD_TOP_X, KILL_COORD_TOP_Y)
	else
		Teleport(aIndex, KILL_MAP, KILL_COORD_DOWN_X, KILL_COORD_DOWN_Y)
	end
end

function MataMata.RemoverPlayer(Player)
	for i, name in ipairs(Participantes) do
		if name == Player
		then
			Participantes[name].Index = -1
			RemoveKey(Participantes, i)
		end
	end
end

function MataMata.CommandCall(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if started == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][28]), aIndex, 1)
		return
	end
	
	if Fight1 ~= nil or Fight2 ~= nil
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][29]), aIndex, 1)
		return
	end
	
	pls = {}
	
	for key, value in pairs(Participantes) do
		if type(key) ~= "number"
		then
			if Participantes[key].Index ~= -1
			then
				local users = User.new(Participantes[key].Index)
				
				if users:getConnected() == 3
				then
					if Participantes[key].Step == StepRunning
					then
						InsertKey(pls, key)
						pls[key] = Participantes[key].Index
					end
				end
			end
		end
	end
	
	local total = CountTable(pls)
	
	if total > 1
	then
		Name1 = pls[1]
		Name2 = pls[2]
		
		local TargetIndex1 = GetIndex(Name1)
		Teleport(TargetIndex1, KILL_MAP, KILL_COORD_DUEL_X_1, KILL_COORD_DUEL_Y_1)
		Fight1 = TargetIndex1
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][30]), TargetIndex1, 1)
		
		local TargetIndex2 = GetIndex(Name2)
		Teleport(TargetIndex2, KILL_MAP, KILL_COORD_DUEL_X_2, KILL_COORD_DUEL_Y_2)
		Fight2 = TargetIndex2
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][31]), TargetIndex2, 1)
		
		SendMessageGlobal(string.format(MATA_MATA_MESSAGE[Language][32], player:getName()), 1)
		SendMessageGlobal(string.format(MATA_MATA_MESSAGE[Language][33], player:getName()), 0)
		SendMessageGlobal(string.format(MATA_MATA_MESSAGE[Language][34], Name1, Name2), 0)
	elseif total == 1
	then
		Name = pls[1]
		
		local TargetIndex = GetIndex(Name)
		
		MataMata.MovePlayerWins(TargetIndex, Name)
		
		SendMessageGlobal(string.format(MATA_MATA_MESSAGE[Language][35], Name), 0)
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][36]), aIndex, 1)
	else
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][36]), aIndex, 1)
	end
	
	
end

function MataMata.CommandStepEnd(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if started == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][37]), aIndex, 1)
		return
	end
	
	StepRunning = StepRunning + 1
	
	SendMessageGlobal(string.format("========================"), 0)
	Message.SendMessageGlobalMultLang(MATA_MATA_MESSAGE, 38, 0)
	SendMessageGlobal(string.format("========================"), 0)
	
	
end

function MataMata.CommandStepSemi(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if started == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][39]), aIndex, 1)
		return
	end
	
	StepRunning = StepRunning + 1
	
	if StepRunning % 2 == 0
	then
		side = 2
	else
		side = 1
	end
	
	SendMessageGlobal(string.format("========================"), 0)
	Message.SendMessageGlobalMultLang(MATA_MATA_MESSAGE, 40, 0)
	SendMessageGlobal(string.format("========================"), 0)
	
	
end

function MataMata.CommandDisp3(aIndex, Arguments)
	if KILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(index)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	if started == false
	then
		SendMessage(string.format(MATA_MATA_MESSAGE[Language][41]), aIndex, 1)
		return
	end
	
	SendMessageGlobal(string.format("========================"), 0)
	Message.SendMessageGlobalMultLang(MATA_MATA_MESSAGE, 42, 0)
	SendMessageGlobal(string.format("========================"), 0)
	
	
end

Commands.Register(KILL_COMMAND_OPEN, MataMata.CommandOpen)
Commands.Register(KILL_COMMAND_GO, MataMata.CommandGo)
Commands.Register(KILL_COMMAND_INIT, MataMata.CommandInit)
Commands.Register(KILL_COMMAND_FINISH, MataMata.CommandFinish)
Commands.Register(KILL_COMMAND_STEP, MataMata.CommandStep)
Commands.Register(KILL_COMMAND_WINS, MataMata.CommandWins)
Commands.Register(KILL_COMMAND_CALL, MataMata.CommandCall)
Commands.Register(KILL_COMMAND_STEP_END, MataMata.CommandStepEnd)
Commands.Register(KILL_COMMAND_STEP_SEMI, MataMata.CommandStepSemi)
Commands.Register(KILL_COMMAND_STEP_DISP3, MataMata.CommandDisp3)

return MataMata