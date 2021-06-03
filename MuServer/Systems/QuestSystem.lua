QuestSystem = {}

local QuestSystemPlayersInfo = {}

function QuestSystem.OpenQuest(player)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    if DataBase.GetValue('QUEST_SYSTEM', 'Finished', 'Name', player:getName()) > 0
    then
        QuestSystem.OpenContinueQuest(player)
        return
    end

    --get db function
    local db = DataBase.getDb()
    local query = string.format("SELECT * FROM QUEST_SYSTEM where AccountID='%s' and Name='%s'", player:getAccountID(), player:getName())

    local QuestIdentification = -1
    local Level = 0
    local Resets = 0
    local MResets = 0
    local Zen = 0
    local Coin1 = 0
    local Coin2 = 0
    local Coin3 = 0
    local Coin4 = 0
    local Vip = 0
    local Kills = 0
    local KillsMonster = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    local ItensRequirement = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            QuestIdentification = db:getInt('QuestIdentification')
            Kills = db:getInt('Kills')
            KillsMonster[1] = db:getInt('KillsMonster1')
            KillsMonster[2] = db:getInt('KillsMonster2')
            KillsMonster[3] = db:getInt('KillsMonster3')
            KillsMonster[4] = db:getInt('KillsMonster4')
            KillsMonster[5] = db:getInt('KillsMonster5')
            KillsMonster[6] = db:getInt('KillsMonster6')
            KillsMonster[7] = db:getInt('KillsMonster7')
            KillsMonster[8] = db:getInt('KillsMonster8')
            KillsMonster[9] = db:getInt('KillsMonster9')

            db:clear()

            local questInfo = QuestSystem.GetQuestIdentification(QuestIdentification)

            if questInfo ~= nil
            then
                if questInfo.Level ~= 0
                then
                    Level = player:getLevel()
                end

                if questInfo.Reset ~= 0
                then
                    Resets = DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, player:getName())
                end

                if questInfo.MReset ~= 0
                then
                    MResets = DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, player:getName())
                end

                if questInfo.Zen ~= 0
                then
                    Zen = player:getMoney()
                end

                if questInfo.Coin1 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN1_CONFIG.Table, QUEST_SYSTEM_COIN1_CONFIG.Column, QUEST_SYSTEM_COIN1_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin2 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN2_CONFIG.Table, QUEST_SYSTEM_COIN2_CONFIG.Column, QUEST_SYSTEM_COIN2_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin3 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN3_CONFIG.Table, QUEST_SYSTEM_COIN3_CONFIG.Column, QUEST_SYSTEM_COIN3_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin4 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN4_CONFIG.Table, QUEST_SYSTEM_COIN4_CONFIG.Column, QUEST_SYSTEM_COIN4_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Vip ~= 0
                then
                    Vip = player:getVip()
                end

                local questRequirementInfo = QUEST_SYSTEM_REQUIREMENTS_ITEMS[QuestIdentification]

                if questRequirementInfo ~= nil
                then
                    local pInv = Inventory.new(player:getIndex())

                    local count = 1

                    for key in pairs(questRequirementInfo) do
                        if count > 10
                        then
                            break
                        end

                        local item = questRequirementInfo[key]
                        for i = 12, 203 do
                            if ItensRequirement[count] > item.Quantity
                            then
                                break
                            end

                            if pInv:isItem(i) ~= 0
                            then
                                if pInv:getIndex(i) == item.ItemIndex
                                then
                                    if (item.Level == -1 or pInv:getLevel(i) == item.Level)
                                        and (item.Skill == -1 or pInv:getItemTable(i, 2) == item.Skill)
                                        and (item.Luck == -1 or pInv:getItemTable(i, 3) == item.Luck)
                                    then
                                        if GetStackItem(pInv:getIndex(i)) <= 0
                                        then
                                            ItensRequirement[count] = ItensRequirement[count] + 1
                                        else
                                            ItensRequirement[count] = ItensRequirement[count] + pInv:getDurability(i)
                                        end
                                    end
                                end
                            end
                        end

                        count = count + 1
                    end

                    pInv = nil
                end
            end
        else
            db:clear()
        end
    else
        db:clear()
    end

    local packetIdentification = string.format("%s_%s",QUEST_SYSTEM_PACKET_OPEN_NAME, player:getName())
    CreatePacket(packetIdentification, QUEST_SYSTEM_PACKET)
    SetDwordPacket(packetIdentification, QuestIdentification)
    SetDwordPacket(packetIdentification, Level)
    SetDwordPacket(packetIdentification, Resets)
    SetDwordPacket(packetIdentification, MResets)
    SetDwordPacket(packetIdentification, Zen)
    SetDwordPacket(packetIdentification, Coin1)
    SetDwordPacket(packetIdentification, Coin2)
    SetDwordPacket(packetIdentification, Coin3)
    SetDwordPacket(packetIdentification, Coin4)
    SetDwordPacket(packetIdentification, Vip)
    SetDwordPacket(packetIdentification, Kills)
    --kills monster by db
    for i = 1, 9 do
        SetDwordPacket(packetIdentification, KillsMonster[i])
    end

    --itens player by inventory
    for i = 1, 10 do
        SetDwordPacket(packetIdentification, ItensRequirement[i])
    end

    SendPacket(packetIdentification, player:getIndex())
    ClearPacket(packetIdentification)
end

function QuestSystem.StartQuest(player)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    if QuestSystemPlayersInfo[aIndex] ~= nil
    then
        SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][5]), player:getIndex(), 1)
		return
    end

    local getFirstQuest = QUEST_SYSTEM_INFO[1]

    if getFirstQuest == nil
    then
        SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][2]), player:getIndex(), 1)
		return
    end

    QuestSystem.InsertPlayer(player:getAccountID(), player:getName(), getFirstQuest.QuestIdentification)

    SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][3], getFirstQuest.QuestName), player:getIndex(), 1)

    QuestSystemPlayersInfo[aIndex] = {
        PlayerIndex = aIndex,
        PlayerName = player:getName(),
        PlayerAccount = player:getAccountID(),
        QuestIdentification = getFirstQuest.QuestIdentification,
        Kills = 0,
        KillsMonster = {}
    }

    for i = 1, 9 do
        QuestSystemPlayersInfo[aIndex].KillsMonster[i] = { value = 0 }
    end

    QuestSystem.OpenQuest(player)
end

function QuestSystem.GetReward(player)
    if QuestSystemPlayersInfo[player:getIndex()] == nil
    then
        SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][4]), player:getIndex(), 1)
        return
    end

    if QuestSystemPlayersInfo[player:getIndex()].Finished == 1
    then
        return
    end

    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    --get db function
    local db = DataBase.getDb()
    local query = string.format("SELECT * FROM QUEST_SYSTEM where AccountID='%s' and Name='%s'", player:getAccountID(), player:getName())

    local QuestIdentification = -1
    local Level = 0
    local Resets = 0
    local MResets = 0
    local Zen = 0
    local Coin1 = 0
    local Coin2 = 0
    local Coin3 = 0
    local Coin4 = 0
    local Vip = 0
    local Kills = 0
    local KillsMonster = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    local ItensRequirement = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            QuestIdentification = db:getInt('QuestIdentification')
            Kills = db:getInt('Kills')
            KillsMonster[1] = db:getInt('KillsMonster1')
            KillsMonster[2] = db:getInt('KillsMonster2')
            KillsMonster[3] = db:getInt('KillsMonster3')
            KillsMonster[4] = db:getInt('KillsMonster4')
            KillsMonster[5] = db:getInt('KillsMonster5')
            KillsMonster[6] = db:getInt('KillsMonster6')
            KillsMonster[7] = db:getInt('KillsMonster7')
            KillsMonster[8] = db:getInt('KillsMonster8')
            KillsMonster[9] = db:getInt('KillsMonster9')

            db:clear()

            local questInfo = QuestSystem.GetQuestIdentification(QuestIdentification)

            if questInfo ~= nil
            then
                if questInfo.Level ~= 0
                then
                    Level = player:getLevel()
                end

                if questInfo.Reset ~= 0
                then
                    Resets = DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, player:getName())
                end

                if questInfo.MReset ~= 0
                then
                    MResets = DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, player:getName())
                end

                if questInfo.Zen ~= 0
                then
                    Zen = player:getMoney()
                end

                if questInfo.Coin1 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN1_CONFIG.Table, QUEST_SYSTEM_COIN1_CONFIG.Column, QUEST_SYSTEM_COIN1_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin2 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN2_CONFIG.Table, QUEST_SYSTEM_COIN2_CONFIG.Column, QUEST_SYSTEM_COIN2_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin3 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN3_CONFIG.Table, QUEST_SYSTEM_COIN3_CONFIG.Column, QUEST_SYSTEM_COIN3_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin4 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_COIN4_CONFIG.Table, QUEST_SYSTEM_COIN4_CONFIG.Column, QUEST_SYSTEM_COIN4_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Vip ~= 0
                then
                    Vip = player:getVip()
                end

                local questRequirementInfo = QUEST_SYSTEM_REQUIREMENTS_ITEMS[QuestIdentification]

                if questRequirementInfo ~= nil
                then
                    local pInv = Inventory.new(player:getIndex())

                    local count = 1

                    for key in pairs(questRequirementInfo) do
                        if count > 10
                        then
                            break
                        end

                        local item = questRequirementInfo[key]
                        for i = 12, 203 do
                            if ItensRequirement[count] > item.Quantity
                            then
                                break
                            end

                            if pInv:isItem(i) ~= 0
                            then
                                if pInv:getIndex(i) == item.ItemIndex
                                then
                                    if (item.Level == -1 or pInv:getLevel(i) == item.Level)
                                        and (item.Skill == -1 or pInv:getItemTable(i, 2) == item.Skill)
                                        and (item.Luck == -1 or pInv:getItemTable(i, 3) == item.Luck)
                                    then
                                        if GetStackItem(pInv:getIndex(i)) <= 0
                                        then
                                            ItensRequirement[count] = ItensRequirement[count] + 1
                                        else
                                            ItensRequirement[count] = ItensRequirement[count] + pInv:getDurability(i)
                                        end
                                    end
                                end
                            end
                        end

                        count = count + 1
                    end

                    pInv = nil
                end
            end
        else
            db:clear()
        end
    else
        db:clear()
    end

    local questInfoCheck = QuestSystem.GetQuestIdentification(QuestIdentification)

    if questInfoCheck ~= nil
    then
        if Level < questInfoCheck.Level
            or Resets < questInfoCheck.Reset
            or MResets < questInfoCheck.MReset
            or Zen < questInfoCheck.Zen
            or Coin1 < questInfoCheck.Coin1
            or Coin2 < questInfoCheck.Coin2
            or Coin3 < questInfoCheck.Coin3
            or Coin4 < questInfoCheck.Coin4
            or Vip < questInfoCheck.Vip
            or Kills < questInfoCheck.Kills
        then
            SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][6]), player:getIndex(), 1)
            return
        end

        local questMonsterInfo = QUEST_SYSTEM_REQUIREMENTS_MONSTER[QuestIdentification]
        if questMonsterInfo ~= nil
        then
            local count = 1

            for key in pairs(questMonsterInfo) do
                if count > 9
                then
                    break
                end

                local monster = questMonsterInfo[key]

                if monster.Quantity > KillsMonster[count]
                then
                    SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][6]), player:getIndex(), 1)
                    return
                end

                count = count + 1
            end
        end

        local questItemInfo = QUEST_SYSTEM_REQUIREMENTS_ITEMS[QuestIdentification]

        if questItemInfo ~= nil
        then
            local count = 1
            for key in pairs(questItemInfo) do
                if count > 9
                then
                    break
                end

                local item = questItemInfo[key]

                if item.Quantity > ItensRequirement[count]
                then
                    SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][6]), player:getIndex(), 1)
                    return
                end

                count = count + 1
            end
        end

        --Remove things
        if QUEST_SYSTEM_REMOVE_RESETS == 1
        then
            if questInfoCheck.Reset > 0
            then
                DataBase.SetDecreaseValue(TABLE_RESET, COLUMN_RESET[0], questInfoCheck.Reset, WHERE_RESET, player:getName())
            end
        end

        if QUEST_SYSTEM_REMOVE_MRESETS == 1
        then
            if questInfoCheck.MReset > 0
            then
                DataBase.SetDecreaseValue(TABLE_MRESET, COLUMN_MRESET[0], questInfoCheck.MReset, WHERE_MRESET, player:getName())
            end
        end

        if QUEST_SYSTEM_REMOVE_COIN1 == 1
        then
            if questInfoCheck.Coin1 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_COIN1_CONFIG.Table, QUEST_SYSTEM_COIN1_CONFIG.Column, questInfoCheck.Coin1, QUEST_SYSTEM_COIN1_CONFIG.Where, player:getAccountID())
            end
        end

        if QUEST_SYSTEM_REMOVE_COIN2 == 1
        then
            if questInfoCheck.Coin2 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_COIN2_CONFIG.Table, QUEST_SYSTEM_COIN2_CONFIG.Column, questInfoCheck.Coin2, QUEST_SYSTEM_COIN2_CONFIG.Where, player:getAccountID())
            end
        end

        if QUEST_SYSTEM_REMOVE_COIN3 == 1
        then
            if questInfoCheck.Coin3 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_COIN3_CONFIG.Table, QUEST_SYSTEM_COIN3_CONFIG.Column, questInfoCheck.Coin3, QUEST_SYSTEM_COIN3_CONFIG.Where, player:getAccountID())
            end
        end

        if QUEST_SYSTEM_REMOVE_COIN4 == 1
        then
            if questInfoCheck.Coin4 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_COIN4_CONFIG.Table, QUEST_SYSTEM_COIN4_CONFIG.Column, questInfoCheck.Coin4, QUEST_SYSTEM_COIN4_CONFIG.Where, player:getAccountID())
            end
        end

        local questItemInfo = QUEST_SYSTEM_REQUIREMENTS_ITEMS[QuestIdentification]

        if questItemInfo ~= nil
        then
            local count = 1
            for key in pairs(questItemInfo) do
                if count > 9
                then
                    break
                end

                local item = questItemInfo[key]

                DeleteItemCount(player:getIndex(), item.ItemIndex, item.Level, item.Quantity)

                count = count + 1
            end
        end

        --Reward player
        local questRewardItem = QUEST_SYSTEM_REWARD_ITEMS[QuestIdentification]

        if questRewardItem ~= nil
        then
            for key in pairs(questRewardItem) do
                local item = questRewardItem[key]

                NpcRescueItem.InsertItem(player:getAccountID(), item.ItemIndex, item.Level, item.Op1, item.Op2, item.Life, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, item.DaysExpire, item.ItemTime)
            end
        end

        local questRewardCoins = QUEST_SYSTEM_REWARD_COINS[QuestIdentification]

        if questRewardCoins ~= nil
        then
            for key in pairs(questRewardCoins) do
                local coin = questRewardCoins[key]

                if coin.CoinIdentification == 1
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_COIN1_CONFIG.Table, QUEST_SYSTEM_COIN1_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_COIN1_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                elseif coin.CoinIdentification == 2
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_COIN2_CONFIG.Table, QUEST_SYSTEM_COIN2_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_COIN2_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                elseif coin.CoinIdentification == 3
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_COIN3_CONFIG.Table, QUEST_SYSTEM_COIN3_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_COIN3_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                elseif coin.CoinIdentification == 4
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_COIN4_CONFIG.Table, QUEST_SYSTEM_COIN4_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_COIN4_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                end
            end
        end

        local questRewardBuff = QUEST_SYSTEM_REWARD_BUFF[QuestIdentification]

        if questRewardBuff ~= nil
        then
            for key in pairs(questRewardBuff) do
                local buff = questRewardBuff[key]

                AddEffect(player:getIndex(), 1, buff.EffectID, os.time() + buff.EffectTime, 0, 0, 0, 0)
            end
        end

        QuestSystemPlayersInfo[player:getIndex()].Finished = 1
        DataBase.SetAddValue('QUEST_SYSTEM', 'Finished', 1, 'Name', player:getName())
        QuestSystem.OpenContinueQuest(player)
    end
end

function QuestSystem.ContinueQuest(player)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    if QuestSystemPlayersInfo[player:getIndex()].Finished ~= 1
    then
        return
    end

    if DataBase.GetValue('QUEST_SYSTEM', 'Finished', 'Name', player:getName()) == 0
    then
        return
    end

    local currentQuest = DataBase.GetValue('QUEST_SYSTEM', 'QuestIdentification', 'Name', player:getName())

    local getNextQuest = QuestSystem.GetQuestIdentification(currentQuest + 1)

    if getNextQuest ~= nil
    then
        QuestSystem.ResetQuestInfo(player:getAccountID(), player:getName(), currentQuest + 1)

        QuestSystem.OpenQuest(player)
    else
        SendMessage(string.format(QUEST_SYSTEM_MESSAGES[Language][8]), player:getIndex(), 1)
    end
end

function QuestSystem.Protocol(aIndex, Packet, PacketName)
    if Packet == QUEST_SYSTEM_PACKET
    then
        local player = User.new(aIndex)

        if string.format("%s_%s",QUEST_SYSTEM_PACKET_OPEN_NAME, player:getName()) == PacketName
        then
            ClearPacket(PacketName)
            QuestSystem.OpenQuest(player)
        elseif string.format("%s_%s",QUEST_SYSTEM_PACKET_START_NAME, player:getName()) == PacketName
        then
            ClearPacket(PacketName)
            QuestSystem.StartQuest(player)
        elseif string.format("%s_%s",QUEST_SYSTEM_PACKET_GET_REWARD_NAME, player:getName()) == PacketName
        then
            ClearPacket(PacketName)
            QuestSystem.GetReward(player)
        elseif string.format("%s_%s",QUEST_SYSTEM_PACKET_CONTINUE_QUEST_NAME, player:getName()) == PacketName
        then
            ClearPacket(PacketName)
            QuestSystem.ContinueQuest(player)
        end

        player = nil
    end
end

function QuestSystem.GetQuestIdentification(id)
    for i in pairs(QUEST_SYSTEM_INFO) do
        if QUEST_SYSTEM_INFO[i].QuestIdentification == id
        then
            return QUEST_SYSTEM_INFO[i]
        end
    end

    return nil
end

function QuestSystem.PlayerJoin(aIndex)
    if QuestSystemPlayersInfo[aIndex] ~= nil
    then
        QuestSystemPlayersInfo[aIndex] = nil
    end

    local player = User.new(aIndex)

    local db = DataBase.getDb()
    local query = string.format("SELECT * FROM QUEST_SYSTEM where AccountID='%s' and Name='%s'", player:getAccountID(), player:getName())

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            QuestSystemPlayersInfo[aIndex] = {
                PlayerIndex = aIndex,
                PlayerName = player:getName(),
                PlayerAccount = player:getAccountID(),
                QuestIdentification = db:getInt('QuestIdentification'),
                Kills = db:getInt('Kills'),
                KillsMonster = {},
                Finished = db:getInt('Finished')
            }

            for i = 1, 9 do
                QuestSystemPlayersInfo[aIndex].KillsMonster[i] = { value = db:getInt(string.format('KillsMonster%d', i)) }
            end
        end
    end

    db:clear()
end

function QuestSystem.OpenContinueQuest(player)
    local packetString = string.format("%s_%s", QUEST_SYSTEM_PACKET_CONTINUE_QUEST_NAME, player:getName())
    CreatePacket(packetString, QUEST_SYSTEM_PACKET)
    SendPacket(packetString, player:getIndex())
    ClearPacket(packetString)
end

function QuestSystem.PlayerLogout(aIndex)
    if QuestSystemPlayersInfo[aIndex] ~= nil
    then
        QuestSystemPlayersInfo[aIndex] = nil
    end
end

function QuestSystem.PlayerDie(PlayerIndex, TargetIndex)
    local playerQuest = QuestSystemPlayersInfo[PlayerIndex]

    if playerQuest ~= nil
    then
        if playerQuest.Finished == 1
        then
            return
        end

        local getQuestInfo = QuestSystem.GetQuestIdentification(playerQuest.QuestIdentification)

        if getQuestInfo ~= nil
        then
            if getQuestInfo.Kills > 0 and playerQuest.Kills < getQuestInfo.Kills
            then
                DataBase.SetAddValue('QUEST_SYSTEM', 'Kills', 1, 'Name', playerQuest.PlayerName)
                playerQuest.Kills = playerQuest.Kills + 1
            end
        end
    end
end

function QuestSystem.MonsterDie(PlayerIndex, MonsterIndex)
    local playerQuest = QuestSystemPlayersInfo[PlayerIndex]

    if playerQuest ~= nil
    then
        if playerQuest.Finished == 1
        then
            return
        end

        local getQuestInfo = QUEST_SYSTEM_REQUIREMENTS_MONSTER[playerQuest.QuestIdentification]

        if getQuestInfo ~= nil
        then
            local monster = User.new(MonsterIndex)

            local count = 1

            for key in pairs(getQuestInfo) do
                if count > 9
                then
                    break
                end

                local monsterInfo = getQuestInfo[key]

                if monsterInfo.MonsterIndex == monster:getClass()
                then
                    if playerQuest.KillsMonster[count].value < monsterInfo.Quantity
                    then
                        DataBase.SetAddValue('QUEST_SYSTEM', string.format('KillsMonster%d', count), 1, 'Name', playerQuest.PlayerName)
                        playerQuest.KillsMonster[count].value = playerQuest.KillsMonster[count].value + 1
                    end
                    break
                end

                count = count + 1
            end

            monster = nil
        end
    end
end

function QuestSystem.CreatePlayerCache()
    for i = OBJECT_START_USER, MAX_OBJECT do
        if gObjIsConnectedGP(i) ~= 0
		then
            QuestSystem.PlayerJoin(i)
        end
    end
end

function QuestSystem.InsertPlayer(account, name, questIdentification)
    local query = string.format("INSERT INTO [dbo].[QUEST_SYSTEM] ([AccountID],[Name],[QuestIdentification]) VALUES ('%s','%s','%d')", account, name, questIdentification)

    local db = DataBase.getDb()
    db:exec(query)
    db:fetch()
    db:clear()
end

function QuestSystem.ResetQuestInfo(account, name, questID)
    local query = string.format("UPDATE [dbo].[QUEST_SYSTEM] SET [QuestIdentification] = %d, [Kills] = 0, [KillsMonster1] = 0, [KillsMonster2] = 0, [KillsMonster3] = 0, [KillsMonster4] = 0, [KillsMonster5] = 0, [KillsMonster6] = 0, [KillsMonster7] = 0, [KillsMonster8] = 0, [KillsMonster9] = 0, [Finished] = 0 WHERE AccountID='%s' and Name='%s'", questID, account, name)

    local db = DataBase.getDb()
    db:exec(query)
    db:fetch()
    db:clear()
end

function QuestSystem.Init()
    if QUEST_SYSTEM_SWITCH ~= 1
    then
        return
    end

    GameServerFunctions.GameServerProtocol(QuestSystem.Protocol)
    GameServerFunctions.EnterCharacter(QuestSystem.PlayerJoin)
    GameServerFunctions.PlayerLogout(QuestSystem.PlayerLogout)
    GameServerFunctions.PlayerDie(QuestSystem.PlayerDie)
    GameServerFunctions.MonsterDie(QuestSystem.MonsterDie)

    QuestSystem.CreatePlayerCache()
end

QuestSystem.Init()

return QuestSystem