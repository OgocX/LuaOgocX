OpenFolder("Definitions")

--descriptions
CUSTOM_DESCRIPTIONS_INFO = {}

CUSTOM_DESCRIPTIONS_INFO[GET_ITEM(12, 201)] = {
{ Description = 'Testando descrição 1', Level = -1, Bold = 0, Color = 20 },
{ Description = 'Testando descrição 2', Level = -1, Bold = 1, Color = 21 },
}

--if you want create description with no background or color white
CUSTOM_COLOR_DESCRIPTION = {
{ colorID = 20, R = 0.8, G = 0.1, B = 0.1 },
{ colorID = 21, R = 0.2, G = 0.8, B = 0.1 },
}

--back ground for text description and text 
CUSTOM_COLOR_WITH_BACKGROUND_DESCRIPTION = {
{ colorID = 22, TextR = 0.2, TextG = 0.2, TextB = 0.8, TextA = 0.8, BackR = 0.8, BackG = 0.1, BackB = 0.1, BackA = 0.8 },
}

--[[
Create your custom descriptions!

createDescription(
line -> need put and increase line by line
text -> text you want print in item
color -> color of the text
bold -> 1 is bold 0 not
)
--]]

function SetNewColorDescription(colorID)
	for i = 1, #CUSTOM_COLOR_DESCRIPTION do
		local info = CUSTOM_COLOR_DESCRIPTION[i]
		
		if info.colorID == colorID
		then
			glColor3f(info.R, info.G, info.B)
			return 1
		end
	end

	return 0
end

function SetNewColorBackGroundDescription(colorID)
	for i = 1, #CUSTOM_COLOR_WITH_BACKGROUND_DESCRIPTION do
		local info = CUSTOM_COLOR_WITH_BACKGROUND_DESCRIPTION[i]
		
		if info.colorID == colorID
		then
			setFontBg(math.floor(info.BackR * 255), math.floor(info.BackG * 255), math.floor(info.BackB * 255), math.floor(info.BackA * 255))
			setFontColor(math.floor(info.TextR * 255), math.floor(info.TextG * 255), math.floor(info.TextB * 255), math.floor(info.TextA * 255))
			return 1
		end
	end

	return 0
end

function createDescMacro(line, text, color, bold)
	createDescription(line, text, color, bold)
	line = line + 1
	return line
end

function SetDescriptions(line, ItemIndex, ItemObject)
	local description = CUSTOM_DESCRIPTIONS_INFO[ItemIndex]
	
	if description ~= nil
	then
		local itemInfo = Item.new(ItemObject)
		
		for i = 1, #description do
			local infos = description[i]
			
			if infos.Level == -1 or infos.Level == itemInfo:getLevel()
			then
				line = createDescMacro(line, infos.Description, infos.Color, infos.Bold)
			end
		end
		
		itemInfo = nil
		
		collectgarbage()
		return line
	end

	--example if you want create
	if ItemIndex == GET_ITEM(12, 200)
	then
		line = createDescMacro(line, "font normal", 1, 0)
		line = createDescMacro(line, "font bold", 1, 1)
		
		if (UserGetMap() == 0)
		then
			line = createDescMacro(line, "Buff no mapa lorencia", 1, 0)
		else
			line = createDescMacro(line, "Buff no mapa lorencia", 10, 0)
		end
		
		line = createDescMacro(line, "Testando nova cor 20", 20, 0)
		line = createDescMacro(line, "Testando nova cor 21", 21, 0)
		line = createDescMacro(line, "Testando nova cor 22", 22, 0)
	end

	return line
end