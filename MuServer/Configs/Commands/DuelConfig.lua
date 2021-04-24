--[[
Command Configs
]]--

--[[Configurations Of system]]--
COMMAND_SEND_DUEL = "/x1"
COMMAND_ACCEPT_DUEL = "/yes"
COMMAND_REJECT_DUEL = "/no"
TIMER_OF_REQUEST = 15 --Segundos que um pedido fica em aberto
TIMER_OF_START = 5 --Segundos que demora para o duelo começar
TIMER_OF_DURATION = 10 --Tempo máximo em minutos que o duelo vai ficar
DUEL_ROUNDS = 3 -- Rounds do duelo
DUEL_MAP = 6 -- caso você queira que vá em qualquer mapa deixe -1
DUEL_DISTANCE = 5 -- Distancia máxima que o player vai poder se afastar no duelo / requisitar um duelo
DUEL_ANNOUNCE_WINS = 1 -- Anunciar no canto esquerdo em azul quem venceu
DUEL_RESPAWN = 1 -- Fazer com que o player nasce em coordenada diferente, Obs: caso sua DUEL_DISTANCE for menor que 2 não recomendo o uso!

--[[ Configurations of SQL Server ]]--
DUEL_RANKING = 1
DUEL_TABLE = "Character"
DUEL_COLUMNS = {}
DUEL_COLUMNS[0] = "duel_total"
DUEL_COLUMNS[1] = "duel_semanal"
DUEL_COLUMNS[2] = "duel_mensal"
DUEL_WHERE = "Name"

--[[
Message Configs
]]--
DUEL_MESSAGE = { }

DUEL_MESSAGE["Por"] = {
[1] = "Pedido para %s ainda pendente, Aguarde!",
[2] = "Uso: %s <nome>",
[3] = "%s está offline ou não existe",
[4] = "%s está ocupado no momento.",
[5] = "Você não pode pedir duelo a si mesmo!",
[6] = "Este jogador já possuí um pedido de duelo, Aguarde!",
[7] = "O jogador está em duelo no momento!",
[8] = "Você precisa estar no mapa certo para duelar",
[9] = "O jogador precisa estar no mapa certo para duelar",
[10] = "Você precisa estar perto do adversário para pedir duelo!",
[11] = "%s quer duelar com você!",
[12] = "Digite %s %s para aceitar o duelo!",
[13] = "Digite %s %s para recusar o duelo!",
[14] = "Pedido de Duelo enviado para %s",
[15] = "Este jogador não fez nenhum pedido de duelo a você.",
[16] = "%s está offline ou não existe",
[17] = "Você aceitou o duelo contra %s",
[18] = "O jogador aceitou o duelo, você está sendo teleportado!",
[19] = "%s aceitou duelo com outro jogador!",
[20] = "Este jogador não lhe enviou pedido de duelo!",
[21] = "Você recusou o duelo contra %s!",
[22] = "%s recusou seu pedido de duelo.",
[23] = "Este jogador não lhe enviou pedido de duelo!",
[24] = "%s venceu duelo contra %s",
[25] = "Seu pedido de duelo contra %s expirou!",
[26] = "Pedido de duelo de %s expirou!",
[27] = "O duelo começará em %d segundos...",
[28] = "Tempo máximo do duelo: %d minutos",
[29] = "PVP Liberado lutem!",
[30] = "Duelo Cancelado, Motivo: %s",
[31] = "%s Wins",
[32] = "Duelo Encerrado!",
[33] = "Duelo terminou empatado!",
[34] = "%s wins %d x %d",
[35] = "%s saiu do jogo",
[36] = "%s saiu do mapa",
[37] = "%s se distanciou da área de combate",
}

DUEL_MESSAGE["Eng"] = {
[1] = "Request for %s still pending, please wait!",
[2] = "Usage: %s <name>",
[3] = " %s is offline or does not exist",
[4] = " %s is currently busy.",
[5] = "You can't ask yourself to duel!",
[6] = "This player already has a duel request, please wait!",
[7] = "The player is currently in a duel!",
[8] = "You need to be on the right map to duel",
[9] = "The player needs to be on the right map to duel",
[10] = "You need to be close to the opponent to ask for a duel!",
[11] = " %s wants to duel with you!",
[12] = "Type %s %s to accept the duel!",
[13] = "Type %s %s to refuse the duel!",
[14] = "Duel request sent to %s",
[15] = "This player did not make a duel request to you.",
[16] = " %s is offline or does not exist",
[17] = "You accepted the duel against %s",
[18] = "The player accepted the duel, you are being teleported!",
[19] = " %s accepted a duel with another player!",
[20] = "This player did not send you a duel request!",
[21] = "You declined the duel against %s!",
[22] = " %s declined your duel request.",
[23] = "This player did not send you a duel request!",
[24] = " %s won a duel against %s",
[25] = "Your duel request against %s has expired!",
[26] = " %s duel request has expired!",
[27] = "The duel will start in %d seconds ...",
[28] = "Maximum duel time: %d minutes",
[29] = "Liberated PVP fight!",
[30] = "Duel Canceled, Reason: %s",
[31] = " %s Wins",
[32] = "Duel Closed!",
[33] = "Duel ended in a draw!",
[34] = " %s wins %d x %d",
[35] = " %s left the game",
[36] = " %s left the map",
[37] = " %s has distanced itself from the combat area",
}

DUEL_MESSAGE["Spn"] = {
[1] = "La solicitud de %s aún está pendiente, ¡espere!",
[2] = "Uso: %s <nombre>",
[3] = " %s está sin conexión o no existe",
[4] = " %s está ocupado actualmente.",
[5] = "¡No puedes pedirte un duelo!",
[6] = "Este jugador ya tiene una solicitud de duelo, ¡espere!",
[7] = "¡El jugador está actualmente en duelo!",
[8] = "Debes estar en el mapa correcto para un duelo",
[9] = "El jugador debe estar en el mapa correcto para el duelo",
[10] = "¡Necesitas estar cerca del oponente para pedir un duelo!",
[11] = "¡ %s quiere batirse en duelo contigo!",
[12] = "¡Ingresa %s %s para aceptar el duelo!",
[13] = "¡Escribe %s %s para rechazar el duelo!",
[14] = "Solicitud de duelo enviada a %s",
[15] = "Este jugador no te hizo una solicitud de duelo",
[16] = " %s está sin conexión o no existe",
[17] = "Aceptaste el duelo contra %s",
[18] = "El jugador aceptó el duelo, ¡te teletransportan!",
[19] = "¡ %s aceptó un duelo con otro jugador!",
[20] = "¡Este jugador no te envió una solicitud de duelo!",
[21] = "¡Rechazaste el duelo contra %s!",
[22] = " %s rechazó tu solicitud de duelo",
[23] = "¡Este jugador no te envió una solicitud de duelo!",
[24] = " %s ganó un duelo contra %s",
[25] = "¡Tu solicitud de duelo contra %s ha expirado!",
[26] = "¡La solicitud de duelo de %s ha expirado!",
[27] = "El duelo comenzará en %d segundos ...",
[28] = "Tiempo máximo de duelo: %d minutos",
[29] = "¡Lucha PVP liberada!",
[30] = "Duelo cancelado, motivo: %s",
[31] = " %s gana",
[32] = "¡Duelo cerrado!",
[33] = "¡El duelo terminó en empate!",
[34] = " %s gana %d x %d",
[35] = " %s abandonó el juego",
[36] = " %s abandonó el mapa",
[37] = " %s se ha distanciado del área de combate",
}