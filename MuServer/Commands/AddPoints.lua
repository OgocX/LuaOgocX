--[[ Add Points In-Game ]]--

AddPoints = {}

function AddPoints.Command(aIndex, Arguments, Type)
	if ADD_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if AUTO_ADD_POINT_COMMAND_SWITCH ~= 0
	then
		local prefix = command:getString(Arguments, 1, 0)

		if string.lower(prefix) == "auto"
		then
			AutoAddPoints.AutoCommand(player, Arguments, Type)
			return
		end
	end

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
	
	if player:getVip() < ADD_VIP
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	if player:getReset() < ADD_RESET
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][5], ADD_RESET), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < ADD_MRESET
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][6], ADD_MRESET), aIndex, 1)
		return
	end

	local maxPoint = ADD_COMMAND_MAX_POINTS[player:getVip()]
	
	if Type == 1
	then
		local Strength = player:getStrength()
	
		if Strength >= maxPoint
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][15], maxPoint), aIndex, 1)
			return
		end
		
		if Strength + Points > maxPoint
		then
			Points = maxPoint - Strength
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
	
		if Dexterity >= maxPoint
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][9], maxPoint), aIndex, 1)
			return
		end
		
		if Dexterity + Points > maxPoint
		then
			Points = maxPoint - Dexterity
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
	
		if Vitality >= maxPoint
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][10], maxPoint), aIndex, 1)
			return
		end
		
		if Vitality + Points > maxPoint
		then
			Points = maxPoint - Vitality
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
	
		if Energy >= maxPoint
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][11], maxPoint), aIndex, 1)
			return
		end
		
		if Energy + Points > maxPoint
		then
			Points = maxPoint - Energy
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
	
		if LeaderShip >= maxPoint
		then
			SendMessage(string.format(ADD_POINTS_MESSAGES[Language][12], maxPoint), aIndex, 1)
			return
		end
		
		if LeaderShip + Points > maxPoint
		then
			Points = maxPoint - LeaderShip
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
	
	if player:getVip() < RE_ADD_VIP
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	if player:getReset() < RE_ADD_RESET
	then
		SendMessage(string.format(ADD_POINTS_MESSAGES[Language][5], RE_ADD_RESET), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < RE_ADD_MRESET
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

	player = nil
end

Commands.Register(STR_COMMAND, AddPoints.Command, 1)
Commands.Register(AGI_COMMAND, AddPoints.Command, 2)
Commands.Register(VIT_COMMAND, AddPoints.Command, 3)
Commands.Register(ENE_COMMAND, AddPoints.Command, 4)
Commands.Register(CMD_COMMAND, AddPoints.Command, 5)
Commands.Register(RE_ADD_COMMAND, AddPoints.CommandReAdd)

return AddPoints