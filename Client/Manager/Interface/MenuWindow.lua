MENU_WINDOW_SWITCH = 1

local MENU_WINDOW_MESSAGES = {}

MENU_WINDOW_MESSAGES['Por'] = {
[1] = 'Menu Rápido',
[2] = 'Banco de jóias',
[3] = 'Procurar Party',
}

MENU_WINDOW_MESSAGES['Eng'] = {
[1] = 'Quick Menu',
[2] = 'Jewel Bank',
[3] = 'Party Search',
}

MENU_WINDOW_MESSAGES['Spn'] = {
[1] = 'Menú rápido',
[2] = 'Banco de joyas',
[3] = 'Grupo de búsqueda',
}

MenuWindow = {}

local MenuWindowVisible = 0
local MenuWindowImage1 = -1
local MenuWindowImage2 = -1

function MenuWindow.Render()
    EnableAlphaTest()

    RenderImage(MenuWindowImage2, 157, 0, 36, 18)

    if (MousePosX() >= 157 and MousePosX() <= 157 + 16)
        and (MousePosY() >= 2 and MousePosY() <= 2 + 12)
    then
        glColor3f(1.00, 1.00, 1.00)
    else
        glColor3f(0.80, 0.80, 0.80)
    end

    RenderImage(MenuWindowImage1, 158, 2, 16, 12)

    if (MousePosX() >= 157 and MousePosX() <= 157 + 16)
        and (MousePosY() >= 2 and MousePosY() <= 2 + 12)
    then
        --Text
        SetFontType(1)
        
        SetTextColor(255, 255, 255, 255)
        
        SetTextBg(0, 0, 0, 200)
        
        RenderText3(140, 25, MENU_WINDOW_MESSAGES[GetLanguage()][1], 60, 3)
    end

    DisableAlphaBlend()

    if MenuWindowVisible ~= 1
    then
        return
    end

    MenuWindow.RenderWindow()
end

function MenuWindow.RenderWindow()
    EnableAlphaTest()

    glColor4f(1.0, 1.0, 1.0, 1.0)

    local PosX = (640 / 2) - (230 / 2)
    local PosY = 80

    --Render Window
    RenderImage(0x7A5A, PosX, PosY + 2.0, 222.0, 210.0)

    RenderImage(0x7A63, PosX, PosY, 230, 67)

    --Close
    RenderImage(0x7EC5, PosX + (230 - 36), PosY, 36, 29)

    PosY = PosY + 45.0

	for i = 1, 8 do
		RenderImage(0x7A58, PosX, PosY, 230.0, 15.0)

        PosY = PosY + 15.0
    end

    RenderImage(0x7A58, PosX, PosY, 230.0, 5.0)
    PosY = PosY + 5.0

	RenderImage(0x7A59, PosX, PosY, 230.0, 45.0)

    PosY = 80

    --Render buttons
    MenuWindow.RenderButtons(PosX, PosY)

    --Render Texts
    MenuWindow.RenderText(PosX, PosY)

    DisableAlphaBlend()
end

function MenuWindow.RenderButtons(x, y)
    SetFontType(1)
	
	SetTextColor(255, 255, 255, 255)
	
	SetTextBg(0, 0, 0, 0)

    local addY = 50.0

    for i = 1, 2 do
        if (MousePosX() >= x + ((230 / 2) - (110 / 2)) and MousePosX() <= x + ((230 / 2) - (110 / 2)) + 130)
            and (MousePosY() >= y + addY and MousePosY() <= y + addY + 30)
        then
            RenderImage2(31326, x + ((230 / 2) - (110 / 2)), y + addY, 130, 30, 0, 0.2264566, 1.0, 0.2245212, 1, 1, 1.0)
        else
            RenderImage2(31326, x + ((230 / 2) - (110 / 2)), y + addY, 130, 30, 0, 0, 1.0, 0.2245212, 1, 1, 1.0)
        end

	    RenderText3(x + ((230 / 2) - (130 / 2)), y + addY + 10, MENU_WINDOW_MESSAGES[GetLanguage()][1+i], 130, 3)

        addY = addY + 35
    end
end

function MenuWindow.RenderText(x, y)
    --Text
	SetFontType(1)
	
	SetTextColor(255, 189, 25, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(x, y + 10, MENU_WINDOW_MESSAGES[GetLanguage()][1], 230, 3)
end

function MenuWindow.UpdateMouse()
    if (MousePosX() >= 157 and MousePosX() <= 157 + 16)
        and (MousePosY() >= 2 and MousePosY() <= 2 + 12)
    then
        if (CheckClickClient() == 1)
        then
            MenuWindow.Open()
            DisableClickClient()
            return
        end
    end

    --Update mouse window
    if MenuWindowVisible ~= 1
    then
        return
    end

    local PosX = (640 / 2) - (230 / 2)
    local PosY = 80

    --Close button
    if (MousePosX() >= PosX + (230 - 36) and MousePosX() <= PosX + (230 - 36) + 36)
        and (MousePosY() >= PosY and MousePosY() <= PosY + 29)
    then
        if (CheckClickClient() == 1)
        then
            MenuWindowVisible = 0
            DisableClickClient()
            return
        end
    end

    local addY = 50.0

    for i = 1, 2 do
        if (MousePosX() >= PosX + ((230 / 2) - (110 / 2)) and MousePosX() <= PosX + ((230 / 2) - (110 / 2)) + 130)
            and (MousePosY() >= PosY + addY and MousePosY() <= PosY + addY + 30)
        then
            if (CheckClickClient() == 1)
            then
                --Jewel bank
                if (i == 1)
                then
                    JewelBank.Open()
                elseif (i == 2)
                then
                    PartySearch.Open()
                end

                MenuWindowVisible = 0
                DisableClickClient()
                return
            end
        end

        addY = addY + 35
    end

    DisableClickClient()
end

function MenuWindow.UpdateKeyEvent()
    if MenuWindowVisible ~= 1
    then
        return
    end

    if (CheckPressedKey(Keys.Escape) == 1)
	then
		MenuWindowVisible = 0
	end
end

function MenuWindow.Open()
    if	CheckWindowOpen(UIFriendList)		== 1	then	return							end
	if	CheckWindowOpen(UIMoveList)			== 1	then	return							end
	if	CheckWindowOpen(UIParty)			== 1	then	CloseWindow(UIParty)			end
	if	CheckWindowOpen(UIQuest)			== 1	then	return							end
	if	CheckWindowOpen(UIGuild)			== 1	then	CloseWindow(UIGuild)			end
	if	CheckWindowOpen(UITrade)			== 1	then	return							end
	if	CheckWindowOpen(UIWarehouse)		== 1	then	return							end
	if	CheckWindowOpen(UIChaosBox)			== 1	then	return							end
	if	CheckWindowOpen(UICommandWindow)	== 1	then	return							end
	if	CheckWindowOpen(UIPetInfo)			== 1	then	return							end
	if	CheckWindowOpen(UIShop)				== 1	then	return							end
	if	CheckWindowOpen(UIStore)			== 1	then	CloseWindow(UIStore)			end
	if	CheckWindowOpen(UIOtherStore)		== 1	then	return							end
	if	CheckWindowOpen(UICharacter)		== 1	then	CloseWindow(UICharacter)		end
	if	CheckWindowOpen(UIOptions)			== 1	then	return							end
	if	CheckWindowOpen(UIHelp)				== 1	then	return							end
	if	CheckWindowOpen(UIFastDial)			== 1	then	return							end
	if	CheckWindowOpen(UISkillTree)		== 1	then	return							end
	if	CheckWindowOpen(UINPC_Titus)		== 1	then	return							end
	if	CheckWindowOpen(UICashShop)			== 1	then	return							end
	if	CheckWindowOpen(UIFullMap)			== 1	then	return							end
	if	CheckWindowOpen(UINPC_Dialog)		== 1	then	return							end
	if	CheckWindowOpen(UIGensInfo)			== 1	then	CloseWindow(UIGensInfo)			end
	if	CheckWindowOpen(UINPC_Julia)		== 1	then	return							end
	if	CheckWindowOpen(UIExpandInventory)	== 1	then	CloseWindow(UIExpandInventory)	end
	if	CheckWindowOpen(UIExpandWarehouse)	== 1	then	return							end
	if	CheckWindowOpen(UIMuHelper)			== 1	then	CloseWindow(UIMuHelper)			end
    if	CheckWindowOpen(UIInventory)	    == 1	then	CloseWindow(UIInventory)		end

    MenuWindowVisible = 1
end

function MenuWindow.LoadImages()
    MenuWindowImage1 = LoadImageByDir("Interface///Menu2.tga")
	MenuWindowImage2 = LoadImageByDir("Interface///Menu_BG.tga")
end

function MenuWindow.Init()
    if MENU_WINDOW_SWITCH ~= 1
    then
        return
    end

    MenuWindowVisible = 0

    InterfaceController.LoadImages(MenuWindow.LoadImages)
	InterfaceController.MainProc(MenuWindow.Render)
	InterfaceController.UpdateMouse(MenuWindow.UpdateMouse)
	InterfaceController.UpdateKey(MenuWindow.UpdateKeyEvent)
end

MenuWindow.Init()

return MenuWindow