--[[
    Command Configs
]]
ZOMBIE_ATTACK_SWITCH = 0
ZOMBIE_ATTACK_COMMAND_SYNTAX = '/zombie'
ZOMBIE_ATTACK_COMMAND_OPEN_SWITCH = 1
ZOMBIE_ATTACK_COMMAND_OPEN_SYNTAX = '/openzombie'

ZOMBIE_ATTACK_LEVEL = 1
ZOMBIE_ATTACK_VIP = 0
ZOMBIE_ATTACK_RESETS = 0
ZOMBIE_ATTACK_MRESETS = 0
ZOMBIE_ATTACK_MONEY = 5000

ZOMBIE_ATTACK_MAX_USERS = 100
ZOMBIE_ATTACK_MIN_USERS = 1

ZOMBIE_ATTACK_SKIN_INFECTED = 16
ZOMBIE_ATTACK_BUFF = 1 -- add buff for infected
ZOMBIE_ATTACK_BUFF_CONST_A = 850
ZOMBIE_ATTACK_BUFF_CONST_B = 1300

ZOMBIE_ATTACK_BLIND_LUCKY = 100 -- percentage of chance to blind

ZOMBIE_ATTACK_TIME_EVENT = 10 -- time max for event in minutes

ZOMBIE_ATTACK_PLAYER_CAN_ATTACK_EQUAL_INFECTED = 0 --1 allows players to attack other players who are the same example, infected attack infected, uninfected attack uninfected

--Participation award, you can place as many coins or jewel points as you like
ZOMBIE_ATTACK_PARTICIPATION_AWARD = {}

ZOMBIE_ATTACK_PARTICIPATION_AWARD[1] = {
Table = 'CashShopData',
Column = 'WcoinP',
Where = 'AccountID',
Amount = 50,
Name = 'WcoinP',
}

--Infection award and award for finalist players
ZOMBIE_ATTACK_NOT_INFECTED_END_EVENT = 500 -- final prize pool that will be divided among players who have not been infected
ZOMBIE_ATTACK_INFECTED_END_EVENT = 100 --final prize that will be awarded to the player who most infected
ZOMBIE_ATTACK_INFECTION_DEFENSE_POINT = 20 -- award when kill a zombie
ZOMBIE_ATTACK_INFECTION_DEFENSE_POINT_RATE = 10 -- percentage of points you steal when you kill a zombie, only if the zombie has more than 10 points
ZOMBIE_ATTACK_INFECTION_PLAYER_POINT = 25 -- award when infect a player
ZOMBIE_ATTACK_INFECTION_PLAYER_POINT_RATE = 10 -- percentage of points that you steal from the infected player, only if the player has more than 10 points
ZOMBIE_ATTACK_INFECTION_AWARD_TABLE = 'CashShopData'
ZOMBIE_ATTACK_INFECTION_AWARD_COLUMN = 'WcoinP'
ZOMBIE_ATTACK_INFECTION_AWARD_WHERE = 'AccountID'
ZOMBIE_ATTACK_INFECTION_AWARD_NAME = 'WcoinP'

--Map Configs
ZOMBIE_ATTACK_MAP = 1
ZOMBIE_ATTACK_COORD_X = 20
ZOMBIE_ATTACK_COORD_Y = 90
ZOMBIE_ATTACK_DISTANCE_RANGE = 15

ZOMBIE_ATTACK_CHECK_AREA = 1
ZOMBIE_ATTACK_CHECK_AREA_CORD_X1 = 1
ZOMBIE_ATTACK_CHECK_AREA_CORD_Y1 = 49
ZOMBIE_ATTACK_CHECK_AREA_CORD_X2 = 50
ZOMBIE_ATTACK_CHECK_AREA_CORD_Y2 = 135

ZOMBIE_ATTACK_TIME_START = 5 -- time in minutes

ZOMBIE_ATTACK_CRON_TIMER = {
{ Day = -1, DayOfWeek = -1, Hour = 18, Minute = 08 },
}

--[[
    Command Messages
]]
ZOMBIE_ATTACK_MESSAGES = {}

ZOMBIE_ATTACK_MESSAGES['Por'] = {
[1] = 'O evento zombie attack não está aberto no momento!',
[2] = 'Você está ocupado no momento!',
[3] = 'Você precisa estar acima do level %d para ir ao evento!',
[4] = 'O seu nível VIP não pode participar do evento',
[5] = 'Você precisa de %d resets para ir ao evento',
[6] = 'Você precisa de %d m.resets para ir ao evento',
[7] = 'Você precisa ter %d zen para ir ao evento',
[8] = 'Aguarde, você será movido em breve!',
[9] = 'Não relogue e não se mova!',
[10] = 'O evento está na capacidade máxima, tente na próxima!',
[11] = 'O evento Zombie Attack Fechou!',
[12] = 'O evento Zombie Attack fechará em %d minuto(s)',
[13] = 'Digite %s para ir ao evento!',
[14] = 'O evento Zombie Attack foi cancelado!',
[15] = 'Motivo: mínimo de %d jogadores não atingido!',
[16] = 'O evento vai começar em %d segundo(s)',
[17] = 'Corra a infecção vai começar!',
[18] = 'A infecção zombie se espalhou!!',
[19] = '%s foi infectado!',
[20] = '%s abriu o evento zombie attack',
[21] = 'Você foi infectado!',
[22] = 'Você saiu da área do evento, e está removido!',
[23] = '%s infectou %s',
[24] = 'Você está em WAR e foi removido do evento!',
[25] = 'Você recebeu %d %s por participar do evento!',
[26] = 'Você recebeu %d %s por infectar um jogador!',
[27] = 'Você recebeu %d pontos por matar um zumbi',
[28] = 'Você roubou %d pontos do zumbi morto',
[29] = 'Você perdeu %d pontos por morrer para um não infectado!',
[30] = 'Você recebeu %d pontos por infectar um jogador',
[31] = 'Você roubou %d pontos do player infectado',
[32] = 'Você perdeu %d pontos por ter sido infectado!',
[33] = 'Você recebeu %d %s por ter sobrevivido a infecção!',
[34] = '%s foi o único sobrevivente!',
[35] = '%s foi o jogador que mais infectou!',
[36] = 'Você recebeu %d %s por ter mais infectado jogadores!',
[37] = '%d jogadores infectados no evento',
[38] = '%d jogadores não infectados no evento',
[39] = 'Sua pontuação no evento: %d pontos',
[40] = 'O evento Ataque zumbi acabou!',
}

ZOMBIE_ATTACK_MESSAGES['Eng'] = {
[1] = 'The zombie attack event is not currently open!',
[2] = 'You are currently busy!',
[3] = 'You need to be above level %d to go to the event!',
[4] = 'Your VIP level cannot participate in the event',
[5] = 'You need %d resets to attend the event',
[6] = 'You need %d m.resets to go to the event',
[7] = 'You need to have %d zen to go to the event',
[8] = 'Wait, you will be moved soon!',
[9] = 'Do not relog and do not move!',
[10] = 'The event is at full capacity, try the next one!',
[11] = 'The Zombie Attack event has closed!',
[12] = 'The Zombie Attack event will close in %d minute (s)',
[13] = 'Enter %s to go to the event!',
[14] = 'The Zombie Attack event has been canceled!',
[15] = 'Reason: minimum of %d players not reached!',
[16] = 'The event will start in %d second (s)',
[17] = 'Run the infection will start!',
[18] = 'The zombie infection has spread !!',
[19] = '%s has been infected!',
[20] = '%s opened the zombie attack event',
[21] = 'You have been infected!',
[22] = 'You left the event area, and you are removed!',
[23] = '%s infected %s',
[24] = 'You are on WAR and have been removed from the event!',
[25] = 'You received %d %s for participating in the event!',
[26] = 'You received %d %s for infecting a player!',
[27] = 'You received %d points for killing a zombie',
[28] = 'You stole %d points from the dead zombie',
[29] = 'You lost %d points for dying to an uninfected one!',
[30] = 'You received %d points for infecting a player',
[31] = 'You stole %d points from the infected player',
[32] = 'You lost %d points for being infected!',
[33] = 'You received %d %s for surviving the infection!',
[34] = '%s was the only survivor!',
[35] = '%s was the player who most infected!',
[36] = 'You received %d %s for having infected more players!',
[37] = '%d players infected at the event',
[38] = '%d players not infected at the event',
[39] = 'Your event score: %d points',
[40] = 'The Zombie Attack event is over!',
}

ZOMBIE_ATTACK_MESSAGES['Spn'] = {
[1] = '¡El evento de ataque zombi no está abierto actualmente!',
[2] = '¡Actualmente estás ocupado!',
[3] = '¡Debes estar por encima del nivel %d para ir al evento!',
[4] = 'Tu nivel VIP no puede participar en el evento',
[5] = 'Necesitas %d restablecimientos para asistir al evento',
[6] = 'Necesitas %d m.resets para ir al evento',
[7] = 'Necesitas tener %d zen para ir al evento',
[8] = '¡Espera, pronto te trasladarán!',
[9] = '¡No vuelvas a iniciar sesión y no te muevas!',
[10] = 'El evento está a su máxima capacidad, ¡prueba el siguiente!',
[11] = '¡El evento Zombie Attack ha cerrado!',
[12] = 'El evento Ataque zombi se cerrará en %d minuto (s)',
[13] = '¡Ingresa %s para ir al evento!',
[14] = '¡El evento Zombie Attack ha sido cancelado!',
[15] = 'Razón: ¡no se alcanzó el mínimo de %d jugadores!',
[16] = 'El evento comenzará en %d segundo (s)',
[17] = 'Ejecutar, ¡la infección comenzará!',
[18] = '¡¡La infección zombi se ha extendido !!',
[19] = '¡ %s ha sido infectado!',
[20] = '%s abrió el evento de ataque zombi',
[21] = '¡Has sido infectado!',
[22] = '¡Has abandonado el área de eventos y te han eliminado!',
[23] = '%s %s infectado',
[24] = '¡Estás en WAR y ha sido eliminado del evento!',
[25] = '¡Recibiste %d %s por participar en el evento!',
[26] = '¡Recibiste %d %s por infectar a un jugador!',
[27] = 'Recibiste %d puntos por matar a un zombi',
[28] = 'Le robaste %d puntos al zombi muerto',
[29] = '¡Perdiste %d puntos por morir a manos de uno no infectado!',
[30] = 'Recibiste %d puntos por infectar a un jugador',
[31] = 'Le robaste %d puntos al jugador infectado',
[32] = '¡Perdiste %d puntos por estar infectado!',
[33] = '¡Recibiste %d %s por sobrevivir a la infección!',
[34] = '¡ %s fue el único superviviente!',
[35] = '¡ %s fue el jugador más infectado!',
[36] = '¡Recibiste %d %s por haber infectado a más jugadores!',
[37] = ' %d jugadores infectados en el evento',
[38] = ' %d jugadores no infectados en el evento',
[39] = 'Puntuación de tu evento: %d puntos',
[40] = '¡El evento Zombie Attack ha terminado!',
}