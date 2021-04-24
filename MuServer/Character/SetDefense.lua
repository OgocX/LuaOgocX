--[[
Configurações defense set
]]--

SetDefense = {}

function SetDefense.CheckSet(aIndex, Set)
	local player = User.new(aIndex)
	local pInv = Inventory.new(aIndex)

	if Set.Helm >= 0
	then
		if player:getDbClass() ~= 48
		then
			if pInv:isItem(2) == 0
			then

				return false
			end
			if pInv:isExc(2) == 0 or pInv:getIndex(2) ~= GET_ITEM(7, Set.Helm)
			then
				return false
			end
		end
	end
	
	if Set.Armor >= 0
	then
		if pInv:isItem(3) == 0
		then
			return false
		end
		if pInv:isExc(3) == 0 or pInv:getIndex(3) ~= GET_ITEM(8, Set.Armor)
		then
			return false
		end
	end
	
	if Set.Pants >= 0
	then
		if pInv:isItem(4) == 0
		then
			return false
		end
		if pInv:isExc(4) == 0 or pInv:getIndex(4) ~= GET_ITEM(9, Set.Pants)
		then
			return false
		end
	end
	
	if Set.Gloves >= 0
	then
		if pInv:isItem(5) == 0
		then
			return false
		end
		if pInv:isExc(5) == 0 or pInv:getIndex(5) ~= GET_ITEM(10, Set.Gloves)
		then
			return false
		end
	end
	
	if Set.Boots >= 0
	then
		if pInv:isItem(6) == 0
		then
			return false
		end
		if pInv:isExc(6) == 0 or pInv:getIndex(6) ~= GET_ITEM(11, Set.Boots)
		then
			return false
		end
	end
	

	return true
end

function SetDefense.ApplyDefenseSet(aIndex)
	if SET_DEFENSE_SWITCH == 0
	then
		return
	end
	
	if #SET_DEFENSE_CONFIG == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	
	for i in ipairs(SET_DEFENSE_CONFIG) do
		if SetDefense.CheckSet(aIndex, SET_DEFENSE_CONFIG[i]) == true
		then
			if SET_DEFENSE_CONFIG[i].Defense > 0
			then
				player:setDefense(math.floor(player:getDefense() * SET_DEFENSE_CONFIG[i].Defense))
			end
			
			if SET_DEFENSE_CONFIG[i].SucessBlock > 0
			then
				player:setSucessBlock(math.floor(math.abs(player:getSucessBlock() * SET_DEFENSE_CONFIG[i].SucessBlock) * 10))
			end
		end
	end
end

GameServerFunctions.CharacterSet(SetDefense.ApplyDefenseSet)

return SetDefense