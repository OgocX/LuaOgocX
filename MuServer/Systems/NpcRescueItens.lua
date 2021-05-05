--[[
System
]]--
NpcRescueItem = {}

NpcRescueItemPlayers = {}

function NpcRescueItem.NpcTalk(NpcIndex, PlayerIndex)
	local npc = User.new(NpcIndex)
	local player = User.new(PlayerIndex)
	
	if (npc:getClass() == NPC_RESCUE_MONSTER_ID)
	then
		NpcRescueItem.Open(player, npc)
	end
	
	npc = nil
	player = nil
end

function NpcRescueItem.InsertItem(Account, Item, Itemlevel, iOp1, iOp2, iOp3, iExc, iAncient, iJoH, iSockCount, iSock1, iSock2, iSock3, iSock4, iSock5, DaysExpire)
	local query = string.format("INSERT INTO [dbo].[NPC_RESCUE_ITENS] ([Account],[ItemIndex],[Level],[Option1],[Option2],[Option3],[Exc],[Ancient],[JoH],[SockBonus],[Sock1],[Sock2],[Sock3],[Sock4],[Sock5],[Delivered],[TimeExpire]) VALUES ('%s',%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,0,DATEADD(day,%d,GETDATE()))", Account, Item, Itemlevel, iOp1, iOp2, iOp3, iExc, iAncient, iJoH, iSockCount, iSock1, iSock2, iSock3, iSock4, iSock5, DaysExpire)
	
	if db:exec(query) == 0
	then
		LogAddC(2,string.format("Query Error: %s", query))
		db:clear()
		return
	end
	
	if db:fetch() == SQL_NO_DATA
	then
		LogAddC(2,string.format("Query Error: %s", query))
		db:clear()
		return
	end
	
	db:clear()
end

function NpcRescueItem.Open(player, npc)
	local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end
	
	if NpcRescueItemPlayers[player:getIndex()] ~= nil
	then
		local lastTime = math.floor((GetTick() - NpcRescueItemPlayers[player:getIndex()]) / 1000) 
		
		if lastTime <= 5
		then
			SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][2]), player:getIndex(), 1)
			ChatTargetSend(npc:getIndex(), string.format(NPC_RESCUE_MESSAGES[Language][3]), player:getIndex())
			return
		end
	end
	
	local db = DataBase.getDb()
	local Query = string.format("SELECT * FROM NPC_RESCUE_ITENS WHERE account='%s' and Delivered=0 and TimeExpire >= GETDATE()", player:getAccountID())
	local ret = db:exec(Query)
	
	if ret == 0
	then
		LogAddC(2,string.format("Query Error: %s", Query))
		db:clear()
		return
	end
	
	local count = 0
	
	local ItensList = {}
	
	while count do
		nFecth = db:fetch()
		
		if nFecth == SQL_NO_DATA
		then
			break
		end
		
		if count >= 31
		then
			break
		end
		
		local getItemID = db:getInt('ID')
		local getItemIndex = db:getInt('ItemIndex')
		local getLevel = db:getInt('Level')
		local getOp1 = db:getInt('Option1')
		local getOp2 = db:getInt('Option2')
		local getOp3 = db:getInt('Option3')
		local getExc = db:getInt('Exc')
		local getAncient = db:getInt('Ancient')
		local getJoH = db:getInt('JoH')
		local getSockBonus = db:getInt('SockBonus')
		local getSock1 = db:getInt('Sock1')
		local getSock2 = db:getInt('Sock2')
		local getSock3 = db:getInt('Sock3')
		local getSock4 = db:getInt('Sock4')
		local getSock5 = db:getInt('Sock5')
		local getTimeExpire = db:getStr('TimeExpire')
		
		ItensList[count] = { ItemID = getItemID, ItemIndex = getItemIndex, Level = getLevel
		, Op1 = getOp1, Op2 = getOp2, Op3 = getOp3
		, Exc = getExc, Ancient = getAncient, JoH = getJoH
		, SockBonus = getSockBonus, Sock1 = getSock1, Sock2 = getSock2
		, Sock3 = getSock3, Sock4 = getSock4, Sock5 = getSock5
		, TimeExpire = getTimeExpire }
		
		count = count + 1
	end
	
	db:clear()
	
	local packetIdentification = string.format('%s-%s', NPC_RESCUE_PACKET_NAME_GET, player:getName())
	
	CreatePacket(packetIdentification, NPC_RESCUE_PACKET)
	
	SetDwordPacket(packetIdentification, count)
	
	for i = 0, count do
		if ItensList[i] ~= nil
		then
			SetDwordPacket(packetIdentification, ItensList[i].ItemID)
			SetWordPacket(packetIdentification, ItensList[i].ItemIndex)
			SetBytePacket(packetIdentification, ItensList[i].Level)
			SetBytePacket(packetIdentification, ItensList[i].Op1)
			SetBytePacket(packetIdentification, ItensList[i].Op2)
			SetBytePacket(packetIdentification, ItensList[i].Op3)
			SetBytePacket(packetIdentification, ItensList[i].Exc)
			SetBytePacket(packetIdentification, ItensList[i].Ancient)
			SetBytePacket(packetIdentification, ItensList[i].JoH)
			SetBytePacket(packetIdentification, ItensList[i].SockBonus)
			SetBytePacket(packetIdentification, ItensList[i].Sock1)
			SetBytePacket(packetIdentification, ItensList[i].Sock2)
			SetBytePacket(packetIdentification, ItensList[i].Sock3)
			SetBytePacket(packetIdentification, ItensList[i].Sock4)
			SetBytePacket(packetIdentification, ItensList[i].Sock5)
			SetCharPacketLength(packetIdentification, ItensList[i].TimeExpire, 16)
		end
	end
	
	SendPacket(packetIdentification, player:getIndex())
	
	ClearPacket(packetIdentification)
	
	NpcRescueItemPlayers[player:getIndex()] = GetTick()
end

function NpcRescueItem.GetItem(aIndex, PacketName)
	local player = User.new(aIndex)
	
	local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end
	
	if NpcRescueItemPlayers[player:getIndex()] ~= nil
	then
		local lastTime = math.floor((GetTick() - NpcRescueItemPlayers[player:getIndex()]) / 1000) 
		
		if lastTime <= 2
		then
			return
		end
	end
	
	local ItemID = GetDwordPacket(PacketName, -1)
	
	local db = DataBase.getDb()
	local Query = string.format("SELECT * FROM NPC_RESCUE_ITENS WHERE account='%s' and Delivered=0 and ID='%d' and TimeExpire >= GETDATE()", player:getAccountID(), ItemID)
	local ret = db:exec(Query)
	
	if ret == 0
	then
		SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][4]), player:getIndex(), 1)
		db:clear()
		return
	end
	
	if db:fetch() == SQL_NO_DATA
	then
		SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][4]), player:getIndex(), 1)
		db:clear()
		return
	end
	
	local getItemID = db:getInt('ID')
	local getItemIndex = db:getInt('ItemIndex')
	local getLevel = db:getInt('Level')
	local getOp1 = db:getInt('Option1')
	local getOp2 = db:getInt('Option2')
	local getOp3 = db:getInt('Option3')
	local getExc = db:getInt('Exc')
	local getAncient = db:getInt('Ancient')
	local getJoH = db:getInt('JoH')
	local getSockBonus = db:getInt('SockBonus')
	local getSock1 = db:getInt('Sock1')
	local getSock2 = db:getInt('Sock2')
	local getSock3 = db:getInt('Sock3')
	local getSock4 = db:getInt('Sock4')
	local getSock5 = db:getInt('Sock5')
	
	db:clear()
	
	if InventoryCheckSpaceByItem(player:getIndex(), getItemIndex) == 0
	then
		SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][5]), player:getIndex(), 1)
		return
	end
	
	local db = DataBase.getDb()
	local Query = string.format("UPDATE NPC_RESCUE_ITENS SET Delivered=1,TimeDelivered=GetDate() WHERE account='%s' and ID='%d'", player:getAccountID(), ItemID)
	local ret = db:exec(Query)
	
	if ret == 0
	then
		SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][6]), player:getIndex(), 1)
		db:clear()
		return
	end
	
	if db:fetch() == SQL_NO_DATA
	then
		SendMessage(string.format(NPC_RESCUE_MESSAGES[Language][6]), player:getIndex(), 1)
		db:clear()
		return
	end
	
	db:clear()
	
	NpcRescueItemPlayers[player:getIndex()] = GetTick()
	
	CreateItemInventory(player:getIndex(), getItemIndex, getLevel, getOp1, getOp2, getOp3, getExc, getAncient, getJoH, getSockBonus, getSock1, getSock2, getSock3, getSock4, getSock5, 0)
	
	ClearPacket(PacketName)
	
	local packetIdentification = string.format('%s-%s', NPC_RESCUE_PACKET_GET_ITEM_RECV, player:getName())
	
	CreatePacket(packetIdentification, NPC_RESCUE_PACKET)
	
	SetDwordPacket(packetIdentification, getItemID)
	
	SendPacket(packetIdentification, player:getIndex())
	
	ClearPacket(packetIdentification)
	
	player = nil
end

function NpcRescueItem.Protocol(aIndex, Packet, PacketName)
	if Packet == NPC_RESCUE_PACKET
	then
		local player = User.new(aIndex)
		
		if string.format('%s-%s', NPC_RESCUE_PACKET_GET_ITEM_RECV, player:getName()) == PacketName
		then
			NpcRescueItem.GetItem(aIndex, PacketName)
		end
	end
end

function NpcRescueItem.RunSQL()
	local query = string.format("IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NPC_RESCUE_ITENS]') AND type in (N'U')) BEGIN CREATE TABLE [dbo].[NPC_RESCUE_ITENS] ([ID] [int] IDENTITY(1,1) NOT NULL,[Account] [varchar](10) NOT NULL,[ItemIndex] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_ItemIndex]  DEFAULT ((0)),[Level] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Level]  DEFAULT ((0)),[Option1] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Option1]  DEFAULT ((0)),[Option2] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Option2]  DEFAULT ((0)),[Option3] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Option3]  DEFAULT ((0)),[Exc] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Exc]  DEFAULT ((0)),[Ancient] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Ancient]  DEFAULT ((0)),[JoH] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_JoH]  DEFAULT ((0)),[SockBonus] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_SockBonus]  DEFAULT ((0)),[Sock1] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Sock1]  DEFAULT ((0)),[Sock2] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Sock2]  DEFAULT ((0)),[Sock3] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Sock3]  DEFAULT ((0)),[Sock4] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Sock4]  DEFAULT ((0)),[Sock5] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Sock5]  DEFAULT ((0)), [Delivered] [int] NOT NULL CONSTRAINT [DF_NPC_RESCUE_ITENS_Delivered]  DEFAULT ((0)), [TimeExpire] [datetime] NOT NULL, [TimeDelivered] [datetime] NULL ) ON [PRIMARY] END")
	
	db = DataBase.getDb()
	db:exec(query)
	
	db:clear()
end

function NpcRescueItem.Init()
	if NPC_RESCUE_ITEM_SWITCH == 0
	then
		return
	end
	
	GameServerFunctions.NpcTalk(NpcRescueItem.NpcTalk)
	GameServerFunctions.GameServerProtocol(NpcRescueItem.Protocol)
	
	Timer.TimeOut(5, NpcRescueItem.RunSQL)
end

NpcRescueItem.Init()

return NpcRescueItem