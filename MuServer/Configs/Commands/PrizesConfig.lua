--[[
Commands Configs
]]--
--Configurações Prizes in-game
PRIZES_SWITCH = 1
--Comando, Table Event, Column Event, Where Event, Table Amount, Column Amount, Where Amount, Nome, Quantia de Players, Pontos p1, Amounts p1, pontos p2, amounts p2, pontos p3, amounts p3
PRIZES_COMMANDS = {
{Command = '/addtradewins', TableE = 'Character', ColumnE = 'tradewins', WhereE = 'Name', TableA = 'MEMB_INFO', ColumnA = 'cash', WhereA = 'memb___id', Name = 'Trade Wins', Players = 1, Points_1 = 1, Amounts_1 = 5, Points_2 = 0, Amounts_2 = 0, Points_3 = 0, Amounts_3 = 0},
{Command = '/addmt', TableE = 'Character', ColumnE = 'matamata', WhereE = 'Name', TableA = 'MEMB_INFO', ColumnA = 'cash', WhereA = 'memb___id', Name = 'Mata-Mata', Players = 3,Points_1 = 3, Amounts_1 = 10, Points_2 = 2, Amounts_2 = 8, Points_3 = 1, Amounts_3 = 5},
}

--[[
Messages Configs
]]--

PRIZES_MESSAGES = { }

PRIZES_MESSAGES["Por"] = {
[1] = "[Sistema] %s está offline ou não existe",
[2] = "[%s]",
[3] = "Prêmio do Evento %s",
[4] = "Adicionado para < %s >",
[5] = "[Sistema] Sua premiação foi adicionada!",
[6] = "[Sistema] Prêmios adicionados com sucesso!",
[7] = "Adicionado para < %s e %s >",
[8] = "%s, %s e %s",
}

PRIZES_MESSAGES["Eng"] = {

}

PRIZES_MESSAGES["Spn"] = {

}