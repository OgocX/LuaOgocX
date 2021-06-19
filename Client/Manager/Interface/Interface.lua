function InterfaceProc()
	--[[RenderImage(40000, 250, 250, 100, 50)

	EnableAlphaTest()
	
	RenderText("OgocX", 250, 250, 100, CONVERT_RGBA(255, 255, 255, 255), 1)
	
	if CheckWindowOpen(UICharacter) == 1
	then
		RenderText("OgocX2", 280, 250, 100, CONVERT_RGBA(255, 255, 255, 255), 1)
	end
	
	DisableAlphaBlend()--]]
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

InterfaceController.MainProc(InterfaceProc)
InterfaceController.ClientProtocol(InterfaceClientProtocol)
InterfaceController.MainProcWorldKey(InterfaceMainProcWorldKey)
InterfaceController.ScrollMouse(InterfaceScrollMouse)
InterfaceController.InterfaceClickRightEvent(InterfaceInterfaceClickRightEvent)
InterfaceController.InterfaceClickEvent(InterfaceInterfaceClickEvent)