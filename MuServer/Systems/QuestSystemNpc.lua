QuestSystemNpc = {}

local QuestSystemNpcPlayersInfo = {}

function QuestSystemNpc.OpenQuest(player, NpcQuestIdentification, CheckAnotherQuest)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    local PlayerQuest = QuestSystemNpc.GetDbQuestIdentification(player:getAccountID(), player:getName())
	local QuestFinished = QuestSystemNpc.CheckQuestFinished(player:getAccountID(), player:getName())

    if QuestFinished > 0
    then
        if PlayerQuest == NpcQuestIdentification
        then
            QuestSystemNpc.OpenFinishedQuest(player)
            return
        end
    end

    if QUEST_SYSTEM_NPC_ONLY_ONE_QUEST == 1
    then
        local questUsed = QuestSystemNpc.CheckQuestUsed(player:getAccountID(), player:getName(), NpcQuestIdentification)

        if questUsed > 0
        then
            QuestSystemNpc.OpenFinishedQuest(player)
            return
        end
    end

    if CheckAnotherQuest == 1
    then
        if PlayerQuest ~= 0
        then
			if QuestFinished == 1
			then
				QuestSystemNpc.DeleteQuestInfo(player:getAccountID(), player:getName())
            elseif PlayerQuest ~= NpcQuestIdentification
            then
                QuestSystemNpc.OpenDismissQuest(player, NpcQuestIdentification)
                return
            end
        end
    end

    --get db function
    local db = DataBase.getDb()
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("SELECT * FROM QUEST_SYSTEM_NPC where AccountID='%s'", player:getAccountID())
    else
        query = string.format("SELECT * FROM QUEST_SYSTEM_NPC where AccountID='%s' and Name='%s'", player:getAccountID(), player:getName())
    end

    local QuestIdentification = NpcQuestIdentification
    local Started = 0
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
            Started = 1
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

            local questInfo = QuestSystemNpc.GetQuestIdentification(QuestIdentification)

            if questInfo ~= nil
            then
                if questInfo.Level ~= 0
                then
                    Level = player:getLevel()
                end

                if questInfo.Reset ~= 0
                then
                    Resets = player:getReset()
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
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN1_CONFIG.Table, QUEST_SYSTEM_NPC_COIN1_CONFIG.Column, QUEST_SYSTEM_NPC_COIN1_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin2 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN2_CONFIG.Table, QUEST_SYSTEM_NPC_COIN2_CONFIG.Column, QUEST_SYSTEM_NPC_COIN2_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin3 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN3_CONFIG.Table, QUEST_SYSTEM_NPC_COIN3_CONFIG.Column, QUEST_SYSTEM_NPC_COIN3_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin4 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN4_CONFIG.Table, QUEST_SYSTEM_NPC_COIN4_CONFIG.Column, QUEST_SYSTEM_NPC_COIN4_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Vip ~= 0
                then
                    Vip = player:getVip()
                end

                local questRequirementInfo = QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[QuestIdentification]

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
                                            if pInv:getDurability(i) > 0
                                            then
                                                ItensRequirement[count] = ItensRequirement[count] + pInv:getDurability(i)
                                            else
                                                ItensRequirement[count] = ItensRequirement[count] + 1
                                            end
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

    local packetIdentification = string.format("%s_%s",QUEST_SYSTEM_NPC_PACKET_OPEN_NAME, player:getName())
    CreatePacket(packetIdentification, QUEST_SYSTEM_NPC_PACKET)
    SetDwordPacket(packetIdentification, QuestIdentification)
    SetDwordPacket(packetIdentification, Started)
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

function QuestSystemNpc.StartQuest(player, QuestIdentification)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    if QuestSystemNpcPlayersInfo[player:getIndex()] ~= nil
    then
        if QuestSystemNpcPlayersInfo[player:getIndex()].Finished == 0
        then
            SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][5]), player:getIndex(), 1)
            return
        end
    end

    if QUEST_SYSTEM_NPC_ONLY_ONE_QUEST == 1
    then
        local questUsed = QuestSystemNpc.CheckQuestUsed(player:getAccountID(), player:getName(), QuestIdentification)

        if questUsed > 0
        then
            return
        end
    end

    local getFirstQuest = QuestSystemNpc.GetQuestIdentification(QuestIdentification)

    if getFirstQuest == nil
    then
        SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][2]), player:getIndex(), 1)
		return
    end

    local QuestExist = QuestSystemNpc.CheckQuestExist(player:getAccountID(), player:getName())

    if QuestExist == 1
    then
        QuestSystemNpc.DeleteQuestInfo(player:getAccountID(), player:getName())
    end

    QuestSystemNpc.InsertPlayer(player:getAccountID(), player:getName(), getFirstQuest.QuestIdentification)

    QuestSystemNpc.InsertQuestUsed(player:getAccountID(), player:getName(), getFirstQuest.QuestIdentification)

    SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][3], getFirstQuest.QuestName), player:getIndex(), 1)

    QuestSystemNpcPlayersInfo[player:getIndex()] = {
        PlayerIndex = player:getIndex(),
        PlayerName = player:getName(),
        PlayerAccount = player:getAccountID(),
        Language = player:getLanguage(),
        QuestIdentification = getFirstQuest.QuestIdentification,
        Kills = 0,
        KillsMonster = {},
        Finished = 0
    }

    for i = 1, 9 do
        QuestSystemNpcPlayersInfo[player:getIndex()].KillsMonster[i] = { value = 0 }
    end

    QuestSystemNpc.OpenQuest(player, getFirstQuest.QuestIdentification, 0)
end

function QuestSystemNpc.GetReward(player)
    if QuestSystemNpcPlayersInfo[player:getIndex()] == nil
    then
        SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][4]), player:getIndex(), 1)
        return
    end

    if QuestSystemNpcPlayersInfo[player:getIndex()].Finished == 1
    then
        return
    end

    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    --get db function
    local db = DataBase.getDb()
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("SELECT * FROM QUEST_SYSTEM_NPC where AccountID='%s'", player:getAccountID())
    else
        query = string.format("SELECT * FROM QUEST_SYSTEM_NPC where AccountID='%s' and Name='%s'", player:getAccountID(), player:getName())
    end

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

            local questInfo = QuestSystemNpc.GetQuestIdentification(QuestIdentification)

            if questInfo ~= nil
            then
                if questInfo.Level ~= 0
                then
                    Level = player:getLevel()
                end

                if questInfo.Reset ~= 0
                then
                    Resets = player:getReset()
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
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN1_CONFIG.Table, QUEST_SYSTEM_NPC_COIN1_CONFIG.Column, QUEST_SYSTEM_NPC_COIN1_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin2 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN2_CONFIG.Table, QUEST_SYSTEM_NPC_COIN2_CONFIG.Column, QUEST_SYSTEM_NPC_COIN2_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin3 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN3_CONFIG.Table, QUEST_SYSTEM_NPC_COIN3_CONFIG.Column, QUEST_SYSTEM_NPC_COIN3_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Coin4 ~= 0
                then
                    Coin1 = DataBase.GetValue(QUEST_SYSTEM_NPC_COIN4_CONFIG.Table, QUEST_SYSTEM_NPC_COIN4_CONFIG.Column, QUEST_SYSTEM_NPC_COIN4_CONFIG.Where, player:getAccountID())
                end

                if questInfo.Vip ~= 0
                then
                    Vip = player:getVip()
                end

                local questRequirementInfo = QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[QuestIdentification]

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
                                            if pInv:getDurability(i) > 0
                                            then
                                                ItensRequirement[count] = ItensRequirement[count] + pInv:getDurability(i)
                                            else
                                                ItensRequirement[count] = ItensRequirement[count] + 1
                                            end
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

    local questInfoCheck = QuestSystemNpc.GetQuestIdentification(QuestIdentification)

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
            SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][6]), player:getIndex(), 1)
            return
        end

        local questMonsterInfo = QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[QuestIdentification]
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
                    SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][6]), player:getIndex(), 1)
                    return
                end

                count = count + 1
            end
        end

        local questItemInfo = QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[QuestIdentification]

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
                    SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[Language][6]), player:getIndex(), 1)
                    return
                end

                count = count + 1
            end
        end

        --Remove things
        if QUEST_SYSTEM_NPC_REMOVE_RESETS == 1
        then
            if questInfoCheck.Reset > 0
            then
                DataBase.SetDecreaseValue(TABLE_RESET, COLUMN_RESET[0], questInfoCheck.Reset, WHERE_RESET, player:getName())
            end
        end

        if QUEST_SYSTEM_NPC_REMOVE_MRESETS == 1
        then
            if questInfoCheck.MReset > 0
            then
                DataBase.SetDecreaseValue(TABLE_MRESET, COLUMN_MRESET[0], questInfoCheck.MReset, WHERE_MRESET, player:getName())
            end
        end

        if QUEST_SYSTEM_NPC_REMOVE_COIN1 == 1
        then
            if questInfoCheck.Coin1 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_NPC_COIN1_CONFIG.Table, QUEST_SYSTEM_NPC_COIN1_CONFIG.Column, questInfoCheck.Coin1, QUEST_SYSTEM_NPC_COIN1_CONFIG.Where, player:getAccountID())
            end
        end

        if QUEST_SYSTEM_NPC_REMOVE_COIN2 == 1
        then
            if questInfoCheck.Coin2 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_NPC_COIN2_CONFIG.Table, QUEST_SYSTEM_NPC_COIN2_CONFIG.Column, questInfoCheck.Coin2, QUEST_SYSTEM_NPC_COIN2_CONFIG.Where, player:getAccountID())
            end
        end

        if QUEST_SYSTEM_NPC_REMOVE_COIN3 == 1
        then
            if questInfoCheck.Coin3 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_NPC_COIN3_CONFIG.Table, QUEST_SYSTEM_NPC_COIN3_CONFIG.Column, questInfoCheck.Coin3, QUEST_SYSTEM_NPC_COIN3_CONFIG.Where, player:getAccountID())
            end
        end

        if QUEST_SYSTEM_NPC_REMOVE_COIN4 == 1
        then
            if questInfoCheck.Coin4 > 0
            then
                DataBase.SetDecreaseValue(QUEST_SYSTEM_NPC_COIN4_CONFIG.Table, QUEST_SYSTEM_NPC_COIN4_CONFIG.Column, questInfoCheck.Coin4, QUEST_SYSTEM_NPC_COIN4_CONFIG.Where, player:getAccountID())
            end
        end

        local questItemInfo = QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[QuestIdentification]

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
        local questRewardItem = QUEST_SYSTEM_NPC_REWARD_ITEMS[QuestIdentification]

        if questRewardItem ~= nil
        then
            for key in pairs(questRewardItem) do
                local item = questRewardItem[key]

                NpcRescueItem.InsertItem(player:getAccountID(), item.ItemIndex, item.Level, item.Op1, item.Op2, item.Life, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, item.DaysExpire, item.ItemTime)
            end
        end

        local questRewardCoins = QUEST_SYSTEM_NPC_REWARD_COINS[QuestIdentification]

        if questRewardCoins ~= nil
        then
            for key in pairs(questRewardCoins) do
                local coin = questRewardCoins[key]

                if coin.CoinIdentification == 1
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_NPC_COIN1_CONFIG.Table, QUEST_SYSTEM_NPC_COIN1_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_NPC_COIN1_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                elseif coin.CoinIdentification == 2
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_NPC_COIN2_CONFIG.Table, QUEST_SYSTEM_NPC_COIN2_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_NPC_COIN2_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                elseif coin.CoinIdentification == 3
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_NPC_COIN3_CONFIG.Table, QUEST_SYSTEM_NPC_COIN3_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_NPC_COIN3_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                elseif coin.CoinIdentification == 4
                then
                    DataBase.SetAddValue(QUEST_SYSTEM_NPC_COIN4_CONFIG.Table, QUEST_SYSTEM_NPC_COIN4_CONFIG.Column, coin.CoinAmount, QUEST_SYSTEM_NPC_COIN4_CONFIG.Where, player:getAccountID())
                    SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[player:getLanguage()][7], coin.CoinAmount, coin.CoinName), player:getIndex(), 1)
                end
            end
        end

        local questRewardBuff = QUEST_SYSTEM_NPC_REWARD_BUFF[QuestIdentification]

        if questRewardBuff ~= nil
        then
            for key in pairs(questRewardBuff) do
                local buff = questRewardBuff[key]

                AddEffect(player:getIndex(), 1, buff.EffectID, os.time() + buff.EffectTime, 0, 0, 0, 0)
            end
        end

        QuestSystemNpcPlayersInfo[player:getIndex()].Finished = 1

        if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
        then
            DataBase.SetAddValue('QUEST_SYSTEM_NPC', 'Finished', 1, 'AccountID', player:getAccountID())
        else
            DataBase.SetAddValue('QUEST_SYSTEM_NPC', 'Finished', 1, 'Name', player:getName())
        end

        QuestSystemNpc.OpenFinishedQuest(player)
    end
end

function QuestSystemNpc.DismissQuest(player, QuestIdentification)
    if QuestSystemNpcPlayersInfo[player:getIndex()] == nil
    then
        return
    end

    QuestSystemNpc.DeleteQuestInfo(player:getAccountID(), player:getName())
    QuestSystemNpcPlayersInfo[player:getIndex()] = nil

    QuestSystemNpc.StartQuest(player, QuestIdentification)
end

function QuestSystemNpc.Protocol(aIndex, Packet, PacketName)
    if Packet == QUEST_SYSTEM_NPC_PACKET
    then
        local player = User.new(aIndex)

        if string.format("%s_%s",QUEST_SYSTEM_NPC_PACKET_START_NAME, player:getName()) == PacketName
        then
            QuestSystemNpc.StartQuest(player, GetDwordPacket(PacketName, -1))
            ClearPacket(PacketName)
        elseif string.format("%s_%s",QUEST_SYSTEM_NPC_PACKET_GET_REWARD_NAME, player:getName()) == PacketName
        then
            ClearPacket(PacketName)
            QuestSystemNpc.GetReward(player)
        elseif string.format("%s_%s",QUEST_SYSTEM_NPC_PACKET_DISMISS_QUEST_NAME, player:getName()) == PacketName
        then
            QuestSystemNpc.DismissQuest(player, GetDwordPacket(PacketName, -1))
            ClearPacket(PacketName)
        end

        player = nil
    end
end

function QuestSystemNpc.GetQuestIdentification(id)
    for i in pairs(QUEST_SYSTEM_NPC_INFO) do
        if QUEST_SYSTEM_NPC_INFO[i].QuestIdentification == id
        then
            return QUEST_SYSTEM_NPC_INFO[i]
        end
    end

    return nil
end

function QuestSystemNpc.PlayerJoin(aIndex)
    if QuestSystemNpcPlayersInfo[aIndex] ~= nil
    then
        QuestSystemNpcPlayersInfo[aIndex] = nil
    end

    local player = User.new(aIndex)

    local db = DataBase.getDb()
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("SELECT * FROM QUEST_SYSTEM_NPC where AccountID='%s'", player:getAccountID())
    else
        query = string.format("SELECT * FROM QUEST_SYSTEM_NPC where AccountID='%s' and Name='%s'", player:getAccountID(), player:getName())
    end

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            QuestSystemNpcPlayersInfo[aIndex] = {
                PlayerIndex = aIndex,
                PlayerName = player:getName(),
                PlayerAccount = player:getAccountID(),
                Language = player:getLanguage(),
                QuestIdentification = db:getInt('QuestIdentification'),
                Kills = db:getInt('Kills'),
                KillsMonster = {},
                Finished = db:getInt('Finished')
            }

            for i = 1, 9 do
                QuestSystemNpcPlayersInfo[aIndex].KillsMonster[i] = { value = db:getInt(string.format('KillsMonster%d', i)) }
            end
        end
    end

    db:clear()
end

function QuestSystemNpc.OpenFinishedQuest(player)
    local packetString = string.format("%s_%s", QUEST_SYSTEM_NPC_PACKET_FINISHED_QUEST_NAME, player:getName())
    CreatePacket(packetString, QUEST_SYSTEM_NPC_PACKET)
    SendPacket(packetString, player:getIndex())
    ClearPacket(packetString)
end

function QuestSystemNpc.OpenDismissQuest(player, QuestIdentification)
    local packetString = string.format("%s_%s", QUEST_SYSTEM_NPC_PACKET_DISMISS_QUEST_NAME, player:getName())
    CreatePacket(packetString, QUEST_SYSTEM_NPC_PACKET)
    SetDwordPacket(packetString, QuestIdentification)
    SendPacket(packetString, player:getIndex())
    ClearPacket(packetString)
end

function QuestSystemNpc.PlayerLogout(aIndex)
    if QuestSystemNpcPlayersInfo[aIndex] ~= nil
    then
        QuestSystemNpcPlayersInfo[aIndex] = nil
    end
end

function QuestSystemNpc.PlayerDie(PlayerIndex, TargetIndex)
    local playerQuest = QuestSystemNpcPlayersInfo[PlayerIndex]

    if playerQuest ~= nil
    then
        if playerQuest.Finished == 1
        then
            return
        end

        local getQuestInfo = QuestSystemNpc.GetQuestIdentification(playerQuest.QuestIdentification)

        if getQuestInfo ~= nil
        then
            if getQuestInfo.Kills > 0 and playerQuest.Kills < getQuestInfo.Kills
            then
                if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
                then
                    DataBase.SetAddValue('QUEST_SYSTEM_NPC', 'Kills', 1, 'AccountID', playerQuest.PlayerAccount)
                else
                    DataBase.SetAddValue('QUEST_SYSTEM_NPC', 'Kills', 1, 'Name', playerQuest.PlayerName)
                end

                playerQuest.Kills = playerQuest.Kills + 1
            end
        end
    end
end

function QuestSystemNpc.MonsterDie(PlayerIndex, MonsterIndex)
    local playerQuest = QuestSystemNpcPlayersInfo[PlayerIndex]

    if playerQuest ~= nil
    then
        if playerQuest.Finished == 1
        then
            return
        end

        local getQuestInfo = QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[playerQuest.QuestIdentification]

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
                        if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
                        then
                            DataBase.SetAddValue('QUEST_SYSTEM_NPC', string.format('KillsMonster%d', count), 1, 'AccountID', playerQuest.PlayerAccount)
                        else
                            DataBase.SetAddValue('QUEST_SYSTEM_NPC', string.format('KillsMonster%d', count), 1, 'Name', playerQuest.PlayerName)
                        end

                        playerQuest.KillsMonster[count].value = playerQuest.KillsMonster[count].value + 1

                        quest = QuestSystemNpc.GetQuestIdentification(playerQuest.QuestIdentification)

                        if quest ~= nil
                        then
                            SendMessage(string.format(QUEST_SYSTEM_NPC_MESSAGES[playerQuest.Language][9], quest.QuestName, monster:getName(), playerQuest.KillsMonster[count].value, monsterInfo.Quantity), PlayerIndex, 1)
                        end
                    end
                    break
                end

                count = count + 1
            end

            monster = nil
        end
    end
end

function QuestSystemNpc.CreatePlayerCache()
    for i = OBJECT_START_USER, MAX_OBJECT do
        if gObjIsConnectedGP(i) ~= 0
		then
            QuestSystemNpc.PlayerJoin(i)
        end
    end

    for i = OBJECT_START_MONSTER, MAX_OBJECT_MONSTER do
        local monster = User.new(i)

        if monster:getConnected() > 0
        then
            for i = 1, #QUEST_SYSTEM_NPC_LOCATION_INFO do
                if monster:getClass() == QUEST_SYSTEM_NPC_LOCATION_INFO[i].Class
                then
                    monster:setType(3)
                end
            end
        end

        monster = nil
    end
end

function QuestSystemNpc.CheckQuestFinished(account, name)
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("SELECT Finished FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s'", account)
    else
        query = string.format("SELECT Finished FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s' and Name='%s'", account, name)
    end

    local value = 0

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            value = db:getInt('Finished')
        end
    end

    db:clear()

    return value
end

function QuestSystemNpc.InsertPlayer(account, name, questIdentification)
    local query = string.format("INSERT INTO [dbo].[QUEST_SYSTEM_NPC] ([AccountID],[Name],[QuestIdentification]) VALUES ('%s','%s','%d')", account, name, questIdentification)

    local db = DataBase.getDb()
    db:exec(query)
    db:fetch()
    db:clear()
end

function QuestSystemNpc.DeleteQuestInfo(account, name)
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("DELETE FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s'", account)
    else
        query = string.format("DELETE FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s' and Name='%s'", account, name)
    end

    local db = DataBase.getDb()
    db:exec(query)
    db:fetch()
    db:clear()
end

function QuestSystemNpc.GetDbQuestIdentification(account, name)
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("SELECT QuestIdentification FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s'", account)
    else
        query = string.format("SELECT QuestIdentification FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s' and Name='%s'", account, name)
    end

    local value = 0

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            value = db:getInt('QuestIdentification')
        end
    end

    db:clear()

    return value
end

function QuestSystemNpc.CheckQuestExist(account, name)
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("SELECT count(*) as count FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s'", account)
    else
        query = string.format("SELECT count(*) as count FROM [dbo].[QUEST_SYSTEM_NPC] WHERE AccountID='%s' and Name='%s'", account, name)
    end

    local value = 0

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            value = db:getInt('count')
        end
    end

    db:clear()

    return value
end

function QuestSystemNpc.InsertQuestUsed(account, name, questIdentification)
    local query = string.format("INSERT INTO [dbo].[QUEST_SYSTEM_NPC_USED] ([AccountID],[Name],[QuestIdentification]) VALUES ('%s','%s','%d')", account, name, questIdentification)

    local db = DataBase.getDb()
    db:exec(query)
    db:fetch()
    db:clear()
end

function QuestSystemNpc.CheckQuestUsed(account, name, questIdentification)
    local query = ""

    if QUEST_SYSTEM_NPC_ONLY_ACCOUNT == 1
    then
        query = string.format("SELECT count(*) as count FROM [dbo].[QUEST_SYSTEM_NPC_USED] WHERE AccountID='%s' and questIdentification = '%d'", account, questIdentification)
    else
        query = string.format("SELECT count(*) as count FROM [dbo].[QUEST_SYSTEM_NPC_USED] WHERE AccountID='%s' and Name='%s' and questIdentification = '%d'", account, name, questIdentification)
    end

    local value = 0

    if db:exec(query) ~= 0
    then
        if db:fetch() ~= SQL_NO_DATA
        then
            value = db:getInt('count')
        end
    end

    db:clear()

    return value
end

function QuestSystemNpc.NpcTalk(NpcIndex, PlayerIndex)
    local npc = User.new(NpcIndex)

    for i = 1, #QUEST_SYSTEM_NPC_LOCATION_INFO do
        local NpcInfo = QUEST_SYSTEM_NPC_LOCATION_INFO[i]

        if npc:getClass() == NpcInfo.Class
        then
            if npc:getMapNumber() == NpcInfo.Map and npc:getX() == NpcInfo.CoordX and npc:getY() == NpcInfo.CoordY
            then
                local player = User.new(PlayerIndex)

                QuestSystemNpc.OpenQuest(player, NpcInfo.QuestIdentification, 1)

                player = nil
                return 1
            end
        end
    end

    npc = nil
end

function QuestSystemNpc.Init()
    if QUEST_SYSTEM_NPC_SWITCH ~= 1
    then
        return
    end

    GameServerFunctions.GameServerProtocol(QuestSystemNpc.Protocol)
    GameServerFunctions.EnterCharacter(QuestSystemNpc.PlayerJoin)
    GameServerFunctions.PlayerLogout(QuestSystemNpc.PlayerLogout)
    GameServerFunctions.PlayerDie(QuestSystemNpc.PlayerDie)
    GameServerFunctions.MonsterDie(QuestSystemNpc.MonsterDie)
    GameServerFunctions.NpcTalk(QuestSystemNpc.NpcTalk)

    QuestSystemNpc.CreatePlayerCache()
end

QuestSystemNpc.Init()

return QuestSystemNpc