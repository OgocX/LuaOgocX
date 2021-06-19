Lock = {}

function Lock.Command(aIndex, Arguments)
    local player = User.new(aIndex)
    local Language = player:getLanguage()

    if player:getLock() > 0
    then
        SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][1]), aIndex, 1)
        return
    end

    local pass = command:getNumber(Arguments, 1)

    if pass <= 0
    then
        SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][2]), aIndex, 1)
        return
    end

    if pass >= 99999999
    then
        SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][2]), aIndex, 1)
        return
    end

    player:setLock(pass)

    SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][3]), aIndex, 1)

    DataBase.SetValue(LOCK_COMMAND_TABLE, LOCK_COMMAND_COLUMN, pass, LOCK_COMMAND_WHERE, player:getAccountID())

    player = nil
end

function Lock.CommandUnlock(aIndex, Arguments)
    local player = User.new(aIndex)
    local Language = player:getLanguage()

    local pass = command:getNumber(Arguments, 1)

    if pass <= 0
    then
        SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][2]), aIndex, 1)
        return
    end

    if pass >= 99999999
    then
        SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][2]), aIndex, 1)
        return
    end

    if pass ~= player:getLock()
    then
        SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][4]), aIndex, 1)
        return
    end

    player:setLock(0)

    SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][5]), aIndex, 1)

    DataBase.SetValue(LOCK_COMMAND_TABLE, LOCK_COMMAND_COLUMN, 0, LOCK_COMMAND_WHERE, player:getAccountID())

    player = nil
end

function Lock.EnterCharacter(aIndex)
    local player = User.new(aIndex)

    local pass = DataBase.GetValue(LOCK_COMMAND_TABLE, LOCK_COMMAND_COLUMN, LOCK_COMMAND_WHERE, player:getAccountID())

    if pass > 0
    then
        player:setLock(pass)
    end

    player = nil
end

function Lock.CreateColumn()
    DataBase.CreateColumn(LOCK_COMMAND_TABLE, LOCK_COMMAND_COLUMN, "INT NOT NULL DEFAULT 0")
end

function Lock.Init()
    if LOCK_COMMAND_SWITCH ~= 1
    then
        return
    end

    DataBase.RunAfterLoad(Lock.CreateColumn)

    Commands.Register(LOCK_COMMAND_SYNTAX, Lock.Command)
    Commands.Register(UNLOCK_COMMAND_SYNTAX, Lock.CommandUnlock)

    GameServerFunctions.EnterCharacter(Lock.EnterCharacter)
end

Lock.Init()

return Lock