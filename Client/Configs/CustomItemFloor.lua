OpenFolder("Definitions")

CUSTOM_ITEM_FLOOR = {
 {ItemIndex = GET_ITEM(13, 200), AngleX = 0.0, AngleY = 25.0,  AngleZ = 15.0,  Size = 0.50 },
}

function StartLoadItemFloor()
	for i = 1, #CUSTOM_ITEM_FLOOR do
		SetItemFloor(CUSTOM_ITEM_FLOOR[i].ItemIndex, CUSTOM_ITEM_FLOOR[i].AngleX, CUSTOM_ITEM_FLOOR[i].AngleY, CUSTOM_ITEM_FLOOR[i].AngleZ, CUSTOM_ITEM_FLOOR[i].Size)
	end
end