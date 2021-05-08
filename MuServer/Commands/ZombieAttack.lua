--[[
    Command
]]
ZombieAttack = {}

--defines command
ZombieAttackPlayers = nil
ZombieAttackMonstersArea = nil
ZombieAttackStarted = false
ZombieAttackOpen = false
ZombieAttackFinishEvent = false
ZombieAttackTimer = 0
ZombieAttackIdTimerCheck = -1
ZombieAttackIdEndTimerCheck = -1
ZombieAttackTimeInfoPlayers = 0
ZombieAttackTimeLastInfectedPlayer = 0

function ZombieAttack.TimeStart()
    if ZombieAttackTimer == 0
	then
		Message.SendMessageGlobalMultLang(ZOMBIE_ATTACK_MESSAGES, 11, 0)
		
		ZombieAttackOpen = false
		
		ZombieAttack.StartStand()
	else
		Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 12, 0, ZombieAttackTimer)
		Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 13, 0, ZOMBIE_ATTACK_COMMAND_SYNTAX)
		ZombieAttackTimer = ZombieAttackTimer - 1
	end
end

function ZombieAttack.StartEvent()
    --Clear var
	ZombieAttackPlayers = {}
    ZombieAttackMonstersArea = {}
	ZombieAttackStarted = false
	ZombieAttackIdTimerCheck = -1
    ZombieAttackIdEndTimerCheck = -1
	
	--Set command open
	ZombieAttackOpen = true
	--Set time for start event
	ZombieAttackTimer = ZOMBIE_ATTACK_TIME_START
	--Print player start event
	ZombieAttack.TimeStart()
	--Create timer for count minutes for event open
	Timer.Repeater(60, ZombieAttackTimer, ZombieAttack.TimeStart)
end

function ZombieAttack.TimeStand()
    if ZombieAttackTimer == 0
	then
		Message.SendMessageGlobalMultLang(ZOMBIE_ATTACK_MESSAGES, 18, 0)
		
		ZombieAttackIdTimerCheck = Timer.Interval(5, ZombieAttack.TimeRunning)

        ZombieAttackTimeInfoPlayers = GetTick()
        ZombieAttackTimeLastInfectedPlayer = GetTick()

        --infect first player
        ZombieAttack.InfectAleatoryPlayer()
	else
        Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 16, 0, ZombieAttackTimer)
        Message.SendMessageGlobalMultLang(ZOMBIE_ATTACK_MESSAGES, 17, 0)
		ZombieAttackTimer = ZombieAttackTimer - 1
	end
end

function ZombieAttack.StartStand()
    local usersInEvent = ZombieAttack.GetCountUsers()
	
	if usersInEvent < ZOMBIE_ATTACK_MIN_USERS
	then
        Message.SendMessageGlobalMultLang(ZOMBIE_ATTACK_MESSAGES, 14, 0)
		Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 15, 0, ZOMBIE_ATTACK_MIN_USERS)
        ZombieAttack.FinishEvent(0)
		return
	end

    ZombieAttack.RemoveMonsters()
    ZombieAttack.CheckAndMoveIntruders()
    ZombieAttack.MoveUsers()

    ZombieAttackFinishEvent = false
    ZombieAttackStarted = true

    ZombieAttackTimer = 5
	Timer.Repeater(1, ZombieAttackTimer, ZombieAttack.TimeStand)

    ZombieAttackIdEndTimerCheck = Timer.TimeOut(ZOMBIE_ATTACK_TIME_EVENT * 60, ZombieAttack.FinishEvent, 1)
end

function ZombieAttack.FinishEvent(Reward)
    ZombieAttackFinishEvent = true

    if Reward == 1
    then
        Message.SendMessageGlobalMultLang(ZOMBIE_ATTACK_MESSAGES, 40, 0)

        if ZOMBIE_ATTACK_NOT_INFECTED_END_EVENT > 0
        then
            local CountNotInfected = ZombieAttack.GetCountNotInfected()

            if CountNotInfected == 1
            then
                local playerInfo = ZombieAttack.GetFirstPlayerNotInfected()

                if playerInfo ~= 0 and playerInfo ~= nil
                then
                    Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 34, 0, playerInfo.PlayerName)
                    ZombieAttack.RewardNotInfected(playerInfo, ZOMBIE_ATTACK_NOT_INFECTED_END_EVENT)
                end
            elseif CountNotInfected >= 2
            then
                local Amount = math.floor(ZOMBIE_ATTACK_NOT_INFECTED_END_EVENT / CountNotInfected)
               
                if Amount > 0
                then
                    ZombieAttack.RewardSurvivors(Amount)
                end
            end
        end

        if ZOMBIE_ATTACK_INFECTED_END_EVENT > 0
        then
            local CountInfected = ZombieAttack.GetCountInfected()

            if CountInfected > 0
            then
                ZombieAttack.CalcRankingInfection(ZombieAttack.GetCountUsers())

                local playerInfo = ZombieAttack.GetPlayerRanking(1)

                if playerInfo ~= 0 and playerInfo ~= nil
                then
                    Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 35, 0, playerInfo.PlayerName)
                    ZombieAttack.RewardNotInfected(playerInfo, ZOMBIE_ATTACK_INFECTED_END_EVENT)
                end
            end
        end

        --Participation reward
        ZombieAttack.RewardParticipation()
        --Move Out users
        ZombieAttack.MoveOutPlayers()
    end

    if ZombieAttackIdEndTimerCheck ~= -1
    then
        Timer.Cancel(ZombieAttackIdEndTimerCheck)
        ZombieAttackIdEndTimerCheck = -1
    end

    if ZombieAttackIdTimerCheck ~= -1
    then
        Timer.Cancel(ZombieAttackIdTimerCheck)
        ZombieAttackIdTimerCheck = -1
    end

    ZombieAttack.RestoreMonsters()

    ZombieAttackPlayers = nil
    ZombieAttackMonstersArea = nil
    ZombieAttackStarted = false
    ZombieAttackOpen = false
    ZombieAttackTimer = 0
    ZombieAttackIdTimerCheck = -1
    ZombieAttackIdEndTimerCheck = -1
end

function ZombieAttack.TimeRunning()
    ZombieAttack.CheckUser()

    local CountNotInfected = ZombieAttack.GetCountNotInfected()

    if CountNotInfected == 1
    then
        ZombieAttack.FinishEvent(1)
        return
    end

    if CountNotInfected == 0
    then
        ZombieAttack.FinishEvent(0)
        return
    end

    if math.floor((GetTick()-ZombieAttackTimeLastInfectedPlayer) / 1000) > 60
    then
        ZombieAttack.InfectAleatoryPlayer()

        ZombieAttackTimeLastInfectedPlayer = GetTick()
    end

    if math.floor((GetTick()-ZombieAttackTimeInfoPlayers) / 1000) > 30
    then
        local CountInfected = ZombieAttack.GetCountInfected()

        for i in pairs(ZombieAttackPlayers) do
            local playerInfo = ZombieAttackPlayers[i]

            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][37], CountInfected), playerInfo.PlayerIndex, 1)
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][38], CountNotInfected), playerInfo.PlayerIndex, 1)
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][39], playerInfo.PointsEvent), playerInfo.PlayerIndex, 1)
        end

        ZombieAttackTimeInfoPlayers = GetTick()
    end
end

function ZombieAttack.RewardSurvivors(Amount)
    for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]
		
		if playerInfo.Infected == 0
        then
            ZombieAttack.RewardNotInfected(playerInfo, Amount)
        end
	end
end

function ZombieAttack.CheckUser()
    for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]

		local player = playerInfo.playerStruct
		
		if player:getConnected() < 3
		then
			playerInfo = nil
			goto continue
		end
		
		local Language = player:getLanguage()

        if player:getGuildWarState() ~= 0
        then
            MoveGate(playerInfo.PlayerIndex, 17)
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][24]), playerInfo.PlayerIndex, 1)
            playerInfo.playerStruct = nil
            ZombieAttackPlayers[i] = nil
            goto continue
        end

        if player:getMapNumber() ~= ZOMBIE_ATTACK_MAP
        then
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][22]), playerInfo.PlayerIndex, 1)
            playerInfo.playerStruct = nil
            ZombieAttackPlayers[i] = nil
            goto continue
        end

        if ZOMBIE_ATTACK_CHECK_AREA == 1
		then
			if player:getX() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_X1 or player:getY() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y1
				or player:getX() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_X2 or player:getY() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y2
			then
				SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][22]), playerInfo.PlayerIndex, 1)
                playerInfo.playerStruct = nil
				ZombieAttackPlayers[i] = nil
                goto continue
			end
		end

		::continue::
	end
end

function ZombieAttack.GetUsersList()
    UsersList = {}
	
	local count = 1
	
	for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 1
		then
            if playerInfo.Infected == 0
            then
                UsersList[count] = playerInfo.PlayerIndex
                count = count + 1
            end
		end
	end
	
	return UsersList
end

function ZombieAttack.InfectAleatoryPlayer()
    local userList = ZombieAttack.GetUsersList()

    if #userList > 0
    then
        math.randomseed(os.time())
		math.random(0, 200)
        math.random(0, 100)

        userRand = math.random(1, #userList)

        local playerInfo = ZombieAttackPlayers[userList[userRand]]

        if playerInfo ~= nil
        then
            playerInfo.Infected = 1

            local player = User.new(playerInfo.PlayerIndex)

            Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 19, 0, player:getName())
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][21]), playerInfo.PlayerIndex, 1)

            if ZOMBIE_ATTACK_BUFF == 1
            then
                AddEffect(playerInfo.PlayerIndex,0,3,1800,ZOMBIE_ATTACK_BUFF_CONST_A,ZOMBIE_ATTACK_BUFF_CONST_B,0,0)
            end

            player:setSkin(ZOMBIE_ATTACK_SKIN_INFECTED)
	        ViewportCreate(playerInfo.PlayerIndex)

            player = nil
        end
    end
end

function ZombieAttack.InfectPlayer(playerInfo, playerKiller, playerDie)
    if playerInfo == nil
    then
        return
    end

    playerInfo.Infected = 1

    playerDie:setSkin(ZOMBIE_ATTACK_SKIN_INFECTED)
    ViewportCreate(playerInfo.PlayerIndex)

    if ZOMBIE_ATTACK_BUFF == 1
    then
        AddEffect(playerInfo.PlayerIndex,0,3,1800,ZOMBIE_ATTACK_BUFF_CONST_A,ZOMBIE_ATTACK_BUFF_CONST_B,0,0)
    end

    Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 23, 0, playerKiller:getName(), playerDie:getName())
    Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 19, 0, playerDie:getName())
    SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][21]), playerInfo.PlayerIndex, 1)
end

function ZombieAttack.ParticipationAward(playerInfo)
    for i = 1, #ZOMBIE_ATTACK_PARTICIPATION_AWARD do
        local awardInfo = ZOMBIE_ATTACK_PARTICIPATION_AWARD[i]

        DataBase.SetAddValue(awardInfo.Table, awardInfo.Column, awardInfo.Amount, awardInfo.Where, playerInfo.PlayerAccount)
        SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][25], awardInfo.Amount, awardInfo.Name), playerInfo.PlayerIndex, 1)
    end
end

function ZombieAttack.RewardNotInfected(playerInfo, Amount)
    DataBase.SetAddValue(ZOMBIE_ATTACK_INFECTION_AWARD_TABLE, ZOMBIE_ATTACK_INFECTION_AWARD_COLUMN, Amount, ZOMBIE_ATTACK_INFECTION_AWARD_WHERE, playerInfo.PlayerAccount)
    SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][33], Amount, ZOMBIE_ATTACK_INFECTION_AWARD_NAME), playerInfo.PlayerIndex, 1)
end

function ZombieAttack.RewardTopInfected(playerInfo, Amount)
    DataBase.SetAddValue(ZOMBIE_ATTACK_INFECTION_AWARD_TABLE, ZOMBIE_ATTACK_INFECTION_AWARD_COLUMN, Amount, ZOMBIE_ATTACK_INFECTION_AWARD_WHERE, playerInfo.PlayerAccount)
    SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][36], Amount, ZOMBIE_ATTACK_INFECTION_AWARD_NAME), playerInfo.PlayerIndex, 1)
end

function ZombieAttack.RewardParticipation()
    for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]

        ZombieAttack.ParticipationAward(playerInfo)
    end
end

function ZombieAttack.MoveUsers()
    for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 0
		then
			goto continue
		end

        --Remove effects when enter in event
        ClearAllBuff(playerInfo.PlayerIndex)

        --Remove Party
        if playerInfo.playerStruct:getPartyNumber() >= 0
        then
            DestroyParty(playerInfo.playerStruct:getPartyNumber())
            playerInfo.playerStruct:setPartyNumber(-1)
        end

		TeleportMapRange(playerInfo.PlayerIndex, ZOMBIE_ATTACK_MAP, ZOMBIE_ATTACK_COORD_X, ZOMBIE_ATTACK_COORD_Y, ZOMBIE_ATTACK_DISTANCE_RANGE)
		
		::continue::
	end
end

function ZombieAttack.CheckAndMoveIntruders()
    for i = OBJECT_START_USER, MAX_OBJECT do
        player = User.new(i)

        if player:getConnected() < 3
        then
            goto continue
        end

        if player:getMapNumber() ~= ZOMBIE_ATTACK_MAP
        then
            goto continue
        end

        if player:getX() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_X1
            and player:getY() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y1
            and player:getX() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_X2
            and player:getY() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y2
        then
            if ZombieAttackPlayers[i] == nil
            then
                MoveGate(i, 17)
            end
        end

        ::continue::
    end
end

function ZombieAttack.RemoveMonsters()
    for i = OBJECT_START_MONSTER, MAX_OBJECT_MONSTER do
        local monster = User.new(i)

        if monster:getConnected() == 0
        then
            goto continue
        end

        if monster:getMapNumber() ~= ZOMBIE_ATTACK_MAP
        then
            goto continue
        end

        if monster:getX() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_X1
            and monster:getY() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y1
            and monster:getX() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_X2
            and monster:getY() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y2
        then
            ZombieAttackMonstersArea[i] = { MonsterIndex = i, Class = monster:getClass(), OldX = monster:getX(), OldY = monster:getY() }
            gObjDel(i)
        end

        ::continue::

        monster = nil
    end
end

function ZombieAttack.RestoreMonsters()
    for i in pairs(ZombieAttackMonstersArea) do
		local monsterInfo = ZombieAttackMonstersArea[i]
        
        local monsterIndex = AddMonster(ZOMBIE_ATTACK_MAP)

        if monsterIndex >= 0
        then
            SetMonster(monsterIndex, monsterInfo.Class)
            SetMapMonster(monsterIndex, ZOMBIE_ATTACK_MAP, monsterInfo.OldX, monsterInfo.OldY)
        end
    end
end

function ZombieAttack.CommandEnter(aIndex, Arguments)
    local player = User.new(aIndex)
	local Language = player:getLanguage()

    if ZombieAttackOpen ~= true
    then
        SendMessage(ZOMBIE_ATTACK_MESSAGES[Language][1], aIndex, 1)
        return
    end

    if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0 or player:getGuildWarState() ~= 0
	then
		SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][2]), aIndex, 1)
		return
	end

    if player:getLevel() < RUSSIAN_ROLETTE_LEVEL
	then
		SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][3], RUSSIAN_ROLETTE_LEVEL), aIndex, 1)
		return
	end

    if player:getVip() < ZOMBIE_ATTACK_VIP
	then
		SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][4]), aIndex, 1)
		return
	end
	
	if player:getReset() < ZOMBIE_ATTACK_RESETS
	then
		SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][5], ZOMBIE_ATTACK_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, player:getName()) < ZOMBIE_ATTACK_MRESETS
	then
		SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][6], ZOMBIE_ATTACK_MRESETS), aIndex, 1)
		return
	end

    local money = player:getMoney()
	
	if money < ZOMBIE_ATTACK_MONEY
	then
		SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][7], ZOMBIE_ATTACK_MONEY), aIndex, 1)
		return
	end

    if ZombieAttackPlayers[aIndex] ~= nil
    then
        SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][8]), aIndex, 1)
    else
        local CountUsers = ZombieAttack.GetCountUsers()

        if CountUsers >= ZOMBIE_ATTACK_MAX_USERS
        then
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][10]), aIndex, 1)
            return
        end

        ZombieAttackPlayers[aIndex] = { PlayerIndex = aIndex, PlayerName = player:getName(), PlayerAccount = player:getAccountID(), playerStruct = player, Language = Language, Infected = 0, InfectCount = 0, PointsEvent = 0, CanMove = 0, ranking = 0 }

        SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][8]), aIndex, 1)
        SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[Language][9]), aIndex, 1)
    end
end

function ZombieAttack.CommandOpen(aIndex, Arguments)
    local player = User.new(aIndex)
	local Language = player:getLanguage()

    if player:getAuthority() == 1
	then
		return
	end

    if (ZombieAttackOpen == true or ZombieAttackStarted == true)
	then
		SendMessage(string.format('Zombie attack wash open now!'), aIndex, 1)
		return
	end

    Message.SendMessageGlobalMultLangArgs(ZOMBIE_ATTACK_MESSAGES, 20, 1, player:getName())

    ZombieAttack.StartEvent()
end

function ZombieAttack.GetCountUsers()
    local count = 0
	
	for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 0
		then
			ZombieAttackPlayers[i] = nil
			goto continue
		end
		
		count = count + 1
		
		::continue::
	end
	
	return count
end

function ZombieAttack.GetCountInfected()
    local count = 0
	
	for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 0
		then
			ZombieAttackPlayers[i] = nil
			goto continue
		end
		
        if playerInfo.Infected == 1
        then
		    count = count + 1
        end
		
		::continue::
	end
	
	return count
end

function ZombieAttack.CalcRankingInfection(CountUser)
    for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]

        if playerInfo.Infected == 0
        then
            goto continue
        end

        rank = CountUser

        for n in pairs(ZombieAttackPlayers) do
            local playerInfo2 = ZombieAttackPlayers[n]
    
            if playerInfo.Infected == 0
            then
                rank = rank - 1
                goto continue
            end

            if playerInfo.PlayerIndex == playerInfo2.PlayerIndex
            then
                rank = rank - 1
                goto continue
            end

            if playerInfo.InfectCount > playerInfo2.InfectCount
            then
                rank = rank - 1
                goto continue
            end

            if playerInfo.InfectCount == playerInfo2.InfectCount and (i < n)
            then
                rank = rank - 1
                goto continue
            end

            ::continue::
        end

        playerInfo.ranking = (rank + 1)

        ::continue::
    end
end

function ZombieAttack.GetPlayerRanking(rank)
    for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]
		
        if playerInfo.Infected == 1
        then
		    if playerInfo.ranking == rank
            then
                return ZombieAttackPlayers[i]
            end
        end
	end

    return 0
end

function ZombieAttack.GetFirstPlayerNotInfected()
	for i in pairs(ZombieAttackPlayers) do
		playerInfo = ZombieAttackPlayers[i]
		
        if playerInfo.Infected == 0
        then
		    return playerInfo
        end
	end
	
	return 0
end

function ZombieAttack.GetCountNotInfected()
    local count = 0
	
	for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]
		
		if gObjIsConnectedGP(playerInfo.PlayerIndex) == 0
		then
			ZombieAttackPlayers[i] = nil
			goto continue
		end
		
        if playerInfo.Infected == 0
        then
		    count = count + 1
        end
		
		::continue::
	end
	
	return count
end

function ZombieAttack.MoveOutPlayers()
    for i in pairs(ZombieAttackPlayers) do
		local playerInfo = ZombieAttackPlayers[i]

        if playerInfo.playerStruct:getSkin() ~= -1
        then
            playerInfo.playerStruct:setSkin(-1)
        end

        --remove effects
        ClearAllBuff(playerInfo.PlayerIndex)

        playerInfo.CanMove = 1

        MoveGate(playerInfo.PlayerIndex, 17)
    end
end

function ZombieAttack.PlayerAttack(aIndex, TargetIndex)
    if ZombieAttackStarted == false
    then
        return
    end

    local playerInfo = ZombieAttackPlayers[aIndex]
    local targetInfo = ZombieAttackPlayers[TargetIndex]

    if playerInfo == nil and targetInfo == nil
    then
        return
    end

    if (playerInfo == nil and targetInfo ~= nil)
        or (playerInfo ~= nil and targetInfo == nil)
    then
        return 1
    end

    if ZOMBIE_ATTACK_PLAYER_CAN_ATTACK_EQUAL_INFECTED == 0
    then
        if playerInfo.Infected == targetInfo.Infected
        then
            return 1
        end
    end
end

function ZombieAttack.PlayerDie(aIndex, TargetIndex)
    if ZombieAttackStarted == false
    then
        return
    end

    local playerInfo = ZombieAttackPlayers[aIndex]
    local targetInfo = ZombieAttackPlayers[TargetIndex]

    if playerInfo == nil and targetInfo == nil
    then
        return
    end

    targetInfo.playerStruct:setKillerType(5)

    if playerInfo.Infected == 1 and targetInfo.Infected == 0
    then
        --Add infect count
        playerInfo.InfectCount = playerInfo.InfectCount + 1
        --clear points
        targetInfo.InfectCount = 0
        --infect player
        ZombieAttack.InfectPlayer(targetInfo, playerInfo.playerStruct, targetInfo.playerStruct)

        if ZOMBIE_ATTACK_INFECTION_PLAYER_POINT > 0
        then
            playerInfo.PointsEvent = playerInfo.PointsEvent + ZOMBIE_ATTACK_INFECTION_PLAYER_POINT
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][30], ZOMBIE_ATTACK_INFECTION_PLAYER_POINT), playerInfo.PlayerIndex, 1)
        end

        if targetInfo.PointsEvent >= 10
        then
            if ZOMBIE_ATTACK_INFECTION_PLAYER_POINT_RATE > 0
            then
                local pointsRemove = math.floor((targetInfo.PointsEvent * ZOMBIE_ATTACK_INFECTION_PLAYER_POINT_RATE) / 100)

                if pointsRemove > 0
                then    
                    playerInfo.PointsEvent = playerInfo.PointsEvent + pointsRemove
                    targetInfo.PointsEvent = targetInfo.PointsEvent - pointsRemove

                    if targetInfo.PointsEvent < 0
                    then
                        targetInfo.PointsEvent = 0
                    end

                    SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][31], pointsRemove), playerInfo.PlayerIndex, 1)
                    SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[targetInfo.Language][32], pointsRemove), targetInfo.PlayerIndex, 1)
                end
            end
        end
    elseif playerInfo.Infected == 0 and targetInfo.Infected == 1
    then
        --Add defense point
        if ZOMBIE_ATTACK_INFECTION_DEFENSE_POINT > 0
        then
            playerInfo.PointsEvent = playerInfo.PointsEvent + ZOMBIE_ATTACK_INFECTION_DEFENSE_POINT
            SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][27], ZOMBIE_ATTACK_INFECTION_DEFENSE_POINT), playerInfo.PlayerIndex, 1)
        end

        if targetInfo.PointsEvent >= 10
        then
            if ZOMBIE_ATTACK_INFECTION_DEFENSE_POINT_RATE > 0
            then
                local pointsRemove = math.floor((targetInfo.PointsEvent * ZOMBIE_ATTACK_INFECTION_DEFENSE_POINT_RATE) / 100)

                if pointsRemove > 0
                then    
                    playerInfo.PointsEvent = playerInfo.PointsEvent + pointsRemove
                    targetInfo.PointsEvent = targetInfo.PointsEvent - pointsRemove

                    if targetInfo.PointsEvent < 0
                    then
                        targetInfo.PointsEvent = 0
                    end

                    SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[playerInfo.Language][28], pointsRemove), playerInfo.PlayerIndex, 1)
                    SendMessage(string.format(ZOMBIE_ATTACK_MESSAGES[targetInfo.Language][29], pointsRemove), targetInfo.PlayerIndex, 1)
                end
            end
        end
    end
end

function ZombieAttack.EnterCharacter(aIndex)
    if ZombieAttackStarted == false and ZombieAttackOpen == false
    then
        return
    end

    local player = User.new(aIndex)

    if player:getMapNumber() ~= ZOMBIE_ATTACK_MAP
    then
        return
    end

    if player:getX() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_X1
        and player:getY() >= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y1
        and player:getX() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_X2
        and player:getY() <= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y2
    then
        MoveGate(aIndex, 17)
    end

    player = nil
end

function ZombieAttack.PlayerLogout(aIndex)
    if ZombieAttackStarted == false and ZombieAttackOpen == false
    then
        return
    end

    local playerInfo = ZombieAttackPlayers[aIndex]

    if playerInfo == nil
    then
        return
    end

    playerInfo.playerStruct = nil
    playerInfo = nil
end

function ZombieAttack.RespawnUser(aIndex)
    if ZombieAttackStarted == false
    then
        return
    end

    local playerInfo = ZombieAttackPlayers[aIndex]

    if playerInfo == nil
    then
        return
    end

    TeleportMap(aIndex, ZOMBIE_ATTACK_DISTANCE_RANGE)
end

function ZombieAttack.CharacterMove(aIndex, map, x, y)
    if ZombieAttackStarted == false
    then
        return
    end

    if ZombieAttackFinishEvent == true
    then
        return
    end

    local playerInfo = ZombieAttackPlayers[aIndex]

    if map ~= ZOMBIE_ATTACK_MAP and playerInfo == nil
    then
        return
    end

    if playerInfo == nil
    then
        if x >= ZOMBIE_ATTACK_CHECK_AREA_CORD_X1
            and y >= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y1
            and x <= ZOMBIE_ATTACK_CHECK_AREA_CORD_X2
            and y <= ZOMBIE_ATTACK_CHECK_AREA_CORD_Y2
        then
            return 1
        end
    end

    if playerInfo.CanMove == 1
    then
        return
    end

    return 1
end

function ZombieAttack.PlayerSendParty(aIndex, TargetIndex)
    if ZombieAttackStarted == false
    then
        return
    end

    local playerInfo = ZombieAttackPlayers[aIndex]
    local targetInfo = ZombieAttackPlayers[TargetIndex]

    if playerInfo == nil and targetInfo == nil
    then
        return
    end

    if (playerInfo == nil and targetInfo ~= nil)
        or (playerInfo ~= nil and targetInfo == nil)
    then
        return 1
    end

    return 1
end

function ZombieAttack.Init()
    if ZOMBIE_ATTACK_SWITCH == 0
    then
        return
    end

    --Register Commands
    Commands.Register(ZOMBIE_ATTACK_COMMAND_SYNTAX, ZombieAttack.CommandEnter)

    if ZOMBIE_ATTACK_COMMAND_OPEN_SWITCH == 1
    then
        Commands.Register(ZOMBIE_ATTACK_COMMAND_OPEN_SYNTAX, ZombieAttack.CommandOpen)
    end

    --Register functions
    GameServerFunctions.PlayerAttack(ZombieAttack.PlayerAttack)
    GameServerFunctions.PlayerDie(ZombieAttack.PlayerDie)
    GameServerFunctions.EnterCharacter(ZombieAttack.EnterCharacter)
    GameServerFunctions.PlayerLogout(ZombieAttack.PlayerLogout)
    GameServerFunctions.RespawnUser(ZombieAttack.RespawnUser)
    GameServerFunctions.CharacterMove(ZombieAttack.CharacterMove)
    GameServerFunctions.PlayerSendParty(ZombieAttack.PlayerSendParty)

    --Register Time Start
	for i in pairs(ZOMBIE_ATTACK_CRON_TIMER) do
		if ZOMBIE_ATTACK_CRON_TIMER[i].DayOfWeek ~= -1
		then
			Schedule.SetDayOfWeek(ZOMBIE_ATTACK_CRON_TIMER[i].DayOfWeek, ZOMBIE_ATTACK_CRON_TIMER[i].Hour, ZOMBIE_ATTACK_CRON_TIMER[i].Minute, ZombieAttack.StartEvent)
		elseif ZOMBIE_ATTACK_CRON_TIMER[i].Day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(ZOMBIE_ATTACK_CRON_TIMER[i].Day, ZOMBIE_ATTACK_CRON_TIMER[i].Hour, ZOMBIE_ATTACK_CRON_TIMER[i].Minute, ZombieAttack.StartEvent)
		else
			Schedule.SetHourAndMinute(ZOMBIE_ATTACK_CRON_TIMER[i].Hour, ZOMBIE_ATTACK_CRON_TIMER[i].Minute, ZombieAttack.StartEvent)
		end
	end
end

ZombieAttack.Init()

return ZombieAttack