--[[
Commands Config
]]--
--Configura��es comando /bonus
REWARD_COMMAND = "/bonus"
REWARD_INVENTORY = 1
REWARD_SWITCH = 1
REWARD_COUNTS = 1 -- Vezes que o player pode usar o comando na conta!

--Class Classe que vai receber o b�nus, 0 - SM | 1 - BK | 2 - ELF | 3 - MG
--ItemSection = Se��o do item no Item(kor)
--ItemIndex = Index do item no Item(kor)
--Demais configura��es todos ja sabem que �!
--Padr�o eu configurei 2 itens por classe mas pode colocar quantas quiser!
REWARD_ITEMS = { {Class = 0, ItemSection = 1, ItemIndex = 0, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1},
{Class = 0, ItemSection = 6, ItemIndex = 1, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1},
{Class = 1, ItemSection = 1, ItemIndex = 0, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1},
{Class = 1, ItemSection = 6, ItemIndex = 1, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1},
{Class = 2, ItemSection = 1, ItemIndex = 0, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1},
{Class = 2, ItemSection = 6, ItemIndex = 1, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1},
{Class = 3, ItemSection = 1, ItemIndex = 0, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1},
{Class = 3, ItemSection = 6, ItemIndex = 1, Level = 15, Luck = 1, Skill = 0, Option = 7, Exc1 = 1, Exc2 = 1, Exc3 = 1, Exc4 = 1, Exc5 = 1, Exc6 = 1} }

--[[
Message Configs
]]--
REWARD_MESSAGES = { }

REWARD_MESSAGES["Por"] = {
[1] = "[Sistema] Voc� j� utilizou seu b�nus!",
[2] = "[Sistema] Seu invent�rio precisa estar vazio!",
[3] = "[Sistema] Sua recompensa foi colocado no invent�rio!",
[4] = "[Sistema] Pegue sua recompensa no ch�o!",
}

REWARD_MESSAGES["Eng"] = {
[1] = "[System] You already used your bonus!",
[2] = "[System] Your inventory must be empty!",
[3] = "[System] Your reward has been placed in the inventory!",
[4] = "[System] Get your reward on the floor!",
}

REWARD_MESSAGES["Spn"] = {
[1] = "[Sistema] �Ya usaste tu bonificaci�n!",
[2] = "[Sistema] �Tu inventario debe estar vac�o!",
[3] = "[Sistema] �Su recompensa ha sido colocada en el inventario!",
[4] = "[Sistema] �Obt�n tu recompensa en el piso!",
}