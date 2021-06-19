--[[ Drop System ]]--

Drop = {}

function Drop.Command(aIndex, Arguments)
	local player = User.new(aIndex)
	
	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), DROP_COMMAND_GAME_MASTER_LEVEL) == 0
	then
		return
	end
	
	local section = command:getNumber(Arguments, 1)
	local index	= command:getNumber(Arguments, 2)
	local level = command:getNumber(Arguments, 3)
	local luck = command:getNumber(Arguments, 4)
	local skill = command:getNumber(Arguments, 5)
	local opt = command:getNumber(Arguments, 6)
	local exc = command:getNumber(Arguments, 7)
	local ancient = command:getNumber(Arguments, 8)
	local socket = command:getNumber(Arguments, 9)
	local count = command:getNumber(Arguments, 10)

	if count == 0
    then
        count = 1
    end
	
	for i = 1, count do
		CreateItemMap(aIndex, player:getMapNumber(), player:getX(), player:getY(), GET_ITEM(section, index), level, luck, skill, opt, exc, ancient, 0, socket, 0)
	end
end

if DROP_COMMAND_SWITCH ~= 0
then
	Commands.Register(DROP_COMMAND_SYNTAX, Drop.Command)
end

return Drop