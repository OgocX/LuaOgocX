OpenFolder("Definitions")

local HELPER_CONFIG = {

{ ItemIndex = GET_ITEM_MODEL(13, 200), Type = 0, Movement = 0, Height = 20.0, Size = 0.60, Model = 'Helper201' , ObjectModel = '' },
{ ItemIndex = GET_ITEM_MODEL(13, 201), Type = 1, Movement = 0, Height = 0.0, Size = 1.0, Model = 'Helper03' , ObjectModel = 'Rider01' },
{ ItemIndex = GET_ITEM_MODEL(13, 202), Type = 2, Movement = 0, Height = 0.0, Size = 0.90, Model = 'Helper04' , ObjectModel = 'Rider02' },
{ ItemIndex = GET_ITEM_MODEL(13, 203), Type = 3, Movement = 0, Height = 0.0, Size = 0.88, Model = 'FR_6' , ObjectModel = 'fenril_black' },
{ ItemIndex = GET_ITEM_MODEL(13, 204), Type = 4, Movement = 0, Height = 0.0, Size = 0.90, Model = 'DarkHorseHorn' , ObjectModel = 'DarkHorse' },

}

local HELPER_CONFIG_GLOW = {}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 200)] = {
--Voador body
{ RenderType = 1, Mesh = 2,  ModelGlow = 0, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 201)] = {
--Uniria body
{ RenderType = 1, Mesh = 2,  ModelGlow = 0, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 202)] = {
--Dinorant body
{ RenderType = 1, Mesh = 2,  ModelGlow = 0, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 203)] = {
--Fenrir render body and glow
{ RenderType = 0, Mesh = 0,  ModelGlow = 2, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
{ RenderType = 0, Mesh = 1,  ModelGlow = 2, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
{ RenderType = 0, Mesh = 1,  ModelGlow = 70, LightR = 0.3, LightG = 0.5, LightB = 0.2 },
}

HELPER_CONFIG_GLOW[GET_ITEM_MODEL(13, 204)] = {
--Horse body
{ RenderType = 1, Mesh = 2,  ModelGlow = 0, LightR = 1.0, LightG = 1.0, LightB = 1.0 },
}

local HELPER_CONFIG_EFFECT = { }

HELPER_CONFIG_EFFECT[GET_ITEM_MODEL(13, 203)] = {
--Fenrir Eye Right
{ EffectType = 0, EffectIndex = 32002, EffectLevel = 0,  Skeleton = 11, Size = 0.8, LightR = 1.0, LightG = 0.3, LightB = 0.2, PosX = 50.0, PosY = 2.0, PosZ = 11.0, Black = 0.0 },
{ EffectType = 0, EffectIndex = 32002, EffectLevel = 0,  Skeleton = 11, Size = 0.8, LightR = 1.0, LightG = 0.3, LightB = 0.2, PosX = 50.0, PosY = 2.0, PosZ = 11.0, Black = 0.0 },
--Fenrir Eye Left
{ EffectType = 0, EffectIndex = 32002, EffectLevel = 0,  Skeleton = 11, Size = 0.8, LightR = 1.0, LightG = 0.3, LightB = 0.2, PosX = 50.0, PosY = 2.0, PosZ = -11.0, Black = 0.0 },
{ EffectType = 0, EffectIndex = 32002, EffectLevel = 0,  Skeleton = 11, Size = 0.8, LightR = 1.0, LightG = 0.3, LightB = 0.2, PosX = 50.0, PosY = 2.0, PosZ = -11.0, Black = 0.0 },
--Fenrir mouth
{ EffectType = 0, EffectIndex = 32002, EffectLevel = 0,  Skeleton = 13, Size = 1.5, LightR = 1.0, LightG = 0.3, LightB = 0.2, PosX = 40.0, PosY = 15.0, PosZ = 0.0, Black = 0.0 },
{ EffectType = 0, EffectIndex = 32002, EffectLevel = 0,  Skeleton = 13, Size = 1.0, LightR = 1.0, LightG = 0.3, LightB = 0.2, PosX = 40.0, PosY = 15.0, PosZ = 0.0, Black = 0.0 },
--Fenrir lightnight body
{ EffectType = 2, EffectIndex = 388, EffectLevel = 0,  Skeleton = -1, Size = 0.0, LightR = 1.0, LightG = 0.0, LightB = 0.2, PosX = 0.0, PosY = 0.0, PosZ = 0.0, Black = 0.0 },
{ EffectType = 2, EffectIndex = 388, EffectLevel = 0,  Skeleton = -1, Size = 0.0, LightR = 1.0, LightG = 0.0, LightB = 0.2, PosX = 0.0, PosY = 0.0, PosZ = 0.0, Black = 0.0 },
}

--[[
SetHelper(
ItemIndex, -> GET_ITEM_MODEL(section, index)
Type, -> 0 (angel) - 1 Uniria - 2 Dinorant - 3 Fenrir - 4 Horse
Movement, -> 0 igual Angel, 1 igual demon season 4, 2 correr atrás do player
Height, -> altura do pet do chão só funciona em type 0
Size, -> tamanho do pet só funciona em type 0
Model, -> nome do BMD para aparecer no inventário
ObjectModel -> nome do BMD para aparecer caso senha Uniria etc... (puxa da pasta Skills)
)
--]]

--[[
CreateSprite(
BMDStruct
EffectIndex
Bone (Skeleton)
Size
R
G
B
ObjectStruct
)

CreateParticle(
BMDStruct
EffectIndex
EffectValue
Bone (Skeleton)
Size
R
G
B
ObjectStruct
)

CheckModelById(
GET_ITEM_MODEL(x, y)
} -> if you want render a mount need get with CheckModelById
]]

function LoadHelpers()
	for i = 1, #HELPER_CONFIG do
		SetHelper(HELPER_CONFIG[i].ItemIndex, HELPER_CONFIG[i].Type, HELPER_CONFIG[i].Movement, HELPER_CONFIG[i].Height, HELPER_CONFIG[i].Size, HELPER_CONFIG[i].Model, HELPER_CONFIG[i].ObjectModel)
	end
end

function RenderHelper(BMDStruct, ObjectStruct, Type)
	for i = 1, #HELPER_CONFIG do
		if HELPER_CONFIG[i].ItemIndex == Type or CheckModelById(HELPER_CONFIG[i].ItemIndex) == Type
		then
			if HELPER_CONFIG[i].Type == 0
			then
				CreateFlyEffect(BMDStruct, ObjectStruct, HELPER_CONFIG[i].ItemIndex)
				return
			elseif HELPER_CONFIG[i].Type == 1
			then
				CreateUniriaEffect(BMDStruct, ObjectStruct, HELPER_CONFIG[i].ItemIndex)
				return
			elseif HELPER_CONFIG[i].Type == 2
			then
				CreateDinorantEffect(BMDStruct, ObjectStruct, HELPER_CONFIG[i].ItemIndex)
				return
			elseif HELPER_CONFIG[i].Type == 3
			then
				CreateFenrirEffect(BMDStruct, ObjectStruct, HELPER_CONFIG[i].ItemIndex)
				return
			elseif HELPER_CONFIG[i].Type == 4
			then
				CreateHorseEffect(BMDStruct, ObjectStruct, HELPER_CONFIG[i].ItemIndex)
				return
			end
		end
	end
end

function CreateFlyEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	--Effect
	local helperEffect = HELPER_CONFIG_EFFECT[Type]
	
	if helperEffect ~= nil
	then
		for i = 1, #helperEffect do
			local effect = helperEffect[i]
			
			if (effect.EffectType == 0)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateSprite(effect.EffectIndex, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
				
			elseif (effect.EffectType == 1)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateParticle(effect.EffectIndex, effect.EffectLevel, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			elseif (effect.EffectType == 2)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateEffect(effect.EffectIndex, effect.EffectLevel, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			end
		end
	end
	
	Bmd = nil
	Obj = nil
	collectgarbage ()
end

function CreateUniriaEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	--Effect
	local helperEffect = HELPER_CONFIG_EFFECT[Type]
	
	if helperEffect ~= nil
	then
		for i = 1, #helperEffect do
			local effect = helperEffect[i]
			
			if (effect.EffectType == 0)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateSprite(effect.EffectIndex, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
				
			elseif (effect.EffectType == 1)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateParticle(effect.EffectIndex, effect.EffectLevel, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			elseif (effect.EffectType == 2)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateEffect(effect.EffectIndex, effect.EffectLevel, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			end
		end
	end
	
	Bmd = nil
	Obj = nil
	collectgarbage ()
end

function CreateDinorantEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	--Effect
	local helperEffect = HELPER_CONFIG_EFFECT[Type]
	
	if helperEffect ~= nil
	then
		for i = 1, #helperEffect do
			local effect = helperEffect[i]
			
			if (effect.EffectType == 0)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateSprite(effect.EffectIndex, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
				
			elseif (effect.EffectType == 1)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateParticle(effect.EffectIndex, effect.EffectLevel, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			elseif (effect.EffectType == 2)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateEffect(effect.EffectIndex, effect.EffectLevel, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			end
		end
	end
	
	Bmd = nil
	Obj = nil
	collectgarbage ()
end

function CreateFenrirEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	Bmd:BeginRender(1.0)
	
	Bmd:setMesh(0)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	Bmd:setMesh(-1)
	
	if (Obj:getAction() == 4)
	then
		local baseCalc = (math.sin(worldTime())*0.002)*0.2
	
		Bmd:SetLight(1.0, 1.0, 1.0)
		
		Bmd:RenderMesh(1, 70, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		
		CreateParticle(BMDStruct, 32049, 15, 14, 0.7+(baseCalc*0.05), 1.0, 0.0, 0.0, ObjectStruct)
	end
	
	Bmd:EndRender()
	
	--Render shadow of the model
	Bmd:RenderShadowModel()
	
	--Effect
	local helperEffect = HELPER_CONFIG_EFFECT[Type]
	
	if helperEffect ~= nil
	then
		for i = 1, #helperEffect do
			local effect = helperEffect[i]
			
			if (effect.EffectType == 0)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateSprite(effect.EffectIndex, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
				
			elseif (effect.EffectType == 1)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateParticle(effect.EffectIndex, effect.EffectLevel, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			elseif (effect.EffectType == 2)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateEffect(effect.EffectIndex, effect.EffectLevel, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			end
		end
	end
	
	--effects when use skill
	Bmd:CreateEffectsInFenrirUsingSkill(ObjectStruct)
	
	Bmd = nil
	Obj = nil
	collectgarbage ()
end

function CreateHorseEffect(BMDStruct, ObjectStruct, Type)
	local Bmd = BMD.new(BMDStruct)
	local Obj = Object.new(ObjectStruct)
	
	--Glow
	local helperGlow = HELPER_CONFIG_GLOW[Type]
	
	if helperGlow ~= nil
	then
		for i = 1, #helperGlow do
			local glow = helperGlow[i]
		
			Bmd:SetLight(glow.LightR, glow.LightG, glow.LightB)
			
			if glow.RenderType == 1
			then
				Bmd:RenderBody(glow.Mesh, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
			else
				Bmd:RenderMesh(glow.Mesh, glow.ModelGlow, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			end
		end
	end
	
	--Effect
	local helperEffect = HELPER_CONFIG_EFFECT[Type]
	
	if helperEffect ~= nil
	then
		for i = 1, #helperEffect do
			local effect = helperEffect[i]
			
			if (effect.EffectType == 0)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateSprite(effect.EffectIndex, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
				
			elseif (effect.EffectType == 1)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateParticle(effect.EffectIndex, effect.EffectLevel, effect.Size, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			elseif (effect.EffectType == 2)
			then
				Bmd:TransformPosition(effect.Skeleton, effect.PosX, effect.PosY, effect.PosZ)
				Bmd:CreateEffect(effect.EffectIndex, effect.EffectLevel, effect.LightR, effect.LightG, effect.LightB, ObjectStruct)
			end
		end
	end
	
	Bmd = nil
	Obj = nil
	collectgarbage ()
end