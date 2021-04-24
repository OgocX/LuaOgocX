--[[
Command Configs
]]--
MULT_VAULT_COMMAND = "/trocarbau"
MULT_VAULT_SWITCH = 1
MULT_VAULT_LEVEL = 1
MULT_VAULT_RESETS = 0
MULT_VAULT_MRESETS = 0
MULT_VAULT_VIP = 0
MULT_VAULT_MONEY = 1000000
--Type 0 = quantia de ba�s atrav�s da coluna, Type = 1 quantia de baus por vip
MULT_VAULT_TYPE = 0
-- Quantia de baus por vip apenas se o Type for 1
MULT_VAULT_COUNT = {}
MULT_VAULT_COUNT[0] = 5
MULT_VAULT_COUNT[1] = 10
MULT_VAULT_COUNT[2] = 15

--Open vault
OPEN_VAULT_COMMAND = "/abrirbau"
OPEN_VAULT_SWITCH = 1
OPEN_VAULT_LEVEL = 1
OPEN_VAULT_RESETS = 0
OPEN_VAULT_MRESETS = 0
OPEN_VAULT_VIP = 0
OPEN_VAULT_MONEY = 1000000

--[[
Message Configs
]]--
WAREHOUSE_MESSAGES = { }

WAREHOUSE_MESSAGES["Por"] = {
[1] = "[Sistema] Coloque um n�mero v�lido!",
[2] = "[Sistema] Feche outras janelas para realizar essa a��o.",
[3] = "[Sistema] Voc� precisa estar acima do level %d",
[4] = "[Sistema] Voc� precisa de %d zen",
[5] = "[Sistema] Voc� n�o tem privil�gios vip para utilizar este comando.",
[6] = "[Sistema] Voc� precisa de %d resets",
[7] = "[Sistema] Voc� precisa de %d M.Resets",
[8] = "[Sistema] Houve um problema ao identificar os baus, contate o administrador.",
[9] = "[Sistema] Seu plano n�o possu� essa quantidade de ba�s.",
[10] = "[Sistema] Ba� trocado com sucesso!",
}

WAREHOUSE_MESSAGES["Eng"] = {
[1] = "[System] Enter a valid number!",
[2] = "[System] Close other windows to perform this action.",
[3] = "[System] You need to be above level %d",
[4] = "[System] You need %d zen",
[5] = "[System] You do not have VIP privileges to use this command.",
[6] = "[System] You need %d resets",
[7] = "[System] You need %d M.Resets",
[8] = "[System] There was a problem identifying the baus, please contact the administrator.",
[9] = "[System] Your plan does not have that many chests.",
[10] = "[System] Chest successfully exchanged!",
}

WAREHOUSE_MESSAGES["Spn"] = {
[1] = "[Sistema] �Ingresa un n�mero v�lido!",
[2] = "[Sistema] Cierre otras ventanas para realizar esta acci�n.",
[3] = "[Sistema] Debes estar por encima del nivel %d",
[4] = "[Sistema] Necesitas %d zen",
[5] = "[Sistema] No tienes privilegios VIP para usar este comando.",
[6] = "[Sistema] Necesitas %d restablecimientos",
[7] = "[Sistema] Necesitas %d M.Resets",
[8] = "[Sistema] Hubo un problema al identificar los baus, comun�quese con el administrador.",
[9] = "[Sistema] Tu plan no tiene tantos cofres.",
[10] = "�El cofre de [Sistema] se intercambi� con �xito!",
}

OPEN_WAREHOUSE_MESSAGES = { }

OPEN_WAREHOUSE_MESSAGES["Por"] = {
[1] = "[Sistema] Feche outras janelas para realizar essa a��o.",
[2] = "[Sistema] Voc� precisa estar acima do level %d",
[3] = "[Sistema] Voc� precisa de %d zen",
[4] = "[Sistema] Voc� n�o tem privil�gios vip para utilizar este comando.",
[5] = "[Sistema] Voc� precisa de %d resets",
[6] = "[Sistema] Voc� precisa de %d M.Resets",
}

OPEN_WAREHOUSE_MESSAGES["Eng"] = {
[1] = "[System] Close other windows to perform this action.",
[2] = "[System] You need to be above level %d",
[3] = "[System] You need %d zen",
[4] = "[System] You do not have VIP privileges to use this command.",
[5] = "[System] You need %d resets",
[6] = "[System] You need %d M.Resets",
}

OPEN_WAREHOUSE_MESSAGES["Spn"] = {
[1] = "[Sistema] Cierre otras ventanas para realizar esta acci�n.",
[2] = "[Sistema] Debes estar por encima del nivel %d",
[3] = "[Sistema] Necesitas %d zen",
[4] = "[Sistema] No tienes privilegios VIP para usar este comando.",
[5] = "[Sistema] Necesitas %d restablecimientos",
[6] = "[Sistema] Necesitas %d M.Resets",
}