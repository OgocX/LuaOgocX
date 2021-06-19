--[[
Command config
--]]
-- Configura��es comandos Add
STR_COMMAND = "/f"
AGI_COMMAND = "/a"
VIT_COMMAND = "/v"
ENE_COMMAND = "/e"
CMD_COMMAND = "/c"
ADD_SWITCH = 1
ADD_MINPOINTS = 5
ADD_LEVEL = 1
ADD_MONEY = 1000000
ADD_RESET = 0
ADD_MRESET = 0
ADD_VIP = 0

ADD_COMMAND_MAX_POINTS = {}

ADD_COMMAND_MAX_POINTS[0] = 65535 -- free
ADD_COMMAND_MAX_POINTS[1] = 65535 -- vip 1
ADD_COMMAND_MAX_POINTS[2] = 65535 -- vip 2
ADD_COMMAND_MAX_POINTS[3] = 65535 -- vip 3

-- Configura��es comandos ReAdd
RE_ADD_COMMAND = "/readd"
RE_ADD_SWITCH = 1
RE_ADD_LEVEL = 1
RE_ADD_MONEY = 1000000
RE_ADD_RESET = 0
RE_ADD_MRESET = 0
RE_ADD_VIP = 0
RE_ADD_MIN_POINTS = 500
RE_ADD_POINTS_AFTER = 25

--[[
Messager config
--]]

ADD_POINTS_MESSAGES = {}

ADD_POINTS_MESSAGES["Por"] = {
[1] = "[Sistema] O min�mo de pontos para adicionar � %d",
[2] = "[Sistema] Voc� precisa estar acima do level %d",
[3] = "[Sistema] Voc� precisa de %d zen",
[4] = "[Sistema] Somente usu�rios vip podem usar este comando!",
[5] = "[Sistema] Voc� precisa de %d resets",
[6] = "[Sistema] Voc� precisa de %d M.Resets",
[7] = "[Sistema] Voc� n�o possui essa quantia de pontos.",
[8] = "[Sistema] Pontos adicionados.",
[9] = "[Sistema] O M�ximo de pontos em Agilidade � %d",
[10] = "[Sistema] O M�ximo de pontos em Vitalidade � %d",
[11] = "[Sistema] O M�ximo de pontos em Energia � %d",
[12] = "[Sistema] O M�ximo de pontos em Comando � %d",
[13] = "[Sistema] Voc� precisa ter no min�mo %d pontos em cada status",
[14] = "[Sistema] Pontos redistribu�dos com sucesso!",
[15] = "[Sistema] O M�ximo de pontos em Agilidade � %d",
}

ADD_POINTS_MESSAGES["Eng"] = {
[1] = "[System] The minimum points to add is %d",
[2] = "[System] You need to be above level %d",
[3] = "[System] You need %d zen",
[4] = "[System] Only VIP users can use this command!",
[5] = "[System] You need %d resets",
[6] = "[System] You need %d M.Resets",
[7] = "[System] You don't have that amount of points.",
[8] = "[System] Points added.",
[9] = "[System] Maximum points in Agility is %d",
[10] = "[System] Maximum points in Vitality is %d",
[11] = "[System] Maximum points in Energy is %d",
[12] = "[System] Maximum points in Command is %d",
[13] = "[System] You must have at least %d points in each status",
[14] = "[System] Points redistributed successfully!",
[15] = "[System] Max Agility points is %d",
}

ADD_POINTS_MESSAGES["Spn"] = {
[1] = "[Sistema] El m�nimo de puntos para agregar es %d",
[2] = "[Sistema] Debes estar por encima del nivel %d",
[3] = "[Sistema] Necesitas %d zen",
[4] = "[Sistema] �Solo los usuarios VIP pueden usar este comando!",
[5] = "[Sistema] Necesitas %d restablecimientos",
[6] = "[Sistema] Necesitas %d M.Resets",
[7] = "[Sistema] No tienes esa cantidad de puntos.",
[8] = "[Sistema] Puntos agregados.",
[9] = "[Sistema] El m�ximo de puntos en agilidad es %d",
[10] = "[Sistema] El m�ximo de puntos en Vitality es %d",
[11] = "[Sistema] El m�ximo de puntos en energ�a es %d",
[12] = "[Sistema] El m�ximo de puntos en Command es %d",
[13] = "[Sistema] Debes tener al menos %d puntos en cada estado",
[14] = "�[Sistema] Puntos redistribuidos correctamente!",
[15] = "[Sistema] Los puntos m�ximos de agilidad son %d",
}