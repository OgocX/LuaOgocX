OpenFolder("Definitions")

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
	--Cape Death
	LoadImage("Item//deathha.tga", 37000)
	LoadImage("Item//deathjung.tga", 37001)
	
	--Ghost
	LoadImage("Item//season_wing_periodc.tga", 37002)
	LoadImage("Item//season_wing_periodc2.tga", 37003)
end

--[[
Seta a bone onde vai ser tirado a base de calculo para "gola" da capa
Se a capa não tem "gola" retorne 1520
--]]

function CharacterCapeBone(ItemIndex)
	if (ItemIndex == GET_ITEM_MODEL(12, 201))
	then
		return 19
	end
	
	return 0
end

--[[
faz o efeito da movimentação
--]]

function CreateCapePlayer(objectStruct, ItemIndex, Class)
	if (ItemIndex == GET_ITEM_MODEL(12, 201))
	then
		local StackValue = 3
		
		if Class == CLASS_DL
		then
			StackValue = 6 -- Need be 6 because DL have hair etc
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
		
		-- Render cape
		Cape:Create(StackRender, objectStruct, 19, 0.0, 15.0, 5.0, 10, 10, 180.0, 170.0, 37000, 37000, 5125)
		
		Cape:Collision(StackRender, -10.0, -10.0, -10.0, 25.0, 17)
		Cape:Collision(StackRender, 10.0, -10.0, -10.0, 25.0, 17)
		Cape:Collision(StackRender, -10.0, -10.0, 20.0, 27.0, 17)
		Cape:Collision(StackRender, 10.0, -10.0, 20.0, 27.0, 17)
		
		StackRender = StackRender + 1
		
		Cape:Create(StackRender, objectStruct, 19, 25.0, 15.0, 2.0, 2, 5, 12.0, 180.0, 37001, 37001, 4096)
		
		Cape:Collision(StackRender, 0.0, -15.0, -20.0, 30.0, 2)
		Cape:Collision(StackRender, 0.0, 0.0, 0.0, 35.0, 17)
		
		StackRender = StackRender + 1
		
		Cape:Create(StackRender, objectStruct, 19, -25.0, 15.0, 2.0, 2, 5, 12.0, 180.0, 37001, 37001, 4096)
		
		Cape:Collision(StackRender, 0.0, -15.0, -20.0, 30.0, 2)
		Cape:Collision(StackRender, 0.0, 0.0, 0.0, 35.0, 17)
		
		Cape:SetCapePlayer(objectStruct)
		
		Cape = nil
		collectgarbage()
		return
	end
	
	if (ItemIndex == GET_ITEM_MODEL(12, 202))
	then
		local StackValue = 2
		
		if Class == CLASS_DL
		then
			StackValue = 5 -- Need be 5 because DL have hair etc
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
		
		-- Render cape
		Cape:Create(StackRender, objectStruct, 19, -32.0, 35.0, -4.0, 10, 10, 50.0, 120.0, 37002, 37002, 4096)
		
		Cape:Collision(StackRender, 0.0, -10.0, -40.0, 37.0, 17)
		
		StackRender = StackRender + 1
		
		Cape:Create(StackRender, objectStruct, 19, 32.0, 35.0, -4.0, 10, 10, 50.0, 120.0, 37003, 37003, 4096)
		
		Cape:Collision(StackRender, 0.0, -10.0, -40.0, 37.0, 17)
		
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
	if (ItemIndex == GET_ITEM_MODEL(12, 201))
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)
		
		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			--Render Character
		
			Bmd:SetLight(1.0, 1.0, 1.0)
			
			Bmd:glColor3fv()
		
			Bmd:RenderMesh(1, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		else
			--Render Inventory
			
			Bmd:SetLight(1.0, 1.0, 1.0)
			
			Bmd:RenderBody(2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
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
	if (ItemIndex == GET_ITEM_MODEL(12, 201))
	then
		return 0.0, 90.0, 0.0, -52.0, -8.0, 0.0
	end
end