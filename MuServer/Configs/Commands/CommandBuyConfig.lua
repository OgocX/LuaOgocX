--[[
Commands Config
]]--
BUY_COMMAND_SWITCH = 0 -- 1 Ative 0 Desative
BUY_COMMAND = "/buy"

BUY_COMMAND_AMOUNT_TABLE = {}
BUY_COMMAND_AMOUNT_TABLE[0] = "MEMB_INFO"
BUY_COMMAND_AMOUNT_TABLE[1] = "MEMB_INFO"
BUY_COMMAND_AMOUNT_TABLE[2] = "MEMB_INFO"

BUY_COMMAND_AMOUNT_COLUMN = {}
BUY_COMMAND_AMOUNT_COLUMN[0] = "Cash"
BUY_COMMAND_AMOUNT_COLUMN[1] = "Golds"
BUY_COMMAND_AMOUNT_COLUMN[2] = "Terceira"

BUY_COMMAND_AMOUNT_WHERE = {}
BUY_COMMAND_AMOUNT_WHERE[0] = "memb___id"
BUY_COMMAND_AMOUNT_WHERE[1] = "memb___id"
BUY_COMMAND_AMOUNT_WHERE[2] = "memb___id"

BUY_COMMAND_AMOUNT_NAME = {}
BUY_COMMAND_AMOUNT_NAME[0] = "Cashs"
BUY_COMMAND_AMOUNT_NAME[1] = "Golds"
BUY_COMMAND_AMOUNT_NAME[2] = "Qualquer"

--Name: Nome do item quando falar na mensagem
--String: Oque o cara vai usar para comprar exemplo /buy Bless, não é permitido utilizar espaço exemplo "/buy bless bless", apenas "/buy packbles" "/buy bless" etc...
--AmountType: Tipo da moeda configurado acima 0 = primeira 1 = segunda etc...
--Amount: Quantidade que será cobrado
--Identification: Numero do item na BUY_COMMAND_ITENS
--ItemCount: Quantos itens serão editados
BUY_COMMAND_CONFIG = {{Name = "Jewel Bless", String = "Bless", AmountType = 0, Amount = 5, Identification = 1, ItemCount = 1},
{Name = "Set Bronze", String = "SetBronze", AmountType = 0, Amount = 5, Identification = 2, ItemCount = 1},}

--Section: Seção do item
--ItemIndex: Index do item
--IsSet: Se for 1 Set coloque a Section = 7 que o sistema automaticamente vai rolar do 7 ao 11 colocando 1 set no inventário
--As demais configurações já dizem por sí...
BUY_COMMAND_ITENS = {{Identification = 1, Section = 14, Index = 13, IsSet = 0, Level = 15, Luck = 1, Skill = 1, Opt = 7, Exc_1 = 1, Exc_2 = 1, Exc_3 = 1, Exc_4 = 1, Exc_5 = 1, Exc_6 = 1},
{Identification = 2, Section = 7, Index = 0, IsSet = 1, Level = 15, Luck = 1, Skill = 1, Opt = 7, Exc_1 = 1, Exc_2 = 1, Exc_3 = 1, Exc_4 = 1, Exc_5 = 1, Exc_6 = 1},}

--[[
Messager Config
]]--
COMMAND_BUY_MESSAGES = { }

COMMAND_BUY_MESSAGES["Por"] = {
[1] = "[Sistema] Para utilizar esse comando deixe seu inventário vazio!",
[2] = "Você precisa de %d %s para comprar este item!",
[3] = "[%s] adicionado em seu inventário!",
[4] = "Não conseguimos encontrar o item!",
}

COMMAND_BUY_MESSAGES["Eng"] = {
[1] = "[System] To use this command, leave your inventory empty!",
[2] = "You need %d %s to buy this item!",
[3] = "[ %s] added to your inventory!",
[4] = "We couldn't find the item!",
}

COMMAND_BUY_MESSAGES["Spn"] = {
[1] = "[Sistema] Para usar este comando, ¡deje su inventario vacío!",
[2] = "¡Necesitas %d %s para comprar este artículo!",
[3] = "¡[ %s] agregado a su inventario!",
[4] = "¡No pudimos encontrar el artículo!",
}