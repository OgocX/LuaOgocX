--[[
Sistema evento sobrevivência
]]--

Sobrevivencia = {}

local Players = {}
local Map = SOBRE_MAP
local CoordX = SOBRE_COORDX
local CoordY = SOBRE_COORDY
local timer = 0
local idtimer = -1
local started = false

function Sobrevivencia.Running(aIndex)
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
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 1, 0, SOBRE_COMMAND_GO)
	else
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 2, 0, SOBRE_COMMAND_GO, timer)
		timer = timer - 1
	end
end

function Sobrevivencia.CommandOpen(aIndex, Arguments)
	if SOBRE_SWITCH == 0
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
		SendMessage(string.format(SOBRE_MESSAGES[Language][3], SOBRE_COMMAND_OPEN), aIndex, 1)
		return
	end
	
	started = true
	
	idtimer = Timer.Repeater(1, timer, Sobrevivencia.Running, aIndex)
	
	Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 4, 1, player:getName(), SOBRE_COMMAND_GO)
	
	
end

function Sobrevivencia.CommandGo(aIndex, Arguments)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if started == false
	then
		SendMessage(string.format(SOBRE_MESSAGES[Language][5], SOBRE_COMMAND_GO), aIndex, 1)
		return
	end
	
	if player:getLevel() < SOBRE_LEVEL
	then
		SendMessage(string.format(SOBRE_MESSAGES[Language][6], SOBRE_LEVEL), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < SOBRE_VIP
	then
		SendMessage(string.format(SOBRE_MESSAGES[Language][7]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < SOBRE_RESETS
	then
		SendMessage(string.format(SOBRE_MESSAGES[Language][8], SOBRE_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < SOBRE_MRESETS
	then
		SendMessage(string.format(SOBRE_MESSAGES[Language][9], SOBRE_MRESETS), aIndex, 1)
		return
	end

	if Players[player:getName()] == nil
	then
		InsertKey(Players, player:getName())
		
		Players[player:getName()] = aIndex
		
		SendMessage(string.format(SOBRE_MESSAGES[Language][10]), aIndex, 1)
		SendMessage(string.format(SOBRE_MESSAGES[Language][11]), aIndex, 1)
	else
		SendMessage(string.format(SOBRE_MESSAGES[Language][10]), aIndex, 1)
	end
	
	
end

Commands.Register(SOBRE_COMMAND_OPEN, Sobrevivencia.CommandOpen)
Commands.Register(SOBRE_COMMAND_GO, Sobrevivencia.CommandGo)

return Sobrevivencia