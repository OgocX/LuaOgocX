OpenFolder("Definitions")

CUSTOM_ITEM_SIZE = {
 {ItemIndex = GET_ITEM(13, 200), SizeInventory = 0.0025 },
}

function StartLoadItemSize()
	for i = 1, #CUSTOM_ITEM_SIZE do
		SetItemSize(CUSTOM_ITEM_SIZE[i].ItemIndex, CUSTOM_ITEM_SIZE[i].SizeInventory)
	end
end