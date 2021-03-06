--[[
Command Configs
]]--
KILL_COMMAND_GAME_MASTER_LEVEL = 1
KILL_COMMAND_OPEN = "/abrirmatamata"
KILL_COMMAND_GO = "/novaarena"
KILL_COMMAND_INIT = "/iniciarmatamata"
KILL_COMMAND_FINISH = "/fimmatamata"
KILL_COMMAND_STEP = "/fase"
KILL_COMMAND_WINS = "/wins"
KILL_COMMAND_CALL = "/chamar"
KILL_COMMAND_STEP_END = "/final"
KILL_COMMAND_STEP_SEMI = "/semi-final"
KILL_COMMAND_STEP_DISP3 = "/disputa3"
KILL_SWITCH = 1
KILL_LEVEL = 1
KILL_VIP = 0
KILL_RESETS = 0
KILL_MRESETS = 0
KILL_MAP = 6
KILL_COORD_X = 192
KILL_COORD_Y = 195
KILL_COORD_TOP_X = 240
KILL_COORD_TOP_Y = 195
KILL_COORD_DOWN_X = 194
KILL_COORD_DOWN_Y = 195
KILL_COORD_DUEL_X_1 = 216
KILL_COORD_DUEL_Y_1 = 195
KILL_COORD_DUEL_X_2 = 217
KILL_COORD_DUEL_Y_2 = 195
KILL_PLAYER_WINS_GUILD = 1
KILL_CHECK_USERS = 1
KILL_AREA_CHECK_COORD_X_1 = 185
KILL_AREA_CHECK_COORD_X_2 = 247
KILL_AREA_CHECK_COORD_Y_1 = 144
KILL_AREA_CHECK_COORD_Y_2 = 244

--[[
Message Configs
]]--

MATA_MATA_MESSAGE = { }

MATA_MATA_MESSAGE["Por"] = {
[1] = "[Sistema] %s saiu do jogo.",
[2] = "[Sistema] %s saiu do mata-mata.",
[3] = "[Sistema] %s saiu do mata-mata.",
[4] = "[Sistema] Voc? n?o tem permiss?o para ficar nesta ?rea.",
[5] = "Move %s fechou!",
[6] = "Move %s fecha em %d segundo(s)",
[7] = "[Sistema] Uso %s tempo",
[8] = "[Sistema] %s abriu %s",
[9] = "[Sistema] No momento n?o tem nenhum %s aberto!",
[10] = "[Sistema] Voc? precisa estar acima do level %d",
[11] = "[Sistema] Somente usu?rios vip podem usar este comando!",
[12] = "[Sistema] Voc? precisa de %d resets",
[13] = "[Sistema] Voc? precisa de %d M.Resets",
[14] = "[Sistema] Voc? ser? movido em alguns segundos...",
[15] = "N?o relogue, n?o mova ou ser? eliminado",
[16] = " ~ Mata-Mata Iniciado! ~ ",
[17] = "[Sistema] Nenhum mata-mata em andamento!",
[18] = " ~ Mata-Mata Finalizado! ~ ",
[19] = "[Sistema] Inicie o mata-mata antes de chamar!",
[20] = "[Sistema] Uso: %s <fase>",
[21] = "~ Fase (%d) iniciada! ~",
[22] = "[Sistema] Nenhum mata-mata em andamento!",
[23] = "[Sistema] Nenhuma luta foi realizada!",
[24] = "[Sistema] %s est? offline ou n?o existe",
[25] = "%s Wins!",
[26] = "%s [G]:Nenhuma Wins!",
[27] = "%s [G]:%s Wins!",
[28] = "[Sistema] Nenhum mata-mata em andamento!",
[29] = "[Sistema] J? existe uma luta em andamento!",
[30] = "[Sistema] Sua vez de lutar!",
[31] = "[Sistema] Sua vez de lutar!",
[32] = "[Sistema] %s chamou a pr?xima luta.",
[33] = "[%s]",
[34] = "~ %s vs %s ~",
[35] = "%s passa para a pr?xima fase por falta de advers?rio!",
[36] = "[Sistema] Todos j? lutaram passe para a pr?xima fase!",
[37] = "[Sistema] Nenhum mata-mata em andamento!",
[38] = "~ Final do mata-mata iniciada ~",
[39] = "[Sistema] Nenhum mata-mata em andamento!",
[40] = "~ Semi-Final do mata-mata iniciada ~",
[41] = "[Sistema] Nenhum mata-mata em andamento!",
[42] = "~ Disputa 3? lugar iniciada ~",
}

MATA_MATA_MESSAGE["Eng"] = {
[1] = "[System] %s has left the game.",
[2] = "[System] %s left the playoff.",
[3] = "[System] %s left the playoff.",
[4] = "[System] You are not allowed to stay in this area.",
[5] = "Move %s closed!",
[6] = "Move %s closes in %d second (s)",
[7] = "[System] I use %s time",
[8] = "[System] %s opened %s",
[9] = "[System] You currently have no %s open!",
[10] = "[System] You need to be above level %d",
[11] = "[System] Only VIP users can use this command!",
[12] = "[System] You need %d resets",
[13] = "[System] You need %d M.Resets",
[14] = "[System] You will be moved in a few seconds ...",
[15] = "Do not relog, do not move or will be deleted",
[16] = "~ Mata-Mata Initiate! ~",
[17] = "[System] No playoffs in progress!",
[18] = "~ Mata-Mata Finished! ~",
[19] = "[System] Start the knockout before calling!",
[20] = "[System] Usage: %s <phase>",
[21] = "~ Phase (%d) started! ~",
[22] = "[System] No killer in progress!",
[23] = "[System] No fighting was done!",
[24] = "[System] %s is offline or does not exist",
[25] = " %s Wins!",
[26] = " %s [G]: No Wins!",
[27] = " %s [G]: %s Wins!",
[28] = "[System] No playoffs in progress!",
[29] = "[System] There is already a fight going on!",
[30] = "[System] Your turn to fight!",
[31] = "[System] Your turn to fight!",
[32] = "[System] %s called the next fight.",
[33] = "[ %s]",
[34] = "~ %s vs %s ~",
[35] = " %s moves on to the next round due to lack of opponents!",
[36] = "[System] Everyone has fought to move on to the next stage!",
[37] = "[System] No playoffs in progress!",
[38] = "~ End of playoff started ~",
[39] = "[System] No playoffs in progress!",
[40] = "~ Playoff semi-final started ~",
[41] = "[System] No playoffs in progress!",
[42] = "~ 3rd place dispute started ~",
}

MATA_MATA_MESSAGE["Spn"] = {
[1] = "[System] %s ha abandonado el juego.",
[2] = "[System] %s abandon? los playoffs.",
[3] = "[System] %s abandon? los playoffs.",
[4] = "[Sistema] No puedes permanecer en esta ?rea.",
[5] = "?Mover %s cerrado!",
[6] = "Mover %s se cierra en %d segundo (s)",
[7] = "[Sistema] Uso %s tiempo",
[8] = "[Sistema] %s abri? %s",
[9] = "[Sistema] ?Actualmente no tienes %s abierto!",
[10] = "[Sistema] Debes estar por encima del nivel %d",
[11] = "[Sistema] ?Solo los usuarios VIP pueden usar este comando!",
[12] = "[Sistema] Necesitas %d restablecimientos",
[13] = "[Sistema] Necesitas %d M.Resets",
[14] = "[Sistema] Ser?s trasladado en unos segundos ...",
[15] = "No vuelva a iniciar sesi?n, no se mueva o se eliminar?",
[16] = "~ ?Iniciado Mata-Mata! ~",
[17] = "[Sistema] ?No hay playoffs en curso!",
[18] = "~ Mata-Mata ?Termin?! ~",
[19] = "[Sistema] ?Empieza el nocaut antes de llamar!",
[20] = "[Sistema] Uso: %s <fase>",
[21] = "~ ?La fase (%d) comenz?! ~",
[22] = "[Sistema] ?Ning?n asesino en progreso!",
[23] = "[Sistema] ?No se pele?!",
[24] = "[Sistema] %s est? desconectado o no existe",
[25] = "? %s gana!",
[26] = " %s [G]: ?No hay victorias!",
[27] = " %s [G]: ? %s gana!",
[28] = "[Sistema] ?No hay playoffs en curso!",
[29] = "[Sistema] ?Ya hay una pelea!",
[30] = "[Sistema] ?Es tu turno de luchar!",
[31] = "[Sistema] ?Es tu turno de luchar!",
[32] = "[Sistema] %s llam? a la pr?xima pelea.",
[33] = "[ %s]",
[34] = "~ %s frente a %s ~",
[35] = "? %s pasa a la siguiente ronda por falta de oponentes!",
[36] = "[Sistema] ?Todos han luchado para pasar a la siguiente etapa!",
[37] = "[Sistema] ?No hay playoffs en curso!",
[38] = "~ Comenz? el final de los playoffs ~",
[39] = "[Sistema] ?No hay playoffs en curso!",
[40] = "~ Comenz? la semifinal de los playoffs ~",
[41] = "[Sistema] ?No hay playoffs en curso!",
[42] = "~ Comenz? la disputa por el tercer lugar ~",
}