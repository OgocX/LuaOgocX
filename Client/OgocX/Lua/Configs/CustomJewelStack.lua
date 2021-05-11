OpenFolder("Definitions")

CUSTOM_JEWEL_STACK = {
{ ItemIndex = GET_ITEM(14, 14) },
}

function StartLoadJewelStack()
	for i = 1, #CUSTOM_JEWEL_STACK do
		SetJewelStack(CUSTOM_JEWEL_STACK[i].ItemIndex)
	end
end