--[[
Command Configs
--]]
-- Configurações comando /autopost
AUTO_POST_COMMAND = "/autopost"
AUTO_POST_STRING = "[AutoPost] %s:%s"
AUTO_POST_SWITCH = 1
AUTO_POST_LEVEL = 100
AUTO_POST_MONEY = 2000000
AUTO_POST_RESET = 0
AUTO_POST_MRESET = 0
AUTO_POST_VIP = 0
AUTO_POST_COLOR = 3
AUTO_POST_TIMER = 10

--[[
Messager Configs
]]--
AUTO_POST_MESSAGES = {  }

AUTO_POST_MESSAGES["Por"] = {
[1] = "[Sistema] Auto post desativado.",
[2] = "[Sistema] Você já está utilizando o comando %s",
[3] = "[Sistema] Você precisa estar acima do level %d para utilizar o auto post",
[4] = "[Sistema] Você precisa de %d zen para utilizar o auto post",
[5] = "[Sistema] Somente usuários vip podem usar este comando!",
[6] = "[Sistema] Você precisa de %d resets para utilizar o auto post",
[7] = "[Sistema] Você precisa de %d M.Resets para utilizar o auto post",
}

AUTO_POST_MESSAGES["Eng"] = {
[1] = "[System] Auto post disabled.",
[2] = "[System] You are already using the command %s",
[3] = "[System] You need to be above level %d to use auto post",
[4] = "[System] You need %d zen to use the auto post",
[5] = "[System] Only VIP users can use this command!",
[6] = "[System] You need %d resets to use the auto post",
[7] = "[System] You need %d M.Resets to use the auto post",
}

AUTO_POST_MESSAGES["Spn"] = {
[1] = "[Sistema] Publicación automática inhabilitada",
[2] = "[Sistema] Ya estás usando el comando %s",
[3] = "[Sistema] Debes estar por encima del nivel %d para usar la publicación automática",
[4] = "[Sistema] Necesitas %d zen para usar la publicación automática",
[5] = "[Sistema] ¡Solo los usuarios VIP pueden usar este comando!",
[6] = "[Sistema] Necesitas %d restablecimientos para usar la publicación automática",
[7] = "[Sistema] Necesitas %d M.Resets para usar la publicación automática",
}