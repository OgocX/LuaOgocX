OpenFolder("Definitions")

COUNTER_ITEM_INFO = {
{ ItemIndex = GET_ITEM(0, 26), TextPor = "Contador de Mortes: %d", TextEng = "Death Counter: %d", TextSpn = "Contador de muertes: %d", Color = 23, Bold = 0 },
{ ItemIndex = GET_ITEM(5, 12), TextPor = "Contador de Resets: %d", TextEng = "Resets Counter: %d", TextSpn = "Restablece el contador: %d", Color = 23, Bold = 0 },

}

function StartLoadCounterItem()
	for i = 1, #COUNTER_ITEM_INFO do
		local info = COUNTER_ITEM_INFO[i]
		
		RegisterItemCounter(info.ItemIndex, info.TextPor, info.TextEng, info.TextSpn, info.Color, info.Bold)
	end
end