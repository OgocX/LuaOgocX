--[[
Command config
--]]
-- Configurações comandos Add
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

-- Configurações comandos ReAdd
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
[1] = "[Sistema] O minímo de pontos para adicionar é %d",
[2] = "[Sistema] Você precisa estar acima do level %d",
[3] = "[Sistema] Você precisa de %d zen",
[4] = "[Sistema] Somente usuários vip podem usar este comando!",
[5] = "[Sistema] Você precisa de %d resets",
[6] = "[Sistema] Você precisa de %d M.Resets",
[7] = "[Sistema] Você não possui essa quantia de pontos.",
[8] = "[Sistema] Pontos adicionados.",
[9] = "[Sistema] O Máximo de pontos em Agilidade é %d",
[10] = "[Sistema] O Máximo de pontos em Vitalidade é %d",
[11] = "[Sistema] O Máximo de pontos em Energia é %d",
[12] = "[Sistema] O Máximo de pontos em Comando é %d",
[13] = "[Sistema] Você precisa ter no minímo %d pontos em cada status",
[14] = "[Sistema] Pontos redistribuídos com sucesso!",
[15] = "[Sistema] O Máximo de pontos em Agilidade é %d",
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
[1] = "[Sistema] El mínimo de puntos para agregar es %d",
[2] = "[Sistema] Debes estar por encima del nivel %d",
[3] = "[Sistema] Necesitas %d zen",
[4] = "[Sistema] ¡Solo los usuarios VIP pueden usar este comando!",
[5] = "[Sistema] Necesitas %d restablecimientos",
[6] = "[Sistema] Necesitas %d M.Resets",
[7] = "[Sistema] No tienes esa cantidad de puntos.",
[8] = "[Sistema] Puntos agregados.",
[9] = "[Sistema] El máximo de puntos en agilidad es %d",
[10] = "[Sistema] El máximo de puntos en Vitality es %d",
[11] = "[Sistema] El máximo de puntos en energía es %d",
[12] = "[Sistema] El máximo de puntos en Command es %d",
[13] = "[Sistema] Debes tener al menos %d puntos en cada estado",
[14] = "¡[Sistema] Puntos redistribuidos correctamente!",
[15] = "[Sistema] Los puntos máximos de agilidad son %d",
}