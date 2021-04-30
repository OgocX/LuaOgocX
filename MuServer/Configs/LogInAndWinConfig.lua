LOG_IN_AND_WIN_SWITCH = 0

--Days player will get reward, obs: min is 5 days!
--don't have limit max of days you can put every number
--client need stay equal!
LOG_IN_AND_WIN_MAX_DAYS = 10

--Min time in seconds for get reward
LOG_IN_AND_WIN_GET_REWARD_MIN_TIME = 0 -- 0 = log and win

--packet number
LOG_IN_AND_WIN_PACKET = 2
--packet name
LOG_IN_AND_WIN_PACKET_NAME = 'GET_REWARD_LOG_IN'

LOG_IN_AND_WIN_REWARD_BY_DAYS = { }

--Day is identification of REWARD you need configure LOG_IN_AND_WIN_REWARDS_PLAYER in base on Day!
LOG_IN_AND_WIN_REWARD_BY_DAYS[1] = { Day = 1, RewardName = 'BrindeX', Quantity = 1, RewardGet = 'Kris Sword +15 + 10 WCoinC' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[2] = { Day = 2, RewardName = 'WCoinP', Quantity = 25, RewardGet = 'WCoinP' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[3] = { Day = 3, RewardName = 'Soul', Quantity = 10, RewardGet = 'Jewel of Soul' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[4] = { Day = 4, RewardName = 'Skull Staff', Quantity = 1, RewardGet = 'Skull Staff +15 FULL' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[5] = { Day = 5, RewardName = 'Asa Lv 1', Quantity = 1, RewardGet = 'Asa level 1 SM' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[6] = { Day = 6, RewardName = 'BrindeX2', Quantity = 1, RewardGet = 'Jewel of Bless + 20 WCoinP' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[7] = { Day = 7, RewardName = 'DK Set', Quantity = 1, RewardGet = 'DK Set Full +15' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[8] = { Day = 8, RewardName = 'Venom Set', Quantity = 1, RewardGet = 'Venom Set Full +15' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[9] = { Day = 9, RewardName = 'Sunlight Set', Quantity = 1, RewardGet = 'Sunlight Set Full +15' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[10] = { Day = 10, RewardName = 'WCoinC', Quantity = 10000, RewardGet = 'WCoinC' }

--this stay only in gameserver, don't put in client, here reward player!
--RewardType: 0 = Item, 1 = things that add data based on monuments
--RewardIdentification: 0 = you need put number of LOG_IN_AND_WIN_REWARD_ITENS, 1 = you need put number of LOG_IN_AND_WIN_REWARD_COINS
LOG_IN_AND_WIN_REWARDS_PLAYER = {}

LOG_IN_AND_WIN_REWARDS_PLAYER[1] = {
{ RewardType = 0, RewardIdentification = 0},
{ RewardType = 1, RewardIdentification = 0},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[2] = {
{ RewardType = 1, RewardIdentification = 1},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[3] = {
{ RewardType = 0, RewardIdentification = 2},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[4] = {
{ RewardType = 0, RewardIdentification = 3},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[5] = {
{ RewardType = 0, RewardIdentification = 4},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[6] = {
{ RewardType = 0, RewardIdentification = 5},
{ RewardType = 1, RewardIdentification = 2},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[7] = {
{ RewardType = 0, RewardIdentification = 7},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[8] = {
{ RewardType = 0, RewardIdentification = 8},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[9] = {
{ RewardType = 0, RewardIdentification = 9},
}

LOG_IN_AND_WIN_REWARDS_PLAYER[10] = {
{ RewardType = 1, RewardIdentification = 3},
}

-----------------------
----- Itens Config ----
-----------------------
LOG_IN_AND_WIN_REWARD_ITENS = {}

LOG_IN_AND_WIN_REWARD_ITENS[0] = {
{ ItemIndex = GET_ITEM(0, 0), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Kriss Sword +15', Count = 1},
}

LOG_IN_AND_WIN_REWARD_ITENS[2] = {
{ ItemIndex = GET_ITEM(14, 14), Level = 0, Op1 = 0, Op2 = 0, Life = 0, Exc = 0, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Jewel of Soul', Count = 10},
}

LOG_IN_AND_WIN_REWARD_ITENS[3] = {
{ ItemIndex = GET_ITEM(5, 0), Level = 15, Op1 = 1, Op2 = 1, Life = 1, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Skull Staff +15', Count = 1},
}

LOG_IN_AND_WIN_REWARD_ITENS[4] = {
{ ItemIndex = GET_ITEM(12, 1), Level = 15, Op1 = 1, Op2 = 1, Life = 1, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Asa level 1 SM', Count = 1},
}

LOG_IN_AND_WIN_REWARD_ITENS[5] = {
{ ItemIndex = GET_ITEM(14, 13), Level = 0, Op1 = 0, Op2 = 0, Life = 0, Exc = 0, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Jewel of Bless', Count = 1},
}

LOG_IN_AND_WIN_REWARD_ITENS[7] = {
{ ItemIndex = GET_ITEM(7, 29), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Helm Dragon Knight +15', Count = 1},
{ ItemIndex = GET_ITEM(8, 29), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Armor Dragon Knight +15', Count = 1},
{ ItemIndex = GET_ITEM(9, 29), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Pants Dragon Knight +15', Count = 1},
{ ItemIndex = GET_ITEM(10, 29), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Gloves Dragon Knight +15', Count = 1},
{ ItemIndex = GET_ITEM(11, 29), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Boots Dragon Knight +15', Count = 1},
}

LOG_IN_AND_WIN_REWARD_ITENS[8] = {
{ ItemIndex = GET_ITEM(7, 30), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Helm Venom Mist +15', Count = 1},
{ ItemIndex = GET_ITEM(8, 30), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Armor Venom Mist +15', Count = 1},
{ ItemIndex = GET_ITEM(9, 30), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Pants Venom Mist +15', Count = 1},
{ ItemIndex = GET_ITEM(10, 30), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Gloves Venom Mist +15', Count = 1},
{ ItemIndex = GET_ITEM(11, 30), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Boots Venom Mist +15', Count = 1},
}

LOG_IN_AND_WIN_REWARD_ITENS[9] = {
{ ItemIndex = GET_ITEM(7, 33), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Helm Sunlight +15', Count = 1},
{ ItemIndex = GET_ITEM(8, 33), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Armor Sunlight +15', Count = 1},
{ ItemIndex = GET_ITEM(9, 33), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Pants Sunlight +15', Count = 1},
{ ItemIndex = GET_ITEM(10, 33), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Gloves Sunlight +15', Count = 1},
{ ItemIndex = GET_ITEM(11, 33), Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Boots Sunlight +15', Count = 1},
}

-----------------------
----- Coins Config ----
-----------------------
LOG_IN_AND_WIN_REWARD_COINS = {}

LOG_IN_AND_WIN_REWARD_COINS[0] = {
{ Table = 'CashShopData', Column = 'WCoinC', Where = 'AccountID', Amounts = 10, Name = 'WCoinC' },
}

LOG_IN_AND_WIN_REWARD_COINS[1] = {
{ Table = 'CashShopData', Column = 'WCoinP', Where = 'AccountID', Amounts = 25, Name = 'WCoinP' },
}

LOG_IN_AND_WIN_REWARD_COINS[2] = {
{ Table = 'CashShopData', Column = 'WCoinP', Where = 'AccountID', Amounts = 20, Name = 'WCoinP' },
}

LOG_IN_AND_WIN_REWARD_COINS[3] = {
{ Table = 'CashShopData', Column = 'WCoinC', Where = 'AccountID', Amounts = 10000, Name = 'WCoinC' },
}

--[[
Messages configs
]]--
LOG_IN_AND_WIN_MESSAGES = {}

LOG_IN_AND_WIN_MESSAGES['Por'] = {
[1] = 'Você foi premiado com: %d %s',
[2] = 'Você está ocupado no momento!',
[3] = 'Ocorreu um erro na premiação, contate a administração.',
[4] = 'Ocorreu um erro, contate a administração.',
}

LOG_IN_AND_WIN_MESSAGES['Eng'] = {
[1] = 'You have been awarded: %d %s',
[2] = 'You are currently busy!',
[3] = 'There was an error in the award, please contact the administration.',
[4] = 'An error has occurred, please contact the administration.',
}

LOG_IN_AND_WIN_MESSAGES['Spn'] = {
[1] = 'Se le otorgó: %d %s',
[2] = '¡Actualmente estás ocupado!',
[3] = 'Hubo un error en el premio, comuníquese con la administración.',
[4] = 'Se produjo un error, comuníquese con la administración.',
}

--[[
Configs SQL
]]--

LOG_IN_AND_WIN_TABLE_TIMEONLINE = 'MEMB_STAT'
LOG_IN_AND_WIN_COLUMN_TIMEONLINE = 'TimeOnlineLogIn'
LOG_IN_AND_WIN_WHERE_TIMEONLINE = 'memb___id'

LOG_IN_AND_WIN_TABLE_DAY = 'MEMB_STAT'
LOG_IN_AND_WIN_COLUMN_DAY = 'LogInDay'
LOG_IN_AND_WIN_WHERE_DAY = 'memb___id'

LOG_IN_AND_WIN_TABLE_CHECK = 'MEMB_STAT'
LOG_IN_AND_WIN_COLUMN_CHECK = 'LogInAndWinReward'
LOG_IN_AND_WIN_WHERE_CHECK = 'memb___id'
