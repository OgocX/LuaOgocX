OpenFolder("Definitions")

CUSTOM_CLAWS_INFO = {
{ ItemIndex = GET_ITEM_MODEL(0, 45), ColorR = 0.5, ColorG = 0.6, ColorB = 0.7, ModelName = "Sword35", LeftIndex = GET_ITEM_MODEL(0, 400), LeftModel = "SwordL35", RightIndex = GET_ITEM_MODEL(0, 401), RightModel = "SwordR35" },
}

function StartLoadClaws()
	for i = 1, #CUSTOM_CLAWS_INFO do
		local claw = CUSTOM_CLAWS_INFO[i]
		
		SetClaws(claw.ItemIndex, claw.ColorR, claw.ColorG, claw.ColorB, claw.ModelName, claw.LeftIndex, claw.LeftModel, claw.RightIndex, claw.RightModel)
	end
end