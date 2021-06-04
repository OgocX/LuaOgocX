InterfaceInfos = {}

function InterfaceInfos.Render()
	if	CheckWindowOpen(UIFriendList)		== 1	then	return							end
	if	CheckWindowOpen(UIMoveList)			== 1	then	return							end
	if	CheckWindowOpen(UIParty)			== 1	then	return							end
	if	CheckWindowOpen(UIQuest)			== 1	then	return							end
	if	CheckWindowOpen(UIGuild)			== 1	then	return							end
	if	CheckWindowOpen(UITrade)			== 1	then	return							end
	if	CheckWindowOpen(UIWarehouse)		== 1	then	return							end
	if	CheckWindowOpen(UIChaosBox)			== 1	then	return							end
	if	CheckWindowOpen(UICommandWindow)	== 1	then	return							end
	if	CheckWindowOpen(UIPetInfo)			== 1	then	return							end
	if	CheckWindowOpen(UIShop)				== 1	then	return							end
	if	CheckWindowOpen(UIStore)			== 1	then	return							end
	if	CheckWindowOpen(UIOtherStore)		== 1	then	return							end
	if	CheckWindowOpen(UICharacter)		== 1	then	return							end
	if	CheckWindowOpen(UIOptions)			== 1	then	return							end
	if	CheckWindowOpen(UIHelp)				== 1	then	return							end
	if	CheckWindowOpen(UIFastDial)			== 1	then	return							end
	if	CheckWindowOpen(UISkillTree)		== 1	then	return							end
	if	CheckWindowOpen(UINPC_Titus)		== 1	then	return							end
	if	CheckWindowOpen(UICashShop)			== 1	then	return							end
	if	CheckWindowOpen(UIFullMap)			== 1	then	return							end
	if	CheckWindowOpen(UINPC_Dialog)		== 1	then	return							end
	if	CheckWindowOpen(UIGensInfo)			== 1	then	return							end
	if	CheckWindowOpen(UINPC_Julia)		== 1	then	return							end
	if	CheckWindowOpen(UIExpandInventory)	== 1	then	return							end
	if	CheckWindowOpen(UIExpandWarehouse)	== 1	then	return							end
	if	CheckWindowOpen(UIMuHelper)			== 1	then	return							end
	if	CheckWindowOpen(UIInventory)		== 1	then	return							end
	if	QuestSystem.CheckOpen()				== 1	then	return							end
	if	QuestSystemNpc.CheckOpen()				== 1	then	return							end

	EnableAlphaTest()
	
	SetBlend()
		
	glColor4f(0.0, 0.0, 0.0, 0.7)
	
	DrawBar(590, 0, 50, 15)
	
	GLSwitchBlend()
	
	glColor3f(1.0, 1.0, 1.0)
	
	SetFontType(1)
	
	SetTextBg(0, 0, 0, 0)
	
	SetTextColor(217, 135, 25, 255)
	
	RenderText3(590, 4, string.format('FPS: %02.f', getFPS()), 50, 3)
	
	GLSwitch()
	glColor3f(1.0, 1.0, 1.0)
	
	DisableAlphaBlend()
end

InterfaceController.MainProc(InterfaceInfos.Render)

return InterfaceInfos