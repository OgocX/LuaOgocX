OpenFolder("Definitions")

CUSTOM_ITEM_POSITION = {
 {ItemIndex = GET_ITEM(13, 200), PosX = -90.0, PosY = -380.0, PosZ = 0.0 },
}

function StartLoadItemPosition()
	for i = 1, #CUSTOM_ITEM_POSITION do
		SetItemPosition(CUSTOM_ITEM_POSITION[i].ItemIndex, CUSTOM_ITEM_POSITION[i].PosX, CUSTOM_ITEM_POSITION[i].PosY, CUSTOM_ITEM_POSITION[i].PosZ)
	end
end