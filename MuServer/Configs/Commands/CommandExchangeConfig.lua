--[[
Commands Config
]]--
EXCHANGE_COMMAND = "/trocar"
EXCHANGE_COMMAND_SWITCH = 0 -- 1 ative 0 desative

EXCHANGE_COMMAND_COIN_TABLE = {}
EXCHANGE_COMMAND_COIN_TABLE[0] = "MEMB_INFO"
EXCHANGE_COMMAND_COIN_TABLE[1] = "MEMB_INFO"
EXCHANGE_COMMAND_COIN_TABLE[2] = "MEMB_INFO"

EXCHANGE_COMMAND_COIN_COLUMN = {}
EXCHANGE_COMMAND_COIN_COLUMN[0] = "Cash"
EXCHANGE_COMMAND_COIN_COLUMN[1] = "Golds"
EXCHANGE_COMMAND_COIN_COLUMN[2] = "Terceira"

EXCHANGE_COMMAND_COIN_WHERE = {}
EXCHANGE_COMMAND_COIN_WHERE[0] = "memb___id"
EXCHANGE_COMMAND_COIN_WHERE[1] = "memb___id"
EXCHANGE_COMMAND_COIN_WHERE[2] = "memb___id"

EXCHANGE_COMMAND_COIN_NAME = {}
EXCHANGE_COMMAND_COIN_NAME[0] = "Cashs"
EXCHANGE_COMMAND_COIN_NAME[1] = "Golds"
EXCHANGE_COMMAND_COIN_NAME[2] = "Qualquer"

--NOTA: PE�O FAZENDO FAVOR QUE UTILIZEM EM CASO DE JOIAS APENAS MULTIPLOS DE 10 O M�XIMO � 640 QUE NO CASO 64 J�IAS + 10 M�NIMO 10! ISSO � J�IAS!

--Aqui � onde ser� requisitado!
--String: Identifica��o do comando exemplo: /exchange JewelOfSoul10
--Name: Nome do jewel / moeda que ser� trocado
--TargetName: Nome que ser� recebido
--Index: Index do item caso seja se n�o for deixe -1
--Section: Se��o do item caso n�o for deixe -1
--Request: Quantia requisitada de moeda / jewel
--IsJewel: Se for Joia, coloque 1, se for moeda coloque 0
--CoinsType: Tipo da moeda pedido acima s� funciona se for trocado moeda por outra coisa...
--Identification: Identifica��o no EXCHANGE_ITENS
EXCHANGE_COINS_JEWELS = {{String = "JewelOfSoul10", Name = "Jewel of Soul", TargetName = "Cash", Request = 20, Index = 14, Section = 14, IsJewel = 1, CoinsType = 0, Identification = 1},
{String = "Cash1", Name = "Cash", TargetName = "Jewel Of Soul", Request = 20, Index = -1, Section = -1, IsJewel = 0, CoinsType = 0, Identification = 2},}

--Aqui e onde ser� trocado...
--Identification: Identifica��o confirme a configura��o acima
--Index: Index do item caso seja se n�o for deixe -1
--Section: Se��o do item caso n�o for deixe -1
--IsJewel: Caso for jewel coloque 1, se for moeda deixe 0
--Trade: Quantia que vai receber, lembre-se em caso de joias o invent�rio tem um limite de item... 64 jewels + 10 = 640... s� use multiplos de 10 se n�o n�o funciona!
--CoinsType: Tipo da moeda das configuradas s� funciona se a troca for para moedas
EXCHANGE_ITENS = {{Identification = 1, Index = -1, Section = -1, IsJewel = 0, Trade = 20, CoinsType = 0},
{Identification = 2, Index = 14, Section = 14, IsJewel = 1, Trade = 20, CoinsType = 0},}

--[[
Messager Config
]]--
EXCHANGE_MESSAGES = { }

EXCHANGE_MESSAGES["Por"] = {
[1] = "[Sistema] Voc� est� impossibilitado de utilizar esse comando no momento!",
[2] = "Voc� precisa de %d %s para trocar por %s",
[3] = "[Sistema] Voc� n�o possui %s suficientes!",
[4] = "[Sistema] Voc� n�o possui %s suficientes!",
[5] = "Voc� trocou: %s (%d) por %s (%d)",
[6] = "[Sistema] Para utilizar esse comando deixe seu invent�rio vazio!",
[7] = "Voc� trocou: %s (%d) por %s (%d)",
[8] = "N�o conseguimos encontrar nenhuma op��o de troca!",
}

EXCHANGE_MESSAGES["Eng"] = {
[1] = "[System] You are currently unable to use this command!",
[2] = "You need %d %s to switch to %s",
[3] = "[System] You don't have enough %s!",
[4] = "[System] You don't have enough %s!",
[5] = "You replaced: %s (%d) with %s (%d)",
[6] = "[System] To use this command, leave your inventory empty!",
[7] = "You replaced: %s (%d) with %s (%d)",
[8] = "We couldn't find any exchange options!",
}

EXCHANGE_MESSAGES["Spn"] = {
[1] = "[Sistema] �Actualmente no puedes usar este comando!",
[2] = "Necesitas %d %s para cambiar a %s",
[3] = "[Sistema] �No tienes suficientes %s!",
[4] = "[Sistema] �No tienes suficientes %s!",
[5] = "Reemplazaste: %s ( %d) con %s ( %d)",
[6] = "[Sistema] Para usar este comando, �deje su inventario vac�o!",
[7] = "Reemplazaste: %s ( %d) con %s ( %d)",
[8] = "�No pudimos encontrar ninguna opci�n de intercambio!",
}