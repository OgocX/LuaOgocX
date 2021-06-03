QUEST_SYSTEM_SWITCH = 1

QUEST_SYSTEM_REMOVE_RESETS = 1
QUEST_SYSTEM_REMOVE_MRESETS = 1
QUEST_SYSTEM_REMOVE_COIN1 = 1
QUEST_SYSTEM_REMOVE_COIN2 = 1
QUEST_SYSTEM_REMOVE_COIN3 = 1
QUEST_SYSTEM_REMOVE_COIN4 = 1

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
ItemTime: 0 = Eternal, time in seconds
DaysExpire: time the item will be able to stay in the rescue npc, after the person can no longer withdraw
]]--
QUEST_SYSTEM_REWARD_ITEMS = {}
--[1] = QuestIdentification
QUEST_SYSTEM_REWARD_ITEMS[1] = {
    { ItemIndex = GET_ITEM(7, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 3600, DaysExpire = 30, Name = 'Brass Helm +15', Count = 1},
    { ItemIndex = GET_ITEM(8, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 3600, DaysExpire = 30, Name = 'Brass Armor +15', Count = 1},
    { ItemIndex = GET_ITEM(9, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 3600, DaysExpire = 30, Name = 'Brass Pants +15', Count = 1},
    { ItemIndex = GET_ITEM(10, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 3600, DaysExpire = 30, Name = 'Brass Gloves +15', Count = 1},
    { ItemIndex = GET_ITEM(11, 8), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 3600, DaysExpire = 30, Name = 'Brass Boots +15', Count = 1},
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

QUEST_SYSTEM_COIN1_CONFIG = { Table = 'MEMB_INFO', Column = 'Cash', Where = 'memb__id' }
QUEST_SYSTEM_COIN2_CONFIG = { Table = 'CashShopData', Column = 'WCoinC', Where = 'AccountID' }
QUEST_SYSTEM_COIN3_CONFIG = { Table = 'CashShopData', Column = 'WcoinP', Where = 'AccountID' }
QUEST_SYSTEM_COIN4_CONFIG = { Table = 'CashShopData', Column = 'GlobinPoint', Where = 'AccountID' }

QUEST_SYSTEM_PACKET = 0x04
QUEST_SYSTEM_PACKET_OPEN_NAME = 'QuestSystemOpen'
QUEST_SYSTEM_PACKET_START_NAME = 'QuestSystemStartQuest'
QUEST_SYSTEM_PACKET_GET_REWARD_NAME = 'QuestSystemGetReward'
QUEST_SYSTEM_PACKET_CONTINUE_QUEST_NAME = 'QuestSystemContinueQuest'

QUEST_SYSTEM_MESSAGES = {}

QUEST_SYSTEM_MESSAGES['Por'] = {
[1] = 'Você está ocupado no momento!',
[2] = 'Não encontramos nenhuma quest disponível no momento!',
[3] = 'Você iniciou a quest %s!',
[4] = 'Não conseguimos identificar a sua quest!',
[5] = 'Você já está com uma quest ativa!',
[6] = 'Você precisa concluir todos os requisitos!',
[7] = 'Você recebeu %d %s',
[8] = 'Você já concluiu todas as quests!',
}

QUEST_SYSTEM_MESSAGES['Eng'] = {
[1] = 'You are busy at the moment!',
[2] = 'We havent found any quests available at the moment!',
[3] = 'You have started quest %s!',
[4] = 'We cant identify your quest!',
[5] = 'You already have an active quest!',
[6] = 'You must complete all requirements!',
[7] = 'You have received %d %s',
[8] = 'You have already completed all the quests!',
}

QUEST_SYSTEM_MESSAGES['Spn'] = {
[1] = '¡Estás ocupado en este momento!',
[2] = '¡No hemos encontrado ninguna misión disponible en este momento!',
[3] = '¡Has comenzado la misión %s!',
[4] = '¡No pudimos identificar tu misión!',
[5] = '¡Ya tienes una misión activa!',
[6] = '¡Debes completar todos los requisitos!',
[7] = 'Has recibido %d %s',
[8] = '¡Ya has completado todas las misiones!',
}
