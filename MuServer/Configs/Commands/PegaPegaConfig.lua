--[[
Command Configs
]]--
CATCH_COMMAND_OPEN = "/abrirpegapega"
CATCH_COMMAND_GO = "/pega-pega"
CATCH_COMMAND_INIT = "/iniciarpegapega"
CATCH_COMMAND_RESULT = "/resultadopegapega"
CATCH_COMMAND_FINISH = "/fimpegapega"
CATCH_SWITCH = 1
CATCH_LEVEL = 1
CATCH_VIP = 0
CATCH_RESETS = 0
CATCH_MRESETS = 0
CATCH_MAP = 9
CATCH_COORDX = 150
CATCH_COORDY = 150
CATCH_CHECK_COORDX1 = 115
CATCH_CHECK_COORDX2 = 155
CATCH_CHECK_COORDY1 = 186
CATCH_CHECK_COORDY2 = 146
CATCH_TIME_INIT = 5

--[[
Message Configs
]]--

CATCH_MESSAGE = { }

CATCH_MESSAGE["Por"] = {
[1] = "Move %s fechou!",
[2] = "Move %s fecha em %d segundo(s)",
[3] = "[Sistema] %s saiu do jogo.",
[4] = "[Sistema] %s saiu do pega-pega.",
[5] = "[Sistema] %s saiu do pega-pega por ter itens não permitidos!",
[6] = "[Sistema] Você está utilizando itens que não são permitidos nesse evento.",
[7] = "Pega-Pega Iniciado!",
[8] = "CORRRAAAAAAMMMMMMMMMM!!!",
[9] = "Pega-Pega inicia em %d segundo(s)",
[10] = "[Sistema] Já existe um pega-pega iniciado!",
[11] = "[Sistema] Uso %s <tempo>",
[12] = "[Sistema] %s abriu %s",
[13] = "Resultado do Pega-Pega:",
[14] = "Primeiro lugar: %s",
[15] = "Segundo lugar: %s",
[16] = "Terceiro lugar: %s",
[17] = "Pega-Pega Finalizado!",
[18] = "[Sistema] No momento não tem nenhum %s aberto!",
[19] = "[Sistema] Você precisa estar acima do level %d",
[20] = "[Sistema] Somente usuários vip podem usar este comando!",
[21] = "[Sistema] Você precisa de %d resets",
[22] = "[Sistema] Você precisa de %d M.Resets",
[23] = "[Sistema] RETIRE SEUS ITENS!",
[24] = "Somente botas, aneis e pendants sao permitidos.",
[25] = "[Sistema] Você será movido em alguns segundos...",
[26] = "Não relogue, não mova ou será eliminado",
[27] = "[Sistema] Você foi movido por não estar na área do evento!",
[28] = "[Sistema] Você foi pego por %s",
[29] = "[Sistema] Você pegou %s",
[30] = "%s pego por %s",
[31] = "(Terceiro Lugar)",
[32] = "%s pego por %s",
[33] = "(Segundo Lugar)",
[34] = "%s pego por %s",
[35] = "%s Wins!!!",
}

CATCH_MESSAGE["Eng"] = {
[1] = "Move %s closed!",
[2] = "Move %s closes in %d second (s)",
[3] = "[System] %s has left the game.",
[4] = "[System] %s left the tag.",
[5] = "[System] %s left the tag for having items not allowed!",
[6] = "[System] You are using items that are not allowed in this event.",
[7] = "Catch-Catch Started!",
[8] = "CORRRAAAAAAMMMMMMMMMM !!!",
[9] = "Pega-Pega starts in %d second (s)",
[10] = "[System] There is already a tag started!",
[11] = "[System] Use %s <time>",
[12] = "[System] %s opened %s",
[13] = "Result of the Catch-Catch:",
[14] = "First place: %s",
[15] = "Second place: %s",
[16] = "Third place: %s",
[17] = "Pega-Pega Finished!",
[18] = "[System] You currently have no %s open!",
[19] = "[System] You need to be above level %d",
[20] = "[System] Only VIP users can use this command!",
[21] = "[System] You need %d resets",
[22] = "[System] You need %d M.Resets",
[23] = "[System] REMOVE YOUR ITEMS!",
[24] = "Only boots, rings and pendants are allowed.",
[25] = "[System] You will be moved in a few seconds ...",
[26] = "Do not relog, do not move or it will be deleted",
[27] = "[System] You were moved because you are not in the event area!",
[28] = "[System] You got caught by %s",
[29] = "[System] Did you get %s",
[30] = " %s caught by %s",
[31] = "(Third Place)",
[32] = " %s caught by %s",
[33] = "(Second Place)",
[34] = " %s caught by %s",
[35] = " %s Wins !!!",
}

CATCH_MESSAGE["Spn"] = {
[1] = "¡Mover %s cerrado!",
[2] = "Mover %s se cierra en %d segundo (s)",
[3] = "[Sistema] %s ha abandonado el juego.",
[4] = "[Sistema] %s abandonó la etiqueta.",
[5] = "¡[Sistema] %s dejó la etiqueta por tener elementos no permitidos!",
[6] = "[Sistema] Estás usando elementos que no están permitidos en este evento.",
[7] = "¡Comenzó Catch-Catch!",
[8] = "¡¡¡CORRRAAAAAAMMMMMMMMMM !!!",
[9] = "Pega-Pega comienza en %d segundo (s)",
[10] = "[Sistema] ¡Ya se inició una etiqueta!",
[11] = "[Sistema] Usa %s <hora>",
[12] = "[Sistema] %s abrió %s",
[13] = "Resultado del Catch-Catch:",
[14] = "Primer lugar: %s",
[15] = "Segundo lugar: %s",
[16] = "Tercer lugar: %s",
[17] = "¡Pega-Pega terminada!",
[18] = "[Sistema] ¡Actualmente no tienes %s abierto!",
[19] = "[Sistema] Debes estar por encima del nivel %d",
[20] = "[Sistema] ¡Solo los usuarios VIP pueden usar este comando!",
[21] = "[Sistema] Necesitas %d restablecimientos",
[22] = "[Sistema] Necesitas %d M.Resets",
[23] = "[Sistema] ¡ELIMINA TUS ELEMENTOS!",
[24] = "Solo se permiten botas, anillos y colgantes.",
[25] = "[Sistema] Serás trasladado en unos segundos ...",
[26] = "No vuelva a iniciar sesión, no se mueva o se eliminará",
[27] = "[Sistema] ¡Te movieron porque no estás en el área del evento!",
[28] = "[Sistema] Te atrapó %s",
[29] = "[Sistema] Obtuviste %s",
[30] = " %s capturado por %s",
[31] = "(Tercer lugar)",
[32] = " %s capturado por %s",
[33] = "(Segundo lugar)",
[34] = " %s capturado por %s",
[35] = "¡¡¡ %s gana !!!",
}