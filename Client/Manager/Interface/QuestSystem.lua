QUEST_SYSTEM_SWITCH = 1

--[[
    Information:

    number -1 is the same as not asking for anything so if for example you have Level = -1, it's any level
]]

--Identification of the quest
QUEST_SYSTEM_INFO = {}
QUEST_SYSTEM_INFO = {
    { QuestIdentification = 1, Level = 220, Reset = 0, MReset = 1, Zen = 0, Coin1 = 0, Coin2 = 0, Coin3 = 0, Coin4 = 0, Vip = 0, Kills = 0, QuestName = 'OgocX Legendary - Season 1', Validity = '05/12/2021' },
    { QuestIdentification = 2, Level = 400, Reset = 100, MReset = 1, Zen = 0, Coin1 = 0, Coin2 = 0, Coin3 = 0, Coin4 = 0, Vip = 0, Kills = 0, QuestName = 'OgocX Medium - Season 1', Validity = '05/12/2021' },

}

--Requirements itens
QUEST_SYSTEM_REQUIREMENTS_ITEMS = {}

--[1] = QuestIdentification (max 9 itens)
QUEST_SYSTEM_REQUIREMENTS_ITEMS[1] = {
    { ItemIndex = GET_ITEM(14, 14), Level = -1, Luck = -1, Skill = -1, Quantity = 2 },
}

--[2] = QuestIdentification
QUEST_SYSTEM_REQUIREMENTS_ITEMS[2] = {
    { ItemIndex = GET_ITEM(12, 15), Level = -1, Luck = -1, Skill = -1, Quantity = 5 },
}

--Requirements monster kill (max 9 monster)
QUEST_SYSTEM_REQUIREMENTS_MONSTER = {}
--[1] = QuestIdentification
QUEST_SYSTEM_REQUIREMENTS_MONSTER[1] = {
    { MonsterIndex = 2, Quantity = 5 },
}

-----
-- Reward player
-----
--Coins
QUEST_SYSTEM_REWARD_COINS = {}
--[1] = QuestIdentification
QUEST_SYSTEM_REWARD_COINS[1] = {
 { CoinName = 'WcoinC', CoinAmount = 50, CoinIdentification = 2 },
}

--[[
DaysItem: -1 = Eternal, 1 = 1 day, 2 = days
DaysExpire: time the item will be able to stay in the rescue npc, after the person can no longer withdraw
]]--
QUEST_SYSTEM_REWARD_ITEMS = {}
--[1] = QuestIdentification
QUEST_SYSTEM_REWARD_ITEMS[1] = {
    { ItemIndex = GET_ITEM(7, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysItem = -1, DaysExpire = 30, Name = 'Brass Helm +15', Count = 1},
    { ItemIndex = GET_ITEM(8, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysItem = -1, DaysExpire = 30, Name = 'Brass Armor +15', Count = 1},
    { ItemIndex = GET_ITEM(9, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysItem = -1, DaysExpire = 30, Name = 'Brass Pants +15', Count = 1},
    { ItemIndex = GET_ITEM(10, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysItem = -1, DaysExpire = 30, Name = 'Brass Gloves +15', Count = 1},
    { ItemIndex = GET_ITEM(11, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysItem = -1, DaysExpire = 30, Name = 'Brass Boots +15', Count = 1},
}

--Buffs
QUEST_SYSTEM_REWARD_BUFF = {}
--[1] = QuestIdentification
-- EffectTime = time in seconds
QUEST_SYSTEM_REWARD_BUFF[1]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}
--[2] = QuestIdentification
QUEST_SYSTEM_REWARD_BUFF[2]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}

QUEST_SYSTEM_PACKET = 0x04
QUEST_SYSTEM_PACKET_OPEN_NAME = 'QuestSystemOpen'
QUEST_SYSTEM_PACKET_START_NAME = 'QuestSystemStartQuest'
QUEST_SYSTEM_PACKET_GET_REWARD_NAME = 'QuestSystemGetReward'
QUEST_SYSTEM_PACKET_CONTINUE_QUEST_NAME = 'QuestSystemContinueQuest'

QUEST_SYSTEM_VIP_NAME = {}

QUEST_SYSTEM_VIP_NAME[0] = 'Free'
QUEST_SYSTEM_VIP_NAME[1] = 'Vip Silver'
QUEST_SYSTEM_VIP_NAME[2] = 'Vip Gold'
QUEST_SYSTEM_VIP_NAME[3] = 'Vip Plantinum'

QUEST_SYSTEM_MESSAGES = {}

QUEST_SYSTEM_MESSAGES['Por'] = {
[1] = 'Sistema de quest',
[2] = 'Válida até o dia: %s',
[3] = 'Você ainda não iniciou nenhuma quest',
[4] = 'Gostaria de iniciar a quest?',
[5] = 'Começar Quest',
[6] = 'Recolher recompensa',
[7] = 'Requisitos:',
[8] = '- %d Level',
[9] = '- %d Resets',
[10] = '- %d MResets',
[11] = '- %d Zen',
[12] = '- %d Cash',
[13] = '- %d WcoinC',
[14] = '- %d WcoinP',
[15] = '- %d GlobinPoint',
[16] = '- %d Kills',
[17] = '- %s',
[18] = '- Matar %s (%d/%d)',
[19] = '- Obter %dx %s',
[20] = 'Prêmios:',
[21] = 'A missão foi concluída!',
[22] = 'Continuar',
[23] = 'Fechar',
}

QUEST_SYSTEM_MESSAGES['Eng'] = {
[1] = 'Quest system',
[2] = 'Valid until day: %s',
[3] = 'You havent started any quests yet',
[4] = 'Would you like to start the quest?',
[5] = 'Start Quest',
[6] = 'Collect reward',
[7] = 'Requirements:',
[8] = '-%d Level',
[9] = '-%d Resets',
[10] = '-%d MResets',
[11] = '-%d Zen',
[12] = '-%d Cash',
[13] = '-%d WcoinC',
[14] = '-%d WcoinP',
[15] = '-%d GlobinPoint',
[16] = '-%d Kills',
[17] = '-%s',
[18] = '- Kill %s (%d/%d)',
[19] = '- Get %dx %s',
[20] = 'Awards:',
[21] = 'The mission has been completed!',
[22] = 'Continue',
[23] = 'Close',
}

QUEST_SYSTEM_MESSAGES['Spn'] = {
[1] = 'Sistema de misiones',
[2] = 'Válido hasta el día: %s',
[3] = 'Aún no has comenzado ninguna misión',
[4] = '¿Te gustaría comenzar la misión?',
[5] = 'Iniciar misión',
[6] = 'Recoger recompensa',
[7] = 'Requisitos:',
[8] = '- %d nivel',
[9] = '- %d reinicia',
[10] = '- %d MResets',
[11] = '- %d Zen',
[12] = '- %d efectivo',
[13] = '- %d WcoinC',
[14] = '- %d WcoinP',
[15] = '- %d GlobinPoint',
[16] = '- %d muertes',
[17] = '- %s',
[18] = '- Mata a %s (%d/%d)',
[19] = '- Obtener %dx %s',
[20] = 'Premios:',
[21] = '¡La misión ha sido completada!',
[22] = 'Continuar',
[23] = 'Cerrar',
}

QuestSystem = {}

local QuestSystemInfo = {}
local QuestSystemInfoMonsterKill = {}
local QuestSystemInfoItensCount = {}
local QuestSystemFinishedQuest = 0

local QuestSystemVisible = 0

local m_Pos = { x = 450, y = 0 }

function QuestSystem.Render()
    if QuestSystemVisible ~= 1
    then
        return
    end

    EnableAlphaTest()

    glColor4f(1.0, 1.0, 1.0, 1.0)

    QuestSystem.RenderFrame()

    QuestSystem.RenderTexts()

    DisableAlphaBlend()
end

function QuestSystem.RenderFrame()
    RenderImage(31322, m_Pos.x, m_Pos.y, 190.0, 429.0)
	RenderImage(31353, m_Pos.x, m_Pos.y, 190.0, 64.0)
	RenderImage(31355, m_Pos.x, m_Pos.y + 64, 21.0, 320.0)
	RenderImage(31356, m_Pos.x + 169, m_Pos.y + 64, 21.0, 320.0)
	RenderImage(31357, m_Pos.x, m_Pos.y + 384, 190.0, 45.0)

    RenderImage2(31370, m_Pos.x + 10, m_Pos.y + 380, 36, 29, 0, 0.0, 0.56, 0.40, 1, 1, 1.0)

    if QuestSystemFinishedQuest == 1
    then
        QuestSystem.RenderButtom(m_Pos.x + 55, m_Pos.y + 150, 100, 20, QUEST_SYSTEM_MESSAGES[GetLanguage()][22])
        return
    end

    local questInfo = QuestSystem.GetQuestIdentification(QuestSystemInfo.QuestIdentification)

    if questInfo ~= nil
    then
        --Division
        RenderImage(31401, m_Pos.x, m_Pos.y + 212, 190.0, 21.0)

        QuestSystem.RenderButtom(m_Pos.x + 65, m_Pos.y + 380, 100, 20, QUEST_SYSTEM_MESSAGES[GetLanguage()][6])
    else
        QuestSystem.RenderButtom(m_Pos.x + 55, m_Pos.y + 150, 100, 20, QUEST_SYSTEM_MESSAGES[GetLanguage()][5])
    end
end

function QuestSystem.RenderButtom(x, y, width, height, text)
    if MousePosX() >= x and MousePosX() <= x + width and MousePosY() >= y and MousePosY() <= y + height
	then
		RenderImage2(31326, x, y, width, height, 0, 0.2264566, 1.0, 0.2245212, 1, 1, 1.0)
	else
		RenderImage2(31326, x, y, width, height, 0, 0, 1.0, 0.2245212, 1, 1, 1.0)
	end
	
	SetFontType(1)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(225, 225, 225, 225)
	
	RenderText3(x, y + 5, text, width-#text, 3)
end

function QuestSystem.RenderTexts()
    EnableAlphaTest()

    SetFontType(1)
	
	SetTextBg(0, 0, 0, 0)
	
	SetTextColor(216, 216, 216, 255)
	
	RenderText3(m_Pos.x, m_Pos.y + 11, QUEST_SYSTEM_MESSAGES[GetLanguage()][1], 190, 3)

    SetFontType(1)

    SetTextColor(225, 225, 225, 225)

    if QuestSystemFinishedQuest == 1
    then
        RenderText3(m_Pos.x, m_Pos.y + 115, QUEST_SYSTEM_MESSAGES[GetLanguage()][21], 190, 3)
        return
    end

    local questInfo = QuestSystem.GetQuestIdentification(QuestSystemInfo.QuestIdentification)

    if questInfo ~= nil
    then
        RenderText3(m_Pos.x, m_Pos.y + 40, questInfo.QuestName, 190, 3)

        RenderText3(m_Pos.x, m_Pos.y + 50, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][2], questInfo.Validity), 190, 3)

        QuestSystem.RenderTextRequirements(questInfo)

        QuestSystem.RenderTextReward(questInfo)
    else
        RenderText3(m_Pos.x, m_Pos.y + 100, QUEST_SYSTEM_MESSAGES[GetLanguage()][3], 190, 3)

        RenderText3(m_Pos.x, m_Pos.y + 120, QUEST_SYSTEM_MESSAGES[GetLanguage()][4], 190, 3)
    end

    if MousePosX() >= m_Pos.x + 10 and MousePosX() <= m_Pos.x + 10 + 36 and MousePosY() >= m_Pos.y + 380 and MousePosY() <= m_Pos.y + 380 + 29
	then   
        SetTextBg(0, 0, 0, 225)
        RenderText3(m_Pos.x + 12, m_Pos.y + 367, QUEST_SYSTEM_MESSAGES[GetLanguage()][23], 30, 3)
    end

    DisableAlphaBlend()
end

function QuestSystem.RenderTextRequirements(questInfo)
    local m_X = m_Pos.x
    local m_Y = m_Pos.y + 100
    local addY = 0

    SetTextColor(255, 189, 25, 255)

    RenderText3(m_Pos.x, m_Pos.y + 80, QUEST_SYSTEM_MESSAGES[GetLanguage()][7], 190, 3)

    SetFontType(1)

    if questInfo.Level > 0
    then
        if questInfo.Level > QuestSystemInfo.Level
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][8], questInfo.Level), 175, 1)
        addY = addY + 10
    end

    if questInfo.Reset > 0
    then
        if questInfo.Reset > QuestSystemInfo.Resets
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][9], questInfo.Reset), 175, 1)
        addY = addY + 10
    end

    if questInfo.MReset > 0
    then
        if questInfo.MReset > QuestSystemInfo.MResets
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][10], questInfo.MReset), 175, 1)
        addY = addY + 10
    end

    if questInfo.Zen > 0
    then
        if questInfo.Zen > QuestSystemInfo.Zen
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][11], questInfo.Zen), 175, 1)
        addY = addY + 10
    end

    if questInfo.Coin1 > 0
    then
        if questInfo.Coin1 > QuestSystemInfo.Coin1
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][12], questInfo.Coin1), 175, 1)
        addY = addY + 10
    end

    if questInfo.Coin2 > 0
    then
        if questInfo.Coin2 > QuestSystemInfo.Coin2
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][13], questInfo.Coin2), 175, 1)
        addY = addY + 10
    end

    if questInfo.Coin3 > 0
    then
        if questInfo.Coin3 > QuestSystemInfo.Coin3
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][14], questInfo.Coin3), 175, 1)
        addY = addY + 10
    end

    if questInfo.Coin4 > 0
    then
        if questInfo.Coin4 > QuestSystemInfo.Coin4
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][15], questInfo.Coin4), 175, 1)
        addY = addY + 10
    end

    if questInfo.Kills > 0
    then
        if questInfo.Kills > QuestSystemInfo.Kills
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][16], questInfo.Kills), 175, 1)
        addY = addY + 10
    end

    if questInfo.Vip > 0
    then
        if questInfo.Vip > QuestSystemInfo.Vip
        then
            SetTextColor(255, 105, 25, 255)
        else
            SetTextColor(172, 255, 56, 255)
        end

        RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][17], QUEST_SYSTEM_VIP_NAME[questInfo.Vip]), 175, 1)
        addY = addY + 10
    end

    local questMonsterInfo = QUEST_SYSTEM_REQUIREMENTS_MONSTER[QuestSystemInfo.QuestIdentification]

    if questMonsterInfo ~= nil
    then
        local count = 1
        for key in pairs(questMonsterInfo) do
            if count > 9
            then
                break
            end

            local monster = questMonsterInfo[key]

            if monster.Quantity > QuestSystemInfoMonsterKill[count]
            then
                SetTextColor(255, 105, 25, 255)
            else
                SetTextColor(172, 255, 56, 255)
            end

            RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][18], GetMonsterName(monster.MonsterIndex), QuestSystemInfoMonsterKill[count], monster.Quantity), 175, 1)
            addY = addY + 10

            count = count + 1
        end
    end

    local questItemInfo = QUEST_SYSTEM_REQUIREMENTS_ITEMS[QuestSystemInfo.QuestIdentification]

    if questItemInfo ~= nil
    then
        local count = 1
        for key in pairs(questItemInfo) do
            if count > 9
            then
                break
            end

            local item = questItemInfo[key]

            if item.Quantity > QuestSystemInfoItensCount[count]
            then
                SetTextColor(255, 105, 25, 255)
            else
                SetTextColor(172, 255, 56, 255)
            end

            RenderText3(m_Pos.x + 15, m_Y + addY, string.format(QUEST_SYSTEM_MESSAGES[GetLanguage()][19], item.Quantity, GetNameByIndex(item.ItemIndex)), 175, 1)
            addY = addY + 10

            count = count + 1
        end
    end
end

function QuestSystem.RenderTextReward(questInfo)
    local m_X = m_Pos.x
    local m_Y = m_Pos.y + 250
    local addY = 0

    SetTextColor(255, 189, 25, 255)

    RenderText3(m_Pos.x, m_Pos.y + 230, QUEST_SYSTEM_MESSAGES[GetLanguage()][20], 190, 3)

    SetFontType(1)

    SetTextColor(225, 225, 225, 225)

    local RewardItens = QUEST_SYSTEM_REWARD_ITEMS[QuestSystemInfo.QuestIdentification]

    if RewardItens ~= nil
    then
        for key in pairs(RewardItens) do
            local item = RewardItens[key]

            RenderText3(m_Pos.x + 15, m_Y + addY, string.format('- %s', GetNameByIndex(item.ItemIndex)), 175, 1)
            addY = addY + 10
        end
    end

    local RewardCoins = QUEST_SYSTEM_REWARD_COINS[QuestSystemInfo.QuestIdentification]

    if RewardCoins ~= nil
    then
        for key in pairs(RewardCoins) do
            local coin = RewardCoins[key]

            RenderText3(m_Pos.x + 15, m_Y + addY, string.format('- %d %s', coin.CoinAmount, coin.CoinName), 175, 1)
            addY = addY + 10
        end
    end

    local RewardBuffs = QUEST_SYSTEM_REWARD_BUFF[QuestSystemInfo.QuestIdentification]

    if RewardBuffs ~= nil
    then
        for key in pairs(RewardBuffs) do
            local buff = RewardBuffs[key]

            RenderText3(m_Pos.x + 15, m_Y + addY, string.format('- %s', buff.BuffName), 175, 1)
            addY = addY + 10
        end
    end
end

function QuestSystem.UpdateMouse()
    if QuestSystemVisible ~= 1
    then
        return
    end

    local MouseX = MousePosX()
    local MoyseY = MousePosY()

    local questInfo = nil

    if QuestSystemInfo ~= nil
    then
        questInfo = QuestSystem.GetQuestIdentification(QuestSystemInfo.QuestIdentification)
    end

    if questInfo ~= nil and QuestSystemFinishedQuest == 0
    then
        --Get reward
        if (MouseX >= (m_Pos.x + 55) and MouseX <= m_Pos.x + 55 + 100)
            and (MoyseY >= (m_Pos.y + 385) and MoyseY <= (m_Pos.y + 385) + 20)
        then
            if (CheckPressedKey(Keys.LButton) == 1)
            then
                QuestSystem.GetReward()
                DisableClickClient()
            end
        end
    else
        if QuestSystemFinishedQuest == 1
        then
            if (MouseX >= (m_Pos.x + 55) and MouseX <= m_Pos.x + 55 + 100)
                and (MoyseY >= (m_Pos.y + 150) and MoyseY <= (m_Pos.y + 150) + 20)
            then
                if (CheckPressedKey(Keys.LButton) == 1)
                then
                    QuestSystem.ContinueQuest()
                    DisableClickClient()
                end
            end
        elseif (MouseX >= (m_Pos.x + 55) and MouseX <= m_Pos.x + 55 + 100)
            and (MoyseY >= (m_Pos.y + 150) and MoyseY <= (m_Pos.y + 150) + 20)
        then
            if (CheckPressedKey(Keys.LButton) == 1)
            then
                QuestSystem.StartQuest()
                DisableClickClient()
            end
        end
    end

    if MouseX >= m_Pos.x + 10 and MouseX <= m_Pos.x + 10 + 36 and MoyseY >= m_Pos.y + 380 and MoyseY <= m_Pos.y + 380 + 29
	then
        if (CheckPressedKey(Keys.LButton) == 1)
        then
            QuestSystem.Close()
            DisableClickClient()
        end
    end

    if (MouseX >= (m_Pos.x) and MouseX <= m_Pos.x + 190)
        and (MoyseY >= (m_Pos.y) and MoyseY <= (m_Pos.y) + 429)
    then
        DisableClickClient()
    end
end

function QuestSystem.UpdateKeyEvent()
    if QuestSystemVisible ~= 1
    then
        return
    end

    if (CheckPressedKey(Keys.Escape) == 1)
	then
		QuestSystem.Close()
	end
end

function QuestSystem.UpdateProc()
    if QuestSystemVisible ~= 1
    then
        return
    end

    if	CheckWindowOpen(UIInventory) 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIFriendList) 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIMoveList)			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIParty) 			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIQuest) 			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIGuild) 			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UITrade) 			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIWarehouse) 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIChaosBox)			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UICommandWindow) 	== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIPetInfo)	 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIShop)				== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIStore) 			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIOtherStore) 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UICharacter) 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIOptions) 			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIHelp)				== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIFastDial)			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UISkillTree) 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UINPC_Titus) 		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UICashShop)			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIFullMap) 			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UINPC_Dialog)		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIGensInfo)			== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UINPC_Julia)		== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIExpandInventory)	== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIExpandWarehouse)	== 1	then	QuestSystem.Close()	end
    if	CheckWindowOpen(UIMuHelper)			== 1	then	QuestSystem.Close()	end
end

function QuestSystem.CheckOpen()
    return QuestSystemVisible
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

function QuestSystem.Close()
    QuestSystemVisible = 0
    QuestSystemFinishedQuest = 0
    QuestSystemInfo = nil
    QuestSystemInfoMonsterKill = nil
    QuestSystemInfoItensCount = nil
end

function QuestSystem.Open(PacketName)
    HideAllInterface()

    QuestIdentification = GetDwordPacket(PacketName, -1)
    Level = GetDwordPacket(PacketName, -1)
    Resets = GetDwordPacket(PacketName, -1)
    MResets = GetDwordPacket(PacketName, -1)
    Zen = GetDwordPacket(PacketName, -1)
    Coin1 = GetDwordPacket(PacketName, -1)
    Coin2 = GetDwordPacket(PacketName, -1)
    Coin3 = GetDwordPacket(PacketName, -1)
    Coin4 = GetDwordPacket(PacketName, -1)
    Vip = GetDwordPacket(PacketName, -1)
    Kills = GetDwordPacket(PacketName, -1)


    QuestSystemInfo = { QuestIdentification = QuestIdentification, Level = Level, Resets = Resets, MResets = MResets, Zen = Zen, Coin1 = Coin1, Coin2 = Coin2
                        , Coin3 = Coin3, Coin4 = Coin4, Vip = Vip, Kills = Kills }

    MonsterCount = {}
    QuestSystemInfoMonsterKill = {}

    for i = 1, 9 do
        MonsterCount[i] = GetDwordPacket(PacketName, -1)
    end

    for i = 1, 9 do
        QuestSystemInfoMonsterKill[i] = MonsterCount[i]
    end

    ItensCount = {}
    QuestSystemInfoItensCount = {}

    for i = 1, 10 do
        ItensCount[i] = GetDwordPacket(PacketName, -1)
    end

    for i = 1, 10 do
        QuestSystemInfoItensCount[i] = ItensCount[i]
    end

    QuestSystemVisible = 1
end

function QuestSystem.SendOpenQuest()
    local packetString = string.format("%s_%s", QUEST_SYSTEM_PACKET_OPEN_NAME, UserGetName())
    CreatePacket(packetString, QUEST_SYSTEM_PACKET)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function QuestSystem.StartQuest()
    local packetString = string.format("%s_%s", QUEST_SYSTEM_PACKET_START_NAME, UserGetName())
    CreatePacket(packetString, QUEST_SYSTEM_PACKET)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function QuestSystem.GetReward()
    local questInfo = QuestSystem.GetQuestIdentification(QuestSystemInfo.QuestIdentification)

    if questInfo ~= nil
    then
        if QuestSystemInfo.Level < questInfo.Level
            or QuestSystemInfo.Resets < questInfo.Reset
            or QuestSystemInfo.MResets < questInfo.MReset
            or QuestSystemInfo.Zen < questInfo.Zen
            or QuestSystemInfo.Coin1 < questInfo.Coin1
            or QuestSystemInfo.Coin2 < questInfo.Coin2
            or QuestSystemInfo.Coin3 < questInfo.Coin3
            or QuestSystemInfo.Coin4 < questInfo.Coin4
            or QuestSystemInfo.Vip < questInfo.Vip
            or QuestSystemInfo.Kills < questInfo.Kills
        then
            return
        end

        local questMonsterInfo = QUEST_SYSTEM_REQUIREMENTS_MONSTER[QuestSystemInfo.QuestIdentification]
        if questMonsterInfo ~= nil
        then
            local count = 1

            for key in pairs(questMonsterInfo) do
                if count > 9
                then
                    break
                end

                local monster = questMonsterInfo[key]

                if monster.Quantity > QuestSystemInfoMonsterKill[count]
                then
                    return
                end

                count = count + 1
            end
        end

        local questItemInfo = QUEST_SYSTEM_REQUIREMENTS_ITEMS[QuestSystemInfo.QuestIdentification]

        if questItemInfo ~= nil
        then
            local count = 1
            for key in pairs(questItemInfo) do
                if count > 9
                then
                    break
                end

                local item = questItemInfo[key]

                if item.Quantity > QuestSystemInfoItensCount[count]
                then
                    return
                end

                count = count + 1
            end
        end

        local packetString = string.format("%s_%s", QUEST_SYSTEM_PACKET_GET_REWARD_NAME, UserGetName())
        CreatePacket(packetString, QUEST_SYSTEM_PACKET)
        SendPacket(packetString)
        ClearPacket(packetString)
    end
end

function QuestSystem.ContinueQuest()
    local packetString = string.format("%s_%s", QUEST_SYSTEM_PACKET_CONTINUE_QUEST_NAME, UserGetName())
    CreatePacket(packetString, QUEST_SYSTEM_PACKET)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function QuestSystem.OpenContinueQuest()
    HideAllInterface()

    QuestSystemFinishedQuest = 1

    QuestSystemVisible = 1
end

function QuestSystem.Protocol(Packet, PacketName)
    if Packet ~= QUEST_SYSTEM_PACKET
    then
        return
    end

    if PacketName == string.format("%s_%s", QUEST_SYSTEM_PACKET_OPEN_NAME, UserGetName())
    then
        QuestSystem.Open(PacketName)
        ClearPacket(PacketName)
    elseif PacketName == string.format("%s_%s", QUEST_SYSTEM_PACKET_CONTINUE_QUEST_NAME, UserGetName())
    then
        QuestSystem.OpenContinueQuest()
        ClearPacket(PacketName)
    end
end

function QuestSystem.Init()
    if QUEST_SYSTEM_SWITCH ~= 1
    then
        return
    end

    InterfaceController.ClientProtocol(QuestSystem.Protocol)
    InterfaceController.MainProc(QuestSystem.Render)
	InterfaceController.UpdateMouse(QuestSystem.UpdateMouse)
	InterfaceController.UpdateKey(QuestSystem.UpdateKeyEvent)
    InterfaceController.UpdateProc(QuestSystem.UpdateProc)
end

QuestSystem.Init()

return QuestSystem