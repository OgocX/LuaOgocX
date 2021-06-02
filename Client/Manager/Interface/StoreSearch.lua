STORE_SEARCH_SWITCH = 1

STORE_SEARCH_PACKET_NAME = 'StoreSearch'
STORE_SEARCH_PACKET_FIND_ITEM_NAME = 'StoreSearchFindItem'
STORE_SEARCH_PACKET_BUY_FIND_ITEM_NAME = 'StoreSearchBuyFindItem'
STORE_SEARCH_PACKET = 0x04

STORE_SEARCH_MESSAGES = {}

STORE_SEARCH_MESSAGES['Por'] = {
[1] = 'Procurar Lojas',
[2] = 'Lista de lojas',
[3] = 'Lista de itens',
[4] = 'Pesquisar',
[5] = 'Shop Descrição',
[6] = 'Vendedor',
[7] = 'Item Nome',
[8] = 'Preço',
[9] = 'Não encontramos nenhuma loja aberta!',
[10] = '[VER VALOR]',
}

STORE_SEARCH_MESSAGES['Eng'] = {
[1] = 'Browse Stores',
[2] = 'List of stores',
[3] = 'List of items',
[4] = 'Search',
[5] = 'Shop Description',
[6] = 'Seller',
[7] = 'Item Name',
[8] = 'Price',
[9] = 'We didnt find any open stores!',
[10] = '[VIEW VALUE]',
}

STORE_SEARCH_MESSAGES['Spn'] = {
[1] = 'Explorar tiendas',
[2] = 'Lista de tiendas',
[3] = 'Lista de elementos',
[4] = 'Buscar',
[5] = 'Descripción de la tienda',
[6] = 'Vendedor',
[7] = 'Nombre del artículo',
[8] = 'Precio',
[9] = '¡No encontramos ninguna tienda abierta!',
[10] = '[VER VALOR]',
}

StoreSearch = {}

local StoreSearchShopList = {}
local StoreSearchItensList = {}
local StoreSearchItensSelected = {}

local StoreSearchVisible = 0
local m_PosX = (640 / 2) - (335 / 2)
local m_PosY = 50

local StoreSearchMoveClickRepeat = 0
local StoreSearchMoveClicked = 0

local m_PY = 0
local m_PX = 0

--Scroll stores list
local StoreSearchScrollBarPosY = 0
local StoreSearchScrollBarPosMouse = 0
local StoreSearchScrollBarPosYMultiplier = 0
local StoreSearchScrollBarCurrentLine = 0
local StoreSearchScrollBarRenderMaxLines = 0
local StoreSearchScrollMaxLine = 0
local StoreSearchScrollBarRenderPageMax = 0

--Scroll item find list
local StoreSearchItemsScrollBarPosY = 0
local StoreSearchItemsScrollBarPosMouse = 0
local StoreSearchItemsScrollBarPosYMultiplier = 0
local StoreSearchItemsScrollBarCurrentLine = 0
local StoreSearchItemsScrollBarRenderMaxLines = 0
local StoreSearchItemsScrollMaxLine = 0
local StoreSearchItemsScrollBarRenderPageMax = 0

--Text find
local StoreSearchSelectText = 0
local StoreSearchText = nil

local StoreSearchPage = 0

StoreSearchItemListOpen = 0
StoreSearchItemSelected = 0

function StoreSearch.Render()
    if StoreSearchVisible ~= 1
    then
        return
    end

    EnableAlphaTest()

    glColor4f(1.0, 1.0, 1.0, 1.0)

    if StoreSearchItemSelected == 0
    then
        if StoreSearchItemListOpen == 1
        then
            StoreSearchItemList.RenderWindow()
        end

        StoreSearch.RenderWindowList()
    else
        StoreSearch.RenderWindowList()

        if StoreSearchItemListOpen == 1
        then
            StoreSearchItemList.RenderWindow()
        end
    end

    DisableAlphaBlend()
end

function StoreSearch.RenderWindowList()
    EnableAlphaTest()

    StoreSearch.RenderFrame()

    StoreSearch.RenderText()

    DisableAlphaBlend()
end

function StoreSearch.RenderFrame()
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
    
    --Division
    RenderImage2(31330, PosX, PosY + 45, 85, 21, 0.0, 0.0, 0.5, 0.60, 1, 1, 1.0)
    RenderImage2(31330, PosX+85, PosY + 45, 165, 21, 0.30, 0.0, 0.25, 0.60, 1, 1, 1.0)	
    RenderImage2(31330, PosX+250, PosY + 45, 85, 21, 0.30, 0.0, 0.57, 0.60, 1, 1, 1.0)

    RenderImage2(31330, PosX, PosY + 70, 85, 21, 0.0, 0.0, 0.5, 0.60, 1, 1, 1.0)
    RenderImage2(31330, PosX+85, PosY + 70, 165, 21, 0.30, 0.0, 0.25, 0.60, 1, 1, 1.0)	
    RenderImage2(31330, PosX+250, PosY + 70, 85, 21, 0.30, 0.0, 0.57, 0.60, 1, 1, 1.0)

    --Box
    StoreSearch.RenderBox(PosX + 15, PosY + 95, 300, 180)

    --Scroll
    StoreSearch.RenderScrollBarPage(PosX + 155, PosY + 95, 160, 170, 13)

    --Buttons
    StoreSearch.RenderButtons(PosX + 330 / 2 - ((100 / 2) + (100 / 2)), PosY + 25, 100, 25, STORE_SEARCH_MESSAGES[GetLanguage()][2])
    StoreSearch.RenderButtons(PosX + 330 / 2 - (100 / 2) + 70, PosY + 25, 100, 25, STORE_SEARCH_MESSAGES[GetLanguage()][3])

    if StoreSearchPage == 1
    then
        --Box Search
        StoreSearch.RenderBox(PosX + 20, PosY + 295, 180, 15, 0)
        StoreSearch.RenderButtons(PosX + 220, PosY + 290, 80, 25, STORE_SEARCH_MESSAGES[GetLanguage()][4])
    end
end

function StoreSearch.RenderBox(x, y, width, height)
    EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 0.3)

	DrawBar(x, y - 1, width, height + 1, 0.0, 0)
	
	glColor4f(0.0, 0.0, 0.0, 0.5)

	DrawBar(x, y - 1, width, height + 1, 0.0, 0)
	
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

function StoreSearch.RenderScrollBarPage(x, y, width, height, size)
    local posY = StoreSearchScrollBarPosY

    if StoreSearchPage == 1
    then
        posY = StoreSearchItemsScrollBarPosY
    end

	glColor4f(1.0, 1.0, 1.0, 1.0)

	RenderImage(31270, x + width - 11, y + 14, 7, 3)
	
	for i = 0, size do
		RenderImage(31271, x + width - 11, (y + 13) + (i * 10 + 4), 7, 15)
	end

	RenderImage(31272, x + width - 11, y + height - 8, 7, 3)

	if MousePosX() >= (x + width - 15) and MousePosX() <= (x + width - 15) + 15
		and MousePosY() >= y + 10 + posY and MousePosY() <= y + 10 + posY + 30
	then
		glColor4f(1.0, 1.0, 1.0, 1.0)
	else
		glColor4f(0.7, 0.7, 0.7, 1.0)
	end

	RenderImage(31273, x + width - 15, y + 10 + posY, 15, 30)
	
	glColor4f(1.0, 1.0, 1.0, 1.0)
end

function StoreSearch.RenderButtons(x, y, width, height, Text)
    if MousePosX() >= x and MousePosX() <= x + width and MousePosY() >= y and MousePosY() <= y + height
	then
		RenderImage2(31326, x, y, width, height, 0, 0.2264566, 1.0, 0.2245212, 1, 1, 1.0)
	else
		RenderImage2(31326, x, y, width, height, 0, 0, 1.0, 0.2245212, 1, 1, 1.0)
	end
	
	SetFontType(1)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(216, 216, 216, 255)
	
	RenderText3(x, y + 8, Text, width - #Text, 3)
end

function StoreSearch.RenderTextBox(x, y, width, height)
    RenderImage(0x79A2, x, y, width, height)
end

function StoreSearch.RenderText()
    local PosX = m_PosX
    local PosY = m_PosY

    --Text
	SetFontType(1)
	
	SetTextColor(255, 189, 25, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(PosX, PosY + 5, STORE_SEARCH_MESSAGES[GetLanguage()][1], 335, 3)

    SetTextColor(255, 255, 255, 255)

    if StoreSearchPage == 0
    then
        RenderText3(PosX, PosY + 65, STORE_SEARCH_MESSAGES[GetLanguage()][5], 167, 3)

        RenderText3(PosX + 167, PosY + 65, STORE_SEARCH_MESSAGES[GetLanguage()][6], 167, 3)

        StoreSearch.RenderStoreList(PosX, PosY)
    else
        RenderText3(PosX, PosY + 65, STORE_SEARCH_MESSAGES[GetLanguage()][7], 100, 3)

        RenderText3(PosX + 115, PosY + 65, STORE_SEARCH_MESSAGES[GetLanguage()][8], 100, 3)

        RenderText3(PosX + 220, PosY + 65, STORE_SEARCH_MESSAGES[GetLanguage()][6], 100, 3)

        RenderText3(PosX + 24, PosY + 298, StoreSearchText, 180, 1)

        StoreSearch.RenderStoreItemList(PosX, PosY)
    end
end

function StoreSearch.RenderStoreList(x, y)
    EnableAlphaTest()

	SetFontType(3)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(225, 225, 225, 255)
	
	local posY = 0
	local line = 0

    if #StoreSearchShopList <= 0
    then
        RenderText3(x + 25, y + 105, STORE_SEARCH_MESSAGES[GetLanguage()][9], 190, 1)
    end

	for key = 1, #StoreSearchShopList do
		if StoreSearchShopList[key] == nil
		then
			goto continue
		end

		if line >= StoreSearchScrollBarCurrentLine and line <= StoreSearchScrollBarRenderPageMax
		then
			local info = StoreSearchShopList[key]

            if (MousePosX() >= x + 18 and MousePosX() <= x + 18 + 150)
                and (MousePosY() >= y + 105 + posY and MousePosY() <= y + 105 + posY + 14) and StoreSearchItemSelected == 0
            then
                SetTextColor(220, 20, 60, 255)
            else
                SetTextColor(225, 225, 225, 255)
            end
		
            RenderText3(x + 18, y + 105 + posY, info.storeName, 230, 1)

            if (MousePosX() >= x + 175 and MousePosX() <= x + 18 + 280)
                and (MousePosY() >= y + 105 + posY and MousePosY() <= y + 105 + posY + 14) and StoreSearchItemSelected == 0
            then
                SetTextColor(220, 20, 60, 255)
            else
                SetTextColor(225, 225, 225, 255)
            end

            RenderText3(x + 175, y + 105 + posY, info.sellerName, 160, 3)
			
			posY = posY + 15
		end
		
		line = line + 1

		::continue::
	end
	
	DisableAlphaBlend()
end

function StoreSearch.RenderStoreItemList(x, y)
    EnableAlphaTest()

	SetFontType(3)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(225, 225, 225, 255)

    local RenderItem = 0
    local RenderItemInfo = nil
    local RenderItemInfoX = 0
    local RenderItemInfoY = 0
	
	local posY = 0
	local line = 0

    local MouseX = MousePosX()
    local MouseY = MousePosY()

	for key = 1, #StoreSearchItensList do
		if StoreSearchItensList[key] == nil
		then
			goto continue
		end

		if line >= StoreSearchItemsScrollBarCurrentLine and line <= StoreSearchItemsScrollBarRenderPageMax
		then
			local info = StoreSearchItensList[key]

            if (MouseX >= x + 18 and MouseX <= x + 18 + 80)
                and (MouseY >= y + 105 + posY and MouseY <= y + 105 + posY + 14) and StoreSearchItemSelected == 0
            then
                SetTextColor(220, 20, 60, 255)

                RenderItem = 1
                RenderItemInfo = info
                RenderItemInfoX = MouseX + 30
                RenderItemInfoY = MouseY + 5
            else
                SetTextColor(225, 225, 225, 255)
            end
		
            RenderText3(x + 25, y + 105 + posY, GetNameByIndex(info.ItemIndex), 100, 1)

            if (MouseX >= x + 130 and MouseX <= x + 130 + 60)
                and (MouseY >= y + 105 + posY and MouseY <= y + 105 + posY + 14) and StoreSearchItemSelected == 0
            then
                SetTextColor(220, 20, 60, 255)
            else
                SetTextColor(225, 225, 225, 255)
            end

            RenderText3(x + 150, y + 105 + posY, STORE_SEARCH_MESSAGES[GetLanguage()][10], 100, 1)

            if (MouseX >= x + 130 and MouseX <= x + 130 + 60)
                and (MouseY >= y + 105 + posY and MouseY <= y + 105 + posY + 14) and StoreSearchItemSelected == 0
            then
                StoreSearchItemList.RenderItemValue(x + 120, y + 105 + posY, info)
            end

            if (MouseX >= x + 230 and MouseX <= x + 230 + 70)
                and (MouseY >= y + 105 + posY and MouseY <= y + 105 + posY + 14) and StoreSearchItemSelected == 0
            then
                SetTextColor(220, 20, 60, 255)
            else
                SetTextColor(225, 225, 225, 255)
            end

            RenderText3(x + 290, y + 105 + posY, info.sellerName, 100, 7)
			
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
	
	DisableAlphaBlend()
end

function StoreSearch.MoveWindow()
    local MouseX = MousePosX()
    local MouseY = MousePosY()

    if StoreSearchItemSelected == 0
    then
        if (MouseX >= m_PosX and MouseX <= m_PosX+335)
            and (MouseY >= m_PosY and MouseY <= m_PosY + 25) or StoreSearchMoveClickRepeat == 1
        then
            if (CheckPressedKey(Keys.LButton) == 1)
            then
                m_PX = MouseX - m_PosX
                m_PY = MouseY - m_PosY

                StoreSearchMoveClicked = 1

            elseif (CheckRepeatKey(Keys.LButton) == 1 and StoreSearchMoveClicked == 1)
            then
                if MouseX > 1 and MouseX < 639
                then
                    m_PosX = MouseX - m_PX
                end

                if MouseY > 1 and MouseY < 439
                then
                    m_PosY = MouseY - m_PY
                end

                StoreSearchMoveClickRepeat = 1
            else
                StoreSearchMoveClickRepeat = 0
                StoreSearchMoveClicked = 0
            end
        else
            StoreSearchMoveClickRepeat = 0
            StoreSearchMoveClicked = 0
        end

        --Text input
        if (MouseX >= (m_PosX + 20) and MouseX <= (m_PosX + 20)+180)
            and (MouseY >= m_PosY + 295 and MouseY <= m_PosY + 295 + 25) and CheckPressedKey(Keys.LButton) == 1
        then
            StoreSearchSelectText = 1
            DisableClickClient()
        else
            if CheckPressedKey(Keys.LButton) == 1
            then
                StoreSearchSelectText = 0
            end
        end

        --Search
        if (MouseX >= (m_PosX + 220) and MouseX <= (m_PosX + 220)+80)
            and (MouseY >= m_PosY + 290 and MouseY <= m_PosY + 290 + 25) and CheckPressedKey(Keys.LButton) == 1
        then
            StoreSearch.FindItens(StoreSearchText)
            DisableClickClient()
        end

        if (MouseX >= (m_PosX + 330 / 2 - ((100 / 2) + (100 / 2))) and MouseX <= (m_PosX + 330 / 2 - ((100 / 2) + (100 / 2)))+100)
            and (MouseY >= m_PosY + 25 and MouseY <= m_PosY + 25 + 25) and CheckPressedKey(Keys.LButton) == 1
        then
            StoreSearchPage = 0
            DisableClickClient()
        end

        if (MouseX >= (m_PosX + 330 / 2 - (100 / 2) + 70) and MouseX <= (m_PosX + 330 / 2 - (100 / 2) + 70)+100)
            and (MouseY >= m_PosY + 25 and MouseY <= m_PosY + 25 + 25) and CheckPressedKey(Keys.LButton) == 1
        then
            StoreSearchPage = 1
            DisableClickClient()
        end

        if (MouseX >= m_PosX + 300 and MouseX <= m_PosX+330)
            and (MouseY >= m_PosY and MouseY <= m_PosY + 20)
        then
            if (CheckClickClient() == 1)
            then
                StoreSearch.Close()
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
                StoreSearchItemSelected = 0
                StoreSearchMoveClickRepeat = 0
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

function StoreSearch.UpdateMouseListWindow()
    local x = m_PosX
    local y = m_PosY

    local posY = 0
	local line = 0

    if (StoreSearchShopList == nil)
    then
        return
    end

	for key = 1, #StoreSearchShopList do
		if StoreSearchShopList[key] == nil
		then
			goto continue
		end

		if line >= StoreSearchScrollBarCurrentLine and line <= StoreSearchScrollBarRenderPageMax
		then
			local info = StoreSearchShopList[key]

            if (MousePosX() >= x + 18 and MousePosX() <= x + 18 + 280)
                and (MousePosY() >= y + 105 + posY and MousePosY() <= y + 105 + posY + 14)
            then
                if (CheckPressedKey(Keys.LButton) == 1)
                then
                    StoreSearchItemList.SetInfo(info)
                    StoreSearchItemListOpen = 1
                    StoreSearchItemSelected = 1
                    DisableClickClient()
                end
            end

			posY = posY + 15
		end
		
		line = line + 1

		::continue::
	end
end

function StoreSearch.UpdateMouse()
    if StoreSearchVisible ~= 1
    then
        return
    end

    if StoreSearchItemSelected == 0
    then
        StoreSearch.MoveWindow()

        if StoreSearchPage == 0
        then
            StoreSearch.UpdateMouseListWindow()
        else

        end

        StoreSearchItemList.UpdateWindow()
    else
        StoreSearchItemList.UpdateWindow()

        StoreSearch.MoveWindow()
    end
end

function StoreSearch.UpdateKeyEvent()
    if StoreSearchVisible ~= 1
    then
        return
    end

    if (CheckPressedKey(Keys.Escape) == 1)
	then
		StoreSearchItemList.Close()
		StoreSearch.Close()
	end

    if StoreSearchPage == 1
    then
        if StoreSearchSelectText == 1
        then
            if CheckPressedKey(Keys.Back) == 1
            then
                if StoreSearchText ~= nil
                then
                    StoreSearchText = StoreSearchText:sub(1, #StoreSearchText - 1)

                    if #StoreSearchText <= 0
                    then
                        StoreSearchText = ' '
                    end
                end
            end
        end
    end

    if StoreSearchSelectText == 1
    then
        DisableClickClient()
    end
end

function StoreSearch.Open()
    if StoreSearchVisible ~= 0
    then
        return
    end

    m_PosX = (640 / 2) - (335 / 2)
    m_PosY = 50

    --Clear list
    StoreSearchShopList = nil
    StoreSearchItensList = nil

    StoreSearchMoveClickRepeat = 0
    StoreSearchMoveClicked = 0
    StoreSearchSelectText = 0
    StoreSearchVisible = 0
    StoreSearchPage = 0
    StoreSearchText = nil

    local packetString = string.format("%s_%s", STORE_SEARCH_PACKET_NAME, UserGetName())
    CreatePacket(packetString, STORE_SEARCH_PACKET)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function StoreSearch.Close()
    StoreSearchMoveClickRepeat = 0
    StoreSearchMoveClicked = 0
    StoreSearchSelectText = 0
    StoreSearchVisible = 0
    StoreSearchShopList = nil
    StoreSearchItensList = nil

    m_PosX = (640 / 2) - (335 / 2)
    m_PosY = 50
end

function StoreSearch.MainProcWorldKey(keys)
    if StoreSearchVisible ~= 1
    then
        return
    end

    if StoreSearchSelectText == 1
    then
        if StoreSearchText == nil
        then
            StoreSearchText = ''
        end

        if KeysConvert[keys] ~= nil
        then
            StoreSearchText = StoreSearchText .. KeysConvert[keys]
        end
    end
end

function StoreSearch.InsertStoreList(index, storeName, sellerName, sellerIdentification)
    StoreSearchShopList[index] = {
        storeName = storeName,
        sellerName = sellerName,
        sellerIdentification = sellerIdentification
    }
end

function StoreSearch.InsertStoreItem(index, sellerName, Slot, Coin1, Coin2, Coin3, Coin4, Zen, iItemIndex, Itemlevel, iOp1, iOp2, iOp3, iExc, iAncient, iJoH, iSockCount, iSock1, iSock2, iSock3, iSock4, iSock5)
    StoreSearchItensList[index] = {
        sellerName = sellerName, Slot = Slot, Coin1 = Coin1, Coin2 = Coin2, Coin3 = Coin3, Coin4 = Coin4, Zen = Zen, ItemIndex = iItemIndex, Level = Itemlevel, Op1 = iOp1, Op2 = iOp2, Op3 = iOp3, Exc = iExc
			, Ancient = iAncient, JoH = iJoH, SockCount = iSockCount, Sock1 = iSock1, Sock2 = iSock2, Sock3 = iSock3, Sock4 = iSock4, Sock5 = iSock5
    }
end

function StoreSearch.CalcScrollBar()
    StoreSearchScrollBarPosY = 0
	StoreSearchScrollBarPosMouse = 0
	StoreSearchScrollBarCurrentLine = 0
	StoreSearchScrollBarRenderMaxLines = #StoreSearchShopList - 1
	StoreSearchScrollMaxLine = 10
	StoreSearchScrollBarPosYMultiplier = (190 / (#StoreSearchShopList - 10))
	StoreSearchScrollBarRenderPageMax = 10
end

function StoreSearch.CalcScrollBarItems()
    StoreSearchItemsScrollBarPosY = 0
	StoreSearchItemsScrollBarPosMouse = 0
	StoreSearchItemsScrollBarCurrentLine = 0
	StoreSearchItemsScrollBarRenderMaxLines = #StoreSearchItensList - 1
	StoreSearchItemsScrollMaxLine = 10
	StoreSearchItemsScrollBarPosYMultiplier = (190 / (#StoreSearchItensList - 10))
	StoreSearchItemsScrollBarRenderPageMax = 10
end

function StoreSearch.ScrollingBar(value)
    if StoreSearchPage == 1
    then
        if value > 0
        then
            if (StoreSearchItemsScrollBarRenderPageMax < (StoreSearchItemsScrollBarRenderMaxLines))
            then
                StoreSearchItemsScrollBarRenderPageMax = StoreSearchItemsScrollBarRenderPageMax + 1
                StoreSearchItemsScrollBarCurrentLine = StoreSearchItemsScrollBarCurrentLine + 1
                StoreSearchItemsScrollBarPosY = StoreSearchItemsScrollBarPosY + StoreSearchItemsScrollBarPosYMultiplier
            end
        elseif value < 0
        then
            if (StoreSearchItemsScrollBarRenderPageMax > StoreSearchItemsScrollMaxLine)
            then
                StoreSearchItemsScrollBarRenderPageMax = StoreSearchItemsScrollBarRenderPageMax - 1
                StoreSearchItemsScrollBarCurrentLine = StoreSearchItemsScrollBarCurrentLine - 1
                StoreSearchItemsScrollBarPosY = StoreSearchItemsScrollBarPosY - StoreSearchItemsScrollBarPosYMultiplier
            end
        end
    else
        if value > 0
        then
            if (StoreSearchScrollBarRenderPageMax < (StoreSearchScrollBarRenderMaxLines))
            then
                StoreSearchScrollBarRenderPageMax = StoreSearchScrollBarRenderPageMax + 1
                StoreSearchScrollBarCurrentLine = StoreSearchScrollBarCurrentLine + 1
                StoreSearchScrollBarPosY = StoreSearchScrollBarPosY + StoreSearchScrollBarPosYMultiplier
            end
        elseif value < 0
        then
            if (StoreSearchScrollBarRenderPageMax > StoreSearchScrollMaxLine)
            then
                StoreSearchScrollBarRenderPageMax = StoreSearchScrollBarRenderPageMax - 1
                StoreSearchScrollBarCurrentLine = StoreSearchScrollBarCurrentLine - 1
                StoreSearchScrollBarPosY = StoreSearchScrollBarPosY - StoreSearchScrollBarPosYMultiplier
            end
        end
    end
end

function StoreSearch.ScrollMouse(value)
    if StoreSearchVisible == 0
    then
        return
    end

    if StoreSearchItemSelected == 0
    then
        if MousePosX() >= m_PosX and MousePosX() <= m_PosX + 330
        then
            if MousePosY() >= m_PosY + 95 and MousePosY() <= m_PosY + 275
            then
                if value > 0
                then
                    StoreSearch.ScrollingBar(-1)
                end
                
                if value < 0
                then
                    StoreSearch.ScrollingBar(1)
                end
            end
        end
    else
        StoreSearchItemList.ScrollMouse(value)
    end
end

function StoreSearch.FindItens(text)
    if text == nil
    then
        return
    end

    if #text <= 0
    then
        return
    end

    local packetString = string.format("%s_%s", STORE_SEARCH_PACKET_FIND_ITEM_NAME, UserGetName())
    CreatePacket(packetString, STORE_SEARCH_PACKET)
    SetCharPacketLength(packetString, text, 30)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function StoreSearch.FindItensReceive(PacketName)
    local count = GetWordPacket(PacketName, -1)

    if count > 0
	then
        for i = 0, (count-1) do
            StoreSearch.InsertStoreItem(i+1, GetCharPacketLength(PacketName, -1, 10), GetBytePacket(PacketName, -1)
            , GetDwordPacket(PacketName, -1), GetDwordPacket(PacketName, -1), GetDwordPacket(PacketName, -1)
            , GetDwordPacket(PacketName, -1), GetDwordPacket(PacketName, -1), GetWordPacket(PacketName, -1), GetBytePacket(PacketName, -1)
            , GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1)
            , GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1)
            , GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1), GetBytePacket(PacketName, -1))
        end
    end

    StoreSearch.CalcScrollBarItems()
end

function StoreSearch.ProcessListAndOpen(PacketName)
    StoreSearchShopList = {}
    StoreSearchItensList = {}
    StoreSearchVisible = 1

    local count = GetWordPacket(PacketName, -1)

    if count > 0
	then
        for i = 0, (count-1) do
            StoreSearch.InsertStoreList(i+1, GetCharPacketLength(PacketName, -1, 36), GetCharPacketLength(PacketName, -1, 10), GetWordPacket(PacketName, -1))
        end
    end

    StoreSearch.CalcScrollBar()
end

function StoreSearch.Protocol(Packet, PacketName)
    if Packet ~= STORE_SEARCH_PACKET
    then
        return
    end

    if PacketName == string.format("%s_%s", STORE_SEARCH_PACKET_NAME, UserGetName())
    then
        StoreSearch.ProcessListAndOpen(PacketName)
        ClearPacket(PacketName)
    elseif PacketName == string.format("%s_%s", STORE_SEARCH_ITEM_LIST_PACKET_NAME, UserGetName())
    then
        StoreSearchItemList.ProcessListItem(PacketName)
        ClearPacket(PacketName)
    elseif PacketName == string.format("%s_%s", STORE_SEARCH_PACKET_FIND_ITEM_NAME, UserGetName())
    then
        StoreSearch.FindItensReceive(PacketName)
        ClearPacket(PacketName)
    end
end

function StoreSearch.Init()
    if STORE_SEARCH_SWITCH ~= 1
    then
        return
    end

    StoreSearchShopList = nil
    StoreSearchItensList = nil

    InterfaceController.ClientProtocol(StoreSearch.Protocol)
	InterfaceController.MainProc(StoreSearch.Render)
	InterfaceController.UpdateMouse(StoreSearch.UpdateMouse)
	InterfaceController.UpdateKey(StoreSearch.UpdateKeyEvent)
    InterfaceController.MainProcWorldKey(StoreSearch.MainProcWorldKey)
    InterfaceController.ScrollMouse(StoreSearch.ScrollMouse)
end

StoreSearch.Init()

return StoreSearch