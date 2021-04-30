-- true Ativa o sistema, false desativa
JewelBank_Enabled = true

-- Id da interface, não pode ser igual a nenhum outro sistema custom
JewelBank_WindowId = 1

-- Numero do Packet usado no sistema (não pode ser igual ao de nenhum outro sistema)
JewelBank_Packet = 0x01

-- ListID (tem que ser o mesmo da configuração no servidor)(tem que começar no 1 e não pode pular)
-- Index da jóia
-- Nome da jóia
-- Ajuste de posição do item na interface:
	-- X posição horizontal (0 = posição original, menor que 0 move para esquerda, mais que 0 move para direita)
	-- Y posição vertical (0 = posição original, menor que 0 move para esquerda, mais que 0 move para direita) 
	-- W largura da area que faz o item girar com mouse em cima
	-- H altura da area que faz o item girar com mouse em cima
JewelBank_Jewels = {
{ListID = 1 , Index = GET_ITEM(12, 15), Nome = "Jewel of Chaos",		Position = {X = 2, Y = -3, W = 13, H = 13}},
{ListID = 2 , Index = GET_ITEM(14, 13), Nome = "Jewel of Bless",		Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 3 , Index = GET_ITEM(14, 14), Nome = "Jewel of Soul",			Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 4 , Index = GET_ITEM(14, 16), Nome = "Jewel of Life",			Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 5 , Index = GET_ITEM(14, 22), Nome = "Jewel of Creation",		Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 6 , Index = GET_ITEM(14, 31), Nome = "Jewel of Guardian",		Position = {X = 2, Y = -1, W = 13, H = 13}},
{ListID = 7 , Index = GET_ITEM(14, 41), Nome = "Gemstone",				Position = {X = 2, Y =  2, W = 13, H = 13}},
{ListID = 8 , Index = GET_ITEM(14, 42), Nome = "Jewel of Harmony",		Position = {X = 2, Y =  2, W = 13, H = 13}},
{ListID = 9 , Index = GET_ITEM(14, 43), Nome = "Lower Refining Stone",	Position = {X = 0, Y =  0, W = 13, H = 13}},
{ListID = 10, Index = GET_ITEM(14, 44), Nome = "Higher Refining Stone",	Position = {X = 0, Y =  0, W = 13, H = 13}},
}

-- Textos do sistema
JewelBank_Texts = {}
JewelBank_Texts["Por"] = {
[1] = "     Banco de Jóias     ",
[2] = " Fechar ",
[3] = " Selecione uma jóia para começar ",
[4] = " Fazer Retirada ",
}
JewelBank_Texts["Eng"] = {
[1] = "     Jewel Bank     ",
[2] = " Close ",
[3] = " Select one jewel to start ",
[4] = " Withdraw ",
}
JewelBank_Texts["Spn"] = {
[1] = "     Banco de Joyas     ",
[2] = " Cerrar ",
[3] = " Seleccione una joya para comenzar ",
[4] = " Sacar Joya ",
}



-- INÍCIO DO CÓDIGO, SÓ MEXA SE SOUBER O QUE ESTÁ FAZENDO --
JewelBank = {}
JewelBank_Buttons = {}
JewelBank_WorkArea = {X1 = 260, X2 = 450, Y1 = 0, Y2 = 429}
JewelBank_Saldo = {}
JewelBank_List = {}
JewelBank_ListOffset = 0
JewelBank_ScrollBar = {Offset = 0, MaxOffset = 0, Pos = 0, Esp = 180, Multiplier = 0}
JewelBank_Selected = {}
JewelBank_ButtonSelected = 0
JewelBank_ButtonValue = {[2] = 1,[3] = 10 ,[4] = 20 ,[5] = 30 ,[6] = 40 ,[7] = 50 ,[8] = 60 ,[9] = 70 ,[10] = 80 ,[11] = 90 ,[12] = 100,[13] = 110,[14] = 120,[15] = 130,[16] = 140,[17] = 150}
JewelBank_WindowOffset = 0

function JewelBank.Close()
	UICustomInterface = 0
	CloseWindow(UIInventory)
	JewelBank_ListOffset = 0
	JewelBank_Selected = {}
	JewelBank_ButtonSelected = 0
	JewelBank_WindowOffset = 0
end

function JewelBank.Open()
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
	JewelBank.GerarLista()
	JewelBank.GerarBarra()
	OpenWindow(UIInventory)
	UICustomInterface = JewelBank_WindowId
end

function JewelBank.GerarLista()
	local listcount = 0
	JewelBank_List = {}
	for i in ipairs(JewelBank_Jewels) do
		if i > JewelBank_ListOffset then
			if listcount < 8 then
				table.insert(JewelBank_List, JewelBank_Jewels[i]) 
				listcount = listcount + 1
			end
		end
	end
end

function JewelBank.GerarBarra()
	if JewelBank_ScrollBar.Offset > 0 then
		JewelBank_ScrollBar.Offset = 0
		JewelBank_ScrollBar.Pos = 0
	end
	JewelBank_ScrollBar.MaxOffset = #JewelBank_Jewels-8	
	JewelBank_ScrollBar.Multiplier = JewelBank_ScrollBar.Esp/(#JewelBank_Jewels-8)
end

function JewelBank.MoveBarDown()
	if JewelBank_ScrollBar.Offset < JewelBank_ScrollBar.MaxOffset then
		JewelBank_ScrollBar.Offset = JewelBank_ScrollBar.Offset + 1
		JewelBank_ScrollBar.Pos = JewelBank_ScrollBar.Pos + JewelBank_ScrollBar.Multiplier
	end
end

function JewelBank.MoveBarUp()
	if JewelBank_ScrollBar.Offset > 0 then
		JewelBank_ScrollBar.Offset = JewelBank_ScrollBar.Offset - 1
		JewelBank_ScrollBar.Pos = JewelBank_ScrollBar.Pos - JewelBank_ScrollBar.Multiplier
	end
end

function JewelBank.CreateButton(IdBotao, X, Y, W, H)
	if JewelBank_Buttons[IdBotao] == nil then
		table.insert(JewelBank_Buttons, IdBotao)
	end
	JewelBank_Buttons[IdBotao] = {X1 = X, X2 = X+W, Y1 = Y, Y2 = Y+H}
end

function JewelBank.CheckButton(IdBotao, X, Y)
	if JewelBank_Buttons[IdBotao] == nil then return false end
	if X >= JewelBank_Buttons[IdBotao].X1 and X <= JewelBank_Buttons[IdBotao].X2 and Y >= JewelBank_Buttons[IdBotao].Y1 and Y <= JewelBank_Buttons[IdBotao].Y2 then
		return true
	end
	return false
end

function JewelBank.BeforeInterface()	
	if UICustomInterface == JewelBank_WindowId then
		if	CheckWindowOpen(UIInventory) 		== 0	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIFriendList) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIMoveList)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIParty) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIQuest) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIGuild) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UITrade) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIWarehouse) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIChaosBox)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UICommandWindow) 	== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIPetInfo)	 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIShop)				== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIStore) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIOtherStore) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UICharacter) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIOptions) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIHelp)				== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIFastDial)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UISkillTree) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UINPC_Titus) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UICashShop)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIFullMap) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UINPC_Dialog)		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIGensInfo)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UINPC_Julia)		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIExpandInventory)	== 1	then	JewelBank_WindowOffset = 190 else JewelBank_WindowOffset = 0	end
		if	CheckWindowOpen(UIExpandWarehouse)	== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIMuHelper)			== 1	then	JewelBank.Close()	end

		EnableAlphaTest()
		
		RenderImage(31322, 260-JewelBank_WindowOffset, 0, 190, 428)
		RenderImage(31353, 260-JewelBank_WindowOffset, 0, 190, 64)
		RenderImage(31355, 260-JewelBank_WindowOffset, 64, 21, 320)
		RenderImage(31356, 429-JewelBank_WindowOffset, 64, 21, 320)
		RenderImage(31357, 260-JewelBank_WindowOffset, 384, 190, 45)
		
		SetFontType(1)
		SetTextBg(0, 0, 0, 255)
		SetTextColor(255, 255, 255, 255)
		RenderText3(355-JewelBank_WindowOffset, 12, string.format(JewelBank_Texts[GetLanguage()][1]), 80, 8)
		
		JewelBank.CreateButton(1, 428-JewelBank_WindowOffset, 6, 14, 14) 		
		
		DisableAlphaBlend()
		
		SetBlend()
		glColor4f(0.0, 0.0, 0.0, 0.7)			
		DrawBar(273-JewelBank_WindowOffset, 36, 160, 23)		
		DrawBar(273-JewelBank_WindowOffset, 196, 154, 202)		
		local ItemY = 223
		for i in ipairs(JewelBank_List) do
			CreateItem((280+JewelBank_List[i].Position.X)-JewelBank_WindowOffset, ((ItemY-20)+JewelBank_List[i].Position.Y), JewelBank_List[i].Position.W, JewelBank_List[i].Position.H, JewelBank_List[i].Index, 0, 0, 0)					
				
			glColor4f(0.5, 0.5, 0.5, 0.4)
			DrawBar(285-JewelBank_WindowOffset, ItemY, 130, 1)
			ItemY = ItemY+25
		end
		if JewelBank_Selected.ListID ~= nil then
			CreateItem((280+JewelBank_Selected.Position.X)-JewelBank_WindowOffset, (43+JewelBank_Selected.Position.Y), JewelBank_Selected.Position.W, JewelBank_Selected.Position.H, JewelBank_Selected.Index, 0, 0, 0)
		end
		
		GLSwitchBlend()	
		glColor3f(1.0,1.0,1.0)
		GLSwitch()
		
		EnableAlphaTest()
		RenderImage(31340, 272-JewelBank_WindowOffset, 195, 14, 14)
		RenderImage(31341, 423-JewelBank_WindowOffset, 195, 14, 14)
		RenderImage(31342, 272-JewelBank_WindowOffset, 390, 14, 14)
		RenderImage(31343, 423-JewelBank_WindowOffset, 390, 14, 14)
		RenderImage(31344, 286-JewelBank_WindowOffset, 195, 137, 14)
		RenderImage(31345, 286-JewelBank_WindowOffset, 390, 137, 14)
		RenderImage(31346, 272-JewelBank_WindowOffset, 208, 14, 182)
		RenderImage(31347, 423-JewelBank_WindowOffset, 208, 14, 182)
		
		RenderImage(31340, 272-JewelBank_WindowOffset, 35, 14, 14)
		RenderImage(31341, 423-JewelBank_WindowOffset, 35, 14, 14)
		RenderImage(31344, 286-JewelBank_WindowOffset, 35, 137, 14)
		RenderImage(31342, 272-JewelBank_WindowOffset, 49, 14, 14)
		RenderImage(31343, 423-JewelBank_WindowOffset, 49, 14, 14)
		RenderImage(31345, 286-JewelBank_WindowOffset, 49, 137, 14)
		
		if JewelBank_Selected.ListID ~= nil then
			SetFontType(0)
			SetTextBg(0, 0, 0, 0)			
			local id = 2
			for y = 65, 140, 25 do
				for x = 275, 395, 40 do
					JewelBank.CreateButton(id, x-JewelBank_WindowOffset, y, 34, 23)
					RenderImage2(32344, x-JewelBank_WindowOffset, y, 60, 23,0, 0, 1.0, 1.0, 1, 1, 1.0)
					if JewelBank_ButtonSelected == id then
						SetTextColor(255, 204, 0, 255)
					else
						SetTextColor(0, 221, 255, 255)
					end					
					RenderText3(x-JewelBank_WindowOffset, y+6, string.format(" %d ", JewelBank_ButtonValue[id]), 40, 3)
					id = id + 1
				end
			end	
		end
		
		if JewelBank_Selected.ListID ~= nil then
			SetFontType(1)
			SetTextBg(0, 0, 0, 0)
			SetTextColor(255, 204, 0, 255)
			RenderText3(305-JewelBank_WindowOffset, 43, string.format(JewelBank_Selected.Nome), 100, 3)
			SetTextColor(255, 255, 255, 165)
			RenderText3(420-JewelBank_WindowOffset, 43, string.format("%dx",JewelBank_Saldo[JewelBank_Selected.ListID]), 50, 7)
			
			JewelBank.CreateButton(18, 310-JewelBank_WindowOffset, 165, 90, 25)
		
			if JewelBank.CheckButton(18, MousePosX(), MousePosY()) then
				RenderImage2(31326, 310-JewelBank_WindowOffset, 165, 110, 25,0, 0.2264566, 1.0, 0.2245212, 1, 1, 1.0)
			else
				RenderImage2(31326, 310-JewelBank_WindowOffset, 165, 110, 25,0, 0, 1.0, 0.2245212, 1, 1, 1.0)
			end
			
			SetTextBg(0, 0, 0, 0)
			SetTextColor(255, 255, 255, 230)
			--RenderText2(315-JewelBank_WindowOffset, 172, string.format(JewelBank_Texts[GetLanguage()][4]), 3)
			RenderText3(322-JewelBank_WindowOffset, 172, string.format(JewelBank_Texts[GetLanguage()][4]), 70, 3)
			
		else
			SetFontType(1)
			SetTextBg(0, 0, 0, 0)
			SetTextColor(255, 204, 0, 255)
			RenderText3(280-JewelBank_WindowOffset, 43, string.format(JewelBank_Texts[GetLanguage()][3]), 150, 3)
		end
		
		RenderImage(31270, 426-JewelBank_WindowOffset, 195, 7, 3)
		for y = 198, 393, 5 do
			RenderImage(31271, 426-JewelBank_WindowOffset, y, 7, 5)
		end
		RenderImage(31272, 426-JewelBank_WindowOffset, 397, 7, 3)
		RenderImage(31273, 422-JewelBank_WindowOffset, (192+JewelBank_ScrollBar.Pos), 15, 30)	-- scrollbar
			
		local ItemY = 223
		for i in ipairs(JewelBank_List) do
			SetFontType(0)
			SetTextBg(0, 0, 0, 0)
			if JewelBank_Selected.ListID ~= nil then
				if JewelBank_Selected.ListID == JewelBank_List[i].ListID then
					SetTextColor(0, 221, 255, 255)
				else
					SetTextColor(255, 255, 255, 230)
				end
			else
				SetTextColor(255, 255, 255, 230)
			end
			RenderText2(315-JewelBank_WindowOffset, ItemY-16, string.format("%s",JewelBank_List[i].Nome), ALIGN_LEFT)
			if JewelBank_Saldo[JewelBank_List[i].ListID] ~= nil then
				SetTextBg(0, 0, 0, 0)
				SetTextColor(255, 255, 255, 165)
				RenderText2(290-JewelBank_WindowOffset, ItemY-8, string.format("%dx", JewelBank_Saldo[JewelBank_List[i].ListID]), ALIGN_CENTER)
			end
			
			ItemY = ItemY+25
		end
		
		if JewelBank.CheckButton(1, MousePosX(), MousePosY()) then
			SetFontType(0)
			SetTextBg(0, 0, 0, 255)
			SetTextColor(255, 255, 255, 255)
			RenderText2(425-JewelBank_WindowOffset, 30, string.format(JewelBank_Texts[GetLanguage()][2]), ALIGN_LEFT)
		end

		DisableAlphaBlend()
	end
end

function JewelBank.Protocol(Packet, PacketName)
	if Packet == JewelBank_Packet then
		local nome = UserGetName()
		if PacketName == string.format("JBOpe_%s",nome) then
			JewelBank_Saldo = {}
			local count = GetBytePacket(PacketName, -1)
			for i = 1, count do
				local listid = GetBytePacket(PacketName, -1)
				local valor = GetWordPacket(PacketName, -1)
				
				table.insert(JewelBank_Saldo, listid)
				JewelBank_Saldo[listid] = valor
			end
			ClearPacket(PacketName)
			JewelBank.Open()
			return true
		end
		
		if PacketName == string.format("JBBal_%s",nome) then
			if UICustomInterface == JewelBank_WindowId then
				local listid = GetBytePacket(PacketName, -1)
				local valor = GetWordPacket(PacketName, -1)
				if JewelBank_Saldo[listid] ~= nil then
					JewelBank_Saldo[listid] = valor
				end
			end
			ClearPacket(PacketName)
			return true
		end
	end
end

function JewelBank.KeyListener(key)
	if CheckWindowOpen(UIChatWindow) == 0 and CheckWindowOpen(UIStore) == 0then
		if key == Keys.J then
			if JewelBank_Enabled then
				if UICustomInterface == JewelBank_WindowId then
					JewelBank.Close()
				else
					local nome = UserGetName()
					CreatePacket(string.format("JBOpe_%s",nome), JewelBank_Packet)
					SendPacket(string.format("JBOpe_%s",nome))
					ClearPacket(string.format("JBOpe_%s",nome))
					return
				end
				return
			end
		end
		
		if key == Keys.V or key == Keys.I or key == Keys.Escape then
			if UICustomInterface == JewelBank_WindowId then
				JewelBank.Close()
				return
			end
		end
	end
end

function JewelBank.ScrollMouse(Direction)
	local x = MousePosX()
	local y = MousePosY()
	if UICustomInterface == JewelBank_WindowId then
		if x >= 275-JewelBank_WindowOffset and x <= 436-JewelBank_WindowOffset and y >= 196 and y <= 399 then
			if Direction > 0 then
				if JewelBank_ListOffset >= 1 then
					JewelBank_ListOffset = JewelBank_ListOffset - 1
					JewelBank.GerarLista()
					JewelBank.MoveBarUp()
				end
				return
			else				
				if #JewelBank_Jewels > 8 then
					if #JewelBank_Jewels-JewelBank_ListOffset > 8 then
						JewelBank_ListOffset = JewelBank_ListOffset + 1
						JewelBank.GerarLista()
						JewelBank.MoveBarDown()
					end
				end
				return				
			end
			return
		end
	end
end

function JewelBank.ClickEvent()
	if UICustomInterface == JewelBank_WindowId then
		if JewelBank.CheckButton(1, MousePosX(), MousePosY()) then
			if UICustomInterface == JewelBank_WindowId then
				JewelBank.Close()
			end
		end
		
		for id = 2, 17 do
			if JewelBank.CheckButton(id, MousePosX(), MousePosY()) then
				JewelBank_ButtonSelected = id
				return
			end
		end
		
		if JewelBank.CheckButton(18, MousePosX(), MousePosY()) then
			if JewelBank_Selected.ListID == nil or JewelBank_Selected.ListID == 0 or JewelBank_ButtonSelected == 0 then
				return
			end
			local nome = UserGetName()
			CreatePacket(string.format("JBSac_%s",nome), JewelBank_Packet)
			SetBytePacket(string.format("JBSac_%s",nome), JewelBank_Selected.ListID)
			SetBytePacket(string.format("JBSac_%s",nome), JewelBank_ButtonSelected)
			SendPacket(string.format("JBSac_%s",nome))
			ClearPacket(string.format("JBSac_%s",nome))
			return
		end
		
		local ItemY = 223
		for i in ipairs(JewelBank_List) do
			if MousePosX() >=280-JewelBank_WindowOffset and MousePosX() <= 420-JewelBank_WindowOffset and MousePosY() >= ItemY-23 and MousePosY() <= ItemY-2 then
				JewelBank_Selected = JewelBank_List[i]
				return
			end
			ItemY = ItemY+25
		end
	end
end

function JewelBank.UpdateMouse()
	if UICustomInterface == JewelBank_WindowId then
		if MousePosX()  >= JewelBank_WorkArea.X1-JewelBank_WindowOffset and MousePosX() <= JewelBank_WorkArea.X2-JewelBank_WindowOffset and MousePosY() >= JewelBank_WorkArea.Y1 and MousePosY() <= JewelBank_WorkArea.Y2 then
			DisableClickClient()
			return
		end
	end	
end

function JewelBank.ClickRightEvent()
	if CheckRepeatKey(Keys.ControlKey) ~= 0 then
		local slot = GetInventoryMouseSlot()
		if slot >= 12 then
			local nome = UserGetName()
			
			CreatePacket(string.format("JBDep_%s",nome), JewelBank_Packet)
			SetBytePacket(string.format("JBDep_%s",nome), slot)			
			SendPacket(string.format("JBDep_%s",nome))
			ClearPacket(string.format("JBDep_%s",nome))
			return
		end
		
	end
end

InterfaceController.BeforeMainProc(JewelBank.BeforeInterface)
InterfaceController.ClientProtocol(JewelBank.Protocol)
InterfaceController.MainProcWorldKey(JewelBank.KeyListener)
InterfaceController.ScrollMouse(JewelBank.ScrollMouse)
InterfaceController.InterfaceClickEvent(JewelBank.ClickEvent)
InterfaceController.InterfaceClickRightEvent(JewelBank.ClickRightEvent)
InterfaceController.UpdateMouse(JewelBank.UpdateMouse)

return JewelBank