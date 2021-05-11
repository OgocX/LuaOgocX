OpenFolder("Definitions")

CUSTOM_ITEM_POSITION = {
 {ItemIndex = GET_ITEM(12, 200), PosX = 0.0, PosY = 0.0, AngleX = -90.0, AngleY = -380.0, AngleZ = -380.0 },
}

function StartLoadItemPosition()
	for i = 1, #CUSTOM_ITEM_POSITION do
		SetItemPosition(CUSTOM_ITEM_POSITION[i].ItemIndex, CUSTOM_ITEM_POSITION[i].PosX, CUSTOM_ITEM_POSITION[i].PosY, CUSTOM_ITEM_POSITION[i].AngleX, CUSTOM_ITEM_POSITION[i].AngleY, CUSTOM_ITEM_POSITION[i].AngleZ)
	end
end