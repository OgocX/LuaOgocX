--[[
Configs Command
]]--
EVENTO_COMMAND_OPEN = "/abrirevento"
EVENTO_COMMAND_GO = "/evento"
EVENTO_SWITCH = 1
EVENTO_LEVEL = 1
EVENTO_VIP = 0
EVENTO_RESETS = 0
EVENTO_MRESETS = 0

--[[
Config Message
]]--
EVENTO_MESSAGE = { }

EVENTO_MESSAGE["Por"] = {
[1] = "Move %s fecha em %d segundo(s)",
[2] = "Move %s fechou!",
[3] = "[Sistema] Uso %s tempo",
[4] = "[Sistema] %s abriu %s",
[5] = "[Sistema] No momento n�o tem nenhum %s aberto!",
[6] = "[Sistema] Voc� precisa estar acima do level %d",
[7] = "[Sistema] Somente usu�rios vip podem usar este comando!",
[8] = "[Sistema] Voc� precisa de %d resets",
[9] = "[Sistema] Voc� precisa de %d M.Resets",
[10] = "[Sistema] Voc� ser� movido em alguns segundos...",
[11] = "N�o relogue, n�o mova ou ser� eliminado",
}

EVENTO_MESSAGE["Eng"] = {
[1] = "Move %s closes in %d second (s)",
[2] = "Move %s closed!",
[3] = "[System] Use %s time",
[4] = "[System] %s opened %s",
[5] = "[System] You currently don't have any %s open!",
[6] = "[System] You need to be above level %d",
[7] = "[System] Only VIP users can use this command!",
[8] = "[System] You need %d resets",
[9] = "[System] You need %d M.Resets",
[10] = "[System] You will be moved in a few seconds ...",
[11] = "Do not relog, do not move or will be eliminated",
}

EVENTO_MESSAGE["Spn"] = {
[1] = "Mover %s se cierra en %d segundo (s)",
[2] = "�Mover %s cerrado!",
[3] = "[Sistema] Usar %s tiempo",
[4] = "[Sistema] %s abri� %s",
[5] = "[Sistema] �Actualmente no tienes ning�n %s abierto!",
[6] = "[Sistema] Debes estar por encima del nivel %d",
[7] = "[Sistema] �Solo los usuarios VIP pueden usar este comando!",
[8] = "[Sistema] Necesitas %d restablecimientos",
[9] = "[Sistema] Necesitas %d M.Resets",
[10] = "[Sistema] Ser�s trasladado en unos segundos ...",
[11] = "No vuelva a iniciar sesi�n, no se mueva o ser� eliminado",
}