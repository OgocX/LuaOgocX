--[[
Coins reward configs
]]--

--[[ 
Additional info:
this reward: who delivers the item and the party the person is at

Devil Square:
this reward: top 1 player who scored the most points
]]--

REWARD_NATIVE_EVENTS_SWITCH = 1

REWARD_NATIVE_EVENTS_COINS = {}

--Type 1 = BC, 2 = CC, 3 = DS

--BC
REWARD_NATIVE_EVENTS_COINS[1] = {
 { Table = 'CashShopItem', Column = 'WCoinP', Where = 'AccountID', Name = 'WCoinP', Amount = 5 },
 { Table = 'CashShopItem', Column = 'WCoinC', Where = 'AccountID', Name = 'WCoinC', Amount = 5 },
}

--CC
REWARD_NATIVE_EVENTS_COINS[2] = {
 { Table = 'CashShopItem', Column = 'WCoinP', Where = 'AccountID', Name = 'WCoinP', Amount = 5 },
 { Table = 'CashShopItem', Column = 'WCoinC', Where = 'AccountID', Name = 'WCoinC', Amount = 5 },
}

--DS
REWARD_NATIVE_EVENTS_COINS[3] = {
 { Table = 'CashShopItem', Column = 'WCoinP', Where = 'AccountID', Name = 'WCoinP', Amount = 5 },
 { Table = 'CashShopItem', Column = 'WCoinC', Where = 'AccountID', Name = 'WCoinC', Amount = 5 },
}

--[[
Itens reward config (only in npc rescue)
]]--
REWARD_NATIVE_EVENTS_ITENS = {}

--BC
REWARD_NATIVE_EVENTS_ITENS[1] = {
{ ItemIndex = GET_ITEM(14, 14), Level = 0, Op1 = 0, Op2 = 0, Life = 0, Exc = 0, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Jewel of Soul', Count = 1},

}

--CC
REWARD_NATIVE_EVENTS_ITENS[1] = {
{ ItemIndex = GET_ITEM(14, 14), Level = 0, Op1 = 0, Op2 = 0, Life = 0, Exc = 0, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Jewel of Soul', Count = 1},

}

--DS
REWARD_NATIVE_EVENTS_ITENS[1] = {
{ ItemIndex = GET_ITEM(14, 14), Level = 0, Op1 = 0, Op2 = 0, Life = 0, Exc = 0, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, DaysExpire = 30, Name = 'Jewel of Soul', Count = 1},

}

--[[
Messages Configs
]]--
REWARD_NATIVE_EVENTS_MESSAGES = {}

REWARD_NATIVE_EVENTS_MESSAGES['Por'] = {
[1] = 'Você ganhou %d %s em sua conta!',
[2] = 'Você ganhou o item %d %s, resgate no Npc Rescue!',
}

REWARD_NATIVE_EVENTS_MESSAGES['Eng'] = {
[1] = 'You have won %d %s in your account!',
[2] = 'You have won item %d %s, rescue at Npc Rescue!',
}

REWARD_NATIVE_EVENTS_MESSAGES['Spn'] = {
[1] = '¡Has ganado %d %s en tu cuenta!',
[2] = '¡Has ganado el artículo %d %s, rescate en Npc Rescue!',
}
