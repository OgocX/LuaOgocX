-- true Ativa o sistema, false Desativa
JewelBank_Ativado = true

-- Numero do Packet usado no sistema (não pode ser igual ao de nenhum outro sistema
JewelBank_Packet = 0x01

-- Tabela onde fica registrado as informações
JewelBank_Table = "MEMB_INFO"

--Where da conta onde fica as informações
JewelBank_Where = "memb___id"

-- ListID (tem que ser o mesmo da configuração no cliente)(tem que começar no 1 e não pode pular)
-- Index da jóia unitaria
-- Index do bundle da jóia
-- Nome da jóia
-- Coluna do saldo da joia na MEMB_INFO
JewelBank_Jewels = {
[1]	= 	{Index = 6159,	BundleIndex = 6285,	Nome = "Jewel of Chaos",		Coluna = "ChaosPoints"},
[2]	= 	{Index = 7181,	BundleIndex = 6174,	Nome = "Jewel of Bless",		Coluna = "BlessPoints"},
[3]	= 	{Index = 7182,	BundleIndex = 6175,	Nome = "Jewel of Soul",			Coluna = "SoulPoints"},
[4]	= 	{Index = 7184,	BundleIndex = 6280,	Nome = "Jewel of Life",			Coluna = "LifePoints"},
[5]	= 	{Index = 7190,	BundleIndex = 6281,	Nome = "Jewel of Creation",		Coluna = "CreationPoints"},
[6]	= 	{Index = 7199,	BundleIndex = 6282,	Nome = "Jewel of Guardian",		Coluna = "GuardianPoints"},
[7]	= 	{Index = 7209,	BundleIndex = 6283,	Nome = "Gemstone",				Coluna = "GemstonePoints"},
[8]	= 	{Index = 7210,	BundleIndex = 6284,	Nome = "Jewel of Harmony",		Coluna = "HarmonyPoints"},
[9]	= 	{Index = 7211,	BundleIndex = 6286,	Nome = "Lower Refining Stone",	Coluna = "LRefiningPoints"},
[10] =	{Index = 7212,	BundleIndex = 6287,	Nome = "Higher Refining Stone",	Coluna = "HRefiningPoints"},
}

-- Valor unitario correspondente a cada level de um bundle
JewelBank_BundleValue = {[0] = 10 ,[1] = 20 ,[2] = 30 ,[3] = 40 ,[4] = 50 ,[5] = 60 ,[6] = 70 ,[7] = 80 ,[8] = 90 ,[9] = 100,[10] = 110,[11] = 120,[12] = 130,[13] = 140,[14] = 150,[15] = 160}

-- Level do item correspondente ao botão escolhido na interface
JewelBank_ButtonToLevel = {[3] = 0 ,[4] = 1 ,[5] = 2 ,[6] = 3 ,[7] = 4 ,[8] = 5 ,[9] = 6 ,[10] = 7 ,[11] = 8 ,[12] = 9,[13] = 10,[14] = 11,[15] = 12,[16] = 13,[17] = 14}

JewelBank_Messages = { }

JewelBank_Messages["Por"] = {
[1] = "Saldo de %s insuficiente",
[2] = "Não há espaço no inventário",
}

JewelBank_Messages["Eng"] = {
[1] = "Insufficient %s balance",
[2] = "There is no space in the inventory",
}

JewelBank_Messages["Spn"] = {
[1] = "Saldo de %s insuficiente",
[2] = "No hay espacio en el inventario",
}

-- INÍCIO DO CÓDIGO, SÓ MEXA SE SOUBER O QUE ESTÁ FAZENDO --
JewelBank = {}

function JewelBank.CreateColumns()
	for i in ipairs(JewelBank_Jewels) do
		DataBase.CreateColumn(JewelBank_Table, JewelBank_Jewels[i].Coluna, "INT NOT NULL DEFAULT 0")
	end
end

function JewelBank.Init()
	if not JewelBank_Ativado then return end
	
	GameServerFunctions.GameServerProtocol(JewelBank.Protocol)
	
	Timer.TimeOut(5, JewelBank.CreateColumns)
end

function JewelBank.Protocol(aIndex, Packet, PacketName)
	if Packet == JewelBank_Packet then
		local player = User.new(aIndex)
		local nome = player:getName()
		if PacketName == string.format("JBOpe_%s",nome) then
			ClearPacket(PacketName)
			local t = JewelBank.GetBalance(aIndex)
			CreatePacket(PacketName, JewelBank_Packet)
			SetBytePacket(PacketName, #t)
			for i in ipairs(t) do
				SetBytePacket(PacketName, t[i].ListID)
				SetWordPacket(PacketName, t[i].Saldo)
			end
			SendPacket(PacketName, aIndex)
			ClearPacket(PacketName)
			return true
		end
		
		if PacketName == string.format("JBDep_%s",nome) then
			local slot = GetBytePacket(PacketName, -1)		
			ClearPacket(PacketName)
			JewelBank.Deposit(aIndex, slot)
			return true
		end
		
		if PacketName == string.format("JBSac_%s",nome) then
			local listid = GetBytePacket(PacketName, -1)
			local botao = GetBytePacket(PacketName, -1)		
			JewelBank.Withdraw(aIndex, listid, botao)			
			ClearPacket(PacketName)
			return true
		end
	end
	return false
end

function JewelBank.Withdraw(aIndex, ListID, Button)
	local player =  User.new(aIndex)
	local Item = JewelBank_Jewels[ListID]
	local Level = 0
	if Button > 3 then
		Level = JewelBank_ButtonToLevel[Button]
	end
	
	local saldo = DataBase.GetValue(JewelBank_Table, Item.Coluna, JewelBank_Where, player:getAccountID())
	local valor = 0
	local Index = 0
	if Button == 2 then
		valor = 1
		Index = Item.Index
	else
		valor = JewelBank_BundleValue[Level]
		Index = Item.BundleIndex
	end
	
	local Language = player:getLanguage()
	
	if saldo < valor then
		SendMessage(string.format(JewelBank_Messages[Language][1], Item.Nome), aIndex, 1)
		return
	end
	
	if InventoryCheckSpaceByItem(aIndex, Index) == 0 then
		SendMessage(string.format(JewelBank_Messages[Language][2]), aIndex, 1)
		return
	end
	
	
	
	ItemSerialCreateComplete(aIndex, 236, 0, 0, Index, Level, 0, 0, 0, 0, aIndex, 0, 0, 0)
	DataBase.SetDecreaseValue(JewelBank_Table, Item.Coluna, valor, JewelBank_Where, player:getAccountID())
	saldo = saldo-valor
	JewelBank.SendBalance(aIndex, ListID, saldo)
	return	
end

function JewelBank.GetBalance(aIndex)
	local player =  User.new(aIndex)
	local saldo = {}
	for i in ipairs(JewelBank_Jewels) do
		local valor = DataBase.GetValue(JewelBank_Table, JewelBank_Jewels[i].Coluna, JewelBank_Where, player:getAccountID())
		table.insert(saldo, i)
		saldo[i] = {ListID = i, Saldo = valor}
	end
	return saldo
end

function JewelBank.Deposit(aIndex, Slot)
	local player =  User.new(aIndex)
	local pInv = Inventory.new(aIndex)
	
	if pInv:isItem(Slot) ~= 0 then
		local Index = pInv:getIndex(Slot)
		local Level = pInv:getLevel(Slot)
		
		local change = 0
		
		for i in ipairs(JewelBank_Jewels) do
			if Index == JewelBank_Jewels[i].Index then
				InventoryDeleteItem(aIndex, Slot)
				SendInventoryDeleteItem(aIndex, Slot)
				DataBase.SetAddValue(JewelBank_Table, JewelBank_Jewels[i].Coluna, 1, JewelBank_Where, player:getAccountID())
				change = 1
			elseif Index == JewelBank_Jewels[i].BundleIndex then
				InventoryDeleteItem(aIndex, Slot)
				SendInventoryDeleteItem(aIndex, Slot)
				DataBase.SetAddValue(JewelBank_Table, JewelBank_Jewels[i].Coluna, JewelBank_BundleValue[Level], JewelBank_Where, player:getAccountID())
				change = 1
			end
			
			if change == 1 then
				local saldo = DataBase.GetValue(JewelBank_Table, JewelBank_Jewels[i].Coluna, JewelBank_Where, player:getAccountID())
				JewelBank.SendBalance(aIndex, i, saldo)	
				break
			end
			
		end
	end
end

function JewelBank.SendBalance(aIndex, ListID, Valor)
	local player = User.new(aIndex)
	local nome = player:getName()
	CreatePacket(string.format("JBBal_%s",nome), JewelBank_Packet)
	SetBytePacket(string.format("JBBal_%s",nome), ListID)
	SetWordPacket(string.format("JBBal_%s",nome), Valor)
	SendPacket(string.format("JBBal_%s",nome), aIndex)
	ClearPacket(string.format("JBBal_%s",nome))
	return
end

JewelBank.Init()

return JewelBank