OpenFolder("Definitions")

CUSTOM_ITEM_FORCE = {
{ ItemIndex = GET_ITEM(0, 0), DamageMin = 350, DamageMax = 450, Defense = 0, MagicDefense = 0 },
{ ItemIndex = GET_ITEM(0, 26), DamageMin = 550, DamageMax = 650, Defense = 0, MagicDefense = 0 },
}

function StartCustomItemForce()
	for i = 1, #CUSTOM_ITEM_FORCE do
		SetItemForce(CUSTOM_ITEM_FORCE[i].ItemIndex, CUSTOM_ITEM_FORCE[i].DamageMin, CUSTOM_ITEM_FORCE[i].DamageMax, CUSTOM_ITEM_FORCE[i].Defense, CUSTOM_ITEM_FORCE[i].MagicDefense)
	end
end