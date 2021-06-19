--[[
Command Config
]]--

AUTO_RESET_SWITCH = 1
AUTO_RESET_COMMAND = "/autoreset"
AUTO_RESET_RESETS = 0
AUTO_RESET_MRESETS = 0

AUTO_RESET_COMMAND_ACTIVE_VIP = {}

AUTO_RESET_COMMAND_ACTIVE_VIP[0] = 1
AUTO_RESET_COMMAND_ACTIVE_VIP[1] = 1
AUTO_RESET_COMMAND_ACTIVE_VIP[2] = 1
AUTO_RESET_COMMAND_ACTIVE_VIP[3] = 1

--[[
Command Message
]]

AUTO_RESET_COMMAND_MESSAGES = {}

AUTO_RESET_COMMAND_MESSAGES["Por"] = {
[1] = 'Este comando n�o est� liberado para voc�!',
[2] = 'Voc� precisa ter %d resets para usar o comando!',
[3] = 'Voc� precisa ter %d m.resets para usar o comando!',
[4] = 'Reset autom�tico ativado',
[5] = 'Reset autom�tico desativado',
}

AUTO_RESET_COMMAND_MESSAGES["Eng"] = {
[1] = 'This command is not released to you!',
[2] = 'You must have %d resets to use the command!',
[3] = 'You must have %d m.resets to use the command!',
[4] = 'Auto reset enabled',
[5] = 'Auto reset disabled',
}

AUTO_RESET_COMMAND_MESSAGES["Spn"] = {
[1] = '�Este comando no est� disponible para ti!',
[2] = '�Debes tener% d reinicios para usar el comando!',
[3] = '�Debes tener% d m.resets para usar el comando!',
[4] = 'Restablecimiento autom�tico habilitado',
[5] = 'Reinicio autom�tico inhabilitado',
}