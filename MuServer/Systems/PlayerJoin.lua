--[[Player Join system]]--

PlayerJoin = {}

function PlayerJoin.CheckPlayerStatus(player)
	local Mod = 0

	if player:getStrength() > STR_MAXPOINTS
	then
		player:setStrength(STR_MAXPOINTS)
		Mod = 1
	end
	
	if player:getDexterity() > AGI_MAXPOINTS
	then
		player:setDexterity(AGI_MAXPOINTS)
		Mod = 1
	end
	
	if player:getVitality() > VIT_MAXPOINTS
	then
		player:setVitality(VIT_MAXPOINTS)
		Mod = 1
	end
	
	if player:getEnergy() > ENE_MAXPOINTS
	then
		player:setEnergy(ENE_MAXPOINTS)
		Mod = 1
	end
	
	if Mod == 1
	then
		CalCharacter(player:getIndex())
		LevelUpSend(player:getIndex())
	end
end

function PlayerJoin.EnterCharacter(aIndex)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	PlayerJoin.CheckPlayerStatus(player)
	
	local Name = player:getName()
	local Account = player:getAccountID()
	local Resets = DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name)
	
	if SERVER_RESETS_MIN ~= -1 and Resets < SERVER_RESETS_MIN
	then
		SendMessage(string.format(LOGIN_PLAYER_MESSAGES[Language][1], SERVER_RESETS_MIN), aIndex, 1)
		SendMessage(string.format(LOGIN_PLAYER_MESSAGES[Language][1], SERVER_RESETS_MIN), aIndex, 0)
		
		CloseChar(aIndex, 2)
		return
	end
	
	if SERVER_RESETS_MAX ~= -1 and Resets < SERVER_RESETS_MAX
	then
		SendMessage(string.format(LOGIN_PLAYER_MESSAGES[Language][2], SERVER_RESETS_MAX), aIndex, 1)
		SendMessage(string.format(LOGIN_PLAYER_MESSAGES[Language][2], SERVER_RESETS_MAX), aIndex, 0)
		
		CloseChar(aIndex, 2)
		return
	end
	
	local lastwarehouse = DataBase.GetValue(TABLE_LAST_VAULT_ID_WAREHOUSE, COLUMN_LAST_VAULT_ID_WAREHOUSE, WHERE_LAST_VAULT_ID_WAREHOUSE, Account)
	
	if lastwarehouse > 0
	then
		TrocarBauPlayer(aIndex, lastwarehouse)
	end
	
	local vip = DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, Account)
	
	if vip > 3
	then
		vip = 3
	end
	
	if vip > 0
	then
		player:setVip(vip)
	end
	
	if SERVER_VIP == 1
	then
		if vip < SERVER_VIP_MIN
		then
			SendMessage(string.format(LOGIN_PLAYER_MESSAGES[Language][1]), aIndex, 1)
			SendMessage(string.format(LOGIN_PLAYER_MESSAGES[Language][1]), aIndex, 0)
			
			CloseChar(aIndex, 2)
			return
		end
	end
	
	if LOGIN_CHAR_SWITCH == 1
	then
		SendMessage(string.format(LOGIN_CHAR_STRING[Language][vip], Name), aIndex, LOGIN_CHAR_STRING_TYPE)
	end
	
	if LOGIN_CHAR_STAFF_SWITCH == 1
	then
		if player:getAuthority() ~= 1
		then
			Message.SendGlobalMultLangeDirect(LOGIN_CHAR_STAFF_STRING, LOGIN_CHAR_STAFF_STRING_TYPE, Name)
		end
	end
	
	
end

GameServerFunctions.EnterCharacter(PlayerJoin.EnterCharacter)

return PlayerJoin