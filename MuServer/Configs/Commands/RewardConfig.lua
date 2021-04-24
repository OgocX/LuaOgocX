--[[
Commands Config
]]--
--Configurações comando /bonus
REWARD_COMMAND = "/bonus"
REWARD_INVENTORY = 1
REWARD_SWITCH = 1
REWARD_COUNTS = 1 -- Vezes que o player pode usar o comando na conta!

--Class Classe que vai receber o bônus, 0 - SM | 1 - BK | 2 - ELF | 3 - MG
--ItemSection = Seção do item no Item(kor)
--ItemIndex = Index do item no Item(kor)
--Demais configurações todos ja sabem que é!
--Padrão eu configurei 2 itens por classe mas pode colocar quantas quiser!
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
[1] = "[Sistema] Você já utilizou seu bônus!",
[2] = "[Sistema] Seu inventário precisa estar vazio!",
[3] = "[Sistema] Sua recompensa foi colocado no inventário!",
[4] = "[Sistema] Pegue sua recompensa no chão!",
}

REWARD_MESSAGES["Eng"] = {
[1] = "[System] You already used your bonus!",
[2] = "[System] Your inventory must be empty!",
[3] = "[System] Your reward has been placed in the inventory!",
[4] = "[System] Get your reward on the floor!",
}

REWARD_MESSAGES["Spn"] = {
[1] = "[Sistema] ¡Ya usaste tu bonificación!",
[2] = "[Sistema] ¡Tu inventario debe estar vacío!",
[3] = "[Sistema] ¡Su recompensa ha sido colocada en el inventario!",
[4] = "[Sistema] ¡Obtén tu recompensa en el piso!",
}