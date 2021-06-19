OpenFolder("Definitions")

VISUAL_ITEM_SWITCH = 1
VISUAL_ITEM_SHOW_ORIGINAL_DESCRIPTION = 0

VISUAL_ITEM_TEXTS = {}

VISUAL_ITEM_TEXTS['Por'] = {
[1] = 'Este item é visual e não oferece nenhum',
[2] = 'atributo de força ou defesa!',
[3] = 'Equipe-o no inventário visual.',
}

VISUAL_ITEM_TEXTS['Eng'] = {
[1] = 'This item is visual and does not offer any',
[2] = 'attribute of strength or defense!',
[3] = 'Equip it in the visual inventory.',
}

VISUAL_ITEM_TEXTS['Spn'] = {
[1] = 'Este artículo es visual y no ofrece ninguno',
[2] = '¡atributo de fuerza o defensa!',
[3] = 'Equiparlo en el inventario visual.',
}

function RenderDescriptionVisualItem(ItemIndex)
	createDescription(0, string.format("%s", GetNameByIndex(ItemIndex)), 8, 0)

    createDescription(1, "\n", 0, 0)

    createDescription(2, VISUAL_ITEM_TEXTS[GetLanguage()][1], 0, 0)

    createDescription(3, VISUAL_ITEM_TEXTS[GetLanguage()][2], 0, 0)

    createDescription(4, "\n", 0, 0)

    createDescription(5, VISUAL_ITEM_TEXTS[GetLanguage()][3], 0, 0)
end

setVisualInventory(VISUAL_ITEM_SWITCH, VISUAL_ITEM_SHOW_ORIGINAL_DESCRIPTION)