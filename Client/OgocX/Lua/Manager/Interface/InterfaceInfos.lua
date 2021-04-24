InterfaceInfos = {}

function InterfaceInfos.Render()
	SetBlend()
		
	glColor4f(0.0, 0.0, 0.0, 0.7)
	
	DrawBar(295, 0, 50, 15)
	
	GLSwitchBlend()
	
	glColor3f(1.0, 1.0, 1.0)
	
	SetTextBg(0, 0, 0, 0)
	
	SetTextColor(217, 135, 25, 255)
	
	RenderText3(295, 4, string.format('FPS: %02.f', getFPS()), 50, 3)
	
	GLSwitch()
	glColor3f(1.0, 1.0, 1.0)
end

InterfaceController.MainProc(InterfaceInfos.Render)

return InterfaceInfos