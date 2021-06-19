Make = {}

function Make.Command(aIndex, Arguments)
    local player = User.new(aIndex)

    if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), MAKE_COMMAND_GAME_MASTER_LEVEL) == 0
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
    local joh = command:getNumber(Arguments, 9)
    local count = command:getNumber(Arguments, 10)
    local socket = command:getNumber(Arguments, 11)
    local timer = command:getNumber(Arguments, 12)

    if count == 0
    then
        count = 1
    end

    if timer > 0
    then
        timer = (timer * 60) * 60
    end

    for i = 1, count do
        CreateItemInventory2(player:getIndex(), GET_ITEM(section, index), level, luck, skill, opt, exc, ancient, joh, socket, timer)
    end

    player = nil
end

function Make.CompleteSet(aIndex, Arguments)
    local player = User.new(aIndex)

    if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), MAKE_SET_COMMAND_GAME_MASTER_LEVEL) == 0
    then
        return
    end

    local index	= command:getNumber(Arguments, 1)
    local level = command:getNumber(Arguments, 2)
    local luck = command:getNumber(Arguments, 3)
    local skill = command:getNumber(Arguments, 4)
    local opt = command:getNumber(Arguments, 5)
    local exc = command:getNumber(Arguments, 6)
    local ancient = command:getNumber(Arguments, 7)
    local joh = command:getNumber(Arguments, 8)
    local socket = command:getNumber(Arguments, 9)
    local timer = command:getNumber(Arguments, 10)

    if timer > 0
    then
        timer = (timer * 60) * 60
    end

    for i = 7, 11 do
        CreateItemInventory2(player:getIndex(), GET_ITEM(i, index), level, luck, skill, opt, exc, ancient, joh, socket, timer)
    end
end

function Make.AllPlayers(aIndex, Arguments)
    local player = User.new(aIndex)

    if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), MAKE_ALL_COMMAND_GAME_MASTER_LEVEL) == 0
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
    local joh = command:getNumber(Arguments, 9)
    local count = command:getNumber(Arguments, 10)
    local socket = command:getNumber(Arguments, 11)
    local timer = command:getNumber(Arguments, 12)

    if count == 0
    then
        count = 1
    end

    if timer > 0
    then
        timer = (timer * 60) * 60
    end

    for n = OBJECT_START_USER, MAX_OBJECT do
        if gObjIsConnectedGP(n) == 0
		then
			goto continue
		end

        for i = 1, count do
            CreateItemInventory2(n, GET_ITEM(section, index), level, luck, skill, opt, exc, ancient, joh, socket, timer)
        end

        ::continue::
    end

    player = nil
end

function Make.Map(aIndex, Arguments)
    local player = User.new(aIndex)

    if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), MAKE_MAP_COMMAND_GAME_MASTER_LEVEL) == 0
    then
        return
    end

    local map =  command:getNumber(Arguments, 1)
    local section = command:getNumber(Arguments, 2)
    local index	= command:getNumber(Arguments, 3)
    local level = command:getNumber(Arguments, 4)
    local luck = command:getNumber(Arguments, 5)
    local skill = command:getNumber(Arguments, 6)
    local opt = command:getNumber(Arguments, 7)
    local exc = command:getNumber(Arguments, 8)
    local ancient = command:getNumber(Arguments, 9)
    local joh = command:getNumber(Arguments, 10)
    local count = command:getNumber(Arguments, 11)
    local socket = command:getNumber(Arguments, 12)
    local timer = command:getNumber(Arguments, 13)

    if count == 0
    then
        count = 1
    end

    if timer > 0
    then
        timer = (timer * 60) * 60
    end

    for n = OBJECT_START_USER, MAX_OBJECT do
        if gObjIsConnectedGP(n) == 0
		then
			goto continue
		end

        if GetMapObject(n) ~= map
        then
            goto continue
        end

        for i = 1, count do
            CreateItemInventory2(n, GET_ITEM(section, index), level, luck, skill, opt, exc, ancient, joh, socket, timer)
        end

        ::continue::
    end

    player = nil
end

if MAKE_COMMAND_SWITCH == 1
then
    Commands.Register(MAKE_COMMAND_SYNTAX, Make.Command)
end

if MAKE_SET_COMMAND_SWITCH == 1
then
    Commands.Register(MAKE_SET_COMMAND_SYNTAX, Make.CompleteSet)
end

if MAKE_ALL_COMMAND_SWITCH == 1
then
    Commands.Register(MAKE_ALL_COMMAND_SYNTAX, Make.AllPlayers)
end

if MAKE_MAP_COMMAND_SWITCH == 1
then
    Commands.Register(MAKE_MAP_COMMAND_SYNTAX, Make.Map)
end

return Make