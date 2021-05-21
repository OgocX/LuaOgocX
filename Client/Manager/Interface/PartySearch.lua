local PARTY_SEARCH_SWITCH = 1

local PARTY_SEARCH_PACKET_NAME = 'PartySearch'
local PARTY_SEARCH_PACKET_SETTINGS_NAME = 'PartySearchSettings'
local PARTY_SEARCH_PACKET_JOIN_NAME = 'PartySearchJoin'
local PARTY_SEARCH_PACKET = 4

local PARTY_SEARCH_MESSAGES = {}

PARTY_SEARCH_MESSAGES['Por'] = {
[1] = 'Procurar Party',
[2] = 'Procurar Party Configurações',
[3] = 'Status: %s',
[4] = 'Off',
[5] = 'On',
[6] = 'Player',
[7] = 'Map',
[8] = 'X',
[9] = 'Y',
[10] = 'Quantidade',
[11] = 'Entrar',
[12] = 'Precisa para entrar:',
[13] = 'Level: %d',
[14] = 'Necessário senha',
[15] = 'Somente Guild',
[16] = 'Somente Aliança',
[17] = 'Somente a mesma class do dono',
[18] = 'Dark Wizard',
[19] = 'Dark Knight',
[20] = 'Elf',
[21] = 'Magic Gladiador',
[22] = 'Dark Lord',
[23] = 'Sumonner',
[24] = 'Rage Fight',
[25] = 'Ativar Party Search',
[26] = 'Max Level',
[27] = 'Password',
[28] = 'Somente Guild',
[29] = 'Somente Aliança',
[30] = 'Somente mesma classe',
[31] = 'Não foi encontrado nenhuma party no momento.',
[32] = 'Digite a senha da party!',
}

PARTY_SEARCH_MESSAGES['Eng'] = {
[1] = 'Search Party',
[2] = 'Search Party Settings',
[3] = 'Status: %s',
[4] = 'Off',
[5] = 'On',
[6] = 'Player',
[7] = 'Map',
[8] = 'X',
[9] = 'Y',
[10] = 'Quantity',
[11] = 'Sign in',
[12] = 'Need to enter:',
[13] = 'Level: %d',
[14] = 'Password required',
[15] = 'Guild only',
[16] = 'Alliance only',
[17] = 'Only the same class as the owner',
[18] = 'Dark Wizard',
[19] = 'Dark Knight',
[20] = 'Elf',
[21] = 'Magic Gladiator',
[22] = 'Dark Lord',
[23] = 'Sumonner',
[24] = 'Rage Fight',
[25] = 'Enable Party Search',
[26] = 'Max Level',
[27] = 'Password',
[28] = 'Guild only',
[29] = 'Alliance only',
[30] = 'Only same class',
[31] = 'No party was found at the moment.',
[32] = 'Enter the Party password!',
}

PARTY_SEARCH_MESSAGES['Spn'] = {
[1] = 'Grupo de búsqueda',
[2] = 'Configuración del grupo de búsqueda',
[3] = 'Estado: %s',
[4] = 'Desactivado',
[5] = 'Activado',
[6] = 'Jugador',
[7] = 'Mapa',
[8] = 'X',
[9] = 'Y',
[10] = 'Cantidad',
[11] = 'Iniciar sesión',
[12] = 'Necesito ingresar:',
[13] = 'Nivel: %d',
[14] = 'Se requiere contraseña',
[15] = 'Solo gremio',
[16] = 'Solo alianza',
[17] = 'Solo la misma clase que el propietario',
[18] = 'Mago ??oscuro',
[19] = 'Caballero de la noche',
[20] = 'Elfo',
[21] = 'Gladiador mágico',
[22] = 'Señor Oscuro',
[23] = 'Sumonner',
[24] = 'Lucha de rabia',
[25] = 'Habilitar búsqueda de grupo',
[26] = 'Nivel máximo',
[27] = 'Contraseña',
[28] = 'Solo gremio',
[29] = 'Solo alianza',
[30] = 'Solo la misma clase',
[31] = 'No se encontró ninguna fiesta en este momento.',
[32] = '¡Ingrese la contraseña de la fiesta!',
}

PartySearch = {}

local PartySearchVisible = 1
local PartySearchPage = 1
local PartySearchList = nil

local PartySearchCurrentPage = 0
local PartySearchMaxPages = 0
local PartySearchStartLine = 0
local PartySearchEndLine = 0
local PartySearchMaxLines = 0

local PartySearchIsOn = 1
local PartySearchLevel = 400
local PartySearchPassword = ''
local PartySearchPasswordSelected = 0
local PartySearchClickClass = { 1, 1, 1, 1, 1, 1, 1 }
local PartySearchOnlyClass = 0
local PartySearchOnlyGuild = 0
local PartySearchOnlyAlliance = 0

local PartySearchPasswordRequired = 0
local PartySearchNameSelected = ''

function PartySearch.Render()
    if PartySearchVisible ~= 1
    then
        return
    end

    EnableAlphaTest()

    glColor4f(1.0, 1.0, 1.0, 1.0)

    if PartySearchPasswordRequired == 1
    then
        PartySearch.RenderPasswordBox()
    elseif PartySearchPage == 0
    then
        PartySearch.RenderImage()
        PartySearch.RenderText()

         --Render List
         PartySearch.RenderList()
    else 
        PartySearch.SettingsRender()
        PartySearch.SettingsRenderText()
    end

    DisableAlphaBlend()
end

function PartySearch.RenderImage()
    local PosX = (640 / 2) - (230 / 2)
    local PosY = 70

    --Render Window
    RenderImage(0x7A5A, PosX, PosY + 2.0, 222.0, 315.0)

    RenderImage(0x7A63, PosX, PosY, 230, 67)

    --Close
    RenderImage(0x7EC5, PosX + (230 - 36), PosY, 36, 29)

    --Division
    RenderImage(0x7A62, PosX, PosY + 45, 230.0, 21.0)

    RenderImage(0x7A62, PosX, PosY + 70, 230.0, 21.0)

    PosY = PosY + 60.0

	for i = 1, 14 do
		RenderImage(0x7A58, PosX, PosY, 230.0, 15.0)

        PosY = PosY + 15.0
    end

    RenderImage(0x7A58, PosX, PosY, 230.0, 5.0)
    PosY = PosY + 5.0

	RenderImage(0x7A59, PosX, PosY, 230.0, 45.0)

    PosY = 70

    --Buttons
    if (MousePosX() >= (PosX + 230 - 45) and MousePosX() <= (PosX + 230 - 45) + 18)
        and (MousePosY() >= (PosY + 35) and MousePosY() <= (PosY + 35) + 13)
    then
        RenderImage2(0x7C11, PosX + 230 - 45, PosY + 35, 18.0, 13.0, 0, 0.22, 0.52, 0.18, 1, 1, 1.0)
    else
        RenderImage2(0x7C11, PosX + 230 - 45, PosY + 35, 18.0, 13.0, 0, 0.02, 0.52, 0.18, 1, 1, 1.0)
    end

    if (MousePosX() >= (PosX + 230 - 70) and MousePosX() <= (PosX + 230 - 70) + 18)
        and (MousePosY() >= (PosY + 35) and MousePosY() <= (PosY + 35) + 13)
    then
        RenderImage2(0x7E53, PosX + 230 - 70, PosY + 35, 18.0, 13.0, 0, 0.20, 0.655, 0.17, 1, 1, 1.0)
    else
        RenderImage2(0x7E53, PosX + 230 - 70, PosY + 35, 18.0, 13.0, 0, 0.01, 0.655, 0.17, 1, 1, 1.0)
    end

    if PartySearchMaxPages > 0
    then
        --left
        if (MousePosX() >= (PosX + 70) and MousePosX() <= (PosX + 70) + 25)
            and (MousePosY() >= (PosY + 288) and MousePosY() <= (PosY + 288) + 16)
        then
            RenderImage2(0x7E59, PosX + 75, PosY + 288, 18.0, 13.0, 0, 0.18, 0.52, 0.18, 1, 1, 1.0)
        else
            RenderImage2(0x7E59, PosX + 75, PosY + 288, 18.0, 13.0, 0, 0.0, 0.52, 0.18, 1, 1, 1.0)
        end

        --right
        if (MousePosX() >= (PosX + 135) and MousePosX() <= (PosX + 135) + 25)
            and (MousePosY() >= (PosY + 288) and MousePosY() <= (PosY + 288) + 16)
        then
            RenderImage2(0x7E5A, PosX + 135, PosY + 288, 18.0, 13.0, 0, 0.18, 0.52, 0.18, 1, 1, 1.0)
        else
            RenderImage2(0x7E5A, PosX + 135, PosY + 288, 18.0, 13.0, 0, 0.0, 0.52, 0.18, 1, 1, 1.0)
        end
    end
end

function PartySearch.RenderText()
    local PosX = (640 / 2) - (230 / 2)
    local PosY = 70

    --Text
	SetFontType(1)
	
	SetTextColor(255, 189, 25, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(PosX, PosY + 10, PARTY_SEARCH_MESSAGES[GetLanguage()][1], 230, 3)

    SetTextColor(255, 255, 255, 255)

    SetTextBg(0, 0, 0, 0)

    --Top message
    local stringStatus = string.format(PARTY_SEARCH_MESSAGES[GetLanguage()][3], PARTY_SEARCH_MESSAGES[GetLanguage()][4 + PartySearchIsOn])
    RenderText3(PosX + 12, PosY + 37, stringStatus, 65, 3)

    --Infos message
    RenderText3(PosX + 15, PosY + 64, PARTY_SEARCH_MESSAGES[GetLanguage()][6], 35, 3)

    RenderText3(PosX + 67, PosY + 64, PARTY_SEARCH_MESSAGES[GetLanguage()][7], 30, 3)

    RenderText3(PosX + 115, PosY + 64, PARTY_SEARCH_MESSAGES[GetLanguage()][8], 20, 3)

    RenderText3(PosX + 130, PosY + 64, PARTY_SEARCH_MESSAGES[GetLanguage()][9], 20, 3)

    RenderText3(PosX + 150, PosY + 64, PARTY_SEARCH_MESSAGES[GetLanguage()][10], 60, 3)

    if PartySearchMaxPages > 0
    then
        local stringPages = string.format('%d / %d', PartySearchCurrentPage + 1, PartySearchMaxPages + 1)
        RenderText3(PosX, PosY + 290, stringPages, 230, 3)
    end
end

function PartySearch.RenderList()
    if PartySearchList == nil
    then
        return
    end

    local PosX = (640 / 2) - (230 / 2)
    local PosY = 165

    if #PartySearchList <= 0
    then
        RenderText3(PosX, PosY + 20, PARTY_SEARCH_MESSAGES[GetLanguage()][31], 230, 3)
        return
    end

    SetFontType(1)
	
	SetTextBg(0, 0, 0, 0)

    local line = 0
    local addY = 0.0

    for i = 1, #PartySearchList do
        if line >= PartySearchStartLine and line < PartySearchEndLine
		then
            local list = PartySearchList[i]

            if list ~= nil
            then
                RenderImage(0x79A2, PosX + 10, PosY + addY, 171.0, 23.0)

                if GetCountParty() <= 0 and list.Count <= 4
                then
                    RenderImage(0x7AA4, PosX + 15 + 187, PosY + 4 + addY, 16.0, 15.0)
                end

                if PartySearchList[i].Password == 1
                then
                    RenderImage2(0x7AB8, PosX + 15 + 167, PosY + 4 + addY, 19.0, 15.0, 0.0, 0.03, 0.60, 0.38, 1.0, 1.0, 1.0)
                else
                    RenderImage2(0x7AB7, PosX + 15 + 167, PosY + 4 + addY, 19.0, 15.0, 0.0, 0.03, 0.60, 0.38, 1.0, 1.0, 1.0)
                end

                SetTextBg(0, 0, 0, 0)

                SetTextColor(255, 189, 25, 255)

                RenderText3(PosX + 15, PosY + 8 + addY, list.Owner, 50, 1)

                SetTextColor(255, 255, 255, 255)

                RenderText3(PosX + 105, PosY + 8 + addY, GetMapName(PartySearchList[i].Map), 45, 7)
                RenderText3(PosX + 120, PosY + 8 + addY, string.format('%d', PartySearchList[i].X), 15, 1)
                RenderText3(PosX + 135, PosY + 8 + addY, string.format('%d', PartySearchList[i].Y), 15, 1)
                RenderText3(PosX + 160, PosY + 8 + addY, string.format('%d/5', PartySearchList[i].Count), 20, 1)

                if (MousePosX() >= (PosX + 15 + 167) and MousePosX() <= (PosX + 15 + 167) + 16)
                    and (MousePosY() >= (PosY + 4 + addY) and MousePosY() <= (PosY + 4 + addY) + 16)
                then
                    PartySearch.RenderPartyInfo(list, PosX + 232, PosY)
                end

                if (MousePosX() >= (PosX + 15 + 187) and MousePosX() <= (PosX + 15 + 187) + 16)
                    and (MousePosY() >= (PosY + 4 + addY) and MousePosY() <= (PosY + 4 + addY) + 16) and GetCountParty() <= 0 and list.Count <= 4
                then
                    SetTextColor(255, 255, 255, 255)
                    SetTextBg(0, 0, 0, 200)
                    RenderText3(PosX + 220, PosY + 8 + addY, PARTY_SEARCH_MESSAGES[GetLanguage()][11], 45, 3)
                end

                addY = addY + 25.0
            end
        end

        line = line + 1
    end
end

function PartySearch.RenderPartyInfo(partyInfo, x, y)
    local height = 40.0
    local texts = {}
    local textsIndex = 1

    texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][12]
    textsIndex = textsIndex + 1

    texts[textsIndex] = string.format(PARTY_SEARCH_MESSAGES[GetLanguage()][13], partyInfo.Level)
    textsIndex = textsIndex + 1

    if partyInfo.Password == 1
    then
        height = height + 10.0
        texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][14]
        textsIndex = textsIndex + 1
    end

    if partyInfo.OnlyGuild == 1
    then
        height = height + 10.0
        texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][15]
        textsIndex = textsIndex + 1
    end

    if partyInfo.OnlyAlliance == 1
    then
        height = height + 10.0
        texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][16]
        textsIndex = textsIndex + 1
    end

    if partyInfo.OnlyClass == 1
    then
        height = height + 10.0
        texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][17]
        textsIndex = textsIndex + 1
    else
        if partyInfo.ClassSM == 1
        then
            height = height + 10.0
            texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][18]
            textsIndex = textsIndex + 1
        end
        if partyInfo.ClassBK == 1
        then
            height = height + 10.0
            texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][19]
            textsIndex = textsIndex + 1
        end
        if partyInfo.ClassELF == 1
        then
            height = height + 10.0
            texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][20]
            textsIndex = textsIndex + 1
        end
        if partyInfo.ClassMG == 1
        then
            height = height + 10.0
            texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][21]
            textsIndex = textsIndex + 1
        end
        if partyInfo.ClassDL == 1
        then
            height = height + 10.0
            texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][22]
            textsIndex = textsIndex + 1
        end
        if partyInfo.ClassSUM == 1
        then
            height = height + 10.0
            texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][23]
            textsIndex = textsIndex + 1
        end
        if partyInfo.ClassRF == 1
        then
            height = height + 10.0
            texts[textsIndex] = PARTY_SEARCH_MESSAGES[GetLanguage()][24]
            textsIndex = textsIndex + 1
        end
    end

    EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 0.8)

	DrawBar(x, y, 120, height, 0.0, 0)
	
	EndDrawBar()
	DisableAlphaBlend()

    EnableAlphaTest()

    local addY = 5.0

    for i = 1 , textsIndex do
        SetTextColor(255, 255, 255, 255)
        RenderText3(x, y + addY, texts[i], 120, 3)

        if i == 1
        then
            addY = addY + 15.0
        else
            addY = addY + 10.0
        end
    end
end

function PartySearch.SettingsRender()
    local PosX = (640 / 2) - (230 / 2)
    local PosY = 70

    --Render Window
    RenderImage(0x7A5A, PosX, PosY + 2.0, 222.0, 315.0)

    RenderImage(0x7A63, PosX, PosY, 230, 67)

    --Close
    RenderImage(0x7EC5, PosX + (230 - 36), PosY, 36, 29)

    --Division
    RenderImage(0x7A62, PosX, PosY + 42, 230.0, 21.0)

    RenderImage(0x7A62, PosX, PosY + 130, 230.0, 21.0)

    RenderImage(0x7A62, PosX, PosY + 270, 230.0, 21.0)

    PosY = PosY + 60.0

	for i = 1, 14 do
		RenderImage(0x7A58, PosX, PosY, 230.0, 15.0)

        PosY = PosY + 15.0
    end

    RenderImage(0x7A58, PosX, PosY, 230.0, 5.0)
    PosY = PosY + 5.0

	RenderImage(0x7A59, PosX, PosY, 230.0, 45.0)

    PosY = 70

    --Buttom 'ok'
    if (MousePosX() >= (PosX + 115 - 28) and MousePosX() <= (PosX + 115 - 28) + 54)
        and (MousePosY() >= (PosY + 284) and MousePosY() <= (PosY + 284) + 30)
    then
        RenderImage2(0x7A5B, PosX + 115 - 28, PosY + 284, 54.0, 30.0, 0.0, 0.235, 0.84, 0.23, 1.00, 1.0, 1.0)
    else
        RenderImage2(0x7A5B, PosX + 115 - 28, PosY + 284, 54.0, 30.0, 0.0, 0.0, 0.84, 0.23, 1.00, 1.0, 1.0)
    end

    --Level
    if (MousePosX() >= (PosX + 15 + 135) and MousePosX() <= (PosX + 15 + 135) + 11)
        and (MousePosY() >= (PosY + 60) and MousePosY() <= (PosY + 60) + 10) and CheckPressedKey(Keys.LButton) == 1
    then
        RenderImage2(71002, PosX + 15 + 135, PosY + 60, 11.0, 10.0, 0.0, 0.0, 0.98, 0.94, 1.00, 1.0, 1.0)
    else
        RenderImage2(71001, PosX + 15 + 135, PosY + 60, 11.0, 10.0, 0.0, 0.0, 0.98, 0.94, 1.00, 1.0, 1.0)
    end

    if (MousePosX() >= (PosX + 15 + 170) and MousePosX() <= (PosX + 15 + 170) + 11)
        and (MousePosY() >= (PosY + 60) and MousePosY() <= (PosY + 60) + 10) and CheckPressedKey(Keys.LButton) == 1
    then
        RenderImage2(71004, PosX + 15 + 170, PosY + 60, 11.0, 10.0, 0.0, 0.0, 0.98, 0.94, 1.00, 1.0, 1.0)
    else
        RenderImage2(71003, PosX + 15 + 170, PosY + 60, 11.0, 10.0, 0.0, 0.0, 0.98, 0.94, 1.00, 1.0, 1.0)
    end

    --Box click
    if PartySearchIsOn == 1
    then
        RenderImage2(31743, PosX + 180, PosY + 34, 13, 13, 0.0, 0.5, 1.0, 0.5, 1, 1, 1.0)
    else
        RenderImage2(31743, PosX + 180, PosY + 34, 13, 13, 0.0, 0.0, 1.0, 0.5, 1, 1, 1.0)
    end

    if PartySearchOnlyGuild == 1
    then
        RenderImage2(31743, PosX + 180, PosY + 89, 13, 13, 0.0, 0.5, 1.0, 0.5, 1, 1, 1.0)
    else
        RenderImage2(31743, PosX + 180, PosY + 89, 13, 13, 0.0, 0.0, 1.0, 0.5, 1, 1, 1.0)
    end

    if PartySearchOnlyAlliance == 1
    then
        RenderImage2(31743, PosX + 180, PosY + 105, 13, 13, 0.0, 0.5, 1.0, 0.5, 1, 1, 1.0)
    else
        RenderImage2(31743, PosX + 180, PosY + 105, 13, 13, 0.0, 0.0, 1.0, 0.5, 1, 1, 1.0)
    end

    if PartySearchOnlyClass == 1
    then
        RenderImage2(31743, PosX + 180, PosY + 120, 13, 13, 0.0, 0.5, 1.0, 0.5, 1, 1, 1.0)
    else
        RenderImage2(31743, PosX + 180, PosY + 120, 13, 13, 0.0, 0.0, 1.0, 0.5, 1, 1, 1.0)
    end

    addY = 0.0

    for i = 1, 7 do
        if PartySearchClickClass[i] == 1
        then
            RenderImage2(31743, PosX + 180, PosY + 150 + addY, 13, 13, 0.0, 0.5, 1.0, 0.5, 1, 1, 1.0)
        else
            RenderImage2(31743, PosX + 180, PosY + 150 + addY, 13, 13, 0.0, 0.0, 1.0, 0.5, 1, 1, 1.0)
        end

        addY = addY + 19.0
    end

    glColor3f(1.00, 1.00, 1.00)

    --division
    RenderImage(0x7B67, PosX + 37, PosY + 70, 155.0, 3.0)

    RenderImage(0x7B67, PosX + 37, PosY + 85, 155.0, 3.0)

    RenderImage(0x7B67, PosX + 37, PosY + 102, 155.0, 3.0)

    RenderImage(0x7B67, PosX + 37, PosY + 102, 155.0, 3.0)

    RenderImage(0x7B67, PosX + 37, PosY + 118, 155.0, 3.0)

    addY = 0.0

    for i = 1, 6 do
        RenderImage(0x7B67, PosX + 37, PosY + 163 + addY, 155.0, 3.0)

        addY = addY + 19.0
    end

    --Box Level
    EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 1.0)

	DrawBar(PosX + 15 + 148, PosY + 60, 20, 10, 0.0, 0)
	
	EndDrawBar()
	DisableAlphaBlend()

    --Box Pass
    EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 1.0)

	DrawBar(PosX + 15 + 110, PosY + 74, 60, 10, 0.0, 0)
	
	EndDrawBar()
	DisableAlphaBlend()

    EnableAlphaTest()
end

function PartySearch.SettingsRenderText()
    local PosX = (640 / 2) - (230 / 2)
    local PosY = 70

    --Text
	SetFontType(0)
	
	SetTextColor(255, 189, 25, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(PosX, PosY + 10, PARTY_SEARCH_MESSAGES[GetLanguage()][2], 230, 3)

    SetTextColor(255, 255, 255, 255)

    RenderText3(PosX + 40, PosY + 37, PARTY_SEARCH_MESSAGES[GetLanguage()][25], 100, 1)

    RenderText3(PosX + 40, PosY + 63, PARTY_SEARCH_MESSAGES[GetLanguage()][26], 100, 1)

    RenderText3(PosX + 40, PosY + 78, PARTY_SEARCH_MESSAGES[GetLanguage()][27], 100, 1)

    RenderText3(PosX + 40, PosY + 95, PARTY_SEARCH_MESSAGES[GetLanguage()][28], 100, 1)

    RenderText3(PosX + 40, PosY + 110, PARTY_SEARCH_MESSAGES[GetLanguage()][29], 100, 1)

    RenderText3(PosX + 40, PosY + 125, PARTY_SEARCH_MESSAGES[GetLanguage()][30], 100, 1)

    addY = 0.0

    for i = 0, 6 do
        RenderText3(PosX + 40, PosY + 153 + addY, PARTY_SEARCH_MESSAGES[GetLanguage()][18 + i], 100, 1)

        addY = addY + 19.0
    end

    --Pass set
    SetFontType(0)

    RenderText3(PosX + 167, PosY + 62, string.format('%d', PartySearchLevel), 50, 1)

    if (#PartySearchPassword > 0)
    then
        RenderText3(PosX + 115, PosY + 76, string.format('%s', PartySearchPassword), 80, 3)
    else
        RenderText3(PosX + 115, PosY + 76, string.format(' '), 80, 3)
    end
end

function PartySearch.UpdateMouse()
    if PartySearchVisible ~= 1
    then
        return
    end

    local PosX = (640 / 2) - (230 / 2)
    local PosY = 70

    if PartySearchPasswordRequired == 1
    then
        PartySearch.UpdatePasswordBox()
        DisableClickClient()
        return
    elseif PartySearchPage == 0
    then
        --Close 
        if (MousePosX() >= (PosX + 230 - 25) and MousePosX() <= (PosX + 230 - 25) + 18)
            and (MousePosY() >= (PosY + 5) and MousePosY() <= (PosY + 5) + 18)
        then
            if (CheckClickClient() == 1)
            then
                DisableClickClient()
                PartySearch.Close()
            end
        end

        --Settings buttom
        if (MousePosX() >= (PosX + 230 - 45) and MousePosX() <= (PosX + 230 - 45) + 18)
            and (MousePosY() >= (PosY + 35) and MousePosY() <= (PosY + 35) + 13)
        then
            if (CheckClickClient() == 1)
            then
                DisableClickClient()
                PartySearchPage = 1
            end
        end

        --Refresh buttom
        if (MousePosX() >= (PosX + 230 - 70) and MousePosX() <= (PosX + 230 - 70) + 18)
            and (MousePosY() >= (PosY + 35) and MousePosY() <= (PosY + 35) + 13)
        then
            if (CheckClickClient() == 1)
            then
                DisableClickClient()
                PartySearch.Refresh()
            end
        end

        if PartySearchMaxPages > 0
        then
            --left
            if (MousePosX() >= (PosX + 70) and MousePosX() <= (PosX + 70) + 25)
                and (MousePosY() >= (PosY + 288) and MousePosY() <= (PosY + 288) + 16)
            then
                if (CheckClickClient() == 1)
                then
                    DisableClickClient()
                    PartySearch.ProcessNextPage(2)
                end
            end
    
            --right
            if (MousePosX() >= (PosX + 135) and MousePosX() <= (PosX + 135) + 25)
                and (MousePosY() >= (PosY + 288) and MousePosY() <= (PosY + 288) + 16)
            then
                if (CheckClickClient() == 1)
                then
                    DisableClickClient()
                    PartySearch.ProcessNextPage(1)
                end
            end
        end

        --Join

        if GetCountParty() <= 0
        then
            PosY = 165
            line = 0
            addY = 0.0

            for i = 1, #PartySearchList do
                if line >= PartySearchStartLine and line < PartySearchEndLine
                then
                    local list = PartySearchList[i]
        
                    if list ~= nil
                    then
                        if (MousePosX() >= (PosX + 15 + 187) and MousePosX() <= (PosX + 15 + 187) + 16)
                            and (MousePosY() >= (PosY + 4 + addY) and MousePosY() <= (PosY + 4 + addY) + 15) and list.Count <= 4
                        then
                            if (CheckClickClient() == 1)
                            then
                                if list.Password == 1
                                then
                                    PartySearchPasswordRequired = 1
                                    PartySearchNameSelected = list.Owner
                                else
                                    PartySearch.JoinParty(list.Owner, '')
                                    PartySearch.Close()
                                end

                                DisableClickClient()
                            end
                        end

                        addY = addY + 25.0
                    end
                end

                line = line + 1
            end
        end
    else
        --Close 
        if (MousePosX() >= (PosX + 230 - 25) and MousePosX() <= (PosX + 230 - 25) + 18)
            and (MousePosY() >= (PosY + 5) and MousePosY() <= (PosY + 5) + 18)
        then
            if (CheckClickClient() == 1)
            then
                DisableClickClient()
                PartySearch.Close()
            end
        end

        if (MousePosX() >= (PosX + 115 - 28) and MousePosX() <= (PosX + 115 - 28) + 54)
            and (MousePosY() >= (PosY + 284) and MousePosY() <= (PosY + 284) + 30) and CheckPressedKey(Keys.LButton) == 1
        then
            PartySearch.SendSettings()
            PartySearch.Close()
            DisableClickClient()
        end

        --Off and on
        if (MousePosX() >= (PosX + 180) and MousePosX() <= (PosX + 180) + 15)
            and (MousePosY() >= (PosY + 34) and MousePosY() <= (PosY + 34) + 15) and CheckPressedKey(Keys.LButton) == 1
        then
            if PartySearchIsOn == 1
            then
                PartySearchIsOn = 0
            else
                PartySearchIsOn = 1
            end
        end

        if PartySearchIsOn == 1
        then
            --Settings
            --Level minus
            if (MousePosX() >= (PosX + 15 + 135) and MousePosX() <= (PosX + 15 + 135) + 11)
            and (MousePosY() >= (PosY + 60) and MousePosY() <= (PosY + 60) + 10) and CheckPressedKey(Keys.LButton) == 1
            then
                DisableClickClient()

                if PartySearchLevel <= 400 and PartySearchLevel >= 10
                then
                    PartySearchLevel = PartySearchLevel - 10
                end
            end

            --level add
            if (MousePosX() >= (PosX + 15 + 170) and MousePosX() <= (PosX + 15 + 170) + 11)
                and (MousePosY() >= (PosY + 60) and MousePosY() <= (PosY + 60) + 10) and CheckPressedKey(Keys.LButton) == 1
            then
                DisableClickClient()

                if PartySearchLevel >= 10 and PartySearchLevel <= 390
                then
                    PartySearchLevel = PartySearchLevel + 10
                end
            end

            --pass
            if (MousePosX() >= (PosX + 15 + 110) and MousePosX() <= (PosX + 15 + 110) + 60)
                and (MousePosY() >= (PosY + 74) and MousePosY() <= (PosY + 74) + 10) and CheckClickClient() == 1
            then
                DisableClickClient()
                PartySearchPasswordSelected = 1
            else
                if CheckClickClient() == 1
                then
                    PartySearchPasswordSelected = 0
                end
            end

            --Clicks guild, alliance, only class
            if (MousePosX() >= (PosX + 180) and MousePosX() <= (PosX + 180) + 15)
                and (MousePosY() >= (PosY + 89) and MousePosY() <= (PosY + 89) + 15) and CheckPressedKey(Keys.LButton) == 1
            then
                if PartySearchOnlyGuild == 1
                then
                    PartySearchOnlyGuild = 0
                else    
                    PartySearchOnlyGuild = 1
                end
            end

            if (MousePosX() >= (PosX + 180) and MousePosX() <= (PosX + 180) + 15)
                and (MousePosY() >= (PosY + 105) and MousePosY() <= (PosY + 105) + 15) and CheckPressedKey(Keys.LButton) == 1
            then
                if PartySearchOnlyAlliance == 1
                then
                    PartySearchOnlyAlliance = 0
                else    
                    PartySearchOnlyAlliance = 1
                end
            end

            if (MousePosX() >= (PosX + 180) and MousePosX() <= (PosX + 180) + 15)
                and (MousePosY() >= (PosY + 120) and MousePosY() <= (PosY + 120) + 15) and CheckPressedKey(Keys.LButton) == 1
            then
                if PartySearchOnlyClass == 1
                then
                    PartySearchOnlyClass = 0
                else    
                    PartySearchOnlyClass = 1
                end
            end

            --Click class
            addY = 0.0

            for i = 1, 7 do
                if (MousePosX() >= (PosX + 180) and MousePosX() <= (PosX + 180) + 15)
                and (MousePosY() >= (PosY + 150 + addY) and MousePosY() <= (PosY + 150 + addY) + 15) and CheckPressedKey(Keys.LButton) == 1
                then
                    if PartySearchClickClass[i] == 1
                    then
                        PartySearchClickClass[i] = 0
                    else
                        PartySearchClickClass[i] = 1
                    end
                end

                addY = addY + 19.0
            end
        end
    end

    if (MousePosX() >= (PosX) and MousePosX() <= PosX + 230)
        and (MousePosY() >= (PosY) and MousePosY() <= (PosY) + 310)
    then
        DisableClickClient()
    end
end

function PartySearch.UpdateKeyEvent()
    if PartySearchVisible ~= 1
    then
        return
    end

    if (CheckPressedKey(Keys.Escape) == 1)
	then
		PartySearchVisible = 0
        PartySearchList = nil
	end

    if PartySearchPage == 1
    then
        if PartySearchPasswordSelected == 1
        then
            if CheckRepeatKey(Keys.Back) == 1
            then
                PartySearchPassword = PartySearchPassword:sub(1, #PartySearchPassword - 1)

                if #PartySearchPassword <= 0
                then
                    PartySearchPassword = ''
                end
                return
            end
        end
    end
end

function PartySearch.Open()
    if PartySearchVisible ~= 0
    then
        return
    end

    --Clear list
    PartySearchList = nil
    PartySearchList = {}

    PartySearchVisible = 0
    PartySearchPage = 0

    local packetString = string.format("%s_%s", PARTY_SEARCH_PACKET_NAME, UserGetName())
    CreatePacket(packetString, PARTY_SEARCH_PACKET)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function PartySearch.Refresh()
    local packetString = string.format("%s_%s", PARTY_SEARCH_PACKET_NAME, UserGetName())
    CreatePacket(packetString, PARTY_SEARCH_PACKET)
    SendPacket(packetString)
    ClearPacket(packetString)
end

function PartySearch.Close()
    if PartySearchVisible ~= 1
    then
        return
    end

    PartySearchPasswordRequired = 0
    PartySearchVisible = 0
end

function PartySearch.RenderPasswordBox()
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
    if (MousePosX() >= (PosX + 115 - 28) and MousePosX() <= (PosX + 115 - 28) + 54)
        and (MousePosY() >= (PosY + 110) and MousePosY() <= (PosY + 110) + 30)
    then
        RenderImage2(0x7A5B, PosX + 115 - 28, PosY + 110, 54.0, 30.0, 0.0, 0.235, 0.84, 0.23, 1.00, 1.0, 1.0)
    else
        RenderImage2(0x7A5B, PosX + 115 - 28, PosY + 110, 54.0, 30.0, 0.0, 0.0, 0.84, 0.23, 1.00, 1.0, 1.0)
    end

    EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 1.0)

	DrawBar(PosX + (230 / 2) - 35, PosY + 65, 70, 15, 0.0, 0)
	
	EndDrawBar()
	DisableAlphaBlend()

    EnableAlphaTest()

     --Text
	SetFontType(1)
	
	SetTextColor(255, 189, 25, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(PosX, PosY + 10, PARTY_SEARCH_MESSAGES[GetLanguage()][32], 230, 3)

    SetTextColor(255, 255, 255, 255)

    if (#PartySearchPassword > 0)
    then
        RenderText3(PosX + (230 / 2) - 35, PosY + 68, string.format('%s', PartySearchPassword), 70, 3)
    else
        RenderText3(PosX + (230 / 2) - 35, PosY + 68, string.format(' '), 70, 3)
    end
end

function PartySearch.UpdatePasswordBox()
    local PosX = (640 / 2) - (230 / 2)
    local PosY = 120

    if (MousePosX() >= (PosX + 115 - 28) and MousePosX() <= (PosX + 115 - 28) + 54)
        and (MousePosY() >= (PosY + 110) and MousePosY() <= (PosY) + 30 + 110) and CheckClickClient() == 1
    then
        PartySearch.JoinParty(PartySearchNameSelected, PartySearchPassword)
        PartySearch.Close()
    end

    if (MousePosX() >= (PosX + (230 / 2) - 35) and MousePosX() <= (PosX + (230 / 2) - 35) + 70)
        and (MousePosY() >= (PosY + 65) and MousePosY() <= (PosY + 65) + 15) and CheckClickClient() == 1
    then
        PartySearchPasswordSelected = 1
    else
        if CheckClickClient() == 1
        then
            PartySearchPasswordSelected = 0
        end
    end
end

function PartySearch.JoinParty(PlayerParty, Password)
    local packetString = string.format("%s_%s", PARTY_SEARCH_PACKET_JOIN_NAME, UserGetName())
    CreatePacket(packetString, PARTY_SEARCH_PACKET)

    SetCharPacketLength(packetString, PlayerParty, 10)

    SetCharPacketLength(packetString, Password, 10)

    SendPacket(packetString)
    ClearPacket(packetString)
end

function PartySearch.SendSettings()
    local packetString = string.format("%s_%s", PARTY_SEARCH_PACKET_SETTINGS_NAME, UserGetName())
    CreatePacket(packetString, PARTY_SEARCH_PACKET)

    SetBytePacket(packetString, PartySearchIsOn)
    SetWordPacket(packetString, PartySearchLevel)
    SetBytePacket(packetString, PartySearchOnlyClass)
    SetBytePacket(packetString, PartySearchOnlyGuild)
    SetBytePacket(packetString, PartySearchOnlyAlliance)
    SetBytePacket(packetString, PartySearchClickClass[1])
    SetBytePacket(packetString, PartySearchClickClass[2])
    SetBytePacket(packetString, PartySearchClickClass[3])
    SetBytePacket(packetString, PartySearchClickClass[4])
    SetBytePacket(packetString, PartySearchClickClass[5])
    SetBytePacket(packetString, PartySearchClickClass[6])
    SetBytePacket(packetString, PartySearchClickClass[7])

    if #PartySearchPassword <= 0
    then
        SetCharPacketLength(packetString, '', 10)
    else
        SetCharPacketLength(packetString, PartySearchPassword, 10)
    end

    SendPacket(packetString)
    ClearPacket(packetString)
end

function PartySearch.CalcPages()
    PartySearchStartLine = 0
    PartySearchEndLine = 7
    PartySearchMaxLines = #PartySearchList
    PartySearchMaxPages = math.floor(PartySearchMaxLines / 7)

    local diffPage = math.floor(PartySearchMaxPages * 7)

    if diffPage == PartySearchMaxLines
    then
        PartySearchMaxPages = PartySearchMaxPages - 1
    end
end

function PartySearch.ProcessNextPage(type)
    if type == 1
    then
        if PartySearchCurrentPage < PartySearchMaxPages
        then
            PartySearchStartLine = PartySearchStartLine + 7
            PartySearchEndLine = PartySearchEndLine + 7
            PartySearchCurrentPage = PartySearchCurrentPage + 1

            if PartySearchEndLine > PartySearchMaxLines
            then
                PartySearchEndLine = PartySearchMaxLines
            end
        end
    end

    if type == 2
    then
        if PartySearchCurrentPage > 0
        then
            PartySearchCurrentPage = PartySearchCurrentPage - 1
            PartySearchStartLine = PartySearchStartLine - 7

            if (PartySearchCurrentPage + 1) == PartySearchMaxPages
            then
                local difLines = ((PartySearchMaxPages+1) * 7)

                if difLines >= PartySearchEndLine
                then
                    PartySearchEndLine = PartySearchEndLine - (7 - (difLines - PartySearchEndLine))
                else
                    PartySearchEndLine = PartySearchEndLine - 7
                end
            else
                PartySearchEndLine = PartySearchEndLine - 7
            end

            if PartySearchStartLine <= 0
            then
                PartySearchStartLine = 0
            end
        end
    end
end

function PartySearch.MainProcWorldKey(keys)
    if PartySearchVisible ~= 1
    then
        return
    end

    if PartySearchPasswordSelected == 1
    then
        if keys == 8
        then
            PartySearchPassword = PartySearchPassword:sub(1, #PartySearchPassword - 1)

            if #PartySearchPassword <= 0
            then
                PartySearchPassword = ' '
            end
            return
        end

        local Key = math.floor(tonumber(keys))

        if (Key >= 48 and Key <= 57
            or Key >= 96 and Key <= 105)
        then
            if #PartySearchPassword >= 10
            then
                return
            end

            if Key >= 48 and Key <= 57
            then
                PartySearchPassword = PartySearchPassword .. tostring(Key-48)
            end

            if Key >= 96 and Key <= 105
            then
                PartySearchPassword = PartySearchPassword .. tostring(Key-96)
            end
        end
    end
end

function PartySearch.AddPartyInList(index, name, map, x, y, count, level, onlyClass, onlyGuild, onlyAlliance, classSM, classBK, classELF, classMG, classDL, classSUM, classRF, password) 
    PartySearchList[index] = {
        Owner = name, Map = map, X = x, Y = y, Count = count
        , Level = level, OnlyClass = onlyClass, OnlyGuild = onlyGuild
        , OnlyAlliance = onlyAlliance, ClassSM = classSM
        , ClassBK = classBK, ClassELF = classELF, ClassMG = classMG
        , ClassDL = classDL, ClassSUM = classSUM, ClassRF = classRF
        , Password = password
    }
end

function PartySearch.ProcessListAndOpen(PacketName)
    PartySearchVisible = 1

    local count = GetWordPacket(PacketName, -1)

    if count > 0
	then
        for i = 0, (count-1) do
            PartySearch.AddPartyInList(
                i+1
                , GetCharPacketLength(PacketName, -1, 10)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetWordPacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
                , GetBytePacket(PacketName, -1)
            )

        end
    end

    PartySearch.CalcPages()
end

function PartySearch.Protocol(Packet, PacketName)
    if Packet ~= PARTY_SEARCH_PACKET
    then
        return
    end

    if PacketName == string.format("%s_%s", PARTY_SEARCH_PACKET_NAME, UserGetName())
    then
        PartySearch.ProcessListAndOpen(PacketName)
        ClearPacket(PacketName)
    end
end

function PartySearch.Init()
    if PARTY_SEARCH_SWITCH ~= 1
    then
        return
    end

    PartySearchVisible = 0
    PartySearchPage = 0

    PartySearchList = {}

    PartySearch.CalcPages()

    InterfaceController.ClientProtocol(PartySearch.Protocol)
	InterfaceController.MainProc(PartySearch.Render)
	InterfaceController.UpdateMouse(PartySearch.UpdateMouse)
	InterfaceController.UpdateKey(PartySearch.UpdateKeyEvent)
    InterfaceController.MainProcWorldKey(PartySearch.MainProcWorldKey)
end

PartySearch.Init()

return PartySearch