--[[ Prevent Player drop item ]]--

PreventDrop = {}

-- Level -1 = qualquer level

ITEM_DROP_BLOCK = {{Section = 12, Index = 200, Level = -1},}

function PreventDrop.PlayerDropItem(aIndex, x, y, position)
	local pInv = Inventory.new(aIndex)
	local item_index = pInv:getIndex(position)
	
	for i in ipairs(ITEM_DROP_BLOCK) do
		if item_index == GET_ITEM(ITEM_DROP_BLOCK[i].Section, ITEM_DROP_BLOCK[i].Index)
		then
			if (ITEM_DROP_BLOCK[i].Level == -1 or pInv:getLevel(position) == ITEM_DROP_BLOCK[i].Level)
			then
				return 1
			end
		end
	end
	
	return
end

GameServerFunctions.PlayerDropItem(PreventDrop.PlayerDropItem)

return PreventDrop