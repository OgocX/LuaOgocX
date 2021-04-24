--[[ Drop System ]]--

-- if you don't know LUA don't move from here down!
DropPeriodic = {}

function DropPeriodic.Command(aIndex, Arguments)
	if DROP_PERIODIC_COMMAND_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
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
	local timeDay = command:getNumber(Arguments, 8)
	
	ItemSerialCreatePeriodic(aIndex, 236, 0, 0, GET_ITEM(section, index), level, 255, luck, skill, opt, exc, timeDay)
end

Commands.Register(DROP_PERIODIC_COMMAND, DropPeriodic.Command)

return DropPeriodic