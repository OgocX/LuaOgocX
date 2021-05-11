--[[
system config
--]]

local PLAYER_MENU_SWITCH = 1
local PLAYER_MENU_WIDTH = 80
local PLAYER_MENU_HEIGHT = 102

local PLAYER_MENU_MESSAGES = {}

PLAYER_MENU_MESSAGES['Por'] = {
[1] = 'Você precisa estar perto do jogador alvo',
[2] = 'Trade',
[3] = 'Party',
[4] = 'Guild',
[5] = 'TradeX',
[6] = 'Char info',
[7] = 'Lojinha',
}

PLAYER_MENU_MESSAGES['Eng'] = {
[1] = 'You need to be close to the target player',
[2] = 'Trade',
[3] = 'Party',
[4] = 'Guild',
[5] = 'TradeX',
[6] = 'Char info',
[7] = 'Shop',
}

PLAYER_MENU_MESSAGES['Spn'] = {
[1] = 'Debes estar cerca del jugador objetivo',
[2] = 'Trade',
[3] = 'Party',
[4] = 'Guild',
[5] = 'TradeX',
[6] = 'Char info',
[7] = 'Tienda',
}

local PLAYER_MENU_COMMAND = {}

PLAYER_MENU_COMMAND['Por'] = {
[1] = 'tradesend',
[2] = 'ptsend',
[3] = 'guildsend',
[4] = '/tradex',
[5] = '/charinfo',
[6] = 'lojasend',
}

PLAYER_MENU_COMMAND['Eng'] = {
[1] = 'tradesend',
[2] = 'ptsend',
[3] = 'guildsend',
[4] = '/tradex',
[5] = '/charinfo',
[6] = 'lojasend',
}

PLAYER_MENU_COMMAND['Spn'] = {
[1] = 'tradesend',
[2] = 'ptsend',
[3] = 'guildsend',
[4] = '/tradex',
[5] = '/charinfo',
[6] = 'lojasend',
}

--[[
system program
]]--
PlayerMenu = {}

local PLAYER_FIND = -1
local MENU_PLAYER_VISIBLE = 0
local MENU_POSITION_X = 0
local MENU_POSITION_Y = 0

local MENU_PLAYER_SELECTED_KEY = 0
local MENU_PLAYER_SELECTED_POSX = 0
local MENU_PLAYER_SELECTED_POSY = 0

function PlayerMenu.CommandPlayer(CommandKey, TargetKey)
	local command = PLAYER_MENU_COMMAND[GetLanguage()][CommandKey-1]
	
	if command == 'tradesend'
	then
		SendTradePlayer(CharacterGetIndex(PLAYER_FIND))
	elseif command == 'ptsend'
	then
		SendPartyPlayer(CharacterGetIndex(PLAYER_FIND))
	elseif command == 'guildsend'
	then
		SendGuildPlayer(CharacterGetIndex(PLAYER_FIND))
	elseif command == 'lojasend'
	then
		SendShopPlayer(CharacterGetIndex(PLAYER_FIND), CharacterGetName(PLAYER_FIND))
	else
		SendPlayerChat(string.format('%s %s', command, CharacterGetName(PLAYER_FIND)))
	end
end

function PlayerMenu.UpdateMouse()
	if MENU_PLAYER_VISIBLE == 0
	then
		return
	end
	
	if CheckDistance(PLAYER_FIND, 3.0) == 0
	then
		MENU_PLAYER_VISIBLE = 0
		PLAYER_FIND = -1
		return
	end
	
	if CheckClickClient() == 1
	then
		if (MousePosX() <= (MENU_POSITION_X - 10) or MousePosY() <= (MENU_POSITION_Y - 10)
			or MousePosX() >= (MENU_POSITION_X + 20) + PLAYER_MENU_WIDTH or MousePosY() >= (MENU_POSITION_Y + 20) + PLAYER_MENU_HEIGHT)
		then
			MENU_PLAYER_VISIBLE = 0
			PLAYER_FIND = -1
			return
		end
	end
	
	local StartPosY = 20
	
	for i = 2, 7 do
		if (MousePosX() >= (MENU_POSITION_X + 10) and MousePosX() <= (MENU_POSITION_X + 10) + PLAYER_MENU_WIDTH)
		then
			if (MousePosY() >= (MENU_POSITION_Y + StartPosY) and MousePosY() <= (MENU_POSITION_Y + StartPosY) + 12)
			then
				MENU_PLAYER_SELECTED_POSX = MENU_POSITION_X + 10
				MENU_PLAYER_SELECTED_POSY = MENU_POSITION_Y + StartPosY
				MENU_PLAYER_SELECTED_KEY = i
				
				if CheckClickClient() == 1
				then
					PlayerMenu.CommandPlayer(i)
					MENU_PLAYER_VISIBLE = 0
					PLAYER_FIND = -1
					DisableClickClient()
				end
			end
		end
		
		StartPosY = StartPosY + 12
	end
end

function PlayerMenu.UpdateKey()
	local playerIndex = GetTargetCharacter()
	
	if playerIndex ~= -1
	then
		if CheckReleasedKey(Keys.RButton) == 1
		then
			if CheckRepeatKey(Keys.ShiftKey) == 1
			then
				if CheckDistance(playerIndex, 3.0) == 0
				then
					SendMessageClient(PLAYER_MENU_MESSAGES[GetLanguage()][1])
					return
				end
				
				MENU_PLAYER_VISIBLE = 1
				PLAYER_FIND = playerIndex
			end
		end
	end
end

function PlayerMenu.Draw()
	if MENU_PLAYER_VISIBLE ~= 0
	then
		if PLAYER_FIND ~= -1
		then
			if CharacterGetIsLive(PLAYER_FIND) == 0
			then
				goto out
			end
			
			if CharacterGetIndex(PLAYER_FIND) == 0
			then
				goto out
			end
			
			if CharacterGetType(PLAYER_FIND) ~= 1
			then
				goto out
			end
			
			local PosX, PosY = GetPosFromPlayer(PLAYER_FIND, 60.0)
			
			MENU_POSITION_X = PosX
			MENU_POSITION_Y = PosY
			
			SetBlend()
		
			glColor4f(0.0, 0.0, 0.0, 0.7)
			
			DrawBar(PosX + 10, PosY, PLAYER_MENU_WIDTH, PLAYER_MENU_HEIGHT)
			
			if MENU_PLAYER_SELECTED_KEY ~= 0
			then
				glColor4f(0.3, 0.3, 0.3, 0.7)
				
				DrawBar(MENU_PLAYER_SELECTED_POSX, MENU_PLAYER_SELECTED_POSY - 1, PLAYER_MENU_WIDTH, 12)
			end
			
			GLSwitchBlend()
			
			glColor3f(1.0, 1.0, 1.0)
			
			SetTextBg(0, 0, 0, 0)
			SetTextColor(217, 135, 25, 255)
			
			RenderText3(PosX + 10, PosY + 5, CharacterGetName(PLAYER_FIND), PLAYER_MENU_WIDTH, ALIGN_CENTER)
			
			SetTextColor(255, 255, 255, 255)
			
			local StartPosY = 20
			local language = GetLanguage()
			
			for i = 2, 7 do
				RenderText3(PosX + 10, PosY + StartPosY, PLAYER_MENU_MESSAGES[language][i], PLAYER_MENU_WIDTH, ALIGN_CENTER)
				
				StartPosY = StartPosY + 12
			end
			
			GLSwitch()
			glColor3f(1.0, 1.0, 1.0)
		end
	end
	
	MENU_PLAYER_SELECTED_KEY = 0
	
	::out::
end

function PlayerMenu.Init()
	if PLAYER_MENU_SWITCH == 0
	then
		return
	end
	
	PLAYER_FIND = -1
	MENU_PLAYER_VISIBLE = 0
	
	InterfaceController.UpdateKey(PlayerMenu.UpdateKey)
	InterfaceController.UpdateMouse(PlayerMenu.UpdateMouse)
	InterfaceController.PlayerDraw(PlayerMenu.Draw)
end

PlayerMenu.Init()

return PlayerMenu