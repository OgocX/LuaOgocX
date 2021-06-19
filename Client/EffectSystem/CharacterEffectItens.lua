OpenFolder("Definitions")

--[[
Type, 0 = Effect static, 1 = dynamic
EffectID, effect id like .jpg
EffectLv, work on dynamic effect
Bone, skeleton of the model
Size, size of the effect
ColorR,
ColorG,
ColorB,
Black, if if static can put "black" not working for now
RandTime, percentage chance to drop the effect
--]]

CUSTOM_EFFECT_INFOS = {}

CUSTOM_EFFECT_INFOS[GET_ITEM_MODEL(12, 200)] = {
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 1, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 2, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 3, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 4, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 5, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 6, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 7, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 8, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 9, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 10, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },

{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 20, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 21, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 22, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 23, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 24, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 25, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 26, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 27, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 28, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 29, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },
{ Type = 0, EffectID = 32114, EffectLv = 0, Bone = 30, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 50 },

{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 1, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 2, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 3, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 4, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 5, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 6, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 7, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 8, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 9, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 10, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },

{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 20, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 21, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 22, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 23, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 24, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 25, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 26, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 27, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 28, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 29, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
{ Type = 1, EffectID = 32101, EffectLv = 12, Bone = 30, Size = 1.0, ColorR = 1.0, ColorG = 1.0, ColorB = 1.0, Black = 0, RandTime = 100 },
}

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

Recomendado não utilizar mais de 50 efeitos por itens!
Recommended not to use more than 50 effects per item!
¡Se recomienda no usar más de 50 efectos por elemento!
]]

function CharacterItensEffect(ObjectStruct, BMDStruct, ItemIndex)
	--Effects in tuple
	effectInfo = CUSTOM_EFFECT_INFOS[ItemIndex]
	
	if effectInfo ~= nil
	then
		math.randomseed(os.time())
		for i = 1, #effectInfo do
			local effect = effectInfo[i]
			local randValue = 100
			
			if effectInfo.RandTime ~= 100
			then
				randValue = math.random(1, 100)
			end
			
			if effect.RandTime >= randValue
			then
				if effect.Type == 0
				then
					CreateSprite(BMDStruct, effect.EffectID, effect.Bone, effect.Size, effect.ColorR, effect.ColorG, effect.ColorB, ObjectStruct)
				else
					CreateParticle(BMDStruct, effect.EffectID, effect.EffectLv, effect.Bone, effect.Size, effect.ColorR, effect.ColorG, effect.ColorB, ObjectStruct)
				end
			end
		end
		return
	end

	--Example if you want create your effect
	if (ItemIndex == GET_ITEM_MODEL(12, 210))
	then
		local light = { 0, 0, 0 }
		
		for i = 0, 60 do
			light[0] = math.random(15, 225)
			light[1] = math.random(15, 225)
			light[2] = math.random(15, 225)
			
			CreateSprite(BMDStruct, 32114, i, 1.0, light[0]/255, light[1]/255, light[2]/255, ObjectStruct)
			
			CreateParticle(BMDStruct, 32101, 12, i, 1.0, light[2]/255, light[0]/255, light[1]/255, ObjectStruct)
		end
	end
end
