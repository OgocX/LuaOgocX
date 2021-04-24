--[[
Sistema de evento in-game 
]]--

Evento = {}

local Players = {}
local Map = 0
local CoordX = 0
local CoordY = 0
local idtimer = -1
local timer = 0
local started = false

function Evento.Running()
	if timer == 0
	then
		for i, name in ipairs(Players) do 
			local index = Players[name]
			local player = User.new(index)
			
			if player:getConnected() > 2
			then
				Teleport(Players[name], Map, CoordX, CoordY)
			end
			
			
		end
		
		started = false
		Message.SendMessageGlobalMultLangArgs(EVENTO_MESSAGE, 2, 0, EVENTO_COMMAND_GO)
	else
		Message.SendMessageGlobalMultLangArgs(EVENTO_MESSAGE, 1, 0, EVENTO_COMMAND_GO, timer)
		timer = timer - 1
	end
end

function Evento.CommandOpen(aIndex, Arguments)
	if EVENTO_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() == 1
	then
		return
	end
	
	Players = {}
	
	timer = command:getNumber(Arguments, 1)
	
	if timer == 0
	then
		SendMessage(string.format(EVENTO_MESSAGE[Language][3], EVENTO_COMMAND_OPEN), aIndex, 1)
		return
	end
	
	Map = command:getNumber(Arguments, 2)
	CoordX = command:getNumber(Arguments, 3)
	CoordY = command:getNumber(Arguments, 4)
	
	started = true
	
	idtimer = Timer.Repeater(1, timer, Evento.Running, aIndex)
	
	SendMessageGlobal(string.format(EVENTO_MESSAGE[Language][4], player:getName(), EVENTO_COMMAND_GO), 1)
	
	
end

function Evento.CommandGo(aIndex, Arguments)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if started == false
	then
		SendMessage(string.format(EVENTO_MESSAGE[Language][5], EVENTO_COMMAND_GO), aIndex, 1)
		return
	end
	
	if player:getLevel() < EVENTO_LEVEL
	then
		SendMessage(string.format(EVENTO_MESSAGE[Language][6], EVENTO_LEVEL), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < EVENTO_VIP
	then
		SendMessage(string.format(EVENTO_MESSAGE[Language][7]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < EVENTO_RESETS
	then
		SendMessage(string.format(EVENTO_MESSAGE[Language][8], EVENTO_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < EVENTO_MRESETS
	then
		SendMessage(string.format(EVENTO_MESSAGE[Language][9], EVENTO_MRESETS), aIndex, 1)
		return
	end
	
	if Players[player:getName()] == nil
	then
		InsertKey(Players, player:getName())
		
		Players[player:getName()] = aIndex
		
		SendMessage(string.format(EVENTO_MESSAGE[Language][10]), aIndex, 1)
		SendMessage(string.format(EVENTO_MESSAGE[Language][11]), aIndex, 1)
	else
		SendMessage(string.format(EVENTO_MESSAGE[Language][11]), aIndex, 1)
	end
	
	
end

Commands.Register(EVENTO_COMMAND_OPEN, Evento.CommandOpen)
Commands.Register(EVENTO_COMMAND_GO, Evento.CommandGo)

return Evento