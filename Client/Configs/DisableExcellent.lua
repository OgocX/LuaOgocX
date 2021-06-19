OpenFolder("Definitions")

--[[
    this disable glow excellent and ancient!
    desabilita glow excellent e anciente!
]]--

DISABLE_EXCELLENT_ITEMS = {
    --{ ItemIndex = GET_ITEM_MODEL(7, 100) },
    --{ ItemIndex = GET_ITEM_MODEL(8, 100) },
    --{ ItemIndex = GET_ITEM_MODEL(9, 100) },
    --{ ItemIndex = GET_ITEM_MODEL(10, 100) },
    --{ ItemIndex = GET_ITEM_MODEL(11, 100) },
}

function StartLoadDisableExcellent()

    for i = 1, #DISABLE_EXCELLENT_ITEMS do
        SetDisableExcellent(DISABLE_EXCELLENT_ITEMS[i].ItemIndex)
    end

end

StartLoadDisableExcellent()