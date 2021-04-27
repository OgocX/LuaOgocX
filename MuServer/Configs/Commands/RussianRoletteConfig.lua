--[[
Command Config
]]--

RUSSIAN_ROLETTE_SWITCH = 1
RUSSIAN_ROLETTE_COMMAND_STAFF_SWITCH = 1
RUSSIAN_ROLETTE_COMMAND_STAFF = '/abrirroletarussa'
RUSSIAN_ROLETTE_COMMAND = '/roletarussa'
RUSSIAN_ROLETTE_LEVEL = 6
RUSSIAN_ROLETTE_RESET = 0
RUSSIAN_ROLETTE_MRESET = 0

RUSSIAN_ROLETTE_MIN_USERS = 2
RUSSIAN_ROLETTE_MAX_USERS = 8

RUSSIAN_ROLETTE_MAP = 0
RUSSIAN_ROLETTE_COORD_X = 125
RUSSIAN_ROLETTE_COORD_Y = 125

RUSSIAN_ROLETTE_TELEPORT_LOSE_MAP = 0
RUSSIAN_ROLETTE_TELEPORT_LOSE_X = 150
RUSSIAN_ROLETTE_TELEPORT_LOSE_Y = 130

--Checar a área do jogador (dependendo do local onde você definir apenas para ver se ele saiu de perto do local de algum  jeito)
RUSSIAN_ROLLETTE_CHECK_AREA = 1
RUSSIAN_ROLLETTE_CHECK_AREA_X1 = 121
RUSSIAN_ROLLETTE_CHECK_AREA_Y1 = 121
RUSSIAN_ROLLETTE_CHECK_AREA_X2 = 128
RUSSIAN_ROLLETTE_CHECK_AREA_Y2 = 129

RUSSIAN_ROLETTE_TIME_START = 5 -- tempo em minutos que vai mostrar no global o tempo do evento iniciar

--Reward for player winner
RUSSIAN_ROLETTE_REWARD_TABLES = { }

RUSSIAN_ROLETTE_REWARD_TABLES[1] = {
Table = 'CashShopData', Column = 'WCoinC', Where = 'AccountID', CoinName = 'WCoinC', Amount = 15
}

RUSSIAN_ROLETTE_REWARD_TABLES[2] = {
Table = 'CashShopData', Column = 'WCoinP', Where = 'AccountID', CoinName = 'WCoinP', Amount = 15
}

--Day -> Só vai rodar no dia que você selecionar
-->Day of Week -> Dia da semana que vai rodar numero dos dias: (0 Domingo), (1 Segunda), (2 Terça), (3 Quarta), (4 Quinta), (5 Sexta), (6 Sábado)
--Caso todos os 2 Day e DayOfWeek esteja -1, então vai valer apenas a Hour e Minute.
RUSSIAN_ROLETTE_DATE = {
{ Day = -1, DayOfWeek = -1, Hour = 18, Minute = 08 },
}

--[[
Command Message
]]--
RUSSIAN_ROLETTE_MESSAGES = {}

RUSSIAN_ROLETTE_MESSAGES['Por'] = {
[1] = "O evento roleta russa vai começar em %d minuto(s)",
[2] = "Digite %s para ir ao evento",
[3] = "O evento roleta russa começou!",
[4] = "O evento roleta russa não está aberto no momento",
[5] = "Você precisa estar acima do level %d para ir ao evento",
[6] = "Você precisa ter %d reset ou mais para ir ao evento",
[7] = "Você precisa ter %d m.reset ou mais para ir ao evento",
[8] = "Você será movido em breve, aguarde o evento iniciar!",
[9] = "Não relogue e não mova!",
[10] = "Evento iniciando em: %d",
[11] = "======= Roleta-Russa  =======",
[12] = "=============================",
[13] = " ",
[14] = "Engatilhando...",
[15] = "Apontando...",
[16] = "Fogo!",
[17] = "%s foi atingido.",
[18] = "%s saiu ileso.",
[19] = "Você não foi atingido!",
[20] = "Vencedor:",
[21] = "%s",
[22] = "Você está fora do evento Roleta Russa!",
[23] = "O STAFF %s abriu o evento Roleta Russa!",
[24] = "Evento roleta russa finalizado!",
[25] = "Roleta Russa Iniciado!",
[26] = "Ocorreu um erro no evento, então foi cancelado!",
[27] = "Você levou um tiro e foi eliminado do evento!",
[28] = "Parabéns sua sorte foi testada e você saiu ileso!",
[29] = "O evento não atingiu o mínimo de %d jogadores para iniciar!",
[30] = "O evento está lotado no momento, tente na próxima!",
[31] = "Prêmio %d %s adicionado em sua conta",
}

RUSSIAN_ROLETTE_MESSAGES['Eng'] = {
[1] = "The Russian roulette event will start in %d minute (s)",
[2] = "Enter %s to go to the event",
[3] = "The Russian roulette event has started!",
[4] = "The Russian roulette event is not currently open",
[5] = "You need to be above level %d to go to the event",
[6] = "You must have %d reset or more to attend the event",
[7] = "You must have %d m.reset or more to attend the event",
[8] = "You will be moved soon, wait for the event to start!",
[9] = "Do not relog and do not move!",
[10] = "Event starting at: %d",
[11] = "======= Russian Roulette =======",
[12] = "=============================",
[13] = "",
[14] = "Crawling ...",
[15] = "Pointing ...",
[16] = "Fire!",
[17] = "%s has been reached.",
[18] = "%s left unscathed.",
[19] = "You haven't been hit!",
[20] = "Winner:",
[21] = "%s",
[22] = "You are out of the Russian Roulette event!",
[23] = "STAFF %s opened the Russian Roulette event!",
[24] = "Russian roulette event finished!",
[25] = "Russian Roulette Started!",
[26] = "An error occurred in the event, so it was canceled!",
[27] = "You were shot and eliminated from the event!",
[28] = "Congratulations, your luck was tested and you came out unscathed!",
[29] = "The event has not reached a minimum of %d players to start!",
[30] = "The event is full at the moment, try the next one!",
[31] = "Award %d %s added to your account",
}

RUSSIAN_ROLETTE_MESSAGES['Spn'] = {
[1] = "El evento de la ruleta rusa comenzará en %d minuto (s)",
[2] = "Ingresa %s para ir al evento",
[3] = "¡El evento de la ruleta rusa ha comenzado!",
[4] = "El evento de la ruleta rusa no está abierto actualmente",
[5] = "Debes estar por encima del nivel %d para ir al evento",
[6] = "Debes tener %d reiniciados o más para asistir al evento",
[7] = "Debes tener %d m.reset o más para asistir al evento",
[8] = "¡Pronto serás trasladado, espera a que comience el evento!",
[9] = "¡No vuelvas a iniciar sesión y no te muevas!",
[10] = "Evento que comienza en: %d",
[11] = "======= Ruleta rusa =======",
[12] = "=============================",
[13] = "",
[14] = "Rastreando ...",
[15] = "Señalando ...",
[16] = "¡Fuego!",
[17] = "Se alcanzó %s.",
[18] = "%s salió ileso.",
[19] = "¡No te han golpeado!",
[20] = "Ganador:",
[21] = "%s",
[22] = "¡Estás fuera del evento de la ruleta rusa!",
[23] = "¡EL PERSONAL %s abrió el evento de la ruleta rusa!",
[24] = "¡El evento de la ruleta rusa terminó!",
[25] = "¡Comenzó la ruleta rusa!",
[26] = "Se produjo un error en el evento, ¡así que fue cancelado!",
[27] = "¡Te dispararon y te eliminaron del evento!",
[28] = "¡Felicidades, se puso a prueba tu suerte y saliste ileso!",
[29] = "¡El evento no ha alcanzado un mínimo de %d jugadores para comenzar!",
[30] = "El evento está lleno en este momento, ¡prueba el siguiente!",
[31] = "Premio %d %s agregado a su cuenta",
}