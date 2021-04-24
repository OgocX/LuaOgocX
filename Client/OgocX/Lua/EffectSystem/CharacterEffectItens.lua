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

CUSTOM_EFFECT_INFOS[GET_ITEM_MODEL(12,200)] = { 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 15, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 16, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 17, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 18, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 19, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 20, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 21, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 22, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 23, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 24, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 25, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 26, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 27, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 28, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 29, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 30, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 31, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 32, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 33, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 34, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 35, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 36, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 37, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 38, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 39, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 40, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 41, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 42, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 43, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 44, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 45, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 46, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 47, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 48, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 49, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 50, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 51, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 52, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 53, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 54, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 55, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 56, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 57, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 58, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 59, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 60, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 61, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 62, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 63, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 64, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 65, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 66, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 67, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 68, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 69, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 70, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 71, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 72, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 73, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 74, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 75, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 76, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 77, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 78, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 79, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 80, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 81, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 82, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 83, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 84, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 85, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 86, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 87, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 88, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 89, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 90, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 91, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 92, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 93, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 94, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 95, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 96, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 97, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 98, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 99, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 100, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 101, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 102, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 103, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 104, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 105, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 106, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 107, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 108, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 109, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 110, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 111, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 112, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 113, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 114, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 115, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 116, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 117, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 118, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 119, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 120, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 121, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 122, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 123, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 124, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 125, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 126, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 127, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 128, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 129, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 130, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 131, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 132, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 133, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 134, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 135, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 136, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 137, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 138, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 139, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 140, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
{ Type = 0, EffectID = 32002, EffectLv = 0, Bone = 141, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
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
