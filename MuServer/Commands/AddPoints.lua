--[[ Add Points In-Game ]]--

AddPoints = {}

function AddPoints.Command(aIndex, Arguments, Type)
	if ADD_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	local Points = command:getNumber(Arguments, 1)
	
	if Points < ADD_MINPOINTS
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][1], ADD_MINPOINTS), aIndex, 1)
		return
	end

	if player:getLevel() < ADD_LEVEL
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][2], ADD_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < ADD_MONEY
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][3], ADD_MONEY), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < ADD_VIP
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < ADD_RESET
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][5], ADD_RESET), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < ADD_MRESET
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][6], ADD_MRESET), aIndex, 1)
		return
	end
	
	if Type == 1
	then
		local Strength = player:getStrength()
	
		if Strength >= STR_MAXPOINTS
		then
			SendMessage(string.format("[Sistema] O Máximo de pontos em força é %d", STR_MAXPOINTS), aIndex, 1)
			return
		end
		
		if Strength + Points > STR_MAXPOINTS
		then
			Points = STR_MAXPOINTS - Strength
		end
		
		local LevelUpPoints = player:getLevelUpPoint()
		
		if LevelUpPoints < Points
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][7]), aIndex, 1)
			return
		end
		
		local setmoney = money - ADD_MONEY
	
		player:setMoney(setmoney)
		
		player:setStrength(Strength + Points)
		player:setLevelUpPoint(LevelUpPoints - Points)
		
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][8]), aIndex, 1)
	end
	
	if Type == 2
	then
		local Dexterity = player:getDexterity()
	
		if Dexterity >= AGI_MAXPOINTS
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][9], AGI_MAXPOINTS), aIndex, 1)
			return
		end
		
		if Dexterity + Points > AGI_MAXPOINTS
		then
			Points = AGI_MAXPOINTS - Dexterity
		end
		
		local LevelUpPoints = player:getLevelUpPoint()
		
		if LevelUpPoints < Points
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][7]), aIndex, 1)
			return
		end
		
		local setmoney = money - ADD_MONEY
	
		player:setMoney(setmoney)
		
		player:setDexterity(Dexterity + Points)
		player:setLevelUpPoint(LevelUpPoints - Points)
		
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][8]), aIndex, 1)
	end
	
	if Type == 3
	then
		local Vitality = player:getVitality()
	
		if Vitality >= VIT_MAXPOINTS
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][10], VIT_MAXPOINTS), aIndex, 1)
			return
		end
		
		if Vitality + Points > VIT_MAXPOINTS
		then
			Points = VIT_MAXPOINTS - Vitality
		end
		
		local LevelUpPoints = player:getLevelUpPoint()
		
		if LevelUpPoints < Points
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][7]), aIndex, 1)
			return
		end
		
		local setmoney = money - ADD_MONEY
	
		player:setMoney(setmoney)
		
		player:setMaxLife(math.floor(player:getVitalityToLife() * (player:getVitality() + (Points -1))))
		
		player:setVitality(Vitality + Points)
		player:setLevelUpPoint(LevelUpPoints - Points)
		
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][8]), aIndex, 1)
	end
	
	if Type == 4
	then
		local Energy = player:getEnergy()
	
		if Energy >= ENE_MAXPOINTS
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][11], ENE_MAXPOINTS), aIndex, 1)
			return
		end
		
		if Energy + Points > ENE_MAXPOINTS
		then
			Points = ENE_MAXPOINTS - Energy
		end
		
		local LevelUpPoints = player:getLevelUpPoint()
		
		if LevelUpPoints < Points
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][7]), aIndex, 1)
			return
		end
		
		local setmoney = money - ADD_MONEY
	
		player:setMoney(setmoney)
		
		player:setMaxMana(math.floor(player:getEnergyToMana() * (player:getEnergy() + (Points -1))))
		
		player:setEnergy(Energy + Points)
		player:setLevelUpPoint(LevelUpPoints - Points)
		
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][8]), aIndex, 1)
	end
	
	if Type == 5
	then
		local LeaderShip = player:getLeaderShip()
	
		if LeaderShip >= CMD_MAXPOINTS
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][12], CMD_MAXPOINTS), aIndex, 1)
			return
		end
		
		if LeaderShip + Points > CMD_MAXPOINTS
		then
			Points = CMD_MAXPOINTS - LeaderShip
		end
		
		local LevelUpPoints = player:getLevelUpPoint()
		
		if LevelUpPoints < Points
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][7]), aIndex, 1)
			return
		end
		
		local setmoney = money - ADD_MONEY
	
		player:setMoney(setmoney)
		
		player:setLeaderShip(LeaderShip + Points)
		player:setLevelUpPoint(LevelUpPoints - Points)
		
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][8]), aIndex, 1)
	end
	
	MoneySend(aIndex)
	SetBP(aIndex)
	CalCharacter(aIndex)
	RefreshCharacter(aIndex)
end

function AddPoints.CommandReAdd(aIndex, Arguments)
	if RE_ADD_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getLevel() < RE_ADD_LEVEL
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][2], RE_ADD_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < RE_ADD_MONEY
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][3], RE_ADD_MONEY), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < RE_ADD_VIP
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < RE_ADD_RESET
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][5], RE_ADD_RESET), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < RE_ADD_MRESET
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][6], RE_ADD_MRESET), aIndex, 1)
		return
	end
	
	if player:getStrength() < RE_ADD_MIN_POINTS or player:getDexterity() < RE_ADD_MIN_POINTS or player:getEnergy() < RE_ADD_MIN_POINTS or player:getVitality() < RE_ADD_MIN_POINTS
		or (player:getClass() == 4 and player:getLeaderShip() < RE_ADD_MIN_POINTS)
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][13], RE_ADD_MIN_POINTS), aIndex, 1)
		return
	end
	
	local pontos = math.abs(player:getStrength() + player:getDexterity() + player:getEnergy() + player:getVitality() + player:getLeaderShip() + player:getLevelUpPoint()) - math.abs(RE_ADD_POINTS_AFTER * 4)
	
	player:setLevelUpPoint(pontos)
	player:setStrength(RE_ADD_POINTS_AFTER)
	player:setDexterity(RE_ADD_POINTS_AFTER)
	player:setEnergy(RE_ADD_POINTS_AFTER)
	player:setVitality(RE_ADD_POINTS_AFTER)
	
	if player:getClass() == 4
	then
		player:setLeaderShip(RE_ADD_POINTS_AFTER)
	end
	
	player:setMaxLife(math.floor(player:getVitalityToLife() * player:getVitality()))
	player:setMaxMana(math.floor(player:getEnergyToMana() * player:getEnergy()))
	
	SendMessage(string.format(ADD_POINTS_MESSAGES[Language][14]), aIndex, 1)
	
	local setmoney = money - RE_ADD_MONEY
	
	player:setMoney(setmoney)
	
	MoneySend(aIndex)
	SetBP(aIndex)
	CalCharacter(aIndex)
	RefreshCharacter(aIndex)
end

Commands.Register(STR_COMMAND, AddPoints.Command, 1)
Commands.Register(AGI_COMMAND, AddPoints.Command, 2)
Commands.Register(VIT_COMMAND, AddPoints.Command, 3)
Commands.Register(ENE_COMMAND, AddPoints.Command, 4)
Commands.Register(CMD_COMMAND, AddPoints.Command, 5)
Commands.Register(RE_ADD_COMMAND, AddPoints.CommandReAdd)

return AddPoints