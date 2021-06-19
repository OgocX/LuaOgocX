OpenFolder("Definitions")

local CHAOS_MACHINE_CONFIG_COMB_SELECTION = {
	{ Combination = 1, CombinationSuccessRate = 100.0, CombinationName = "Set Dragon Knight - FULL" },
	{ Combination = 2, CombinationSuccessRate = 100.0, CombinationName = "Set Venon Mist - FULL" },
}

local CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS = { }

CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[1] = {
	{ Level = -1, Exc = -1, Quantity = 3, ItemIndex = GET_ITEM(12, 15), ItemName = "Jewel of Chaos" },
	{ Level = -1, Exc = -1, Quantity = 2, ItemIndex = GET_ITEM(14, 14), ItemName = "Jewel of Soul" },
	{ Level = -1, Exc = -1, Quantity = 8, ItemIndex = GET_ITEM(14, 13), ItemName = "Jewel of Bless" },
	{ Level = -1, Exc = -1, Quantity = 4, ItemIndex = GET_ITEM(14, 16), ItemName = "Jewel of Life" },
	{ Level = -1, Exc = -1, Quantity = 3, ItemIndex = GET_ITEM(14, 22), ItemName = "Jewel of Creation" },
	{ Level = -1, Exc = -1, Quantity = 2, ItemIndex = GET_ITEM(0, 0), ItemName = "Kriss" },
	{ Level = -1, Exc = -1, Quantity = 2, ItemIndex = GET_ITEM(7, 0), ItemName = "Bronze Helm" },
	{ Level = -1, Exc = -1, Quantity = 2, ItemIndex = GET_ITEM(8, 0), ItemName = "Bronze Armor" },
	{ Level = -1, Exc = -1, Quantity = 2, ItemIndex = GET_ITEM(9, 0), ItemName = "Bronze Pants" },
	{ Level = -1, Exc = -1, Quantity = 2, ItemIndex = GET_ITEM(10, 0), ItemName = "Bronze Gloves" },
	{ Level = -1, Exc = -1, Quantity = 2, ItemIndex = GET_ITEM(11, 0), ItemName = "Bronze Boots" },
}

CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[2] = {
	{ Level = -1, Exc = -1, Quantity = 1, ItemIndex = GET_ITEM(12, 15), ItemName = "Jewel of Chaos" },
}

--[[
Config messages
--]]

local CHAOS_MACHINE_TEXTS = { }

CHAOS_MACHINE_TEXTS["Por"] = {
[1] = "Mixar itens", 
[2] = "Selecionar",
[3] = "Selecione a combinação desejada!",
[4] = "Combinação em andamento",
[5] = "Combinação bem sucedida",
[6] = "Combinação cancelada",
[7] = "Taxa de sucesso: %.2f",
[8] = "Itens necessários para combinação:",
[9] = "Seus itens:",
[10] = "Resultado da combinação:",
[11] = "Chaos Machine Genesis",
[12] = "Mixar itens",
[13] = "Falta itens para a combinação!",
[14] = "Este item não funciona nesta combinação!",
}

CHAOS_MACHINE_TEXTS["Eng"] = {
[1] = "Mix items",
[2] = "Select",
[3] = "Select the desired combination!",
[4] = "Combination in progress",
[5] = "Successful combination",
[6] = "Combination canceled",
[7] = "Success rate: %.2f",
[8] = "Items needed for combination:",
[9] = "Your items:",
[10] = "Result of the combination:",
[11] = "Chaos Machine Genesis",
[12] = "Mix items",
[13] = "Items are missing for the combination!",
[14] = "This item does not work in this combination!",
}

CHAOS_MACHINE_TEXTS["Spn"] = {
[1] = "Mezclar elementos",
[2] = "Seleccionar",
[3] = "¡Seleccione la combinación deseada!",
[4] = "Combinación en curso",
[5] = "Combinación exitosa",
[6] = "Combinación cancelada",
[7] = "Tasa de éxito: %.2f",
[8] = "Elementos necesarios para la combinación:",
[9] = "Tus artículos:",
[10] = "Resultado de la combinación:",
[11] = "Génesis de la máquina del caos",
[12] = "Mezclar elementos",
[13] = "¡Elementos faltantes para la combinación!",
[14] = "¡Este elemento no funciona en esta combinación!",
}

--[[
Configs Chaos Machine don't touch if you don't know!
--]]

local ChaosMachineSelectedItem = 0
local ChaosMachineSelectedItemClicked = 0
local ChaosMachineSelectedItemPosY = 0
local ChaosMachineSelectedItemClickedPosY = 0
local ChaosMachinePage = 0
local ChaosMachineScrollBarCurrentLine = 0
local ChaosMachineScrollBarMaxRenderLine = 13
local ChaosMachineScrollBarPosY = 0
local ChaosMachineScrollBarPosMouse = 0
local ChaosMachineScrollBarPosYMultiplier = 0
local ChaosMachineSelectedKey = 0
local ChaosMachineSelectedCombSelected = 0
local ChaosMachineItensIngredients = {}
local ChaosMachineCombinationStatus = 0
local ScrollBarPageOneMaxLine = 13
local ScrollBarPageCombMaxLine = 6
local ScrollBarPageMin = 0
local ScrollBarPageMax = 0

local m_Pos = { x = 260, y = 0 }

function ChaosMachineRenderFrame()
	RenderImage(31322, m_Pos.x, m_Pos.y, 190.0, 429.0)
	RenderImage(31353, m_Pos.x, m_Pos.y, 190.0, 64.0)
	RenderImage(31355, m_Pos.x, m_Pos.y + 64, 21.0, 320.0)
	RenderImage(31356, m_Pos.x + 169, m_Pos.y + 64, 21.0, 320.0)
	RenderImage(31357, m_Pos.x, m_Pos.y + 384, 190.0, 45.0)
	
	if ChaosMachinePage == 1 and ChaosMachineCombinationStatus == 0
	then
		if MousePosX() >= m_Pos.x + 73 and MousePosX() <= m_Pos.x + 73 + 44 and MousePosY() >= m_Pos.y + 380 and MousePosY() <= m_Pos.y + 380 + 32
		then
			SetFontType(1)
			
			SetTextColor(255, 255, 255, 255)
			
			SetTextBg(0, 0, 0, 255)
			
			local MixText = CHAOS_MACHINE_TEXTS[GetLanguage()][1]
			
			RenderText3(m_Pos.x + 75, m_Pos.y + 370, MixText, #MixText * 3, 3)
			
			if CheckPressedKey(Keys.LButton) == 1
			then
				RenderImage2(31419, m_Pos.x + 73, m_Pos.y + 380, 44, 32, 0, 0.26, 0.72, 0.26, 1, 1, 1.0)
				
				DisableClickClient()
			else 
				RenderImage2(31419, m_Pos.x + 73, m_Pos.y + 380, 44, 32, 0, 0.0, 0.72, 0.26, 1, 1, 1.0)
			end
		else
			RenderImage2(31419, m_Pos.x + 73, m_Pos.y + 380, 44, 32, 0, 0.0, 0.72, 0.26, 1, 1, 1.0)
		end
	end
end

function RenderSelectButton(x, y, width, height)
	EnableAlphaTest()
	
	if MousePosX() >= x and MousePosX() <= x + width and MousePosY() >= y and MousePosY() <= y + height
	then
		RenderImage2(31326, x, y, width, height, 0, 0.2264566, 1.0, 0.2245212, 1, 1, 1.0)
	else
		RenderImage2(31326, x, y, width, height, 0, 0, 1.0, 0.2245212, 1, 1, 1.0)
	end
	
	SetFontType(1)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(216, 216, 216, 255)
	
	local Text = CHAOS_MACHINE_TEXTS[GetLanguage()][2]
	
	RenderText3(x, y + 10, Text, width - #Text, 3)
	
	DisableAlphaBlend()
end

function RenderBox(x, y, width, height)
	EnableAlphaTest()
	
	glColor4f(0.0, 0.0, 0.0, 0.3)

	DrawBar(x, y, width, height, 0.0, 0)
	
	glColor4f(0.0, 0.0, 0.0, 0.5)

	DrawBar(x, y, width, height, 0.0, 0)
	
	if ChaosMachineSelectedItem ~= 0
	then
		glColor4f(0.2, 0.2, 0.2, 0.5)
		DrawBar(x, ChaosMachineSelectedItemPosY - 2, width, 10, 0.0, 0)
	end
	
	if ChaosMachineSelectedItemClicked ~= 0
	then
		glColor4f(0.2, 0.2, 0.2, 0.5)
		DrawBar(x, ChaosMachineSelectedItemClickedPosY - 2, width, 10, 0.0, 0)
	end
	
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
	
	DisableAlphaBlend()
end

function RenderScrollBarPage(x, y, width, height, size)
	EnableAlphaTest()

	glColor4f(1.0, 1.0, 1.0, 1.0)

	RenderImage(31270, x + width - 11, y + 14, 7, 3)
	
	for i = 0, size do
		RenderImage(31271, x + width - 11, (y + 13) + (i * 10 + 4), 7, 15)
	end

	RenderImage(31272, x + width - 11, y + height - 8, 7, 3)

	if MousePosX() >= (x + width - 15) and MousePosX() <= (x + width - 15) + 15
		and MousePosY() >= y + 10 + ChaosMachineScrollBarPosY and MousePosY() <= y + 10 + ChaosMachineScrollBarPosY + 30
	then
		glColor4f(1.0, 1.0, 1.0, 1.0)
	else
		glColor4f(0.7, 0.7, 0.7, 1.0)
	end

	RenderImage(31273, x + width - 15, y + 10 + ChaosMachineScrollBarPosY, 15, 30)
	
	glColor4f(1.0, 1.0, 1.0, 1.0)

	DisableAlphaBlend()
end

function RenderTextPageOne(x , y)
	EnableAlphaTest()

	SetFontType(1)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(215, 150, 230, 255)
	
	local posY = 0
	local line = 0

	for key = 1, #CHAOS_MACHINE_CONFIG_COMB_SELECTION do
		if line >= ChaosMachineScrollBarCurrentLine and line < ChaosMachineScrollBarMaxRenderLine
		then
			local combs = CHAOS_MACHINE_CONFIG_COMB_SELECTION[key]
		
			RenderText3(x, y + posY, combs.CombinationName, 155 - #combs.CombinationName, 1)
			
			posY = posY + 15
		end
		
		line = line + 1
	end
	
	DisableAlphaBlend()
end

function ChaosMachineRenderSelectPageOne()
	SetFontType(1)
	
	SetTextBg(0, 0, 0, 0)
	
	SetTextColor(216, 216, 216, 255)
	
	RenderText3(m_Pos.x, m_Pos.y + 70, CHAOS_MACHINE_TEXTS[GetLanguage()][3], 190, 3)
	
	RenderBox(m_Pos.x + 15, m_Pos.y + 100, 160, 200)
	
	RenderSelectButton(m_Pos.x + 57.5, m_Pos.y + 350, 80, 30)
	
	RenderScrollBarPage(m_Pos.x + 15, m_Pos.y + 100, 160, 200, 16)
	
	RenderTextPageOne(m_Pos.x + 20, m_Pos.y + 110)
end

function ChaosMachineRenderCombItensNeed(x, y)
	local posY = 0
	local line = 0

	for i in ipairs(ChaosMachineItensIngredients) do
		if line >= ChaosMachineScrollBarCurrentLine and line < ChaosMachineScrollBarMaxRenderLine
		then
			local itens = ChaosMachineItensIngredients[i].Ingredients
			local itensQuantity = getCountItensByIndexLevel(itens.ItemIndex, itens.Level, itens.Exc)
			
			if itensQuantity ==  itens.Quantity
			then
				SetTextColor(000, 150, 000, 255)
			else
				SetTextColor(200, 000, 000, 255)
			end
			
			local strName = string.format('%s - [%d / %d]', itens.ItemName, itensQuantity, itens.Quantity)
			
			RenderText3(x, y + posY, strName, 155 - #strName, 1)
			
			posY = posY + 15
		end
		
		line = line + 1
	end
end

function ChaosMachineRenderCombinationPage()
	EnableAlphaTest()
	
	SetFontType(1)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(255, 255, 255, 255)
	
	RenderText3(m_Pos.x, m_Pos.y + 40, string.format('%s', CHAOS_MACHINE_CONFIG_COMB_SELECTION[ChaosMachineSelectedKey].CombinationName), 190, 3)
	
	local TextComb = CHAOS_MACHINE_TEXTS[GetLanguage()][4]
	
	if ChaosMachineCombinationStatus == 1
	then
		SetTextColor(000, 150, 000, 255)
		TextComb = CHAOS_MACHINE_TEXTS[GetLanguage()][5]
	elseif ChaosMachineCombinationStatus == 2
	then
		SetTextColor(200, 000, 000, 255)
		TextComb = CHAOS_MACHINE_TEXTS[GetLanguage()][6]
	end
	
	RenderText3(m_Pos.x, m_Pos.y + 55, TextComb, 190, 3)
	
	SetTextColor(255, 255, 255, 255)
	
	if (ChaosMachineCombinationStatus == 0)
	then
		SetTextColor(216, 216, 216, 255)
		
		RenderText3(m_Pos.x, m_Pos.y + 70, string.format(CHAOS_MACHINE_TEXTS[GetLanguage()][7], CHAOS_MACHINE_CONFIG_COMB_SELECTION[ChaosMachineSelectedKey].CombinationSuccessRate), 190, 3)
	
		RenderText3(m_Pos.x + 15, m_Pos.y + 95, CHAOS_MACHINE_TEXTS[GetLanguage()][8], 190, 1)
	end
	
	DisableAlphaBlend()
	
	local posYReduce = 0
	local MaxLines = 8
	local HeightBoxItem = 110
	
	--box itens comb
	if (ChaosMachineCombinationStatus == 0)
	then
		RenderBox(m_Pos.x + 15, m_Pos.y + 110, 160, 100)
		
		RenderScrollBarPage(m_Pos.x + 15, m_Pos.y + 100, 160, 110, 7)
		
		EnableAlphaTest()
		
		ChaosMachineRenderCombItensNeed(m_Pos.x + 18, m_Pos.y + 115)
		
		DisableAlphaBlend()
	else 
		posYReduce = 130
		MaxLines = 19
		HeightBoxItem = 220
	end
	
	EnableAlphaTest()
	
	SetTextColor(216, 216, 216, 255)
	
	if (ChaosMachineCombinationStatus == 0)
	then
		RenderText3(m_Pos.x + 15, m_Pos.y + 225 - posYReduce, CHAOS_MACHINE_TEXTS[GetLanguage()][9], 190, 1)
	else
		RenderText3(m_Pos.x + 15, m_Pos.y + 225 - posYReduce, CHAOS_MACHINE_TEXTS[GetLanguage()][10], 190, 1)
	end
	
	DisableAlphaBlend()
	
	--box my itens
	RenderBox(m_Pos.x + 15, m_Pos.y + 240 - posYReduce, 160, HeightBoxItem - 10)
	
	RenderItensChaosMachine(m_Pos.x + 20, m_Pos.y + 245 - posYReduce, HeightBoxItem, MaxLines)
end

function ChaosMachineRenderPages()
	SetFontType(1)
	
	SetTextBg(0, 0, 0, 0)
	
	SetTextColor(216, 216, 216, 255)
	
	RenderText3(m_Pos.x, m_Pos.y + 11, CHAOS_MACHINE_TEXTS[GetLanguage()][11], 190, 3)
	
	if ChaosMachinePage == 0
	then
		ChaosMachineRenderSelectPageOne()
	elseif ChaosMachinePage == 1
	then
		ChaosMachineRenderCombinationPage()
	end
end


function ChaosMachineRender()
	EnableAlphaTest()
	
	glColor4f(1.0, 1.0, 1.0, 1.0)
	
	ChaosMachineRenderFrame()
	
	ChaosMachineRenderPages()
	
	DisableAlphaBlend()
end

function ChaosMachineUpdate()
	if CheckWindowOpen(UIExpandInventory) == 1
	then
		m_Pos.x = 70
		
	else
		m_Pos.x = 260
	end
end

function ScrollingBar(value)
	if value > 0
	then
		if (ChaosMachineScrollBarMaxRenderLine < ScrollBarPageMin)
		then
			ChaosMachineScrollBarMaxRenderLine = ChaosMachineScrollBarMaxRenderLine + 1
			ChaosMachineScrollBarCurrentLine = ChaosMachineScrollBarCurrentLine + 1
			ChaosMachineScrollBarPosY = ChaosMachineScrollBarPosY + ChaosMachineScrollBarPosYMultiplier
		end
	elseif value < 0
	then
		if (ChaosMachineScrollBarMaxRenderLine > ScrollBarPageMax)
		then
			ChaosMachineScrollBarMaxRenderLine = ChaosMachineScrollBarMaxRenderLine - 1
			ChaosMachineScrollBarCurrentLine = ChaosMachineScrollBarCurrentLine - 1
			ChaosMachineScrollBarPosY = ChaosMachineScrollBarPosY - ChaosMachineScrollBarPosYMultiplier
		end
	end
end

function ChaosMachineScrollBarPageOneMouseCheckMouseClicked()
	if CheckRepeatKey(Keys.LButton) == 1
	then
		if MousePosX() >= m_Pos.x + 150 and MousePosX() <= m_Pos.x + 190
		then
			local value = MousePosY() - ChaosMachineScrollBarPosMouse
			
			if value < 0
			then
				if (MousePosY() <= (m_Pos.y + 100 + ChaosMachineScrollBarPosY) + 15)
				then
					ScrollingBar(-1)
				end
			elseif value > 0
			then
				if (MousePosY() >= (m_Pos.y + 100 + ChaosMachineScrollBarPosY) + 15)
				then
					ScrollingBar(1)
				end
			end
			
			ChaosMachineScrollBarPosMouse = MousePosY()
		end
	end
end

function ChaosMachineScrollBarPageCombMouseCheckMouseClicked()
	if CheckRepeatKey(Keys.LButton) == 1
	then
		if MousePosX() >= m_Pos.x + 150 and MousePosX() <= m_Pos.x + 190 
			and MousePosY() >= m_Pos.y + 50 and MousePosY() <= m_Pos.y + 210
		then
			local value = MousePosY() - ChaosMachineScrollBarPosMouse
			
			if value < 0
			then
				if (MousePosY() <= (m_Pos.y + 100 + ChaosMachineScrollBarPosY) + 15)
				then
					ScrollingBar(-1)
				end
			elseif value > 0
			then
				if (MousePosY() >= (m_Pos.y + 100 + ChaosMachineScrollBarPosY) + 15)
				then
					ScrollingBar(1)
				end
			end
			
			ChaosMachineScrollBarPosMouse = MousePosY()
		end
	end
end

function ChaosMachineScrollBarPageOneMouse()
	ChaosMachineSelectedItem = 0
	local x = m_Pos.x + 20
	local y = m_Pos.y + 110
	local posY = 0
	local line = 0

	for key = 1, #CHAOS_MACHINE_CONFIG_COMB_SELECTION do
		if line >= ChaosMachineScrollBarCurrentLine and line < ChaosMachineScrollBarMaxRenderLine
		then
			if MousePosX() >= x and MousePosX() <= x + 130
			then
				if MousePosY() >= (y + posY) and MousePosY() <= (y + posY) + 10
				then
					if CheckPressedKey(Keys.LButton) == 1
					then
						ChaosMachineSelectedCombSelected = CHAOS_MACHINE_CONFIG_COMB_SELECTION[key].Combination
						ChaosMachineSelectedKey = key
						ChaosMachineSelectedItemClicked = 1
						ChaosMachineSelectedItemClickedPosY = (y + posY)
						DisableClickClient()
					end
					
					ChaosMachineSelectedItem = 1
					ChaosMachineSelectedItemPosY = (y + posY)
				end
			end
			
			posY = posY + 15
		end
		
		line = line + 1
	end
end

function ChaosMachineSetIngredientItens()
	if ChaosMachineSelectedCombSelected == 0
	then
		return
	end
	
	if CHAOS_MACHINE_CONFIG_COMB_SELECTION[ChaosMachineSelectedKey] == nil
	then
		ChaosMachineSelectedKey = 1
		return
	end
	
	if CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[ChaosMachineSelectedCombSelected] == nil
	then
		return
	end
	
	local value = 1
	
	for i in ipairs(CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[ChaosMachineSelectedCombSelected]) do
		ChaosMachineItensIngredients[value] = { Ingredients = CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[ChaosMachineSelectedCombSelected][i] }
		
		value = value + 1
	end
end

function ChaosMachineSelectNextPage()
	ChaosMachinePage = 1
	
	ChaosMachineItensIngredients = nil
	ChaosMachineItensIngredients = {}
	
	ChaosMachineSetIngredientItens()
	
	ChaosMachineCombinationStatus = getChaosBoxGenesisState()
	ChaosMachineSelectedItem = 0
	ChaosMachineSelectedItemClicked = 0
	ChaosMachineSelectedItemClickedPosY = 0
	ChaosMachineSelectedItemPosY = 0
	ChaosMachineScrollBarCurrentLine = 0
	ChaosMachineScrollBarMaxRenderLine = ScrollBarPageCombMaxLine
	ScrollBarPageMax = ScrollBarPageCombMaxLine
	ChaosMachineScrollBarPosY = 0
	ChaosMachineScrollBarPosMouse = 0
	ChaosMachineScrollBarPosYMultiplier = (75 / (#ChaosMachineItensIngredients - ChaosMachineScrollBarMaxRenderLine))
	ScrollBarPageMin = #ChaosMachineItensIngredients
end

function ChaosMachineCheckClickSelectPageOne()
	if CheckPressedKey(Keys.LButton) == 1
	then
		if MousePosX() >= m_Pos.x + 57.5 and MousePosX() <= m_Pos.x + 57.5 + 75 and MousePosY() >= m_Pos.y + 350 and MousePosY() <= m_Pos.y + 350 + 30
		then
			if ChaosMachineSelectedKey ~= 0
			then
				SetChaosBoxGenesis(ChaosMachineSelectedKey, ChaosMachineSelectedCombSelected)
				ChaosMachineSelectNextPage()
			end
			
			DisableClickClient()
		end
	end
end

function ChaosMachineButtomMix()
	if ChaosMachineCombinationStatus ~= 0
	then
		return
	end

	if MousePosX() >= m_Pos.x + 73 and MousePosX() <= m_Pos.x + 73 + 44 and MousePosY() >= m_Pos.y + 380 and MousePosY() <= m_Pos.y + 380 + 32 and CheckPressedKey(Keys.LButton) == 1
	then
		EnableAlphaTest()
	
		SetTextColor(216, 216, 216, 255)
		
		SetTextBg(0, 0, 0, 255)
		
		RenderText3(m_Pos.x + 70, m_Pos.y + 370, CHAOS_MACHINE_TEXTS[GetLanguage()][12], 40, 3)
		
		DisableAlphaBlend()
	end
end

function ChaosMachineUpdateMousePageOne()
	if ChaosMachinePage == 0
	then
		ChaosMachineScrollBarPageOneMouse()
		ChaosMachineScrollBarPageOneMouseCheckMouseClicked()
		ChaosMachineCheckClickSelectPageOne()
	end
end

function ChaosMachineUpdateMousePageComb()
	ChaosMachineButtomMix()
	ChaosMachineScrollBarPageCombMouseCheckMouseClicked()
	
	if MousePosX() >= m_Pos.x + 73 and MousePosX() <= m_Pos.x + 73 + 44 and MousePosY() >= m_Pos.y + 380 and MousePosY() <= m_Pos.y + 380 + 32
	then
		if CheckPressedKey(Keys.LButton) == 1
		then
			if ChaosMachineCheckCanMix() == 0
			then
				SendMessageClient(CHAOS_MACHINE_TEXTS[GetLanguage()][13])
			else
				SendChaosMachineMix()
			end
			
			DisableClickClient()
		end
	end
end

function ChaosMachineUpdateMouse()
	if ChaosMachinePage == 0
	then
		ChaosMachineUpdateMousePageOne()
	elseif ChaosMachinePage == 1
	then
		ChaosMachineUpdateMousePageComb()
	end
end

function ChaosMachineScrollingPageOne(value)
	if MousePosX() >= m_Pos.x and MousePosX() <= m_Pos.x + 190
	then
		if MousePosY() >= m_Pos.y + 50 and MousePosY() <= m_Pos.y + 380
		then
			if value > 0
			then
				ScrollingBar(-1)
			end
			
			if value < 0
			then
				ScrollingBar(1)
			end
		end
	end
end

function ChaosMachineScrollingPageComb(value)
	if MousePosX() >= m_Pos.x and MousePosX() <= m_Pos.x + 190
	then
		if MousePosY() >= m_Pos.y + 100 and MousePosY() <= m_Pos.y + 210
		then
			if value > 0
			then
				ScrollingBar(-1)
			end
			
			if value < 0
			then
				ScrollingBar(1)
			end
		end
	end
end

function ChaosMachineScrolling(value)
	if ChaosMachinePage == 0
	then
		ChaosMachineScrollingPageOne(value)
	elseif ChaosMachinePage == 1
	then
		ChaosMachineScrollingPageComb(value)
	end
end

function ChaosMachineMixResult(result)
	ChaosMachineCombinationStatus = result
end

function ChaosMachineCheckItens(ItemIndex, Quantity, Level, Exc)
	local itemFind = 0
	local itemQuantity = 0
	
	local maxitens = getMaxItens() - 1

	for i = 0, maxitens do
		local item = ChaosMachine.new(i)
		
		if item ~= nil
		then
			if ItemIndex == item:getIndex() and (Level == -1 or item:getLevel() == Level)
				and (Exc == -1 or bit.band(item:getOption1(), 63) > 0)
			then
				itemFind = 1
				itemQuantity = itemQuantity + 1
			end
		end
		
		item = nil
	end
	
	--clear stack from client
	collectgarbage()
	
	if itemFind == 1 and itemQuantity == Quantity
	then
		return 1
	end
	
	return 0
end

function ChaosMachineCheckCanMix()
	local itemMissing = 0
	
	for i in ipairs(ChaosMachineItensIngredients) do
		local itens = ChaosMachineItensIngredients[i].Ingredients
		
		if itens ~= nil
		then
			if ChaosMachineCheckItens(itens.ItemIndex, itens.Quantity, itens.Level, itens.Exc) == 0
			then
				itemMissing = itemMissing + 1
			end
		end
	end
	
	if itemMissing == 0
	then
		return 1
	end
	
	return 0
end

function ChaosMachineCheckCanMoveItem(ItemIndex)
	if ChaosMachineCombinationStatus ~= 0
	then
		return 0
	end

	local itemFind = 0

	for i in ipairs(ChaosMachineItensIngredients) do
		local itens = ChaosMachineItensIngredients[i].Ingredients
		
		if itens ~= nil
		then
			if itens.ItemIndex == ItemIndex
			then
				itemFind = 1
				break
			end
		end
	end
	
	if itemFind == 1
	then
		return 1
	else
		SendMessageClient(CHAOS_MACHINE_TEXTS[GetLanguage()][14])
	end
	
	return 0
end

function ChaosMachineOpenning()
	if getChaosBoxGenesisSelectedKey() > 0
	then
		ChaosMachineSelectedCombSelected = getChaosBoxGenesisSelectedComb()
		ChaosMachineSelectedKey = getChaosBoxGenesisSelectedKey()
		ChaosMachineSelectNextPage()
		return
	end

	ChaosMachineCombinationStatus = 0
	ChaosMachinePage = 0
	ChaosMachineSelectedItem = 0
	ChaosMachineSelectedItemClicked = 0
	ChaosMachineSelectedItemClickedPosY = 0
	ChaosMachineSelectedItemPosY = 0
	ChaosMachineSelectedKey = 0
	ChaosMachineSelectedCombSelected = 0
	ChaosMachineScrollBarCurrentLine = 0
	ChaosMachineScrollBarMaxRenderLine = ScrollBarPageOneMaxLine
	ScrollBarPageMax = ScrollBarPageOneMaxLine
	ChaosMachineScrollBarPosY = 0
	ChaosMachineScrollBarPosMouse = 0
	ScrollBarPageMin = #CHAOS_MACHINE_CONFIG_COMB_SELECTION
	ChaosMachineScrollBarPosYMultiplier = (160 / (#CHAOS_MACHINE_CONFIG_COMB_SELECTION - ChaosMachineScrollBarMaxRenderLine))
	
	ChaosMachineItensIngredients = nil
	ChaosMachineItensIngredients = {}
	
	m_Pos.x = 260
	m_Pos.y = 0
end