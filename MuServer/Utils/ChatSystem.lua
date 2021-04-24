--[[
Function Recv Chat GameServer
]]--
Commands = {}

local Handles = {}
local HandlesCalled = {}

--[[ Receive data and treat ]]--
function Commands.Chat(index, text)
	if string.len(text) <= 0
	then
		return 0
	end
	
	if string.sub(text, 1, 1) ~= '/'
	then
		return 0
	end
	
	local arguments = string.split(text, " ")
	local command = string.lower(arguments[1])
	
	if Commands.CallCheck(index, command, text) == 1
	then
		return 1
	end
	
	for i in ipairs(Handles) do
		if Handles[i].prefix == nil then
			LogAddC(2, string.format("Comando mal configurado, index %d", i))
			return 1
		end
		
		if command == string.lower(Handles[i].prefix)
		then
			if Handles[i].callback == nil then
				LogAddC(2, string.format("Comando %s mal configurado, falta função a ser executada", command))
				return 1
			end
			Handles[i].callback(index, text, unpack(Handles[i].args))
			return 1
		end
	end
	
	return 0
end

--[[ Register Commands ]]--
function Commands.Register(name, call, ...)
	if name == nil or call == nil
	then
		return
	end

	table.insert(Handles, {prefix = name, callback = call, args = {...}})
end

--[[ Register Call Command ]]--
function Commands.CallCommand(call, ...)
	if call == nil
	then
		return
	end
	
	table.insert(HandlesCalled, {callback = call, args = {...}})
end

--[[ Check Call Command ]]--
function Commands.CallCheck(index, command, text)
	for i in ipairs(HandlesCalled) do
		if HandlesCalled[i].callback(index, command, text, unpack(HandlesCalled[i].args)) == 1
		then
			return 1
		end
	end
	
	return
end

--[[ Receive Function GameServer ]]--
function ChatProc(index, text)
	local player = User.new(index)

	if string.sub(text, 0, 1) == '#'
	then
		if string.sub(text, 2, 2) == '!'
		then
			if player:getAuthority() ~= 1
			then
				SendMessageAllServer(string.format("[%s] %s", player:getName(), string.sub(text, 3, #text)), 0)
				return 1
			end
		elseif string.sub(text, 2, 2) == '$'
		then
			if player:getAuthority() ~= 1
			then
				SendMessageAllServer(string.format("[%s]", player:getName()), 0)
				SendMessageAllServer(string.format("%s", string.sub(text, 3, #text)), 0)
				return 1
			end
		end
	elseif string.sub(text, 0, 1) == '!'
	then
		if player:getAuthority() ~= 1
		then
			SendMessageGlobal(string.format("[%s] %s", player:getName(), string.sub(text, 2, #text)), 0)
			return 1
		end
	elseif string.sub(text, 0, 1) == '$'
	then
		if player:getAuthority() ~= 1
		then
			SendMessageGlobal(string.format("[%s]", player:getName()), 0)
			SendMessageGlobal(string.format("%s", string.sub(text, 2, #text)), 0)
			return 1
		end
	end
	
	player = nil

	return Commands.Chat(index, text)
end

return Commands