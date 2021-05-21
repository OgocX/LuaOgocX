--[[
	Configs
]]--
NPC_RESCUE_ITEM_SWITCH = 1

NPC_RESCUE_PACKET = 2
NPC_RESCUE_PACKET_NAME_GET = 'NPC_RESCUE_ITEM_GET'
NPC_RESCUE_PACKET_GET_ITEM_RECV = 'NPC_RESCUE_GET_ITEM_RECV'

--[[
	Messages
]]

NPC_RESCUE_MESSAGES = {}

NPC_RESCUE_MESSAGES['Por'] = {
[1] = 'Npc Resgate Item',
[2] = 'Disponível até:',
[3] = 'Pré vizualização do item:',
[4] = 'Lista de Itens',
[5] = 'No momento você não tem itens!',
[6] = 'Resgatar Item',
}

NPC_RESCUE_MESSAGES['Eng'] = {
[1] = 'Npc Rescue Item',
[2] = 'Available until:',
[3] = 'Item preview:',
[4] = 'List of Items',
[5] = 'You currently have no items!',
[6] = 'Redeem Item',
}

NPC_RESCUE_MESSAGES['Spn'] = {
[1] = 'Objeto de rescate de Npc',
[2] = 'Disponible hasta:',
[3] = 'Vista previa del artículo:',
[4] = 'Lista de elementos',
[5] = '¡Actualmente no tienes artículos!',
[6] = 'Canjear artículo',
}

--[[
	System
]]--
NpcRescueItem = { }

local NpcRescueItensList = {}

local NpcRescueVisible = 0

--Box item
local NpcRescueSelectedItem = 0
local NpcRescueSelectedItemPosY = 0
local NpcRescueSelectedItemClicked = 0
local NpcRescueSelectedItemClickedPosY = 0
local NpcRescueSelectedItemKey = -1
local NpcRescueItemCount = 0

--Scroll Bar
local NpcRescueScrollBarPosY = 0
local NpcRescueScrollBarPosMouse = 0
local NpcRescueScrollBarPosYMultiplier = 0
local NpcRescueScrollBarCurrentLine = 0
local NpcRescueScrollBarRenderMaxLines = 0
local NpcRescueScrollBarRenderPageMax = 0
local NpcRescueScrollMaxLine = 0
local NpcRescueScrollBarMaxLines = 8

local m_Pos = { x = 260, y = 0 }

function NpcRescueItem.RenderFrame()
    RenderImage(31322, m_Pos.x, m_Pos.y, 190.0, 429.0)
	RenderImage(31353, m_Pos.x, m_Pos.y, 190.0, 64.0)
	RenderImage(31355, m_Pos.x, m_Pos.y + 64, 21.0, 320.0)
	RenderImage(31356, m_Pos.x + 169, m_Pos.y + 64, 21.0, 320.0)
	RenderImage(31357, m_Pos.x, m_Pos.y + 384, 190.0, 45.0)

   --Buttom
    NpcRescueItem.RenderButtom(m_Pos.x + 190/2 - 85/2, m_Pos.y + 185, 100, 30)

    --Box item selected
    NpcRescueItem.RenderBox(m_Pos.x + 45, m_Pos.y + 85, 100, 80, 0)

	--Render Item selected on box
	NpcRescueItem.RenderItemSelected(m_Pos.x + 82, m_Pos.y + 85 + 25)

    --Box itens
    NpcRescueItem.RenderBox(m_Pos.x + 15, m_Pos.y + 230, 160, 160, 1)

	--Render Itens if have
	NpcRescueItem.RenderListItens(m_Pos.x + 20, m_Pos.y + 250)

    --Scroll bar
    NpcRescueItem.RenderScrollBarPage(m_Pos.x + 15, m_Pos.y + 232, 160, 160, 12)
end

function NpcRescueItem.RenderScrollBarPage(x, y, width, height, size)
	EnableAlphaTest()

	glColor4f(1.0, 1.0, 1.0, 1.0)

	RenderImage(31270, x + width - 11, y + 14, 7, 3)
	
	for i = 0, size do
		RenderImage(31271, x + width - 11, (y + 13) + (i * 10 + 4), 7, 15)
	end

	RenderImage(31272, x + width - 11, y + height - 8, 7, 3)

	if MousePosX() >= (x + width - 15) and MousePosX() <= (x + width - 15) + 15
		and MousePosY() >= y + 10 + NpcRescueScrollBarPosY and MousePosY() <= y + 10 + NpcRescueScrollBarPosY + 30
	then
		glColor4f(1.0, 1.0, 1.0, 1.0)
	else
		glColor4f(0.7, 0.7, 0.7, 1.0)
	end

	RenderImage(31273, x + width - 15, y + 10 + NpcRescueScrollBarPosY, 15, 30)
	
	glColor4f(1.0, 1.0, 1.0, 1.0)

	DisableAlphaBlend()
end

function NpcRescueItem.RenderItemSelected(x, y)
	if NpcRescueSelectedItemKey == -1
	then
		return
	end

	local item = NpcRescueItensList[NpcRescueSelectedItemKey]

	if item.ItemIndex >= GET_ITEM(0, 15) and item.ItemIndex < GET_ITEM(5, 0)
	then
		y = y + 17
	end

	if item.ItemIndex >= GET_ITEM(5, 0) and item.ItemIndex < GET_ITEM(6, 0)
	then
		y = y + 10
	end

	CreateItem(x, y, 25, 25, item.ItemIndex, item.Level, 0, 0)
end

function NpcRescueItem.RenderDescriptionItemSelected(x, y, width, height)
	if NpcRescueSelectedItemKey == -1
	then
		return
	end

	if MousePosX() > x and MousePosX() < x + width
		and MousePosY() > y and MousePosY() < y + height
	then
		local item = NpcRescueItensList[NpcRescueSelectedItemKey]
		EnableAlphaTest()

		glColor4f(1.0, 1.0, 1.0, 1.0)

		ShowDescriptionComplete(x + 35, y, item.ItemIndex, item.Level, item.Op1, item.Op2, item.Op3, item.Exc, item.Ancient, item.JoH, item.SockCount, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5)

		DisableAlphaBlend()
	end
end

function NpcRescueItem.RenderBox(x, y, width, height, title)
	EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 0.3)

	DrawBar(x, y, width, height, 0.0, 0)
	
	glColor4f(0.0, 0.0, 0.0, 0.5)

	DrawBar(x, y, width, height, 0.0, 0)

	if title == 1
	then
		glColor4f(0.3, 0.3, 0.3, 0.7)

		DrawBar(x, y-1, width+1, 15.0, 0.0, 0)
	end
	
	if NpcRescueSelectedItem ~= 0
	then
		glColor4f(0.2, 0.2, 0.2, 0.5)
		DrawBar(x, NpcRescueSelectedItemPosY - 2, width-10, 13, 0.0, 0)
	end
	
	if NpcRescueSelectedItemClicked ~= 0
	then
		glColor4f(0.2, 0.2, 0.2, 0.5)
		DrawBar(x, NpcRescueSelectedItemClickedPosY - 2, width-10, 13, 0.0, 0)
	end
	
	EndDrawBar()
	DisableAlphaBlend()
	
	EnableAlphaTest()

	RenderImage(31340, x - 4, y - 3, 14.0, 14.0)
	RenderImage(31341, x + width - 9, y - 3, 14.0, 14.0)
	RenderImage(31342, x - 4, y + height - 8, 14.0, 14.0)
	RenderImage(31343, x + width - 9, y + height - 8, 14.0, 14.0)

	for i = (x + 10), x + width - 9, 1
	do
		RenderImage(31344, i, y - 3, 1, 14);
		RenderImage(31345, i, y + height - 8, 1, 14)
	end
	
	for i = y + 11, y + height - 8, 1
	do
		RenderImage(31346, x - 4, i, 14, 1);
		RenderImage(31347, x + width - 9, i, 14, 1)
	end
	
	DisableAlphaBlend()
end

function NpcRescueItem.RenderButtom(x, y, width, height)
    EnableAlphaTest()
	
	if MousePosX() >= x and MousePosX() <= x + width and MousePosY() >= y and MousePosY() <= y + height
	then
		RenderImage2(31326, x, y, width, height, 0, 0.2264566, 1.0, 0.2245212, 1, 1, 1.0)
	else
		RenderImage2(31326, x, y, width, height, 0, 0, 1.0, 0.2245212, 1, 1, 1.0)
	end
	
	SetFontType(1)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(216, 216, 216, 255)
	
	local Text = NPC_RESCUE_MESSAGES[GetLanguage()][6]
	
	RenderText3(x, y + 10, Text, width - #Text, 3)
	
	DisableAlphaBlend()
end

function NpcRescueItem.RenderListItens(x, y)
	EnableAlphaTest()

	SetFontType(0)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(225, 225, 225, 255)
	
	local posY = 0
	local line = 0

	for key = 0, #NpcRescueItensList do
		if NpcRescueItensList[key] == nil
		then
			goto continue
		end

		if line >= NpcRescueScrollBarCurrentLine and line <= NpcRescueScrollBarRenderPageMax
		then
			local itens = NpcRescueItensList[key]
		
			local itemName = GetNameByIndex(itens.ItemIndex)

			RenderText3(x, y + posY, itemName, 155 - #itemName, 1)
			
			posY = posY + 15
		end
		
		line = line + 1

		::continue::
	end
	
	DisableAlphaBlend()
end

function NpcRescueItem.ItemListUpdate()
	NpcRescueSelectedItem = 0
	local x = m_Pos.x + 20
	local y = m_Pos.y + 250
	local posY = 0
	local line = 0

	for key = 0, #NpcRescueItensList do
		if NpcRescueItensList[key] == nil
		then
			goto continue
		end

		if line >= NpcRescueScrollBarCurrentLine and line <= NpcRescueScrollBarRenderPageMax
		then
			if MousePosX() >= x and MousePosX() <= x + 130
			then
				if MousePosY() >= (y + posY) and MousePosY() <= (y + posY) + 10
				then
					if CheckPressedKey(Keys.LButton) == 1
					then
						NpcRescueSelectedItemKey = key
						NpcRescueSelectedItemClicked = 1
						NpcRescueSelectedItemClickedPosY = (y + posY)
						DisableClickClient()
					end
					
					NpcRescueSelectedItem = 1
					NpcRescueSelectedItemPosY = (y + posY)
				end
			end
			
			posY = posY + 15
		end
		
		line = line + 1

		::continue::
	end
end

function NpcRescueItem.ScrollBarClick()
	if CheckRepeatKey(Keys.LButton) == 1
	then
		if MousePosX() >= m_Pos.x + 150 and MousePosX() <= m_Pos.x + 190
		then
			local value = MousePosY() - NpcRescueScrollBarPosMouse
			
			if value < 0
			then
				if (MousePosY() <= (m_Pos.y + 225 + NpcRescueScrollBarPosY) + 15)
				then
					NpcRescueItem.ScrollingBar(-1)
				end
			elseif value > 0
			then
				if (MousePosY() >= (m_Pos.y + 225 + NpcRescueScrollBarPosY) + 15)
				then
					NpcRescueItem.ScrollingBar(1)
				end
			end
			
			NpcRescueScrollBarPosMouse = MousePosY()
		end
	end
end

function NpcRescueItem.ScrollingBar(value)
	if value > 0
	then
		if (NpcRescueScrollBarRenderPageMax < (NpcRescueScrollBarRenderMaxLines))
		then
			NpcRescueScrollBarRenderPageMax = NpcRescueScrollBarRenderPageMax + 1
			NpcRescueScrollBarCurrentLine = NpcRescueScrollBarCurrentLine + 1
			NpcRescueScrollBarPosY = NpcRescueScrollBarPosY + NpcRescueScrollBarPosYMultiplier
		end
	elseif value < 0
	then
		if (NpcRescueScrollBarRenderPageMax > NpcRescueScrollMaxLine)
		then
			NpcRescueScrollBarRenderPageMax = NpcRescueScrollBarRenderPageMax - 1
			NpcRescueScrollBarCurrentLine = NpcRescueScrollBarCurrentLine - 1
			NpcRescueScrollBarPosY = NpcRescueScrollBarPosY - NpcRescueScrollBarPosYMultiplier
		end
	end
end

function NpcRescueItem.CalcScrollBar()
	NpcRescueScrollBarPosY = 0
	NpcRescueScrollBarPosMouse = 0
	NpcRescueScrollBarCurrentLine = 0
	NpcRescueScrollBarRenderMaxLines = NpcRescueItemCount
	NpcRescueScrollMaxLine = NpcRescueScrollBarMaxLines
	NpcRescueScrollBarPosYMultiplier = (125 / (NpcRescueItemCount - NpcRescueScrollBarMaxLines))
	NpcRescueScrollBarRenderPageMax = NpcRescueScrollBarMaxLines
end

function NpcRescueItem.RenderText()
    EnableAlphaTest()

    SetFontType(1)
	
	SetTextBg(0, 0, 0, 0)
	
	SetTextColor(216, 216, 216, 255)
	
	RenderText3(m_Pos.x, m_Pos.y + 11, NPC_RESCUE_MESSAGES[GetLanguage()][1], 190, 3)

	SetFontType(0)

	if NpcRescueSelectedItemKey ~= -1
	then
		RenderText3(m_Pos.x + 20, m_Pos.y + 50, NPC_RESCUE_MESSAGES[GetLanguage()][2], 170, 1)
		SetFontType(1)
		RenderText3(m_Pos.x + 150, m_Pos.y + 50, string.format('%s', NpcRescueItensList[NpcRescueSelectedItemKey].TimeExpire), 150, 7)
		SetFontType(0)
	end

	RenderText3(m_Pos.x, m_Pos.y + 70, NPC_RESCUE_MESSAGES[GetLanguage()][3], 190, 3)

	SetFontType(1)

	RenderText3(m_Pos.x + 20, m_Pos.y + 232, NPC_RESCUE_MESSAGES[GetLanguage()][4], 160, 1)

    if NpcRescueItemCount <= 0
    then
        SetTextBg(0, 0, 0, 0)
        SetTextColor(255, 255, 255, 255)
        RenderText3(m_Pos.x + 20, m_Pos.y + 255, NPC_RESCUE_MESSAGES[GetLanguage()][5], 170, 1)
    end

    DisableAlphaBlend()
end

function NpcRescueItem.BeforeInterface()
	if NpcRescueVisible == 0
    then
        return
    end

    EnableAlphaTest()

    NpcRescueItem.RenderFrame()

    NpcRescueItem.RenderText()

	--Render Description Item selected if mouse on
	NpcRescueItem.RenderDescriptionItemSelected(m_Pos.x + 60, m_Pos.y + 85, 75, 75)

    DisableAlphaBlend()
end

function NpcRescueItem.UpdateProc()
	if NpcRescueVisible == 0
    then
        return
    end

	if CheckWindowOpen(UIExpandInventory) == 1
	then
		m_Pos.x = 70
	else
		m_Pos.x = 260
	end

	if MousePosX() >= m_Pos.x + (190/2 - 85/2) and MousePosX() <= m_Pos.x + (190/2 - 85/2) + 80 and MousePosY() >= m_Pos.y + m_Pos.y + 185 and MousePosY() <= m_Pos.y + m_Pos.y + 185 + 32
	then
		if CheckPressedKey(Keys.LButton) == 1
		then
			if NpcRescueSelectedItemKey ~= -1
			then
				NpcRescueItem.SendGetItem(NpcRescueItensList[NpcRescueSelectedItemKey].ID)
			end

			DisableClickClient()
		end
	end

	NpcRescueItem.ItemListUpdate()
end

function NpcRescueItem.UpdateMouse()
	if NpcRescueVisible == 0
    then
        return
    end

	NpcRescueItem.ScrollBarClick()

	if MousePosX() >= m_Pos.x and MousePosX() <= m_Pos.x + 190
	then
		if MousePosY() >= m_Pos.y + 0 and MousePosY() <= m_Pos.y + 430
		then
			if (CheckClickClient() == 1)
			then
				DisableClickClient()
			end
		end
	end
end

function NpcRescueItem.ScrollMouse(value)
    if NpcRescueVisible == 0
    then
        return
    end

	if MousePosX() >= m_Pos.x and MousePosX() <= m_Pos.x + 190
	then
		if MousePosY() >= m_Pos.y + 220 and MousePosY() <= m_Pos.y + 400
		then
			if value > 0
			then
				NpcRescueItem.ScrollingBar(-1)
			end
			
			if value < 0
			then
				NpcRescueItem.ScrollingBar(1)
			end
		end
	end
end

function NpcRescueItem.InsertItem(ItemId, Item, Itemlevel, iOp1, iOp2, iOp3, iExc, iAncient, iJoH, iSockCount, iSock1, iSock2, iSock3, iSock4, iSock5, iTimeExpire)

	for i = 0, 32 do
		if NpcRescueItensList[i] == nil
		then
			NpcRescueItensList[i] = { ID = ItemId, ItemIndex = Item, Level = Itemlevel, Op1 = iOp1, Op2 = iOp2, Op3 = iOp3, Exc = iExc
			, Ancient = iAncient, JoH = iJoH, SockCount = iSockCount, Sock1 = iSock1, Sock2 = iSock2, Sock3 = iSock3, Sock4 = iSock4, Sock5 = iSock5, TimeExpire = iTimeExpire }
			return
		end
	end
end

function NpcRescueItem.DeleteItem(ItemId)
	for i = 0, 32 do
		if NpcRescueItensList[i] ~= nil
		then
			if NpcRescueItensList[i].ID == ItemId
			then
				NpcRescueItensList[i] = nil
				NpcRescueItemCount = NpcRescueItemCount -1
				NpcRescueSelectedItemKey = -1
				NpcRescueSelectedItem = 0
				NpcRescueSelectedItemClicked = 0
				NpcRescueSelectedItemPosY = 0

				NpcRescueItem.CalcScrollBar()
				return
			end
		end
	end
end

function NpcRescueItem.CloseInterface()
	if	CheckWindowOpen(UIParty)			== 1	then	CloseWindow(UIParty)			end
	if	CheckWindowOpen(UIGuild)			== 1	then	CloseWindow(UIGuild)			end
	if	CheckWindowOpen(UIStore)			== 1	then	CloseWindow(UIStore)			end
	if	CheckWindowOpen(UICharacter)		== 1	then	CloseWindow(UICharacter)		end
	if	CheckWindowOpen(UIGensInfo)			== 1	then	CloseWindow(UIGensInfo)			end
	if	CheckWindowOpen(UIExpandInventory)	== 1	then	CloseWindow(UIExpandInventory)	end
	if	CheckWindowOpen(UIMuHelper)			== 1	then	CloseWindow(UIMuHelper)			end
	if	CheckWindowOpen(UIMoveList)			== 1	then	CloseWindow(UIMoveList)			end
end

function NpcRescueItem.Open(packet)
	NpcRescueItensList = nil
	NpcRescueItensList = {}

	local count = GetDwordPacket(packet, -1)

	if count > 0
	then
		for i = 0, (count-1) do
			ItemID = GetDwordPacket(packet, -1)
			ItemIndex = GetWordPacket(packet, -1)
			Level = GetBytePacket(packet, -1)
			Op1 = GetBytePacket(packet, -1)
			Op2 = GetBytePacket(packet, -1)
			Op3 = GetBytePacket(packet, -1)
			Exc = GetBytePacket(packet, -1)
			Ancient = GetBytePacket(packet, -1)
			JoH = GetBytePacket(packet, -1)
			SockBonus = GetBytePacket(packet, -1)
			Sock1 = GetBytePacket(packet, -1)
			Sock2 = GetBytePacket(packet, -1)
			Sock3 = GetBytePacket(packet, -1)
			Sock4 = GetBytePacket(packet, -1)
			Sock5 = GetBytePacket(packet, -1)
			TimeExpire = GetCharPacketLength(packet, -1, 16)

			NpcRescueItem.InsertItem(ItemID, ItemIndex, Level, Op1, Op2, Op3, Exc, Ancient, JoH, SockBonus, Sock1, Sock2, Sock3, Sock4, Sock5, TimeExpire)
		end
	end

	NpcRescueItem.CloseInterface()

	NpcRescueItemCount = count
	NpcRescueSelectedItemKey = -1
	NpcRescueSelectedItem = 0
	NpcRescueVisible = 1

	NpcRescueItem.CalcScrollBar()

	SetLockInterfaces()

	OpenWindow(UIInventory)
end

function NpcRescueItem.Close()
	SetUnlockInterfaces()
	NpcRescueVisible = 0
	NpcRescueItensList = nil
	NpcRescueItensList = {}
end

function NpcRescueItem.UpdateKey()
	if NpcRescueVisible == 0
    then
        return
    end

	if (CheckPressedKey(Keys.Escape) == 1) 
		or CheckWindowOpen(UIInventory) == 0 
		or CheckWindowOpen(UIStore) == 1
		or CheckWindowOpen(UIFriendList) == 1
		or CheckWindowOpen(UIMoveList) == 1
		or CheckWindowOpen(UIParty) == 1
		or CheckWindowOpen(UIQuest) == 1
		or CheckWindowOpen(UIGuild) == 1
		or CheckWindowOpen(UITrade) == 1
		or CheckWindowOpen(UIWarehouse) == 1
		or CheckWindowOpen(UIChaosBox) == 1
		or CheckWindowOpen(UICommandWindow) == 1
		or CheckWindowOpen(UIPetInfo) == 1
		or CheckWindowOpen(UIShop) == 1
		or CheckWindowOpen(UIOtherStore) == 1
		or CheckWindowOpen(UICharacter) == 1
		or CheckWindowOpen(UIFastMenu) == 1
		or CheckWindowOpen(UIOptions) == 1
		or CheckWindowOpen(UIFastDial) == 1
		or CheckWindowOpen(UISkillTree) == 1
		or CheckWindowOpen(UINPC_Titus) == 1
		or CheckWindowOpen(UICashShop) == 1
		or CheckWindowOpen(UIFullMap) == 1
		or CheckWindowOpen(UINPC_Dialog) == 1
		or CheckWindowOpen(UIGensInfo) == 1
		or CheckWindowOpen(UINPC_Julia) == 1
		or CheckWindowOpen(UIExpandWarehouse) == 1
		or CheckWindowOpen(UIMuHelper) == 1
	then
		NpcRescueItem.Close()
	end
end

function NpcRescueItem.SendGetItem(ItemID)
	if NpcRescueVisible == 0
    then
        return
    end

	local packetIdentification = string.format('%s-%s', NPC_RESCUE_PACKET_GET_ITEM_RECV, UserGetName())

	CreatePacket(packetIdentification, NPC_RESCUE_PACKET)
	
	SetDwordPacket(packetIdentification, ItemID)
	
	SendPacket(packetIdentification)
	
	ClearPacket(packetIdentification)
end

function NpcRescueItem.ClientProtocol(Packet, PacketName)
	if Packet == NPC_RESCUE_PACKET
	then
		if string.format('%s-%s', NPC_RESCUE_PACKET_NAME_GET, UserGetName()) == PacketName
		then
			NpcRescueItem.Open(PacketName)
			ClearPacket(PacketName)
			return
		end

		if string.format('%s-%s', NPC_RESCUE_PACKET_GET_ITEM_RECV, UserGetName()) == PacketName
		then
			NpcRescueItem.DeleteItem(GetDwordPacket(PacketName, -1))
			ClearPacket(PacketName)
			return
		end
	end
end

function NpcRescueItem.Init()
	if NPC_RESCUE_ITEM_SWITCH == 0
    then
        return
    end

	NpcRescueItensList = nil
	NpcRescueItensList = {}

	NpcRescueItem.CalcScrollBar()

    InterfaceController.BeforeMainProc(NpcRescueItem.BeforeInterface)
    InterfaceController.ScrollMouse(NpcRescueItem.ScrollMouse)
    InterfaceController.UpdateMouse(NpcRescueItem.UpdateMouse)
    InterfaceController.UpdateProc(NpcRescueItem.UpdateProc)
	InterfaceController.UpdateKey(NpcRescueItem.UpdateKey)
	InterfaceController.ClientProtocol(NpcRescueItem.ClientProtocol)
end

NpcRescueItem.Init()

return NpcRescueItem