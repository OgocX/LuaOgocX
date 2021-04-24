--[[ Class Count Duel Do not touch! ]]--
DuelSystem = {}
DuelSystem.__index = DuelSystem

setmetatable(DuelSystem, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function DuelSystem:_init(Player, Target)
	self.index = {Player, Target}
	self.player = {User.new(Player), User.new(Target)}
	self.name = {self.player[1]:getName(), self.player[2]:getName()}
	self.language = { self.player[1]:getLanguage(), self.player[2]:getLanguage() }
	self.points = {}

	self.callback = nil
	self.duelstart = false
	self.timerfinish = false
	
	self.points[self:get_name()] = 0
	self.points[self:get_target_name()] = 0
	
	Timer.TimeOut(TIMER_OF_START, self.start_duel, self)
	
	SendMessage(string.format(DUEL_MESSAGE[self:getLanguage()][27], TIMER_OF_START), self:get_index(), 1)
	SendMessage(string.format(DUEL_MESSAGE[self:getLanguage()][28], TIMER_OF_DURATION), self:get_index(), 1)
	SendMessage(string.format(DUEL_MESSAGE[self:getLanguageTarget()][27], TIMER_OF_START), self:get_target_index(), 1)
	SendMessage(string.format(DUEL_MESSAGE[self:getLanguageTarget()][28], TIMER_OF_DURATION), self:get_target_index(), 1)
	
	self.canceled = false
	self.cancel_message = ''
	self.cancel_message_target = ''
	self.cancel_wins = nil
	self.cancel_lose = nil
end

function DuelSystem:get_index()
	return self.index[1]
end

function DuelSystem:get_target_index()
	return self.index[2]
end

function DuelSystem:get_player()
	return self.player[1]
end

function DuelSystem:get_target_player()
	return self.player[2]
end

function DuelSystem:get_name()
	return self.name[1]
end

function DuelSystem:get_target_name()
	return self.name[2]
end

function DuelSystem:getLanguage()
	return self.language[1]
end

function DuelSystem:getLanguageTarget()
	return self.language[2]
end

function DuelSystem:start_duel()
	self.duelstart = true
	
	SendMessage(DUEL_MESSAGE[self:getLanguage()][29], self:get_index(), 1)
	SendMessage(DUEL_MESSAGE[self:getLanguageTarget()][29], self:get_target_index(), 1)
	
	self.timer_end = Timer.TimeOut(60 * TIMER_OF_DURATION, self.FinishDuel, self)
	self.timer_check = Timer.Interval(1, self.check, self)
end

function DuelSystem:clear_finish()
	if self.timerfinish == false
	then
		return
	end
	
	if self.timer_end ~= nil
	then
		Timer.Cancel(self.timer_end)
		self.timer_end = nil
	end
end

function DuelSystem:FinishDuel()
	if self.timer_check ~= nil
	then
		Timer.Cancel(self.timer_check)
		self.timer_check = nil
	end
	
	if self.canceled == true
	then
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguage()][30], self.cancel_message), self:get_index(), 1)
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguage()][31], self.cancel_wins:getName()), self:get_index(), 1)
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguageTarget()][30], self.cancel_message_target), self:get_target_index(), 1)
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguageTarget()][31], self.cancel_wins:getName()), self:get_target_index(), 1)
		
		
		if self.callback ~= nil
		then
			self.callback(self, self.cancel_wins, self.cancel_lose)
		end
		
		self:clear_finish()
		return
	end
	
	SendMessage(string.format(DUEL_MESSAGE[self:getLanguage()][32]), self:get_index(), 1)
	SendMessage(string.format(DUEL_MESSAGE[self:getLanguageTarget()][32]), self:get_target_index(), 1)
	
	local points1 = self.points[self:get_name()]
	local points2 = self.points[self:get_target_name()]
	
	if points1 == points2
	then
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguage()][33]), self:get_index(), 1)
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguageTarget()][33]), self:get_target_index(), 1)
		
		if self.callback ~= nil
		then
			self.callback(self, nil, nil)
		end
	else
		local pontos = points1
		local pontos2 = points2
		local winner = self:get_player()
		local looser = self:get_target_player()
		
		if points2 > points1
		then
			pontos = points2
			pontos2 = points1
			winner = self:get_target_player()
			looser = self:get_player()
		end
		
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguage()][34], winner:getName(), pontos, pontos2), self:get_index(), 1)
		SendMessage(string.format(DUEL_MESSAGE[self:getLanguageTarget()][34], winner:getName(), pontos, pontos2), self:get_target_index(), 1)
	
		if self.callback ~= nil
		then
			self.callback(self, winner, looser)
		end
	end
	
	self:clear_finish()
end

function DuelSystem:EndDuel(call)
	self.callback = call
end

function DuelSystem:PlayerDie(aIndex, TargetIndex)
	local player = User.new(aIndex)
	local target_player = User.new(TargetIndex)

	if not player:getName() == self:get_name() and target_player:getName() == self:get_target_name()
	then
		if not target_player:getName() == self:get_name() and player:getName() == self:get_target_name()
		then
			return
		end
	end
	
	local points = self.points[player:getName()]
	points = points + 1
	self.points[player:getName()] = points
	
	local Name = player:getName()
	local TargetName = target_player:getName()
	
	local SourcePoints = self.points[Name]
	local TargetPoints = self.points[TargetName]
	
	if TargetPoints > SourcePoints
	then
		Name = TargetName
		TargetName = player:getName()
		
		SourcePoints = TargetPoints
		TargetPoints = self.points[TargetName]
	end
	
	if self.points[player:getName()] == self.points[target_player:getName()]
	then
		SendMessage(string.format("%d x %d", SourcePoints, TargetPoints), aIndex, 0)
		SendMessage(string.format("%d x %d", SourcePoints, TargetPoints), TargetIndex, 0)
	else
		SendMessage(string.format("%s %d x %d %s", Name, SourcePoints, TargetPoints, TargetName), aIndex, 0)
		SendMessage(string.format("%s %d x %d %s", Name, SourcePoints, TargetPoints, TargetName), TargetIndex, 0)
	end
	
	if DUEL_RESPAWN == 1
	then
		target_player:setKillerType(5)
	end
	
	if self.points[player:getName()] >= DUEL_ROUNDS
	then
		self.timerfinish = true
		self:FinishDuel()
	end
end

function DuelSystem:PlayerAttack(aIndex, TargetIndex)
	if self.duelstart == false
	then
		return 1
	end
	
	return
end

function DuelSystem:CancelDuel(message, messageTarget, winner, loser)
	self.canceled = true
	self.cancel_message = message
	self.cancel_message_target = messageTarget
	self.cancel_wins = winner
	self.cancel_lose = loser
	self.timerfinish = true
	self:FinishDuel()
end

function DuelSystem:check()
	if self.get_player:getConnected() ~= 3
	then
		local message = string.format(DUEL_MESSAGE[self:getLanguage()][35], self:get_name())
		local messageTarget = string.format(DUEL_MESSAGE[self:getLanguageTarget()][35], self:get_name())
		
		self:CancelDuel(message, messageTarget, self:get_target_player(), self:get_player())
		return
	end
	
	if self.get_target_player:getConnected() ~= 3
	then
		local message = string.format(DUEL_MESSAGE[self:getLanguage()][35], self:get_target_name())
		local messageTarget = string.format(DUEL_MESSAGE[self:getLanguageTarget()][35], self:get_target_name())
		
		self:CancelDuel(message, messageTarget, self:get_player(), self:get_target_player())
		return
	end
	
	if self.get_player:getMapNumber() ~= DUEL_MAP and DUEL_MAP ~= -1
	then
		local message = string.format(DUEL_MESSAGE[self:getLanguage()][36], self:get_name())
		local messageTarget = string.format(DUEL_MESSAGE[self:getLanguageTarget()][36], self:get_name())
		
		self:CancelDuel(message, messageTarget, self:get_target_player(), self:get_player())
		return
	end
	
	if self.get_target_player:getMapNumber() ~= DUEL_MAP and DUEL_MAP ~= -1
	then
		local message = string.format(DUEL_MESSAGE[self:getLanguage()][36], self:get_target_name())
		local messageTarget = string.format(DUEL_MESSAGE[self:getLanguageTarget()][36], self:get_target_name())
		
		self:CancelDuel(message, messageTarget, self:get_player(), self:get_target_player())
		return
	end
	
	if Distance(self.get_player:getX(), self.get_target_player:getX(), self.get_player:getY(), self.get_target_player:getY()) > DUEL_DISTANCE
	then
		local message = string.format(DUEL_MESSAGE[self:getLanguage()][37], self:get_name())
		local messageTarget = string.format(DUEL_MESSAGE[self:getLanguageTarget()][37], self:get_name())
		
		self:CancelDuel(message, messageTarget, self:get_target_player(), self:get_player())
		return
	end
	
	if Distance(self.get_target_player:getX(), self.get_player:getX(), self.get_target_player:getY(), self.get_player:getY()) > DUEL_DISTANCE
	then
		local message = string.format(DUEL_MESSAGE[self:getLanguage()][37], self:get_target_name())
		local messageTarget = string.format(DUEL_MESSAGE[self:getLanguageTarget()][37], self:get_target_name())
		
		self:CancelDuel(message, messageTarget, self:get_target_player(), self:get_player())
		return
	end
end

--[[ Class Request Do not touch! ]]--
Requests = {}
Requests.__index = Requests

setmetatable(Requests, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Requests:_init(Player, Target)
	self.index = Player
	self.target_index = Target
	
	self.player = User.new(Player)
	self.target_player = User.new(Target)
  
	self.name = self.player:getName()
	self.target_name = self.target_player:getName()
	
	self.language = self.player:getLanguage()
	self.languageTarget = self.target_player:getLanguage()
	
	self.callback = nil
  
	self.timer_id = Timer.TimeOut(TIMER_OF_REQUEST, self.RunTimer, self)
end

function Requests:Get_Index()
	return self.index
end

function Requests:Get_Target_Index()
	return self.target_index
end

function Requests:Get_Name()
	return self.name
end

function Requests:Get_Taget_Name()
	return self.target_name
end

function Requests:getLanguage()
	return self.language
end

function Requests:getLanguageTarget()
	return self.languageTarget
end

function Requests:setTimerId(id)
	self.timer_id = id
end

function Requests:OnTimer(call)
	self.callback = call
end

function Requests:ClearTimer()
	if self.timer_id ~= nil
	then
		Timer.Cancel(self.timer_id)
		self.timer_id = nil
	end
end

function Requests:RunTimer()
	if self.callback ~= nil
	then
		self.callback(self)
	end
end

--[[ Class Commands ]]--

DuelCommand = {}

--[[ System storage (Do not touch) ]]--
DUEL = {}
DUEL_REQUESTS = {}

--[[Commands and Functions]]--

function DuelCommand.CommandDuel(aIndex, Arguments)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if DUEL_REQUESTS[player:getName()]
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][1], DUEL_REQUESTS[player:getName()]:Get_Taget_Name()), aIndex, 1)
		return
	end

	local TargetName = command:getString(Arguments, 1, 0)
	
	if #TargetName <= 0
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][2], COMMAND_SEND_DUEL), aIndex, 1)
		return
	end
	
	local TargetIndex = GetIndex(TargetName)
	
	if TargetIndex == -1
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][3], TargetName), aIndex, 1)
		return
	end
	
	local target_player = User.new(TargetIndex)
	
	if (target_player:getOption() & 1) ~= 1
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][4], TargetName), aIndex, 1)
		return
	end
	
	if player:getName() == target_player:getName()
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][5]), aIndex, 1)
		return
	end
	
	if DUEL_REQUESTS[TargetName]
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][6]), aIndex, 1)
		return
	end
	
	if DuelCommand.Check_Duel(TargetName) == 1
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][7]), aIndex, 1)
		return
	end
	
	if player:getMapNumber() ~= DUEL_MAP and DUEL_MAP ~= -1
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][8]), aIndex, 1)
		return
	end
	
	if target_player:getMapNumber() ~= DUEL_MAP and DUEL_MAP ~= -1
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][9]), aIndex, 1)
		return
	end
	
	if Distance(player:getX(), target_player:getX(), player:getY(), target_player:getY()) > DUEL_DISTANCE
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][10]), aIndex, 1)
		return
	end
	
	SendMessage(string.format(DUEL_MESSAGE[Language][11], player:getName()), TargetIndex, 1)
	SendMessage(string.format(DUEL_MESSAGE[Language][12], COMMAND_ACCEPT_DUEL, player:getName()), TargetIndex, 1)
	SendMessage(string.format(DUEL_MESSAGE[Language][13], COMMAND_REJECT_DUEL, player:getName()), TargetIndex, 1)
	SendMessage(string.format(DUEL_MESSAGE[Language][14], TargetName), aIndex, 1)
	
	request = Requests(aIndex, TargetIndex)
	request:OnTimer(DuelCommand.RequestTimer)
	DUEL_REQUESTS[player:getName()] = request
	
	
end

function DuelCommand.CommandAccept(aIndex, Arguments)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	local TargetName = command:getString(Arguments, 1, 0)
	
	if #TargetName <= 0
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][2], COMMAND_ACCEPT_DUEL), aIndex, 1)
		return
	end
	
	if DUEL_REQUESTS[TargetName]
	then
		duel_request = DUEL_REQUESTS[TargetName]
		
		if duel_request:Get_Taget_Name() ~= player:getName()
		then
			SendMessage(string.format(DUEL_MESSAGE[Language][15]), aIndex, 1)
		end
		
		local TargetIndex = GetIndex(TargetName)
	
		if TargetIndex == -1
		then
			SendMessage(string.format(DUEL_MESSAGE[Language][16], TargetName), aIndex, 1)
			duel_request:ClearTimer()
			DUEL_REQUESTS[TargetName] = nil
			return
		end
		
		SendMessage(string.format(DUEL_MESSAGE[Language][17], TargetName), aIndex, 1)
		SendMessage(string.format(DUEL_MESSAGE[Language][18]), TargetIndex, 1)
		
		Teleport(aIndex, player:getMapNumber(), player:getX(), player:getY())
		Teleport(TargetIndex, player:getMapNumber(), player:getX() + 1, player:getY())
		
		duel_request:ClearTimer()
		DUEL_REQUESTS[TargetName] = nil
		
		local Name = player:getName()
		ClearRequests = {}
		
		for key in pairs(DUEL_REQUESTS) do
			if DUEL_REQUESTS[key]:Get_Taget_Name() == Name
			then
				SendMessage(string.format(DUEL_MESSAGE[Language][19], Name), DUEL_REQUESTS[key]:Get_Index(), 1)
				DUEL_REQUESTS[key]:ClearTimer()
				table.insert(ClearRequests, key)
			end
		end
		
		for i, key in ipairs(ClearRequests) do
			DUEL_REQUESTS[key] = nil
		end
		
		--Insert player in duel system
		duel = DuelSystem(TargetIndex, aIndex)
		duel:EndDuel(DuelCommand.DuelFinish)
		DUEL[duel] = duel
	else
		SendMessage(string.format(DUEL_MESSAGE[Language][20]), aIndex, 1)
	end
	
	
end

function DuelCommand.CommandReject(aIndex, Arguments)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	local TargetName = command:getString(Arguments, 1, 0)
	
	if #TargetName <= 0
	then
		SendMessage(string.format(DUEL_MESSAGE[Language][2], COMMAND_REJECT_DUEL), aIndex, 1)
		return
	end
	
	if DUEL_REQUESTS[TargetName]
	then
		duel_request = DUEL_REQUESTS[TargetName]
		
		if duel_request:Get_Taget_Name() ~= player:getName()
		then
			SendMessage(string.format(DUEL_MESSAGE[Language][15]), aIndex, 1)
		end
		
		local TargetIndex = GetIndex(TargetName)
	
		if TargetIndex == -1
		then
			SendMessage(string.format(DUEL_MESSAGE[Language][16], TargetName), aIndex, 1)
			duel_request:ClearTimer()
			DUEL_REQUESTS[TargetName] = nil
			return
		end
		
		SendMessage(string.format(DUEL_MESSAGE[Language][21], TargetName), aIndex, 1)
		SendMessage(string.format(DUEL_MESSAGE[Language][22], player:getName()), TargetIndex, 1)
		
		duel_request:ClearTimer()
		DUEL_REQUESTS[TargetName] = nil
	else
		SendMessage(string.format(DUEL_MESSAGE[Language][23]), aIndex, 1)
	end
	
	
end

function DuelCommand.Check_Duel(Name)
	for duels in pairs(DUEL) do
		if duels:get_name() == Name or duels:get_target_name() == Name
		then
			return 1
		end
	end
	
	return
end

function DuelCommand.DuelFinish(duel, player_wins, player_lose)
	DuelCommand.ClearDuel(duel)
	
	if player_wins ~= nil 
	then
		DuelCommand.SetDataBase(player_wins)
	end
	
	if player_wins ~= nil and player_lose ~= nil
	then
		if DUEL_ANNOUNCE_WINS == 1
		then
			Message.SendMessageGlobalMultLangArgs(DUEL_MESSAGE, 24, 1, player_wins:getName(), player_lose:getName())
		end
	end
end

function DuelCommand.ClearDuel(duel)
	for duels in pairs(DUEL) do
		if duels:get_name() == duel:get_name() and duels:get_target_name() == duel:get_target_name()
		then
			DUEL[duels] = nil
		end
	end
end

function DuelCommand.PlayerDie(aIndex, TargetIndex)
	for duel in pairs(DUEL) do
		if duel:get_index() == aIndex or duel:get_index() == TargetIndex
		then
			if duel:get_target_index() == aIndex or duel:get_target_index() == TargetIndex
			then
				duel:PlayerDie(aIndex, TargetIndex)
			end
		end
	end
end

function DuelCommand.PlayerAttack(aIndex, TargetIndex)
	for duel in pairs(DUEL) do
		if duel:get_index() == aIndex or duel:get_index() == TargetIndex
		then
			if duel:get_target_index() == aIndex or duel:get_target_index() == TargetIndex
			then
				return duel:PlayerAttack(aIndex, TargetIndex)
			end
		end
	end
	
	return
end

function DuelCommand.RespawnUser(aIndex)
	for duel in pairs(DUEL) do
		if duel:get_index() == aIndex or duel:get_target_index() == aIndex
		then
			TeleportMap(aIndex, DUEL_DISTANCE)
		end
	end
end

function DuelCommand.RequestTimer(request)
	if DUEL_REQUESTS[request:Get_Name()]
	then
		SendMessage(string.format(DUEL_MESSAGE[request:getLanguage()][25], request:Get_Taget_Name()), request:Get_Index(), 1)
		SendMessage(string.format(DUEL_MESSAGE[request:getLanguageTarget()][26], request:Get_Name()), request:Get_Target_Index(), 1)
		
		DUEL_REQUESTS[request:Get_Name()] = nil
	end
end

function DuelCommand.SetDataBase(player)
	for i = 0 , #DUEL_COLUMNS do
		DataBase.SetAddValue(DUEL_TABLE, DUEL_COLUMNS[i], 1, DUEL_WHERE, player:getName())
	end
end

function DuelCommand.CreateColumns()
	--[[ Create coluns if not exist  ]]--
	for i = 0 , #DUEL_COLUMNS do
		DataBase.CreateColumn(DUEL_TABLE, DUEL_COLUMNS[i], "INT NOT NULL DEFAULT 0")
	end
end

--[[ Register Commands ]]--
Commands.Register(COMMAND_SEND_DUEL, DuelCommand.CommandDuel)
Commands.Register(COMMAND_ACCEPT_DUEL, DuelCommand.CommandAccept)
Commands.Register(COMMAND_REJECT_DUEL, DuelCommand.CommandReject)

--[[ Register Functions ]]--
GameServerFunctions.PlayerDie(DuelCommand.PlayerDie)
GameServerFunctions.PlayerAttack(DuelCommand.PlayerAttack)
GameServerFunctions.RespawnUser(DuelCommand.RespawnUser)

Timer.TimeOut(5, DuelCommand.CreateColumns)

return DuelCommand