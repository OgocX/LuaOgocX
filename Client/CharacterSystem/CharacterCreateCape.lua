OpenFolder("Definitions")

CAPE_SYSTEM_INFO = {}

CAPE_SYSTEM_INFO[GET_ITEM_MODEL(12, 201)] = {
	stackMax = 3, imageCape = 'Item//deathha.tga', imageStrip = 'Item//deathjung.tga', indexCape = 37000, indexStrip = 37001
}

CAPE_SYSTEM_INFO[GET_ITEM_MODEL(12, 202)] = {
	stackMax = 2, imageCape = 'Item//season_wing_periodc.tga', imageStrip = 'Item//season_wing_periodc2.tga', indexCape = 37002, indexStrip = 37003
}

CAPE_SYSTEM_INFO[GET_ITEM_MODEL(12, 203)] = {
	stackMax = 3, imageCape = 'Item//darklordwing4de.tga', imageStrip = 'Item//darklordwing4dd.tga', indexCape = 37004, indexStrip = 37005
}

-----

CAPE_SYSTEM_SHINE = {}

CAPE_SYSTEM_SHINE[37004] = {
	shineImage = 'Item//darklordwing4de_render.jpg', shineIndex = 37006, colorR = 2.0, colorG = 0.50, colorB = 1.05
}

-----

CAPE_SYSTEM_RENDER_INFO = {}

CAPE_SYSTEM_RENDER_INFO[GET_ITEM_MODEL(12, 201)] = {
	{ Bone = 19, posX = 0.0, posY = 15.0, posZ = 5.0, width = 180.0, height = 170.0, imageIndex = 37000, renderType = 5125 }, 
	{ Bone = 19, posX = 25.0, posY = 15.0, posZ = 2.0, width = 12.0, height = 180.0, imageIndex = 37001,renderType = 4096 },
	{ Bone = 19, posX = -25.0, posY = 15.0, posZ = 2.0, width = 12.0, height = 180.0, imageIndex = 37001,renderType = 4096 },
}

CAPE_SYSTEM_RENDER_INFO[GET_ITEM_MODEL(12, 202)] = {
	{ Bone = 19, posX = -28.0, posY = 30.0, posZ = 5.0, width = 50.0, height = 120.0, imageIndex = 37002, renderType = 4096 }, 
	{ Bone = 19, posX = 32.0, posY = 20.0, posZ = 5.0, width = 50.0, height = 120.0, imageIndex = 37003,renderType = 4096 },
}

CAPE_SYSTEM_RENDER_INFO[GET_ITEM_MODEL(12, 203)] = {
	{ Bone = 19, posX = 0.0, posY = 20.0, posZ = 5.0, width = 180.0, height = 170.0, imageIndex = 37004, renderType = 5125 }, 
	{ Bone = 19, posX = 25.0, posY = 20.0, posZ = 2.0, width = 12.0, height = 180.0, imageIndex = 37005,renderType = 4096 },
	{ Bone = 19, posX = -25.0, posY = 20.0, posZ = 2.0, width = 12.0, height = 180.0, imageIndex = 37005,renderType = 4096 },
}

CAPE_SYSTEM_RENDER_INFO[GET_ITEM_MODEL(12, 204)] = {
	{ Bone = 19, posX = 0.0, posY = 20.0, posZ = 5.0, width = 180.0, height = 170.0, imageIndex = 37004, renderType = 5125 }, 
}

-----

CAPE_SYSTEM_RENDER_MODEL = {}

CAPE_SYSTEM_RENDER_MODEL[GET_ITEM_MODEL(12, 201)] = {
	{ renderType = 1, layer = 1, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 1, renderCharacter = 1 },
	{ renderType = 2, layer = 2, effectLayer = 0, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 0 },
}	

CAPE_SYSTEM_RENDER_MODEL[GET_ITEM_MODEL(12, 203)] = {
	{ renderType = 1, layer = 0, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 1, renderCharacter = 1 },
	{ renderType = 1, layer = 3, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 1 },
	{ renderType = 1, layer = 4, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 1 },
	{ renderType = 1, layer = 5, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 1 },
	{ renderType = 1, layer = 3, effectLayer = 66, lightR = 0.5, lightG = 0.5, lightB = 0.5, color3fv = 0, renderCharacter = 1 },

	{ renderType = 1, layer = 0, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 1, renderCharacter = 0 },
	{ renderType = 1, layer = 1, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 0 },
	{ renderType = 1, layer = 2, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 0 },
	{ renderType = 1, layer = 3, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 0 },
	{ renderType = 1, layer = 4, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 0 },
	{ renderType = 1, layer = 5, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 0 },
	{ renderType = 1, layer = 3, effectLayer = 66, lightR = 0.5, lightG = 0.5, lightB = 0.5, color3fv = 0, renderCharacter = 0 },
}

CAPE_SYSTEM_RENDER_MODEL[GET_ITEM_MODEL(12, 204)] = {
	{ renderType = 1, layer = 1, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 1, renderCharacter = 1 },
	{ renderType = 2, layer = 2, effectLayer = 0, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, renderCharacter = 0 },
}

-----

CAPE_SYSTEM_SET_BONE = {}

CAPE_SYSTEM_SET_BONE[GET_ITEM_MODEL(12, 201)] = { Bone = 19 }

CAPE_SYSTEM_SET_BONE[GET_ITEM_MODEL(12, 203)] = { Bone = 19 }

CAPE_SYSTEM_SET_BONE[GET_ITEM_MODEL(12, 204)] = { Bone = 1520 }

-----

CAPE_SYSTEM_SET_POSITION = {}

CAPE_SYSTEM_SET_POSITION[GET_ITEM_MODEL(12, 201)] = {
	posX = 0.0, posY = 90.0, posZ = 0.0, matrixX = -52.0, matrixY = -8.0, matrixZ = 0.0
}

CAPE_SYSTEM_SET_POSITION[GET_ITEM_MODEL(12, 203)] = {
	posX = 0.0, posY = 90.0, posZ = 0.0, matrixX = -53.0, matrixY = -5.0, matrixZ = 0.0
}

-----


--[[
LoadImage(
name jpg ou tga,
imageValue -> recomendo entre 37000 a 38000
]]--

--[[
CapeStack.new(
stacks
) -> 3 significa que você vai criar uma capa com 3 imagens, a capa e as faixas por exemplo...

Cape:Create(
Position of Stack, 
Object Struct, 
BoneCharacter, 
posX, 
posY, 
posZ, 
Unknow, 
Unknow, 
Width, 
Height, 
Img Front, 
Img Back, 
Unknow
) -> cria a imagem e animação

Cape:Collision(
Position of Stack, 
posX,
posY,
posZ,
Unknow,
BoneCharacter
) -> faz a animação movimentar melhor

Cape:SetCapePlayer(
objectStruct
) -> necessario colocar no final de tudo
--]]

--[[
load the tga ou jpg for the cape
--]]

function LoadImageCape()
	for i in pairs(CAPE_SYSTEM_INFO) do
		local capeInfo = CAPE_SYSTEM_INFO[i]
		
		if string.len(capeInfo.imageCape) > 0
		then
			LoadImage(capeInfo.imageCape, capeInfo.indexCape)
		end
		
		if string.len(capeInfo.imageStrip) > 0
		then
			LoadImage(capeInfo.imageStrip, capeInfo.indexStrip)
		end
	end

	for i in pairs(CAPE_SYSTEM_SHINE) do
		local shineInfo = CAPE_SYSTEM_SHINE[i]

		LoadImage(shineInfo.shineImage, shineInfo.shineIndex)
	end
end

--[[
Seta a bone onde vai ser tirado a base de calculo para "gola" da capa
Se a capa não tem "gola" retorne 1520
--]]

function CharacterCapeBone(ItemIndex)
	local getCapeBone = CAPE_SYSTEM_SET_BONE[ItemIndex]

	if getCapeBone ~= nil
	then
		return getCapeBone.Bone
	end
	
	return 0
end

--[[
faz o efeito da movimentação
--]]

function CreateCapePlayer(objectStruct, ItemIndex, Class)
	local getCapeInfo = CAPE_SYSTEM_INFO[ItemIndex]
	
	if getCapeInfo ~= nil
	then
		local StackValue = getCapeInfo.stackMax
		
		if Class == CLASS_DL
		then
			StackValue = StackValue + 3
		end
		
		local StackRender = 1
		local Cape = CapeStack.new(StackValue)
		
		--Render things of DL
		if Class == CLASS_DL
		then
			Cape:Create(StackRender, objectStruct, 20, 0.0, 0.0, 20.0, 6, 5, 30.0, 70.0, 30549, 30549, -1073741307)
			
			Cape:SetWindMinMax(StackRender, 10, 50)
			
			Cape:Collision(StackRender, -10.0, 20.0, 20.0, 27.0, 17)
			
			Cape:Collision(StackRender, 10.0, 20.0, 20.0, 27.0, 17)
			
			StackRender = StackRender + 1
			
			Cape:Create(StackRender, objectStruct, 20, 0.0, 5.0, 18.0, 5, 5, 30.0, 70.0, 30549, 30549, -2147474939)
			
			Cape:SetWindMinMax(StackRender, 8, 40)
			
			Cape:Collision(StackRender, -10.0, 20.0, 20.0, 27.0, 17)
			
			Cape:Collision(StackRender, 10.0, 20.0, 20.0, 27.0, 17)
			
			StackRender = StackRender + 1
		end
		
		local renderCapeInfo = CAPE_SYSTEM_RENDER_INFO[ItemIndex]
		
		if renderCapeInfo ~= nil
		then
			for i = 1, getCapeInfo.stackMax do
				local capeInfo = renderCapeInfo[i]
			
				Cape:Create(StackRender, objectStruct, capeInfo.Bone, capeInfo.posX, capeInfo.posY, capeInfo.posZ, 10, 10, capeInfo.width, capeInfo.height, capeInfo.imageIndex, capeInfo.imageIndex, capeInfo.renderType)
				
				if i == 1
				then
					Cape:Collision(StackRender, -10.0, -10.0, -10.0, 25.0, 17)
					Cape:Collision(StackRender, 10.0, -10.0, -10.0, 25.0, 17)
					Cape:Collision(StackRender, -10.0, -10.0, 20.0, 27.0, 17)
					Cape:Collision(StackRender, 10.0, -10.0, 20.0, 27.0, 17)
				elseif i == 2
				then
					Cape:Collision(StackRender, 0.0, -15.0, -20.0, 30.0, 2)
					Cape:Collision(StackRender, 0.0, 0.0, 0.0, 35.0, 17)
				end
				
				StackRender = StackRender + 1
			end
		end
		
		Cape:SetCapePlayer(objectStruct)
		
		Cape = nil
		collectgarbage()
		return
	end
end

--[[
cria a gola no personagem, aqui é necessário fazer se não a capa não some alguns "pedaços"
--]]

function RenderCapeModel(BMDStruct, ObjectStruct, ItemIndex)

	local getRenderModel = CAPE_SYSTEM_RENDER_MODEL[ItemIndex]

	if getRenderModel ~= nil
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)

		local R = Bmd:GetLight(0)
		local G = Bmd:GetLight(1)
		local B = Bmd:GetLight(2)

		for i = 1, #getRenderModel do
			local render = getRenderModel[i]

			if render.renderCharacter == 1
			then
				if R == 1.0 or G == 1.0 or B == 1.0
				then
					goto continue
				end
			else
				if R ~= 1.0 and G ~= 1.0 and B ~= 1.0
				then
					goto continue
				end
			end

			Bmd:SetLight(render.lightR, render.lightG, render.lightB)

			if render.color3fv == 1
			then
				Bmd:glColor3fv()
			end

			if render.renderType == 1
			then
				Bmd:RenderMesh(render.layer, render.effectLayer, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			elseif render.renderType == 2
			then
				Bmd:RenderBody(render.layer, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			end

			::continue::
		end

		Bmd = nil
		Obj = nil
		collectgarbage()
	end
end
	

--[[
Seta a posição do modelo no personagem

return
posX,
posY,
posZ,
matrixX,
matrixY,
matrixZ
--]]

function CapeModelPosition(ItemIndex)
	local getPosition = CAPE_SYSTEM_SET_POSITION[ItemIndex]

	if getPosition ~= nil
	then
		return getPosition.posX, getPosition.posY, getPosition.posZ, getPosition.matrixX, getPosition.matrixY, getPosition.matrixZ
	end
end

--[[
Render shine cape
]]
function CapeRenderShine(ImageIndex, ObjectStruct, BMDStruct)
	local getShine = CAPE_SYSTEM_SHINE[ImageIndex]

	if getShine ~= nil
	then
		RenderShine(ObjectStruct, BMDStruct, getShine.shineIndex, getShine.colorR, getShine.colorG, getShine.colorR)
	end
end