local MouseRightPressed = 0

function InterfaceProc()
	--RenderImage(40000, 250, 250, 100, 50)

	--[[EnableAlphaTest()
	
	SetFontType(2)
	
	SetTextBg(0, 0, 0, 0)
	
	SetTextColor(255, 255, 255, 255)
	
	RenderText2(250, 250, string.format("value chat: %d",CheckClickClient()), ALIGN_LEFT)
	
	SetFontType(1)
	
	SetTextBg(0, 0, 0, 200)
	
	SetTextColor(255, 255, 255, 255)
	
	RenderText2(250, 275, "OgocX BOLD", ALIGN_LEFT)
	
	SetFontType(0)
	
	SetTextBg(0, 0, 0, 200)
	
	SetTextColor(255, 255, 255, 255)
	
	RenderText2(250, 290, "OgocX NORMAL", ALIGN_LEFT)
	
	if CheckWindowOpen(UICharacter) == 1
	then
		RenderText("OgocX2", 280, 250, 100, CONVERT_RGBA(255, 255, 255, 255), 1)
	end
	
	DisableAlphaBlend()
	
	RenderImage2(31035,300,250,15,15,0.0,0.0,15.0/128.0,15.0/32.0);
	
	CreateItem(50, 50, 150, 150, GET_ITEM(14, 11), 10, 0, 0)
	
	CreateItem(50, 80, 15, 15, GET_ITEM(0, 0), 10, 0, 0)
	
	if MousePosX() > 50 and MousePosX() < 60
	then
		ShowItemDescription(50, 50, GET_ITEM(0, 0), 15, 1, 1, 7, 255, 63, 0) -- PosX, PosY, Index, Level, Op1, Op2, Op3, Durability, Exc, Ancient
	end
	
	CreateItem(50, 50, 150, 150, GET_ITEM(14, 22), 10, 0, 0)

	LogDebug(string.format('%d %d %d %d', GetInventoryMouseItemSlot(), GetInventoryMouseItemIndex(), GetInventoryMouseItemLevel(), GetInventoryMouseItemExc()))--]]
	
	
	--LogDebug(string.format('%d', UserGetGuild()))
end

function InterfaceBeforeMainProc()
	
end

function InterfaceUpdateProc()

end

function InterfaceClientProtocol(head, packetName)

end

function InterfaceMainProcWorldKey(key)

end

function InterfaceScrollMouse(value)

end

function InterfaceInterfaceClickRightEvent()

end

function InterfaceInterfaceClickEvent()

end

function InterfaceInterfaceMouse()

end

function PlayerDraw()
	--[[local Name = ""
	
	for n= 0, 399 do
		if CharacterGetIsLive(n) == 0
		then
			goto continue
		end
		
		if CharacterGetIndex(n) == 0
		then
			goto continue
		end
		
		if CharacterGetType(n) ~= 1
		then
			goto continue
		end
		
		local PosX, PosY = GetPosFromPlayer(n, 100.0)
		
		Name = CharacterGetName(n)
		
		PosX = PosX - 33
		
		SetBlend()
		
		glColor4f(0.0, 0.0, 0.0, 0.5);
		
		DrawBar(PosX - 1, PosY - 8, 72, 16.0)
		
		GLSwitchBlend()
		
		glColor3f(1.0, 1.0, 1.0)
		
		SetTextColor(255, 255, 255, 255)
		
		if (CharacterGetGuild(n) ~= -1)
		then
			Name = Name..' G:'..CharacterGuildGetName(n)
		end
		
		RenderText(Name, (PosX + 12 + #Name + 20 - #Name), PosY - 7, 100, CONVERT_RGBA(255, 255, 255, 255), ALIGN_CENTER_TO_RIGHT)
		
		--CreateGuildMark(CharacterGetGuild(n))
		--RenderImage(31740, PosX + 12, PosY - 7, 15.0, 15.0)
	
		GLSwitch()
		glColor3f(1.0, 1.0, 1.0)
		
		::continue::
	end
	
	GLSwitch()
	glColor3f(1.0, 1.0, 1.0)--]]
end

InterfaceController.MainProc(InterfaceProc)
InterfaceController.ClientProtocol(InterfaceClientProtocol)
InterfaceController.MainProcWorldKey(InterfaceMainProcWorldKey)
InterfaceController.ScrollMouse(InterfaceScrollMouse)
InterfaceController.InterfaceClickRightEvent(InterfaceInterfaceClickRightEvent)
InterfaceController.InterfaceClickEvent(InterfaceInterfaceClickEvent)
InterfaceController.UpdateProc(InterfaceUpdateProc)
InterfaceController.BeforeMainProc(InterfaceBeforeMainProc)
InterfaceController.UpdateMouse(InterfaceInterfaceMouse)

InterfaceController.PlayerDraw(PlayerDraw)