--[[
Command Configs
]]--
ONLINE_TIME_AWARDS_SWITCH = 0
ONLINE_TIME_AWARDS_OFFATTACK = 1 -- This work in /offattack and offmuhelper if 0 don't reward who was offattack or muhelper offline
ONLINE_TIME_AWARDS_OFFSTORE = 1 -- This work in /offstore if 0 don't reward who was offstore
ONLINE_TIME_AWARDS_TIME = 60 -- time in minutes

ONLINE_TIME_AWARDS_COINS_CONFIG = { }

ONLINE_TIME_AWARDS_COINS_CONFIG[1] = {
Table = 'MEMB_INFO',
Column = 'cash',
Where = 'memb___id',
Coins = 25,
CoinName = 'Cashs',
}

ONLINE_TIME_AWARDS_COINS_CONFIG[2] = {
Table = 'CashShopData',
Column = 'WCoinC',
Where = 'AccountID',
Coins = 15,
CoinName = 'WCoinC',
}

--[[
Command Message
]]--
ONLINE_TIME_AWARDS_MESSAGES = {  }

ONLINE_TIME_AWARDS_MESSAGES['Por'] = {
[1] = 'Você acabou de ser premiado com %d %s por ficar online',
}

ONLINE_TIME_AWARDS_MESSAGES['Eng'] = {
[1] = 'You have just been awarded %d %s for being online',
}

ONLINE_TIME_AWARDS_MESSAGES['Spn'] = {
[1] = 'Acabas de recibir %d %s por estar en línea',
}