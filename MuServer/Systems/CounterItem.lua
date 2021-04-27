--[[
config
--]]
COUNTER_ITEM_SWITCH = 0

--[[
System
]]--
CounterItem = {}

function CounterItem.AddValue(aIndex, slot, value)
	if COUNTER_ITEM_SWITCH == 0
	then
		return
	end

	local player = User.new(aIndex)
	local pInv = Inventory.new(aIndex)
	
	if pInv:isItem(slot) == 0
	then
		return
	end
	
	InsertCounter(aIndex, slot, value)
	UpdateCounter(aIndex)
	
	pInv = nil
	player = nil
end

function CounterItem.DecreaseValue(aIndex, slot, value)
	if COUNTER_ITEM_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local pInv = Inventory.new(aIndex)
	
	if pInv:isItem(slot) == 0
	then
		return
	end
	
	DecreaseCounter(aIndex, slot, value)
	UpdateCounter(aIndex)
	
	pInv = nil
	player = nil
	
end

return CounterItem