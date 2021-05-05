--[[
Command Configs
]]--
CLEAR_INVENTORY_COMMAND = '/limparinv'
CLEAR_INVENTORY_SWITCH = 1
CLEAR_INVENTORY_LEVEL = 6
CLEAR_INVENTORY_RESET = 0
CLEAR_INVENTORY_MRESET = 0
CLEAR_INVENTORY_MONEY = 0
CLEAR_INVENTORY_VIP = 0

--[[
Command Messages
]]--

CLEAR_INVENTORY_MESSAGES = { }

CLEAR_INVENTORY_MESSAGES["Por"] = {
[1] = "[Sistema] Voc� precisa estar acima do level %d para utilizar o limpar invent�rio",
[2] = "[Sistema] Voc� precisa de %d zen para utilizar o limpar invent�rio",
[3] = "[Sistema] Somente usu�rios vip podem usar o limpar invent�rio",
[4] = "[Sistema] Voc� precisa de %d resets para utilizar o limpar invent�rio",
[5] = "[Sistema] Voc� precisa de %d M.Resets para utilizar o limpar invent�rio",
[6] = "[Sistema] Seu invent�rio j� est� limpo!",
[7] = "[Sistema] Invent�rio limpo com sucesso!",
[8] = "[Sistema] Voc� est� ocupado no momento!",
}

CLEAR_INVENTORY_MESSAGES["Eng"] = {
[1] = "[System] You need to be above level %d to use clear inventory",
[2] = "[System] You need %d zen to use clear inventory",
[3] = "[System] Only VIP users can use clear inventory",
[4] = "[System] You need %d resets to use clear inventory",
[5] = "[System] You need %d M.Resets to use clear inventory",
[6] = "[System] Your inventory is already clean!",
[7] = "[System] Inventory successfully cleaned!",
[8] = "[System] You are currently busy!",
}

CLEAR_INVENTORY_MESSAGES["Spn"] = {
[1] = "[Sistema] Debe estar por encima del nivel %d para usar inventario limpio",
[2] = "[Sistema] Necesitas %d zen para usar inventario limpio",
[3] = "[Sistema] Solo los usuarios VIP pueden usar inventario limpio",
[4] = "[Sistema] Necesitas %d restablecimientos para usar inventario limpio",
[5] = "[Sistema] Necesitas %d M.Resets para usar inventario limpio",
[6] = "[Sistema] �Tu inventario ya est� limpio!",
[7] = "�[Sistema] Inventario limpiado correctamente!",
[8] = "[Sistema] �Actualmente est�s ocupado!",
}