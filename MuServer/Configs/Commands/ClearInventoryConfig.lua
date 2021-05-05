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
[1] = "[Sistema] Você precisa estar acima do level %d para utilizar o limpar inventário",
[2] = "[Sistema] Você precisa de %d zen para utilizar o limpar inventário",
[3] = "[Sistema] Somente usuários vip podem usar o limpar inventário",
[4] = "[Sistema] Você precisa de %d resets para utilizar o limpar inventário",
[5] = "[Sistema] Você precisa de %d M.Resets para utilizar o limpar inventário",
[6] = "[Sistema] Seu inventário já está limpo!",
[7] = "[Sistema] Inventário limpo com sucesso!",
[8] = "[Sistema] Você está ocupado no momento!",
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
[6] = "[Sistema] ¡Tu inventario ya está limpio!",
[7] = "¡[Sistema] Inventario limpiado correctamente!",
[8] = "[Sistema] ¡Actualmente estás ocupado!",
}