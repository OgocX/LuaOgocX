STORE_SEARCH_ITEM_LIST_PACKET_NAME = 'StoreSearchGetItemList'
STORE_SEARCH_ITEM_BUY_PACKET_NAME = 'StoreSearchBuyItem'

STORE_SEARCH_ITEM_LIST_MESSAGES = {}

STORE_SEARCH_ITEM_LIST_MESSAGES['Por'] = {
[1] = 'Lista de itens da loja',
[2] = 'Nome do item',
[3] = 'Preço',
[4] = '[VEJA O VALOR]',
[5] = 'Valor do item:',
[6] = 'Zen: %d',
[7] = 'WCoinC: %d',
[8] = 'WCoinP: %d',
[9] = 'GlobinPoint: %d',
[10] = 'Cash: %d',
[11] = 'Confirmar compra',
[12] = 'Tem certeza que quer comprar:',
}

STORE_SEARCH_ITEM_LIST_MESSAGES['Eng'] = {
[1] = 'List of store items',
[2] = 'Item name',
[3] = 'Price',
[4] = '[VIEW THE VALUE]',
[5] = 'Item Value:',
[6] = 'Zen: %d',
[7] = 'WCoinC: %d',
[8] = 'WCoinP: %d',
[9] = 'GlobinPoint: %d',
[10] = 'Cash: %d',
[11] = 'Confirm purchase',
[12] = 'Are you sure you want to buy:',
}

STORE_SEARCH_ITEM_LIST_MESSAGES['Spn'] = {
[1] = 'Lista de artículos de la tienda',
[2] = 'Nombre del artículo',
[3] = 'Precio',
[4] = '[VER EL VALOR]',
[5] = 'Valor del artículo:',
[6] = 'Zen:% d',
[7] = 'WCoinC:% d',
[8] = 'WCoinP:% d',
[9] = 'GlobinPoint:% d',
[10] = 'Efectivo:% d',
[11] = 'Confirmar compra',
[12] = '¿Está seguro de que desea comprar?',
}

StoreSearchItemList = {}


local m_PosX = (640 / 2) - (335 / 2) - 45
local m_PosY = 60

local m_PX = 0
local m_PY = 0
local StoreSearchItemListMoveClickRepeat = 0
local StoreSerachItemListMoveClicked = 0

local StoreSearchItemListScrollBarPosY = 0
local StoreSearchItemListScrollBarPosMouse = 0
local StoreSearchItemListScrollBarPosYMultiplier = 0
local StoreSearchItemListScrollBarCurrentLine = 0
local StoreSearchItemListScrollBarRenderMaxLines = 0
local StoreSearchItemListScrollMaxLine = 0
local StoreSearchItemListScrollBarRenderPageMax = 0

local StoreSelectedInfo = nil
local StoreSearchItems = {}

local StoreBuyItemBoxOpened = 0
local StoreBuyItemSlot = 0
local StoreBuyItemIdentification = 0
local StoreBuyItemName = ''

function StoreSearchItemList.RenderWindow()
    if StoreSearchItemListOpen == 0
    then
        return
    end

    EnableAlphaTest()

    glColor4f(1.0, 1.0, 1.0, 1.0)

    StoreSearchItemList.RenderFrame()

    StoreSearchItemList.RenderText()

    if StoreBuyItemBoxOpened == 1
    then
        StoreSearchItemList.RenderItemBuyBox()
    end

    DisableAlphaBlend()
end

function StoreSearchItemList.RenderFrame()
    local PosX = m_PosX
    local PosY = m_PosY

    --Render Window
    RenderImage(31322, PosX, PosY + 2.0, 167.0, 330.0)
    RenderImage(31322, PosX + 167.0, PosY + 2.0, 167.0, 330.0)

    RenderImage2(31353, PosX, PosY, 85, 42, 0.0, 0.0, 0.5, 1.0, 1, 1, 1.0)
    RenderImage2(31353, PosX+85, PosY, 165, 42, 0.242465867, 0.0, 0.242465867, 1.0, 1, 1, 1.0)	
    RenderImage2(31353, PosX+250, PosY, 85, 42, 0.242465867, 0.0, 0.5, 1.0, 1, 1, 1.0)

    RenderImage(31355, PosX, PosY+41, 18, 262)
    RenderImage(31356, PosX+314, PosY+41, 21, 262)

    RenderImage2(31357, PosX, PosY+302, 85, 42, 0.0, 0.0, 0.5, 1.0, 1, 1, 1.0)
    RenderImage2(31357, PosX+85, PosY+302, 165, 42, 0.242465867, 0.0, 0.242465867, 1.0, 1, 1, 1.0)	
    RenderImage2(31357, PosX+250, PosY+302, 85, 42, 0.242465867, 0.0, 0.5, 1.0, 1, 1, 1.0)

    --Render Box info
    StoreSearchItemList.RenderBox(PosX + 20, PosY + 35, 180, 15, 0)

    --Render box itens
    StoreSearchItemList.RenderBox(PosX + 15, PosY + 80, 300, 190, 1)

    --Render Scroll bar
    StoreSearchItemList.RenderScrollBarPage(PosX + 250, PosY + 85, 65, 180, 14)
end

function StoreSearchItemList.RenderText()
    local PosX = m_PosX
    local PosY = m_PosY

    --Text
	SetFontType(1)
	
	SetTextColor(255, 189, 25, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(PosX, PosY + 5, STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][1], 335, 3)

    if StoreSelectedInfo ~= nil
    then
        SetFontType(0)

        SetTextColor(255, 255, 255, 255)

        RenderText3(PosX + 24, PosY + 38, StoreSelectedInfo.storeName, 180, 1)

        --Box item list
        SetFontType(1)

        RenderText3(PosX + 15, PosY + 83, STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][2], 100, 3)

        RenderText3(PosX + 167, PosY + 83, STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][3], 167, 3)

        SetFontType(3)

        SetTextColor(200, 200, 200, 255)

        StoreSearchItemList.RenderItensList(PosX, PosY + 100)
    end
end

function StoreSearchItemList.RenderItensList(x, y)
    local posY = 0
	local line = 0

    local MouseX = MousePosX()
    local MouseY = MousePosY()

    if #StoreSearchItems <= 0
    then
        return
    end

    local RenderItem = 0
    local RenderItemInfo = nil
    local RenderItemInfoX = 0
    local RenderItemInfoY = 0

	for key = 1, #StoreSearchItems do
		if StoreSearchItems[key] == nil
		then
			goto continue
		end

		if line >= StoreSearchItemListScrollBarCurrentLine and line <= StoreSearchItemListScrollBarRenderPageMax
		then
			local itemInfo = StoreSearchItems[key]

            if (MouseX >= x + 15 and MouseX <= x + 15 + 150)
                and (MouseY >= y + posY and MouseY <= y + posY + 14) and StoreSearchItemSelected == 1 and StoreBuyItemBoxOpened == 0
            then
                SetTextColor(220, 20, 60, 255)
            else
                SetTextColor(225, 225, 225, 255)
            end
		
            RenderText3(x + 15, y + posY, GetNameByIndex(itemInfo.ItemIndex), 100, 3)

            if (MouseX >= x + 175 and MouseX <= x + 15 + 280)
                and (MouseY >= y + posY and MouseY <= y + posY + 14) and StoreSearchItemSelected == 1 and StoreBuyItemBoxOpened == 0
            then
                SetTextColor(220, 20, 60, 255)
            else
                SetTextColor(225, 225, 225, 255)
            end

            RenderText3(x + 167, y + posY, STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][4], 167, 3)

            if (MouseX >= x + 15 and MouseX <= x + 15 + 150)
                and (MouseY >= y + posY and MouseY <= y + posY + 14) and StoreSearchItemSelected == 1 and StoreBuyItemBoxOpened == 0
            then
                RenderItem = 1
                RenderItemInfo = itemInfo
                RenderItemInfoX = MouseX + 30
                RenderItemInfoY = MouseY + 5
            end

            if (MouseX >= x + 175 and MouseX <= x + 15 + 280)
                and (MouseY >= y + posY and MouseY <= y + posY + 14) and StoreSearchItemSelected == 1 and StoreBuyItemBoxOpened == 0
            then
                StoreSearchItemList.RenderItemValue(x + 200, y + posY, itemInfo)
            end
			
			posY = posY + 15
		end
		
		line = line + 1

		::continue::
	end

    if RenderItem ~= 0
    then
        if RenderItemInfo ~= nil
        then
            StoreSearchItemList.RenderDescriptionItem(RenderItemInfoX, RenderItemInfoY, RenderItemInfo)
        end
    end
end

function StoreSearchItemList.RenderItemValue(x, y, itemInfo)
    local width = 20
    local reduceY = 0

    if itemInfo.Zen > 0
    then
        width = width + 15
        reduceY = reduceY + 5
    end

    if itemInfo.Coin1 > 0
    then
        width = width + 15
        reduceY = reduceY + 5
    end

    if itemInfo.Coin2 > 0
    then
        width = width + 15
        reduceY = reduceY + 5
    end

    if itemInfo.Coin3 > 0
    then
        width = width + 15
        reduceY = reduceY + 5
    end

    if itemInfo.Coin4 > 0
    then
        width = width + 15
        reduceY = reduceY + 5
    end

    local newY = y - (width + 5)

    EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 0.9)

	DrawBar(x, newY, 100, width, 0.0, 0)
	
	EndDrawBar()
	DisableAlphaBlend()
	
	EnableAlphaTest()

    SetTextColor(225, 225, 225, 255)

    RenderText3(x, newY + 5, STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][5], 100, 3)

    local addY = 20

    if itemInfo.Zen > 0
    then
        RenderText3(x, newY + addY, string.format(STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][6], itemInfo.Zen), 100, 3)
        addY = addY + 15.0
    end

    if itemInfo.Coin1 > 0
    then
        RenderText3(x, newY + addY, string.format(STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][7], itemInfo.Coin1), 100, 3)
        addY = addY + 15.0
    end

    if itemInfo.Coin2 > 0
    then
        RenderText3(x, newY + addY, string.format(STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][8], itemInfo.Coin2), 100, 3)
        addY = addY + 15.0
    end

    if itemInfo.Coin3 > 0
    then
        RenderText3(x, newY + addY, string.format(STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][9], itemInfo.Coin3), 100, 3)
        addY = addY + 15.0
    end

    if itemInfo.Coin4 > 0
    then
        RenderText3(x, newY + addY, string.format(STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][10], itemInfo.Coin4), 100, 3)
        addY = addY + 15.0
    end
end

function StoreSearchItemList.RenderDescriptionItem(x, y, item)
    EnableAlphaTest()

    glColor4f(1.0, 1.0, 1.0, 1.0)

    ShowDescriptionComplete(x + 35, y, item.ItemIndex, item.Level, item.Op1, item.Op2, item.Op3, item.Exc, item.Ancient, item.JoH, item.SockCount, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5)

    DisableAlphaBlend()
end

function StoreSearchItemList.MoveWindow()
    local MouseX = MousePosX()
    local MouseY = MousePosY()

    if StoreSearchItemSelected == 1
    then
        if (MouseX >= m_PosX and MouseX <= m_PosX+335)
            and (MouseY >= m_PosY and MouseY <= m_PosY + 25) or StoreSearchItemListMoveClickRepeat == 1
        then
            if (CheckPressedKey(Keys.LButton) == 1)
            then
                m_PX = MouseX - m_PosX
                m_PY = MouseY - m_PosY

                StoreSerachItemListMoveClicked = 1

            elseif (CheckRepeatKey(Keys.LButton) == 1 and StoreSerachItemListMoveClicked == 1)
            then
                if MouseX > 1 and MouseX < 639
                then
                    m_PosX = MouseX - m_PX
                end

                if MouseY > 1 and MouseY < 439
                then
                    m_PosY = MouseY - m_PY
                end

                StoreSearchItemListMoveClickRepeat = 1
            else
                StoreSearchItemListMoveClickRepeat = 0
                StoreSerachItemListMoveClicked = 0
            end
        else
            StoreSearchItemListMoveClickRepeat = 0
            StoreSerachItemListMoveClicked = 0
        end

        if (MouseX >= m_PosX + 300 and MouseX <= m_PosX+330)
            and (MouseY >= m_PosY and MouseY <= m_PosY + 20)
        then
            if (CheckClickClient() == 1)
            then
                StoreSearchItemList.Close()
                DisableClickClient()
            end
        end
    else
        if (MouseX >= m_PosX and MouseX <= m_PosX+335)
            and (MouseY >= m_PosY and MouseY <= m_PosY + 320)
        then
            if (CheckClickClient() == 1)
            then
                DisableClickClient()
                StoreSearchItemSelected = 1

                StoreSearchItemListMoveClickRepeat = 0
                m_PX = MouseX - m_PosX
                m_PY = MouseY - m_PosY
            end
        end
    end

    if (MouseX >= m_PosX and MouseX <= m_PosX+335)
        and (MouseY >= m_PosY and MouseY <= m_PosY + 330)
    then
        DisableClickClient()
    end
end

function StoreSearchItemList.UpdateMouseItemList()
    if #StoreSearchItems <= 0
    then
        return
    end

    if StoreBuyItemBoxOpened == 1
    then
        return
    end

    local x = m_PosX
    local y = m_PosY + 100

    local MouseX = MousePosX()
    local MouseY = MousePosY()

    local posY = 0
	local line = 0

	for key = 1, #StoreSearchItems do
		if StoreSearchItems[key] == nil
		then
			goto continue
		end

		if line >= StoreSearchItemListScrollBarCurrentLine and line <= StoreSearchItemListScrollBarRenderPageMax
		then
			local itemInfo = StoreSearchItems[key]

            if (MouseX >= x + 15 and MouseX <= x + 15 + 290)
                and (MouseY >= y + posY and MouseY <= y + posY + 14) and StoreSearchItemSelected == 1
            then
                if (CheckPressedKey(Keys.LButton) == 1)
                then
                    StoreBuyItemBoxOpened = 1
                    StoreBuyItemSlot = itemInfo.Slot
                    StoreBuyItemIdentification = itemInfo.aIndex
                    StoreBuyItemName = GetNameByIndex(itemInfo.ItemIndex)
                    DisableClickClient()
                end
            end
			
			posY = posY + 15
		end
		
		line = line + 1

		::continue::
	end
end

function StoreSearchItemList.UpdateWindow()
    if StoreSearchItemListOpen == 0
    then
        return
    end

    if StoreBuyItemBoxOpened == 1
    then
        local MouseX = MousePosX()
        local MouseY = MousePosY()

        local PosX = (640 / 2) - (230 / 2)
        local PosY = 120

        if (MouseX >= (PosX + 50) and MouseX <= (PosX + 50) + 54)
        and (MouseY >= (PosY + 110) and MouseY <= (PosY + 110) + 30)
        then
            if (CheckClickClient() == 1)
            then
                StoreSearchItemList.ClickOk()
            end
        end

        if (MouseX >= (PosX + 120) and MouseX <= (PosX + 120) + 54)
        and (MouseY >= (PosY + 110) and MouseY <= (PosY + 110) + 30)
        then
            if (CheckClickClient() == 1)
            then
                StoreSearchItemList.ClickCancel()
            end
        end

        DisableClickClient()
        return
    end

    StoreSearchItemList.MoveWindow()

    StoreSearchItemList.UpdateMouseItemList()
end

function StoreSearchItemList.RenderBox(x, y, width, height, title)
    EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 0.8)

	DrawBar(x, y - 1, width, height + 1, 0.0, 0)

    if title == 1
    then
        glColor4f(0.2, 0.2, 0.2, 0.8)

        DrawBar(x, y, width, 12, 0.0, 0)
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
end

function StoreSearchItemList.RenderScrollBarPage(x, y, width, height, size)
	glColor4f(1.0, 1.0, 1.0, 1.0)

	RenderImage(31270, x + width - 11, y + 14, 7, 3)
	
	for i = 0, size do
		RenderImage(31271, x + width - 11, (y + 13) + (i * 10 + 4), 7, 15)
	end

	RenderImage(31272, x + width - 11, y + height - 8, 7, 3)

	if MousePosX() >= (x + width - 15) and MousePosX() <= (x + width - 15) + 15
		and MousePosY() >= y + 10 + StoreSearchItemListScrollBarPosY and MousePosY() <= y + 10 + StoreSearchItemListScrollBarPosY + 30
	then
		glColor4f(1.0, 1.0, 1.0, 1.0)
	else
		glColor4f(0.7, 0.7, 0.7, 1.0)
	end

	RenderImage(31273, x + width - 15, y + 10 + StoreSearchItemListScrollBarPosY, 15, 30)
	
	glColor4f(1.0, 1.0, 1.0, 1.0)
end

function StoreSearchItemList.CalcScrollBar()
    StoreSearchItemListScrollBarPosY = 0
	StoreSearchItemListScrollBarPosMouse = 0
	StoreSearchItemListScrollBarCurrentLine = 0
	StoreSearchItemListScrollBarRenderMaxLines = #StoreSearchItems - 1
	StoreSearchItemListScrollMaxLine = 10
	StoreSearchItemListScrollBarPosYMultiplier = (185 / (#StoreSearchItems - 10))
	StoreSearchItemListScrollBarRenderPageMax = 10
end

function StoreSearchItemList.ScrollingBar(value)
    if value > 0
	then
		if (StoreSearchItemListScrollBarRenderPageMax < StoreSearchItemListScrollBarRenderMaxLines)
		then
			StoreSearchItemListScrollBarRenderPageMax = StoreSearchItemListScrollBarRenderPageMax + 1
			StoreSearchItemListScrollBarCurrentLine = StoreSearchItemListScrollBarCurrentLine + 1
			StoreSearchItemListScrollBarPosY = StoreSearchItemListScrollBarPosY + StoreSearchItemListScrollBarPosYMultiplier
		end
	elseif value < 0
	then
		if (StoreSearchItemListScrollBarRenderPageMax > StoreSearchItemListScrollMaxLine)
		then
			StoreSearchItemListScrollBarRenderPageMax = StoreSearchItemListScrollBarRenderPageMax - 1
			StoreSearchItemListScrollBarCurrentLine = StoreSearchItemListScrollBarCurrentLine - 1
			StoreSearchItemListScrollBarPosY = StoreSearchItemListScrollBarPosY - StoreSearchItemListScrollBarPosYMultiplier
		end
	end
end

function StoreSearchItemList.ScrollMouse(value)
    if MousePosX() >= m_PosX and MousePosX() <= m_PosX + 330
    then
        if MousePosY() >= m_PosY + 80 and MousePosY() <= m_PosY + 270
        then
            if value > 0
            then
                StoreSearchItemList.ScrollingBar(-1)
            end
            
            if value < 0
            then
                StoreSearchItemList.ScrollingBar(1)
            end
        end
    end
end

function StoreSearchItemList.InsertItemList(index, aIndex, Slot, Coin1, Coin2, Coin3, Coin4, Zen, iItemIndex, Itemlevel, iOp1, iOp2, iOp3, iExc, iAncient, iJoH, iSockCount, iSock1, iSock2, iSock3, iSock4, iSock5)
    StoreSearchItems[index] = { aIndex = aIndex, Slot = Slot, Coin1 = Coin1, Coin2 = Coin2, Coin3 = Coin3, Coin4 = Coin4, Zen = Zen, ItemIndex = iItemIndex, Level = Itemlevel, Op1 = iOp1, Op2 = iOp2, Op3 = iOp3, Exc = iExc
			, Ancient = iAncient, JoH = iJoH, SockCount = iSockCount, Sock1 = iSock1, Sock2 = iSock2, Sock3 = iSock3, Sock4 = iSock4, Sock5 = iSock5 }
end

function StoreSearchItemList.Close()
    StoreSearchItemListOpen = 0
    StoreSearchItemSelected = 0
    
    StoreSearchItems = {}

    StoreBuyItemBoxOpened = 0
    StoreBuyItemSlot = 0
    StoreBuyItemIdentification = 0
    StoreBuyItemName = ''
end

function StoreSearchItemList.ProcessListItem(PacketName)
    StoreSearchItems = {}

    local aIndex = GetWordPacket(PacketName, -1)
    local count = GetWordPacket(PacketName, -1)

    if count > 0
	then
        for i = 0, (count-1) do
            StoreSearchItemList.InsertItemList(i+1, aIndex, GetBytePacket(PacketName, -1)
            , GetDwordPacket(PacketName, -1), GetDwordPacket(PacketName, -1), GetDwordPacket(PacketName, -1)
            , GetDwordPacket(PacketName, -1), GetDwordPacket(PacketName, -1), GetWordPacket(PacketName, -1), GetBytePacket(PacketName, -1)
            , GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1)
            , GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1)
            , GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1))
        end
    end

    StoreSearchItemList.CalcScrollBar()
end

function StoreSearchItemList.BuyItemFromPlayer(aIndex, slot)
    local packetString = string.format("%s_%s", STORE_SEARCH_ITEM_BUY_PACKET_NAME, UserGetName())
    CreatePacket(packetString, STORE_SEARCH_PACKET)
    SetWordPacket(packetString, aIndex)
    SetBytePacket(packetString, slot)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function StoreSearchItemList.SetInfo(storeList)
    StoreSelectedInfo = storeList

    local packetString = string.format("%s_%s", STORE_SEARCH_ITEM_LIST_PACKET_NAME, UserGetName())
    CreatePacket(packetString, STORE_SEARCH_PACKET)
    SetCharPacketLength(packetString, storeList.sellerName, 10)
    SetWordPacket(packetString, storeList.sellerIdentification)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function StoreSearchItemList.RenderItemBuyBox()
    local PosX = (640 / 2) - (230 / 2)
    local PosY = 120

    --Render Window
    RenderImage(0x7A5A, PosX, PosY + 2.0, 222.0, 150.0)

    RenderImage(0x7A63, PosX, PosY, 230, 67)

    PosY = PosY + 60.0

	for i = 1, 3 do
		RenderImage(0x7A58, PosX, PosY, 230.0, 15.0)

        PosY = PosY + 15.0
    end

    RenderImage(0x7A58, PosX, PosY, 230.0, 5.0)
    PosY = PosY + 5.0

	RenderImage(0x7A59, PosX, PosY, 230.0, 45.0)

    PosY = 120

    --Ok
    if (MousePosX() >= (PosX + 50) and MousePosX() <= (PosX + 50) + 54)
        and (MousePosY() >= (PosY + 110) and MousePosY() <= (PosY + 110) + 30)
    then
        RenderImage2(0x7A5B, PosX + 50, PosY + 110, 54.0, 30.0, 0.0, 0.235, 0.84, 0.23, 1.00, 1.0, 1.0)
    else
        RenderImage2(0x7A5B, PosX + 50, PosY + 110, 54.0, 30.0, 0.0, 0.0, 0.84, 0.23, 1.00, 1.0, 1.0)
    end

    --Cancel
    if (MousePosX() >= (PosX + 120) and MousePosX() <= (PosX + 120) + 54)
        and (MousePosY() >= (PosY + 110) and MousePosY() <= (PosY + 110) + 30)
    then
        RenderImage2(0x7A5C, PosX + 120, PosY + 110, 54.0, 30.0, 0.0, 0.235, 0.84, 0.23, 1.00, 1.0, 1.0)
    else
        RenderImage2(0x7A5C, PosX + 120, PosY + 110, 54.0, 30.0, 0.0, 0.0, 0.84, 0.23, 1.00, 1.0, 1.0)
    end

    EnableAlphaTest()

     --Text
	SetFontType(1)
	
	SetTextColor(255, 189, 25, 255)
	
	SetTextBg(0, 0, 0, 0)

	RenderText3(PosX, PosY + 10, STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][11], 230, 3)

    SetTextColor(255, 255, 255, 255)

    RenderText3(PosX, PosY + 50, STORE_SEARCH_ITEM_LIST_MESSAGES[GetLanguage()][12], 230, 3)

    RenderText3(PosX, PosY + 75, StoreBuyItemName, 230, 3)
end

function StoreSearchItemList.ClickOk()
    StoreSearchItemList.BuyItemFromPlayer(StoreBuyItemIdentification, StoreBuyItemSlot)

    StoreBuyItemBoxOpened = 0
    StoreBuyItemSlot = 0
    StoreBuyItemIdentification = 0
    StoreBuyItemName = ''
end

function StoreSearchItemList.ClickCancel()
    StoreBuyItemBoxOpened = 0
    StoreBuyItemSlot = 0
    StoreBuyItemIdentification = 0
    StoreBuyItemName = ''
end

return StoreSearchItemList