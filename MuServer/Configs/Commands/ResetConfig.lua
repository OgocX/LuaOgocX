--[[
Commands Config
]]--
--Configurações comando /reset
RESET_COMMAND = "/reset"
RESET_SWITCH = 1
RESET_TYPE = 0 -- 0 (Acumulativo), 1 (Tabelado)

--Configurações Npc Reset
RESET_NPC_SWITCH = 0
RESET_NPC = { {Class = 249, Map = 0, CoordX = 125, CoordY = 125, Dir = 3},
{Class = 249, Map = 2, CoordX = 240, CoordY = 130, Dir = 2} }

-- Configurações auto reset
AUTO_RESET_COMMAND = "/autoreset"
AUTO_RESET_SWITCH = 1
AUTO_RESET_LEVEL = 1
AUTO_RESET_VIP = 0
AUTO_RESET_RESETS = 0
AUTO_RESET_MRESETS = 0

--Configurações reset acumulativo
RESET_ACUMULATIVE_LEVEL = {}
RESET_ACUMULATIVE_LEVEL[0] = 300
RESET_ACUMULATIVE_LEVEL[1] = 280
RESET_ACUMULATIVE_LEVEL[2] = 250
RESET_ACUMULATIVE_MONEY = {}
RESET_ACUMULATIVE_MONEY[0] = 1000000
RESET_ACUMULATIVE_MONEY[1] = 800000
RESET_ACUMULATIVE_MONEY[2] = 500000
RESET_ACUMULATIVE_LEVEL_AFTER = {}
RESET_ACUMULATIVE_LEVEL_AFTER[0] = 1
RESET_ACUMULATIVE_LEVEL_AFTER[1] = 6
RESET_ACUMULATIVE_LEVEL_AFTER[2] = 15
RESET_ACUMULATIVE_RETURN = {}
RESET_ACUMULATIVE_RETURN[0] = 1
RESET_ACUMULATIVE_RETURN[1] = 1
RESET_ACUMULATIVE_RETURN[2] = 0
RESET_ACUMULATIVE_RETURN_MAP_CLASS = {}
RESET_ACUMULATIVE_RETURN_MAP_CLASS[0] = 0 -- SM
RESET_ACUMULATIVE_RETURN_MAP_CLASS[1] = 0 -- BK
RESET_ACUMULATIVE_RETURN_MAP_CLASS[2] = 0 -- ELF
RESET_ACUMULATIVE_RETURN_MAP_CLASS[3] = 0 -- MG
RESET_ACUMULATIVE_RETURN_MAP_CLASS[4] = 0 -- DL
RESET_ACUMULATIVE_RETURN_MAP_X_CLASS = {}
RESET_ACUMULATIVE_RETURN_MAP_X_CLASS[0] = 125 -- SM
RESET_ACUMULATIVE_RETURN_MAP_X_CLASS[1] = 125 -- BK
RESET_ACUMULATIVE_RETURN_MAP_X_CLASS[2] = 125 -- ELF
RESET_ACUMULATIVE_RETURN_MAP_X_CLASS[3] = 125 -- MG
RESET_ACUMULATIVE_RETURN_MAP_X_CLASS[4] = 125 -- DL
RESET_ACUMULATIVE_RETURN_MAP_Y_CLASS = {}
RESET_ACUMULATIVE_RETURN_MAP_Y_CLASS[0] = 125 -- SM
RESET_ACUMULATIVE_RETURN_MAP_Y_CLASS[1] = 125 -- BK
RESET_ACUMULATIVE_RETURN_MAP_Y_CLASS[2] = 125 -- ELF
RESET_ACUMULATIVE_RETURN_MAP_Y_CLASS[3] = 125 -- MG
RESET_ACUMULATIVE_RETURN_MAP_Y_CLASS[4] = 125 -- DL
RESET_ACUMULATIVE_RELOGAR = {}
RESET_ACUMULATIVE_RELOGAR[0] = 0
RESET_ACUMULATIVE_RELOGAR[1] = 0
RESET_ACUMULATIVE_RELOGAR[2] = 0
RESET_ACUMULATIVE_RESETS = {}
RESET_ACUMULATIVE_RESETS[0] = 1
RESET_ACUMULATIVE_RESETS[1] = 1
RESET_ACUMULATIVE_RESETS[2] = 1

--Configs Reset Table

--Pontos fixos ao dar o Reset Tabelado por vip
RESET_TABLE_POINTS = {}
RESET_TABLE_POINTS[0] = 0
RESET_TABLE_POINTS[1] = 0
RESET_TABLE_POINTS[2] = 0

--Caso não encontre o Método de reset pelo RESET_TABLE puxar um level fixo
RESET_TABLE_LEVEL = {}
RESET_TABLE_LEVEL[0] = 400
RESET_TABLE_LEVEL[1] = 400
RESET_TABLE_LEVEL[2] = 400

--Caso não encontre o Money de reset pelo RESET_TABLE puxar um valor fixo
RESET_TABLE_MONEY = {}
RESET_TABLE_MONEY[0] = 5000
RESET_TABLE_MONEY[1] = 5000
RESET_TABLE_MONEY[2] = 5000

--Level Após dar reset tabelado (por vip)
RESET_TABLE_AFTER = {}
RESET_TABLE_AFTER[0] = 1
RESET_TABLE_AFTER[1] = 1
RESET_TABLE_AFTER[2] = 1

--mover Player ao dar reset tabelado (por vip)
RESET_TABLE_RETURN = {}
RESET_TABLE_RETURN[0] = 1
RESET_TABLE_RETURN[1] = 1
RESET_TABLE_RETURN[2] = 0

--Mapa caso mova o player que deu reset ativado em RESET_TABLE_RETURN (por classe)
RESET_TABLE_RETURN_MAP_CLASS = {}
RESET_TABLE_RETURN_MAP_CLASS[0] = 0 -- SM
RESET_TABLE_RETURN_MAP_CLASS[1] = 0 -- BK
RESET_TABLE_RETURN_MAP_CLASS[2] = 0 -- ELF
RESET_TABLE_RETURN_MAP_CLASS[3] = 0 -- MG
RESET_TABLE_RETURN_MAP_CLASS[4] = 0 -- DL

--Coord X caso mova o player que deu reset ativado em RESET_TABLE_RETURN (por classe)
RESET_TABLE_RETURN_MAP_X_CLASS = {}
RESET_TABLE_RETURN_MAP_X_CLASS[0] = 125 -- SM
RESET_TABLE_RETURN_MAP_X_CLASS[1] = 125 -- BK
RESET_TABLE_RETURN_MAP_X_CLASS[2] = 125 -- ELF
RESET_TABLE_RETURN_MAP_X_CLASS[3] = 125 -- MG
RESET_TABLE_RETURN_MAP_X_CLASS[4] = 125 -- DL

--Coord Y caso mova o player que deu reset ativado em RESET_TABLE_RETURN (por classe)
RESET_TABLE_RETURN_MAP_Y_CLASS = {}
RESET_TABLE_RETURN_MAP_Y_CLASS[0] = 125 -- SM
RESET_TABLE_RETURN_MAP_Y_CLASS[1] = 125 -- BK
RESET_TABLE_RETURN_MAP_Y_CLASS[2] = 125 -- ELF
RESET_TABLE_RETURN_MAP_Y_CLASS[3] = 125 -- MG
RESET_TABLE_RETURN_MAP_Y_CLASS[4] = 125 -- DL

--Relogar player caso dê reset (por vip)
RESET_TABLE_RELOGAR = {}
RESET_TABLE_RELOGAR[0] = 0
RESET_TABLE_RELOGAR[1] = 0
RESET_TABLE_RELOGAR[2] = 0

--Quantidade de resets que o player recebe ao dar reset (por vip)
RESET_TABLE_RESETS = {}
RESET_TABLE_RESETS[0] = 1
RESET_TABLE_RESETS[1] = 1
RESET_TABLE_RESETS[2] = 1

--Pontos Status após dar Reset (por vip)
RESET_TABLE_POINTS_STATUS = {}
RESET_TABLE_POINTS_STATUS[0] = 25
RESET_TABLE_POINTS_STATUS[1] = 25
RESET_TABLE_POINTS_STATUS[2] = 25

--Configurações do reset tabelado
RESET_TABLE = {
{MinReset = 0, MaxReset = 5, Level_Free = 400, Level_Vip1 = 380, Level_Vip2 = 370, Level_Vip3 = 360, Money_Free= 10000, Money_Vip1 = 9000, Money_Vip2 = 8000, Money_Vip3 = 7000, Points_Free = 10, Points_Vip1 = 15, Points_Vip2 = 20, Points_Vip3 = 25},
{MinReset = 6, MaxReset = 1000, Level_Free = 400, Level_Vip1 = 380, Level_Vip2 = 370, Level_Vip3 = 360, Money_Free= 10000, Money_Vip1 = 9000, Money_Vip2 = 8000, Money_Vip3 = 7000, Points_Free = 15, Points_Vip1 = 20, Points_Vip2 = 25, Points_Vip3 = 30},
}

--[[
Message Config
]]--
RESET_MESSAGES = { }

RESET_MESSAGES["Por"] = {
[1] = "[Sistema] Você precisa estar acima do level %d para usar o auto reset",
[2] = "[Sistema] Somente usuários vip podem usar o auto reset!",
[3] = "[Sistema] Você precisa de %d resets para ativar o auto reset",
[4] = "[Sistema] Você precisa de %d M.Resets para ativar o auto reset",
[5] = "[Sistema] Auto Reset Desativado com sucesso!",
[6] = "[Sistema] Auto Reset Ativado com sucesso!",
[7] = "[Sistema] Não foi possível resetar.",
[8] = "[Sistema] Resetado com sucesso!",
[9] = "Você possui %d resets!",
[10] = "[Sistema] Não foi possível resetar.",
[11] = "[Sistema] Resetado com sucesso!",
[12] = "O limite de resets é :%d",
[13] = "[Sistema] Você precisa de %d level para resetar",
[14] = "[Sistema] Você precisa de %d zen para resetar",
}

RESET_MESSAGES["Eng"] = {
[1] = "[System] You need to be above level %d to use auto reset",
[2] = "[System] Only VIP users can use auto reset!",
[3] = "[System] You need %d resets to activate auto reset",
[4] = "[System] You need %d M.Resets to activate auto reset",
[5] = "[System] Auto Reset Deactivated successfully!",
[6] = "[System] Auto Reset Activated successfully!",
[7] = "[System] Couldn't be reset.",
[8] = "[System] Successfully reset!",
[9] = "You have %d resets!",
[10] = "[System] Couldn't be reset.",
[11] = "[System] Successfully reset!",
[12] = "The resets limit is: %d",
[13] = "[System] You need %d level to reset",
[14] = "[System] You need %d zen to reset",
}

RESET_MESSAGES["Spn"] = {
[1] = "[Sistema] Debes estar por encima del nivel %d para usar el restablecimiento automático",
[2] = "[Sistema] ¡Solo los usuarios VIP pueden usar el reinicio automático!",
[3] = "[Sistema] Necesitas %d restablecimientos para activar el restablecimiento automático",
[4] = "[Sistema] Necesitas %d M.Resets para activar el reinicio automático",
[5] = "¡[Sistema] Reinicio automático desactivado correctamente!",
[6] = "¡[Sistema] Reinicio automático activado correctamente!",
[7] = "[Sistema] No se pudo restablecer.",
[8] = "[Sistema] Se reinició correctamente",
[9] = "¡Tienes %d restablecimientos!",
[10] = "[Sistema] No se pudo restablecer.",
[11] = "[Sistema] Se reinició correctamente",
[12] = "El límite de reinicios es: %d",
[13] = "[Sistema] Necesitas %d nivel para restablecer",
[14] = "[Sistema] Necesitas %d zen para reiniciar",
}