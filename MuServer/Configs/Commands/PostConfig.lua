--[[
Commands Configs
]]--
POST_COMMAND = "/post"
POST_STRING = "[Post] %s:%s"
POST_SWITCH = 1
POST_LEVEL = 100
POST_MONEY = 2000000
POST_RESET = 0
POST_MRESET = 0
POST_VIP = 0
POST_COLOR = 3
POST_TIMER = 7

--[[
Message Configs
]]--
POST_MESSAGES = { }

POST_MESSAGES["Por"] = {
[1] = "[Sistema] Você tem que esperar %d segundo(s) para utilizar o %s novamente.",
[2] = "[Sistema] Você precisa estar acima do level %d",
[3] = "[Sistema] Você precisa de %d zen",
[4] = "[Sistema] Somente usuários vip podem usar este comando!",
[5] = "[Sistema] Você precisa de %d resets",
[6] = "[Sistema] Você precisa de %d M.Resets",
}

POST_MESSAGES["Eng"] = {
[1] = "[System] You have to wait %d second (s) to use %s again.",
[2] = "[System] You need to be above level %d",
[3] = "[System] You need %d Zen",
[4] = "[System] Only VIP users can use this command!",
[5] = "[System] You need %d resets",
[6] = "[System] You need %d M.Resets",
}

POST_MESSAGES["Spn"] = {
[1] = "[Sistema] Tienes que esperar %d segundo (s) para usar %s nuevamente",
[2] = "[SISTEMA] Debe estar por encima del nivel %d",
[3] = "[Sistema] Necesita %d Zen",
[4] = "[SISTEMA] ¡Solo los usuarios VIP pueden usar este comando!",
[5] = "[SISTEMA] Necesita %d restablece",
[6] = "[Sistema] Necesita %d M.Resets",
}