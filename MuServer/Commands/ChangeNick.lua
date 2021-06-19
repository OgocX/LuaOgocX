ChangeNick = {}

local ColunsAccountCharacter = {}

ColunsAccountCharacter[1] = 'GameID1'
ColunsAccountCharacter[2] = 'GameID2'
ColunsAccountCharacter[3] = 'GameID3'
ColunsAccountCharacter[4] = 'GameID4'
ColunsAccountCharacter[5] = 'GameID5'
ColunsAccountCharacter[6] = 'GameID6'
ColunsAccountCharacter[7] = 'GameID7'
ColunsAccountCharacter[8] = 'GameID8'
ColunsAccountCharacter[9] = 'GameID9'
ColunsAccountCharacter[10] = 'GameID10'

function ChangeNick.checkNameExist(name)
	local str = string.format("Select count(*) as countFind FROM Character WHERE Name='%s'", name)
	local db = DataBase.getDb()
	
	if db:exec(str) == 0
	then
		LogAdd('Error when execute ChangeNick:checkNameExist')
		db:clear()
		return 0
	end
	
	if db:fetch() == SQL_NO_DATA
	then
		LogAdd('Error when fetch ChangeNick:checkNameExist')
		db:clear()
		return 0
	end
	
	local val = db:getInt('countFind')
	db:clear()
	return val
end

function ChangeNick.ChangeCharacterNick(newnick, account, name)
	local str = string.format("UPDATE CHARACTER SET Name='%s' where AccountID='%s' and Name='%s'", newnick, account, name)
	local db = DataBase.getDb()
	
	if db:exec(str) == 0
	then
		LogAdd('Error when exec ChangeNick:ChangeCharacterNick')
		db:clear()
		return 0
	end
	
	db:clear()
	return 1
end

function ChangeNick.ChangeAccountCharacterNick(newnick, account, name, position)
	local str = string.format("UPDATE AccountCharacter SET %s='%s' where id='%s' and %s='%s'", ColunsAccountCharacter[position], newnick, account, ColunsAccountCharacter[position], name)
	local db = DataBase.getDb()
	
	if db:exec(str) == 0
	then
		LogAdd('Error when exec ChangeNick:ChangeAccountCharacterNick')
		db:clear()
		return 0
	end
	
	db:clear()
	return 1
end

function ChangeNick.getPositionCharacter(account, name)
	local str = string.format("Select GameID1, GameID2, GameID3, GameID4, GameID5, GameID6, GameID7, GameID8, GameID9, GameID10 FROM AccountCharacter WHERE Id='%s'", account)
	local db = DataBase.getDb()
	
	if db:exec(str) == 0
	then
		LogAdd('Error when execute ChangeNick:getPositionCharacter')
		db:clear()
		return 0
	end
	
	if db:fetch() == SQL_NO_DATA
	then
		LogAdd('Error when fetch ChangeNick:getPositionCharacter')
		db:clear()
		return 0
	end
	
	local result = 0
	local GameID1 = db:getStr('GameID1')
	local GameID2 = db:getStr('GameID2')
	local GameID3 = db:getStr('GameID3')
	local GameID4 = db:getStr('GameID4')
	local GameID5 = db:getStr('GameID5')
	local GameID6 = db:getStr('GameID6')
	local GameID7 = db:getStr('GameID7')
	local GameID8 = db:getStr('GameID8')
	local GameID9 = db:getStr('GameID9')
	local GameID10 = db:getStr('GameID10')
	
	if GameID1 == name
	then
		result = 1
	elseif GameID2 == name
	then
		result = 2
	elseif GameID3 == name
	then
		result = 3
	elseif GameID4 == name
	then
		result = 4
	elseif GameID5 == name
	then
		result = 5
	elseif GameID6 == name
	then
		result = 6
	elseif GameID7 == name
	then
		result = 7
	elseif GameID8 == name
	then
		result = 8
	elseif GameID9 == name
	then
		result = 9
	elseif GameID10 == name
	then
		result = 10
	end
	
	db:clear()
	return result
end

function ChangeNick.ExecQuery(newnick, name)
	local str = string.format("EXEC OGOCX_CHANGE_NEWNICK '%s', '%s'", newnick, name)
	local db = DataBase.getDb()
	
	if db:exec(str) == 0
	then
		LogAdd('Error when exec ChangeNick:ExecQuery')
		db:clear()
		return 0
	end
	
	db:clear()
	return 1
end

function ChangeNick.Command(aIndex, Arguments)
	if CHANGE_NICK_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getLevel() < CHANGE_NICK_LEVEL
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][1], CHANGE_NICK_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < CHANGE_NICK_ZEN
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][2], CHANGE_NICK_ZEN), aIndex, 1)
		return
	end
	
	if player:getVip() < CHANGE_NICK_VIP
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][3]), aIndex, 1)
		return
	end
	
	if player:getGuildNumber() ~= 0
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][12]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if player:getReset() < CHANGE_NICK_RESETS
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][4], CHANGE_NICK_RESETS), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < CHANGE_NICK_MRESETS
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][5], CHANGE_NICK_MRESETS), aIndex, 1)
		return
	end
	
	local NewNick = command:getString(Arguments, 1, 0)
	
	if #NewNick <= 0 or #NewNick > 10
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][6]), aIndex, 1)
		return
	end
	
	if #NewNick < CHANGE_NICK_MIN_LEN
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][7], CHANGE_NICK_MIN_LEN), aIndex, 1)
		return
	end
	
	if string.match(NewNick, '%W') ~= nil
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][8]), aIndex, 1)
		return
	end
	
	if ChangeNick.checkNameExist(NewNick) == 1
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][9]), aIndex, 1)
		return
	end
	
	local positionCharacter = ChangeNick.getPositionCharacter(player:getAccountID(), player:getName())
	
	if positionCharacter == 0
	then
		SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][11]), aIndex, 1)
		return
	end
	
	ChangeNick.ChangeAccountCharacterNick(NewNick, player:getAccountID(), player:getName(), positionCharacter)
	
	ChangeNick.ChangeCharacterNick(NewNick, player:getAccountID(), player:getName())
	
	ChangeNick.ExecQuery(NewNick, player:getName())
	
	player:setName(NewNick)
	
	SendMessage(string.format(CHANGE_NICK_MESSAGE[Language][10]), aIndex, 1)
	
	CloseChar(aIndex, 1)
	
	player = nil
end

Commands.Register(CHANGE_NICK_COMMAND, ChangeNick.Command)

return ChangeNick