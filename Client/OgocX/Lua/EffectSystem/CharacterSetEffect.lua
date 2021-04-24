OpenFolder("Definitions")

CUSTOM_EFFECT_SETS_SWITCH = 1

CUSTOM_SET_EFFECTS = {}

--[[
this config only detect boots so you need put boots of the set you want put effect

EffectType, 0 = sprite, 1 = particle, 2 = skill
]]--
CUSTOM_SET_EFFECTS[GET_ITEM_MODEL(11, 0)] = {
{ BonePlayer = 25, ItemMinLevel = 10, ItemMaxLevel = 15, EffectType = 2, EffectID = 388, EffectLv = 1, Size = 5.0, R = 0.0, G = 0.0, B = 0.8, PosX = 0.0, PosY = 10.0, PosZ = 0.0, RandTime = 50 },
{ BonePlayer = 15, ItemMinLevel = 10, ItemMaxLevel = 15, EffectType = 2, EffectID = 388, EffectLv = 1, Size = 5.0, R = 0.1, G = 0.1, B = 0.8, PosX = 0.0, PosY = 5.0, PosZ = 0.0, RandTime = 50 },
{ BonePlayer = 0, ItemMinLevel = 10, ItemMaxLevel = 15, EffectType = 2, EffectID = 388, EffectLv = 1, Size = 5.0, R = 0.8, G = 0.2, B = 0.2, PosX = 0.0, PosY = 0.0, PosZ = 0.0, RandTime = 50 },
{ BonePlayer = 11, ItemMinLevel = 10, ItemMaxLevel = 15, EffectType = 2, EffectID = 388, EffectLv = 1, Size = 5.0, R = 0.0, G = 0.8, B = 0.2, PosX = 0.0, PosY = -10.0, PosZ = 0.0, RandTime = 50 },
{ BonePlayer = 21, ItemMinLevel = 10, ItemMaxLevel = 15, EffectType = 2, EffectID = 388, EffectLv = 1, Size = 5.0, R = 0.0, G = 0.0, B = 0.8, PosX = 0.0, PosY = -15.0, PosZ = 0.0, RandTime = 50 },
{ BonePlayer = 30, ItemMinLevel = 10, ItemMaxLevel = 15, EffectType = 2, EffectID = 388, EffectLv = 1, Size = 5.0, R = 0.1, G = 0.1, B = 0.8, PosX = 0.0, PosY = -20.0, PosZ = 0.0, RandTime = 50 },
{ BonePlayer = 41, ItemMinLevel = 10, ItemMaxLevel = 15, EffectType = 2, EffectID = 388, EffectLv = 1, Size = 5.0, R = 0.2, G = 0.9, B = 0.2, PosX = 0.0, PosY = -25.0, PosZ = 0.0, RandTime = 50 },
}

function CreateEffectSetPlayer(BMDStruct, ObjectStruct, ItemIndex, SetLevel)
	if CUSTOM_EFFECT_SETS_SWITCH == 0
	then
		return
	end
	
	local setInfo = CUSTOM_SET_EFFECTS[ItemIndex]
	
	if setInfo ~= nil
	then
		math.randomseed(os.time())
		
		for key in pairs(setInfo) do
			local effectInfo = setInfo[key]
			
			if (SetLevel >= effectInfo.ItemMinLevel and SetLevel <= effectInfo.ItemMaxLevel)
			then
				local RandValue = 100
				
				if effectInfo.RandTime ~= 100
				then
					randValue = math.random(1, 100)
				end
				
				if effectInfo.RandTime >= randValue
				then
					if effectInfo.EffectType == 0
					then
						CreateSprite(BMDStruct, ObjectStruct, effectInfo.BonePlayer, effectInfo.EffectID, effectInfo.Size, effectInfo.R, effectInfo.G, effectInfo.B, effectInfo.PosX, effectInfo.PosY, effectInfo.PosZ)
					elseif effectInfo.EffectType == 1
					then
						CreateParticle(BMDStruct, ObjectStruct, effectInfo.BonePlayer, effectInfo.EffectID, effectInfo.EffectLv, effectInfo.Size, effectInfo.R, effectInfo.G, effectInfo.B, effectInfo.PosX, effectInfo.PosY, effectInfo.PosZ)
					elseif effectInfo.EffectType == 2
					then
						CreateSkill(BMDStruct, ObjectStruct, effectInfo.BonePlayer, effectInfo.EffectID, effectInfo.EffectLv, effectInfo.Size, effectInfo.R, effectInfo.G, effectInfo.B, effectInfo.PosX, effectInfo.PosY, effectInfo.PosZ)
					end
				end
			end
		end
	end
end