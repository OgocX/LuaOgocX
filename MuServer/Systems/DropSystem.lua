--[[Drop System By OgocX]]--

DropSystem = {}

--Configuração sistema de drop
CONFIG_DROP_SWITCH = 0

--Nome do Item (aparece no global)
--Seção do item kor
--Index do item kor
--Level do item (-1 qualquer level)
--Anunciar no global (Anunciar o que foi dropado)
CONFIG_DROP_SYSTEM = { {_Name = "Box Teste", _Section = 14, _Index = 11, _Level = -1, _AnnounceGlobal = 1, ItemInventory = 1} }

--Nome deixe o mesmo do DROP_SYSTEM para o sistema identificar tem que está identico.
--Seção do item kor
--Index do item kor
--Level
--Luck
--Skill
--Opt
--Exc 1
--Exc 2
--Exc 3
--Exc 4
--Exc 5
--Exc 6
--Count - se colocar 5 vai dropar 5 itens caso for este o item sorteado.
CONFIG_DROP_SYSTEM_ITEM = { {_Name = "Box Teste", _ItemName = "Teste1", _Section = 0, _Index = 15, _Level = 15, _Luck = 1, _Skill = 1, _Opt = 7, _Exc_1 = 1, _Exc_2 = 1, _Exc_3 = 1, _Exc_4 = 1, _Exc_5 = 1, _Exc_6 = 1, _Count = 1},
{_Name = "Box Teste", _ItemName = "Teste1", _Section = 0, _Index = 15, _Level = 15, _Luck = 1, _Skill = 1, _Opt = 7, _Exc_1 = 1, _Exc_2 = 1, _Exc_3 = 1, _Exc_4 = 1, _Exc_5 = 1, _Exc_6 = 1, _Count = 1},
{_Name = "Box Teste", _ItemName = "Teste2", _Section = 0, _Index = 15, _Level = 15, _Luck = 1, _Skill = 1, _Opt = 7, _Exc_1 = 1, _Exc_2 = 1, _Exc_3 = 1, _Exc_4 = 1, _Exc_5 = 1, _Exc_6 = 1, _Count = 1},
{_Name = "Box Teste", _ItemName = "Teste3", _Section = 0, _Index = 15, _Level = 15, _Luck = 1, _Skill = 1, _Opt = 7, _Exc_1 = 1, _Exc_2 = 1, _Exc_3 = 1, _Exc_4 = 1, _Exc_5 = 1, _Exc_6 = 1, _Count = 1},
{_Name = "Box Teste", _ItemName = "Teste4", _Section = 0, _Index = 15, _Level = 15, _Luck = 1, _Skill = 1, _Opt = 7, _Exc_1 = 1, _Exc_2 = 1, _Exc_3 = 1, _Exc_4 = 1, _Exc_5 = 1, _Exc_6 = 1, _Count = 1} }

local DROP_SYSTEM_MESSAGES = { }

DROP_SYSTEM_MESSAGES["Por"] = {
[1] = "[Sistema] Houve um problema ao dropar o item, contate o administrador.",
[2] = "Seu inventário precisa estar vázio,[%s] no primeiro quadrado!",
[3] = "[%s] %s dropou %s",
}

DROP_SYSTEM_MESSAGES["Eng"] = {
[1] = "[System] There was a problem dropping the item, please contact the administrator.",
[2] = "Your inventory must be empty, [%s] in the first square!",
[3] = "[%s] %s dropped %s",
}

DROP_SYSTEM_MESSAGES["Spn"] = {
[1] = "[Sistema] Hubo un problema al soltar el elemento, comuníquese con el administrador.",
[2] = "¡Tu inventario debe estar vacío, [%s] en el primer cuadro!",
[3] = "[%s] %s cayó %s",
}

--Não mexer nisso
local DROP_ITEM_RAND = {}

function DropSystem.InsertItem(item)
	if CONFIG_DROP_SWITCH == 0
	then
		return
	end

	InsertKey(DROP_ITEM_RAND, item)
end

function DropSystem.GetItemRandom(name)
	if CONFIG_DROP_SWITCH == 0
	then
		return
	end

	DROP_ITEM_RAND = {}
	
	for i in ipairs(CONFIG_DROP_SYSTEM_ITEM) do
		if string.lower(CONFIG_DROP_SYSTEM_ITEM[i]._Name) == string.lower(name)
		then
			DropSystem.InsertItem(CONFIG_DROP_SYSTEM_ITEM[i])
		end
	end
	
	if #DROP_ITEM_RAND > 0
	then
		return DROP_ITEM_RAND[GetRand(1, #DROP_ITEM_RAND)]
	end
	
	return -1
end

function DropSystem.PlayerDropItem(aIndex, x, y, position)
	if CONFIG_DROP_SWITCH == 0
	then
		return
	end

	local pInv = Inventory.new(aIndex)
	local item_index = pInv:getIndex(position)
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	for i in ipairs(CONFIG_DROP_SYSTEM) do
		if item_index == GET_ITEM(CONFIG_DROP_SYSTEM[i]._Section, CONFIG_DROP_SYSTEM[i]._Index)
		then
			if (CONFIG_DROP_SYSTEM[i]._Level == -1 or pInv:getLevel(position) == CONFIG_DROP_SYSTEM[i]._Level)
			then
				local Item = DropSystem.GetItemRandom(CONFIG_DROP_SYSTEM[i]._Name)
				
				if Item == -1
				then
					SendMessage(string.format(DROP_SYSTEM_MESSAGES[Language][1]), aIndex, 1)
					return 1
				end
				
				if CONFIG_DROP_SYSTEM[i].ItemInventory == 1
				then
					for i = 13, MAX_INVENTORY_RANGE do
						if pInv:isItem(i) ~= 0
						then
							SendMessage(string.format(DROP_SYSTEM_MESSAGES[Language][2], Item._Name), aIndex, 1)
							return 1
						end
					end
				end
				
				local exc = 0
				
				if Item._Exc_1 ~= 0
				then
					exc = exc + 1
				end
				if Item._Exc_2 ~= 0
				then
					exc = exc + 2
				end
				if Item._Exc_3 ~= 0
				then
					exc = exc + 4
				end
				if Item._Exc_4 ~= 0
				then
					exc = exc + 8
				end
				if Item._Exc_5 ~= 0
				then
					exc = exc + 16
				end
				if Item._Exc_6 ~= 0
				then
					exc = exc + 32
				end
				
				for forcount = 1, Item._Count do
					if CONFIG_DROP_SYSTEM[i].ItemInventory == 1
					then
						ItemSerialCreate(aIndex, 236, 0, 0, GET_ITEM(Item._Section, Item._Index), Item._Level, 255, Item._Luck, Item._Skill, Item._Opt, exc)
					else
						ItemSerialCreate(aIndex,player:getMapNumber(), x, y, GET_ITEM(Item._Section, Item._Index), Item._Level, 255, Item._Luck, Item._Skill, Item._Opt, exc)
					end
				end
				
				if CONFIG_DROP_SYSTEM[i]._AnnounceGlobal == 1
				then
					SendMessageGlobal(string.format(DROP_SYSTEM_MESSAGES[Language][3], CONFIG_DROP_SYSTEM[i]._Name, player:getName(), Item._ItemName), 0)
				end
				
				InventoryDeleteItem(aIndex, position)
				SendInventoryDeleteItem(aIndex, position)
				
				
				return 1
			end
		end
	end
	
	
	
	return
end

GameServerFunctions.PlayerDropItem(DropSystem.PlayerDropItem)

return DropSystem