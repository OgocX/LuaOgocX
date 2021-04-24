--[[ Configurations Event PvP ]]--

EVENT_PVP_COMMAND_OPEN = "/abrireventopvp"
EVENT_PVP_COMMAND_GO = "/eventopvp"
--Day -> Só vai rodar no dia que você selecionar
-->Day of Week -> Dia da semana que vai rodar numero dos dias: (0 Domingo), (1 Segunda), (2 Terça), (3 Quarta), (4 Quinta), (5 Sexta), (6 Sábado)
--Caso todos os 2 Day e DayOfWeek esteja -1, então vai valer apenas a Hour e Minute.
EVENT_PVP_CRON = {Day = -1, DayOfWeek = -1, Hour = 14, Minute = 55}
EVENT_PVP_TIMER_FOR_START = 5 --Tempo que vai avisar no global a cada 1 minuto que o evento vai abrir obs: 5 = 5 minutos...
EVENT_PVP_TIMER_COMMAND_OPEN = 60 --Tempo em segundos que vai aparecer no global o comando aberto
EVENT_PVP_DURATION = 10 --Tempo em minutos de duração do evento
EVENT_PVP_MIN_USERS = 3 -- Mínimo de players para o evento funcionar, caso todos saiam do evento após começar e não tenha a quantia ele é finalizado automaticamente! (-1 = Sem quantia)
EVENT_PVP_TIMER_KILLS = 30 --Tempo em segundos que vai aparecer no canto da tela os kills que a pessoa possui
EVENT_PVP_POINTS_KILL = 3 --Pontos ganhos ao matar alguém
EVENT_PVP_DECREASE_POINTS = 1 --Caso queira que remova ponto quando morre
EVENT_PVP_POINTS_DECREASE_KILL = 1 --Pontos perdidos ao morrer para alguém
EVENT_PVP_ANNOUNCE_KILL = 1 --Mostrar no global para os players que estão no evento quem matou quem...
EVENT_PVP_RESPAWN = 0 --Respawn o player em lugar diferente (OBS: CUIDADO COM ESSA FUNÇÃO) o char pode nascer fora do limite do check... etc...
EVENT_PVP_RESPAWN_DISTANCE = 5 --Distancia máxima do respawn (OBS: CUIDADO COM ESSA FUNÇÃO) o char pode nascer fora do limite do check... etc...

EVENT_PVP_MAP = 6
EVENT_PVP_COORD_X = 60
EVENT_PVP_COORD_Y = 160

EVENT_PVP_COORD_CHECK_X_1 = 54
EVENT_PVP_COORD_CHECK_X_2 = 120
EVENT_PVP_COORD_CHECK_Y_1 = 70
EVENT_PVP_COORD_CHECK_Y_2 = 190

EVENT_PVP_LEVEL = 100 --Level minimos para ir ao eventopvp
EVENT_PVP_RESETS = 0 --Resets minimos para ir ao eventopvp
EVENT_PVP_MRESETS = 0 --M.Resets minimos para ir ao eventopvp
EVENT_PVP_CLASS = -1 --Classe que pode ir ao evento -1 = qualquer classe, lista: (0 SM), (1 BK), (2 ELF), (3 MG)

--[[ Configurations SQL ]]--
EVENT_PVP_REWARD_PLAYER_FIRST = 1 --Premiar o primeiro lugar
EVENT_PVP_REWARD_PLAYER_SECOND = 1 --Segundo o primeiro lugar
EVENT_PVP_REWARD_PLAYER_THIRD = 1 --Terceiro o primeiro lugar

--Pontos de rankings que vai receber
EVENT_PVP_REWARD_POINTS_RANKING_FIRST = 3 --Player 1
EVENT_PVP_REWARD_POINTS_RANKING_SECOND = 2 --Player 2
EVENT_PVP_REWARD_POINTS_RANKING_THIRD = 1 --Player 3

--Você pode colocar quantas colunas quiser... mas não se esqueça de manter o padrão o mínimo e uma vai ser gravado conforme pontos de rankings...
EVENT_PVP_REWARD_COLUMNS = {}
EVENT_PVP_REWARD_COLUMNS[0] = "eventopvp"
EVENT_PVP_REWARD_COLUMNS[1] = "eventostotais"
EVENT_PVP_REWARD_TABLE = "character"
EVENT_PVP_REWARD_WHERE = "Name"

--Amounts (moedas)
EVENT_PVP_REWARD_AMOUNT_RANKING_FIRST = 50 -- Player 1
EVENT_PVP_REWARD_AMOUNT_RANKING_SECOND = 40 -- Player 2
EVENT_PVP_REWARD_AMOUNT_RANKING_THIRD = 30 -- Player 3

--Configs para Moedas
EVENT_PVP_REWARD_AMOUNTS_TABLE = "MEMB_INFO"
--Você pode colocar quantas colunas quiser... mas não se esqueça de manter o padrão o mínimo e uma vai ser gravado conforme configurado em amounts...
EVENT_PVP_REWARD_AMOUNTS_COLUMNS = {}
EVENT_PVP_REWARD_AMOUNTS_COLUMNS[0] = "cash"
EVENT_PVP_REWARD_AMOUNTS_WHERE = "memb___id"

--[[
Config Messages
--]]

EVENT_PVP_MESSAGE = { }

EVENT_PVP_MESSAGE["Por"] = {
[1] = "[EventoPvP] Abriu, boa sorte a todos!",
[2] = "[EventoPvP] abre em %d minutos(s)",
[3] = "[EventoPvP] Fechou",
[4] = "[EventoPvP] fecha em %d segundos(s)",
[5] = "digite %s para ir ao evento",
[6] = "=====================",
[7] = "~ Resultado EventoPvP ~",
[8] = "1º %s - (%d) points",
[9] = "2º %s - (%d) points",
[10] = "3º %s - (%d) points",
[11] = "=====================",
[12] = "[EventoPvP] Finalizado!",
[13] = "[EventoPvP] Cancelado!",
[14] = "Motivo: não tem a quantia de players suficiente.",
[15] = "Você possui %d pontos continue matando!",
[16] = "Se você morrer perde 1 pontos se você matar ganha 3 pontos",
[17] = "[Sistema] Você saiu do mapa do evento pvp",
[18] = "[Sistema] Você saiu da área do evento pvp",
[19] = "[Sistema] Você não tem permissão para ficar nesta área.",
[20] = "[Sistema] Evento Aberto aguarde o sistema.",
[21] = "[Sistema] No momento não tem nenhum %s aberto!",
[22] = "[Sistema] Você precisa estar acima do level %d",
[23] = "[Sistema] Sua classe está proíbida de participar do evento.",
[24] = "[Sistema] Você precisa de %d resets",
[25] = "[Sistema] Você precisa de %d M.Resets",
[26] = "[Sistema] Aguarde o evento já vai começar!",
[27] = "[Sistema] Aguarde o evento breve começará",
[28] = "[Sistema] conheça o mapa enquanto isso.",
[29] = "[Sistema] Você matou %s e ganhou %d pontos",
[30] = "[Sistema] Você morreu para %s e perdeu %d pontos",
[31] = "%s matou %s",
}

EVENT_PVP_MESSAGE["Eng"] = {
[1] = "[PVP Event] Open, good luck to everyone!",
[2] = "[PVP Event] opens in %d minutes (s)",
[3] = "[PVP Event] Closed",
[4] = "[PVP Event] closes in %d seconds (s)",
[5] = "type %s to go to the event",
[6] = "=====================",
[7] = "~ ResultPvP Event ~",
[8] = "1st %s - (%d) points",
[9] = "2nd %s - (%d) points",
[10] = "3rd %s - (%d) points",
[11] = "=====================",
[12] = "[PVP Event] Finished!",
[13] = "[PVP Event] Canceled!",
[14] = "Reason: you don't have enough players.",
[15] = "You have %d points keep killing!",
[16] = "If you die you lose 1 points if you kill you get 3 points",
[17] = "[System] You left the pvp event map",
[18] = "[System] You have left the pvp event area",
[19] = "[System] You are not allowed to stay in this area.",
[20] = "[System] Open Event wait for the system.",
[21] = "[System] You currently don't have any %s open!",
[22] = "[System] You need to be above level %d",
[23] = "[System] Your class is forbidden to participate in the event.",
[24] = "[System] You need %d resets",
[25] = "[System] You need %d M.Resets",
[26] = "[System] Wait for the event to start!",
[27] = "[System] Wait for the brief event to begin",
[28] = "[System] know the map in the meantime.",
[29] = "[System] You killed %s and earned %d points",
[30] = "[System] You died for %s and lost %d points",
[31] = " %s killed %s",
}

EVENT_PVP_MESSAGE["Spn"] = {
[1] = "[Evento PVP] Abierto, ¡buena suerte a todos!",
[2] = "[Evento PVP] se abre en %d minutos",
[3] = "[Evento PVP] Cerrado",
[4] = "[Evento PVP] se cierra en %d segundos",
[5] = "escribe %s para ir al evento",
[6] = "=====================",
[7] = "~ Evento ResultPvP ~",
[8] = "1st %s - (%d) puntos",
[9] = "2nd %s - (%d) puntos",
[10] = "3.º %s - (%d) puntos",
[11] = "=====================",
[12] = "[Evento PVP] ¡Finalizado!",
[13] = "¡[Evento PVP] cancelado!",
[14] = "Razón: no tienes suficientes jugadores",
[15] = "¡Tienes %d puntos para seguir matando!",
[16] = "Si mueres, pierdes 1 punto, si matas, obtienes 3 puntos",
[17] = "[Sistema] Abandonaste el mapa de eventos pvp",
[18] = "[Sistema] Saliste del área de eventos de pvp",
[19] = "[Sistema] No puedes permanecer en esta área.",
[20] = "[Sistema] Evento abierto espera al sistema.",
[21] = "[Sistema] ¡Actualmente no tienes ningún %s abierto!",
[22] = "[Sistema] Debes estar por encima del nivel %d",
[23] = "[Sistema] Tu clase tiene prohibido participar en el evento.",
[24] = "[Sistema] Necesitas %d restablecimientos",
[25] = "[Sistema] Necesitas %d M.Resets",
[26] = "[Sistema] ¡Espera a que comience el evento!",
[27] = "[Sistema] Espere a que comience el breve evento",
[28] = "[Sistema] conoce el mapa mientras tanto.",
[29] = "[Sistema] Mataste a %s y ganaste %d puntos",
[30] = "[Sistema] Moriste por %s y perdiste %d puntos",
[31] = " %s mató a %s",
}