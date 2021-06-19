--[[
Command Config
]]--
--this command is only staff
--/premiar <nick> <number config> <coins amount>
REWARD_PLAYERS_SWITCH = 0
REWARD_PLAYERS_COMMAND = '/premiar'
REWARD_PLAYERS_GAME_MASTER_LEVEL = 1
REWARD_ANNOUNCE_GLOBAL = 1

REWARD_PLAYERS_CONFIGS = { }

REWARD_PLAYERS_CONFIGS[1] = {
Table = 'MEMB_INFO',
Column = 'Cash',
Where = 'memb___id',
CoinName = 'Cashs',
MaxReward = -1, --  max coin amount reward -1 = no limit
}

REWARD_PLAYERS_CONFIGS[2] = {
Table = 'CashShopData',
Column = 'WCoinC',
Where = 'AccountID',
CoinName = 'WCoinC',
MaxReward = 20, --  max coin amount reward -1 = no limit
}

--[[
Command Message
]]--
--Global users message
REWARD_PLAYERS_GLOBAL_MESSAGES = { }

REWARD_PLAYERS_GLOBAL_MESSAGES['Por'] = {
[1] = '[%s] Premiou',
[2] = '%d %s para %s',
}

REWARD_PLAYERS_GLOBAL_MESSAGES['Eng'] = {
[1] = '[%s] Awarded',
[2] = '%d %s for %s',
}

REWARD_PLAYERS_GLOBAL_MESSAGES['Spn'] = {
[1] = '[%s] Otorgado',
[2] = '%d %s para %s',
}

--Staff message
REWARD_PLAYERS_MESSAGES = {}

REWARD_PLAYERS_MESSAGES['Por'] = {
[1] = 'Uso incorreto do comando: <nick> <valor do premio> <quantidade>',
[2] = 'O numero dessa premiação não foi encontrado!',
[3] = 'Ocorreu algum problema ao identificar a premiação',
[4] = 'O limite de moedas a ser adiciona é %d',
[5] = 'O jogador %s não está online ou não existe',
[6] = 'Sua premiação %d %s, foi adicionada',
}

REWARD_PLAYERS_MESSAGES['Eng'] = {
[1] = 'Incorrect use of the command: <nick> <prize value> <quantity>',
[2] = 'The number of this award was not found!',
[3] = 'There was a problem identifying the award',
[4] = 'The currency limit to be added is %d',
[5] = 'The player %s is not online or does not exist',
[6] = 'Your %d %s award has been added',
}

REWARD_PLAYERS_MESSAGES['Spn'] = {
[1] = 'Uso incorrecto del comando: <nick> <valor del premio> <cantidad>',
[2] = '¡No se encontró el número de este premio!',
[3] = 'Hubo un problema al identificar el premio',
[4] = 'El límite de moneda que se agregará es %d',
[5] = 'El jugador %s no está en línea o no existe',
[6] = 'Se agregó tu premio %d %s',
}