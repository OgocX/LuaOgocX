--[[
Configs
]]--

LOG_IN_AND_WIN_SWITCH = 1

--Days player will get reward, obs: min is 5 days!
--don't have limit max of days you can put every number
LOG_IN_AND_WIN_MAX_DAYS = 10

--packet number
LOG_IN_AND_WIN_PACKET = 2
--packet name
LOG_IN_AND_WIN_PACKET_NAME = 'GET_REWARD_LOG_IN'

LOG_IN_AND_WIN_REWARD_BY_DAYS = { }

LOG_IN_AND_WIN_REWARD_BY_DAYS[1] = { Day = 1, RewardName = 'BrindeX', Quantity = 1, RewardGet = 'Kris Sword +15 + 10 WCoinC' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[2] = { Day = 2, RewardName = 'WCoinP', Quantity = 25, RewardGet = 'WCoinP' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[3] = { Day = 3, RewardName = 'Soul', Quantity = 10, RewardGet = 'Jewel of Soul' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[4] = { Day = 4, RewardName = 'Skull Staff', Quantity = 1, RewardGet = 'Skull Staff +15 FULL' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[5] = { Day = 5, RewardName = 'Asa Lv 1', Quantity = 1, RewardGet = 'Asa level 1 SM' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[6] = { Day = 6, RewardName = 'BrindeX2', Quantity = 1, RewardGet = 'Jewel of Bless + 20 WCoinP' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[7] = { Day = 7, RewardName = 'DK Set', Quantity = 1, RewardGet = 'DK Set Full +15' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[8] = { Day = 8, RewardName = 'Venom Set', Quantity = 1, RewardGet = 'Venom Set Full +15' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[9] = { Day = 9, RewardName = 'Sunlight Set', Quantity = 1, RewardGet = 'Sunlight Set Full +15' }
LOG_IN_AND_WIN_REWARD_BY_DAYS[10] = { Day = 10, RewardName = 'WCoinC', Quantity = 10000, RewardGet = 'WCoinC' }

LOG_IN_AND_WIN_MESSAGES = {}

LOG_IN_AND_WIN_MESSAGES['Por'] = {
[1] = 'Logue e Ganhe',
[2] = 'Dia %d',
[3] = 'SUPER BRINDE',
[4] = 'PARABÉNS',
[5] = 'SUA RECOMPENSA DE HOJE É:',
[6] = 'Jogue o Mu OgocX todos os dias e ganhe brindes!',
}

LOG_IN_AND_WIN_MESSAGES['Eng'] = {
[1] = 'Log in and Win',
[2] = 'Day %d',
[3] = 'SUPER TOAST',
[4] = 'CONGRATULATIONS',
[5] = 'YOUR REWARD FOR TODAY IS:',
[6] = 'Play Mu OgocX every day and win free gifts!',
}

LOG_IN_AND_WIN_MESSAGES['Spn'] = {
[1] = 'Iniciar sesión y ganar',
[2] = 'Día %d',
[3] = 'SUPER TOSTADA',
[4] = 'FELICIDADES',
[5] = 'TU RECOMPENSA POR HOY ES:',
[6] = '¡Juega a Mu OgocX todos los días y gana regalos gratis!',
}


--[[
System, if you don't know how this work, don't touch!
]]--
LogInAndWin = {}

LogInAndWinVisible = 0
LogInAndWinHide = 0
LogInAndWinDayPlayer = 0

local InterfaceIndex_1 = -1
local InterfaceIndex_2 = -1
local InterfaceIndex_3 = -1
local InterfaceIndex_4 = -1
local InterfaceIndex_5 = -1
local InterfaceIndex_6 = -1
local InterfaceIndex_7 = -1
local InterfaceIndex_8 = -1

function LogInAndWin.GetScaleImage(x)
	local resolution = GetResolution()
	
	if resolution == 4 or resolution == 5 or resolution == 7
	then
		return math.floor(((x * 85) / 100))
	elseif resolution == 6 or resolution == 8
	then
		return math.floor(((x * 80) / 100))
	end
	
	return x
end

function LogInAndWin.GetScalePosX(x)
	local resolution = GetResolution()
	
	if resolution == 4 or resolution == 5 or resolution == 7
	then
		return x + math.floor(((x * 15) / 100))
	elseif resolution == 6 or resolution == 8
	then
		return x + math.floor(((x * 20) / 100))
	end
	
	return x
end

function LogInAndWin.GetScaleFontX(x)
	local resolution = GetResolution()
	
	if resolution == 4 or resolution == 5 or resolution == 7
	then
		return x - math.floor(((x * 28) / 100))
	elseif resolution == 6 or resolution == 8
	then
		return x - math.floor(((x * 37) / 100))
	end
	
	return x
end

function LogInAndWin.ImagesOn(x)
	local resolution = GetResolution()
	
	if resolution == 4 or resolution == 5 or resolution == 7
	then
		return x - math.floor(((x * 15) / 100))
	elseif resolution == 6 or resolution == 8
	then
		return x - math.floor(((x * 20) / 100))
	end
	
	return x
end

function LogInAndWin.GetScaleMouseX(x)
	local resolution = GetResolution()
	
	if resolution == 4 or resolution == 5 or resolution == 7
	then
		return math.floor(((x * 90) / 100))
	elseif resolution == 6 or resolution == 8
	then
		return math.floor(((x * 87) / 100))
	end
	
	return x
end

function LogInAndWin.CheckAnotherInterfaceOpen()
	if CheckWindowOpen(UIMuHelper) ~= 0 
		or CheckWindowOpen(UIExpandWarehouse) ~= 0 
		or CheckWindowOpen(UIExpandInventory) ~= 0 
		or CheckWindowOpen(UIChaosBox) ~= 0 
		or CheckWindowOpen(UITrade) ~= 0 
		or CheckWindowOpen(UIQuest) ~= 0 
		or CheckWindowOpen(UICashShop) ~= 0 
		or CheckWindowOpen(UIOptions) ~= 0 
	then
		return 1
	end
	
	return 0
end

function LogInAndWin.GetReward()
	local packetIdentification = string.format('%s-%s', LOG_IN_AND_WIN_PACKET_NAME, UserGetName())
	
	CreatePacket(packetIdentification, LOG_IN_AND_WIN_PACKET)
	
	SetWordPacket(packetIdentification, LogInAndWinDayPlayer)
	
	SendPacket(packetIdentification)
	
	ClearPacket(packetIdentification)
end

function LogInAndWin.UpdateMouse()
	if LogInAndWinVisible == 0 or LogInAndWinHide == 1
	then
		return
	end
	
	if LogInAndWin.CheckAnotherInterfaceOpen() ~= 0 
	then
		return
	end
	
	local posX = LogInAndWin.GetScalePosX(math.floor((640 / 2) - 180))
	local posY = 80
	
	if (MousePosX() >= posX + LogInAndWin.GetScaleImage(150) and MousePosX() <= posX + LogInAndWin.GetScaleImage(150) + 50)
	and (MousePosY() >= posY + 245 and MousePosY() <= posY + 245 + 30)
	then
		if (CheckClickClient() == 1)
		then
			LogInAndWin.GetReward()
			LogInAndWinVisible = 0
			DisableClickClient()
		end
	end

	if (MousePosX() >= posX and MousePosX() <= LogInAndWin.GetScaleMouseX(posX + 360))
		and (MousePosY() >= posY + 80 and MousePosY() <= posY + 250)
	then
		DisableClickClient()
	end
end

function LogInAndWin.UpdateKeyEvent()
	if LogInAndWinVisible == 0
	then
		return
	end
	
	if (CheckPressedKey(Keys.Escape) == 1)
	then
		LogInAndWinHide = 0
		LogInAndWinVisible = 0
	end
end

function LogInAndWin.Render()
	if LogInAndWinVisible == 0 or LogInAndWinHide == 1
	then
		return
	end
	
	if LogInAndWin.CheckAnotherInterfaceOpen() ~= 0 
	then
		return
	end
	
	EnableAlphaTest()
	
	local posX = LogInAndWin.GetScalePosX(math.floor((640 / 2) - 180))
	local posY = 80
	
	RenderImage2(InterfaceIndex_1, posX, posY, LogInAndWin.GetScaleImage(500), 475, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
	
	StartPosImg = posX + 20
	
	ImgPos = 0
	
	local StartPosition = 1
	local EndPosition = 5
	
	if (LogInAndWinDayPlayer) >= LOG_IN_AND_WIN_MAX_DAYS
	then
		StartPosition = LOG_IN_AND_WIN_MAX_DAYS - 5
		EndPosition = LOG_IN_AND_WIN_MAX_DAYS - 1
	elseif LogInAndWinDayPlayer > EndPosition
	then
		local dif = LogInAndWinDayPlayer - EndPosition
		StartPosition = StartPosition + dif
		EndPosition = EndPosition + dif
		
		
		--make the day always print before the previous day if it is greater than 5
		local difEnd = LOG_IN_AND_WIN_MAX_DAYS - EndPosition
		
		if difEnd > 1
		then
			StartPosition = StartPosition + 1
			EndPosition = EndPosition + 1
		end
	else
		if LOG_IN_AND_WIN_MAX_DAYS > 5 and LogInAndWinDayPlayer > 3
		then
			local difEnd = LOG_IN_AND_WIN_MAX_DAYS - EndPosition
			
			if difEnd > 1
			then
				StartPosition = StartPosition + 1
				EndPosition = EndPosition + 1
			end
		end
	end
	
	for i = StartPosition, EndPosition do
		local ImageWidth = LogInAndWin.GetScaleImage(72)
		
		if LogInAndWinDayPlayer == i
		then
			if ImgPos == 0
			then
				RenderImage2(InterfaceIndex_4, StartPosImg, posY + 115, ImageWidth, 62, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
			else
				RenderImage2(InterfaceIndex_5, StartPosImg, posY + 115, ImageWidth, 62, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
			end
		else
			if ImgPos == 0
			then
				RenderImage2(InterfaceIndex_6, StartPosImg, posY + 115, ImageWidth, 62, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
			else
				RenderImage2(InterfaceIndex_2, StartPosImg, posY + 115, ImageWidth, 62, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
			end
		end
		
		SetFontType(2)
	
		SetTextColor(255, 255, 255, 255)
		
		SetTextBg(0, 0, 0, 0)
		
		RenderText3(StartPosImg + 10, posY + 117, string.format('%d', LOG_IN_AND_WIN_REWARD_BY_DAYS[i].Quantity), 30, 3)
		
		if LogInAndWinDayPlayer == i
		then
			SetTextColor(178, 34, 34, 255)
		else
			SetTextColor(255,255,255, 255)
		end
		
		SetFontType(0)
		
		RenderText3(StartPosImg + 10, posY + 137, string.format('%s', LOG_IN_AND_WIN_REWARD_BY_DAYS[i].RewardName), 30, 3)
		
		SetTextColor(255, 255, 255, 255)
		
		RenderText3(StartPosImg + 15, posY + 152, string.format(LOG_IN_AND_WIN_MESSAGES[GetLanguage()][2], i), 0, 0)
		
		StartPosImg = StartPosImg + LogInAndWin.ImagesOn(48)
		
		ImgPos = ImgPos + 1
	end
	
	--Finally Brind
	SetFontType(1)
	
	SetTextColor(255, 215, 0, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(StartPosImg + 25, posY + 100, LOG_IN_AND_WIN_MESSAGES[GetLanguage()][3], 0, 0)
	
	RenderImage2(InterfaceIndex_3, StartPosImg + 15, posY + 110, LogInAndWin.GetScaleImage(72), 62, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
	
	SetFontType(2)
	
	SetTextColor(128,0,128, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(StartPosImg + 13, posY + 115, string.format('%d', LOG_IN_AND_WIN_REWARD_BY_DAYS[LOG_IN_AND_WIN_MAX_DAYS].Quantity), LogInAndWin.GetScaleImage(72), 3)
	
	SetFontType(0)
	
	SetTextColor(255,20,147, 255)
	
	RenderText3(StartPosImg + 3, posY + 140, string.format('%s', LOG_IN_AND_WIN_REWARD_BY_DAYS[LOG_IN_AND_WIN_MAX_DAYS].RewardName), LogInAndWin.GetScaleImage(100), 3)
	
	SetFontType(1)
	
	SetTextColor(255, 215, 0, 255)
	
	RenderText3(StartPosImg, posY + 157, string.format(LOG_IN_AND_WIN_MESSAGES[GetLanguage()][2], LOG_IN_AND_WIN_MAX_DAYS), LogInAndWin.GetScaleImage(100), 3)
	
	--Print brind today
	SetFontType(2)
	
	SetTextColor(255, 215, 0, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(posX + LogInAndWin.GetScaleImage(130), posY + 165, string.format(LOG_IN_AND_WIN_MESSAGES[GetLanguage()][4]), LogInAndWin.GetScaleImage(100), 3)
	
	SetFontType(1)
	
	SetTextColor(255, 255, 255, 255)
	
	RenderText3(posX + LogInAndWin.GetScaleImage(105), posY + 185, LOG_IN_AND_WIN_MESSAGES[GetLanguage()][5], LogInAndWin.GetScaleImage(150), 3)
	
	--separation
	RenderImage2(InterfaceIndex_8, posX + LogInAndWin.GetScaleImage(55), posY + 185, LogInAndWin.GetScaleImage(500), 30, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
	
	RenderImage2(InterfaceIndex_8, posX + LogInAndWin.GetScaleImage(55), posY + 210, LogInAndWin.GetScaleImage(500), 30, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
	
	--Text Get Reward
	SetFontType(2)
	
	SetTextColor(255, 255, 255, 255)
	
	local TextReward = string.format('%d %s', LOG_IN_AND_WIN_REWARD_BY_DAYS[LogInAndWinDayPlayer].Quantity, LOG_IN_AND_WIN_REWARD_BY_DAYS[LogInAndWinDayPlayer].RewardGet)
	
	RenderText3(posX + LogInAndWin.GetScaleImage(100), posY + 200, TextReward, LogInAndWin.GetScaleImage(170), 3)
	
	--Text play game every day
	SetFontType(1)
	
	SetTextColor(255, 215, 0, 255)
	
	local PlayGame = string.format(LOG_IN_AND_WIN_MESSAGES[GetLanguage()][6])
	
	RenderText3(posX + LogInAndWin.GetScaleImage(55), posY + 230, PlayGame, LogInAndWin.GetScaleImage(250), 3)
	
	--"ok button"
	RenderImage2(InterfaceIndex_7, posX + LogInAndWin.GetScaleImage(150), posY + 245, LogInAndWin.GetScaleImage(110), 32, 1.0, 1.0, 1.0, 1.0, 1, 1, 1.0)
	
	--Text
	SetFontType(2)
	
	SetTextColor(255, 215, 0, 255)
	
	SetTextBg(0, 0, 0, 0)
	
	RenderText3(posX + LogInAndWin.GetScaleFontX(110), posY + 80, LOG_IN_AND_WIN_MESSAGES[GetLanguage()][1], 150, 3)
	
	DisableAlphaBlend()
end

function LogInAndWin.Protocol(Packet, PacketName)
	if Packet == LOG_IN_AND_WIN_PACKET
	then
		local packetIdentification = string.format('%s-%s', LOG_IN_AND_WIN_PACKET_NAME, UserGetName())
		
		if PacketName == packetIdentification
		then
			LogInAndWinDayPlayer = GetWordPacket(packetIdentification, -1) + 1
			LogInAndWinVisible = 1
			LogInAndWinHide = 0
			
			ClearPacket(packetIdentification)
		end
	end
end

function LogInAndWin.LoadImages()
	InterfaceIndex_1 = LoadImageByDir("Interface///background_ogocx.tga")
	InterfaceIndex_2 = LoadImageByDir("Interface///Ativo2.tga")
	InterfaceIndex_3 = LoadImageByDir("Interface///Ativo3.tga")
	InterfaceIndex_4 = LoadImageByDir("Interface///Ativo4.tga")
	InterfaceIndex_5 = LoadImageByDir("Interface///Ativo5.tga")
	InterfaceIndex_6 = LoadImageByDir("Interface///Ativo6.tga")
	InterfaceIndex_7 = LoadImageByDir("Interface///Ativo7.tga")
	InterfaceIndex_8 = LoadImageByDir("Interface///Ativo9.tga")
end

function LogInAndWin.Init()
	if LOG_IN_AND_WIN_SWITCH == 0
	then
		return
	end
	
	InterfaceController.ClientProtocol(LogInAndWin.Protocol)
	InterfaceController.LoadImages(LogInAndWin.LoadImages)
	InterfaceController.MainProc(LogInAndWin.Render)
	InterfaceController.UpdateMouse(LogInAndWin.UpdateMouse)
	InterfaceController.UpdateKey(LogInAndWin.UpdateKeyEvent)
end

LogInAndWin.Init()

return LogInAndWin