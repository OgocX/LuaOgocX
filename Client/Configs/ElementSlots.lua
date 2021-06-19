OpenFolder("Definitions")

--[[
pet = work only in index 0 and 1
pet = funciona só no index 0 e 1

for a pet to work it is necessary to add it in CharacterHelper.lua
para um pet funcionar é necessário adicionar ele no CharacterHelper.lua

active = if is 0 the slot don't will show in game and work!
active = se 0 o slot não vai mostrar no jogo e nem funcionar!

slot item.txt: 236 = element 0
slot item.txt: 237 = element 1
slot item.txt: 238 = element 2
slot item.txt: 239 = element 3
--]]

ELEMENT_SLOTS_CONFIG = {
	{ index = 0, x = 56, y = 44, width = 22, height = 22, active = 0, pet = 1 },
	{ index = 1, x = 116, y = 175, width = 22, height = 22, active = 0, pet = 1 },
	{ index = 2, x = 56, y = 115, width = 22, height = 22, active = 0, pet = 0 },
	{ index = 3, x = 116, y = 115, width = 22, height = 22, active = 0, pet = 0 },
}

function StartLoadElementSlots()
	for i = 1, #ELEMENT_SLOTS_CONFIG do
		local element = ELEMENT_SLOTS_CONFIG[i]
		
		SetElementSlot(element.index, element.x, element.y, element.width, element.height, element.active, element.pet)
	end
end

StartLoadElementSlots()