--[[Calcs Pet System]]--

local NEW_CALC_PETS_SWITCH = 1

local NEW_CALC_PETS = {{Section = 13, Index = 200, Defense = 200, BlockSucess = 50, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0},}

function SetNewsCalcPet(aIndex)
	if NEW_CALC_PETS_SWITCH == 0
	then
		return
	end
	
	local pInv = Inventory.new(aIndex)
	
	if pInv:isItem(8) == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local PlayerItemIndex = pInv:getIndex(8)
	
	for i in ipairs(NEW_CALC_PETS) do
		local ItemIndex = GET_ITEM(NEW_CALC_PETS[i].Section, NEW_CALC_PETS[i].Index)

		if PlayerItemIndex == ItemIndex
		then
			if NEW_CALC_PETS[i].Defense > 0
			then
				player:setDefense((math.floor(player:getDefense() + NEW_CALC_PETS[i].Defense)))
			end
			
			if NEW_CALC_PETS[i].BlockSucess > 0
			then
				player:setSuccessBlock(math.floor(player:getSuccessBlock() + NEW_CALC_PETS[i].BlockSucess))
			end
			
			if NEW_CALC_PETS[i].AddLife > 0
			then
				player:setAddLife((math.floor(player:getAddLife() + NEW_CALC_PETS[i].AddLife)))
			end
			
			if NEW_CALC_PETS[i].AddMana > 0
			then
				player:setAddMana((math.floor(player:getAddMana() + NEW_CALC_PETS[i].AddMana)))
			end
			
			if NEW_CALC_PETS[i].MinDmgLeft > 0
			then
				player:setAttackDamageMinLeft((math.floor(player:getAttackDamageMinLeft() + NEW_CALC_PETS[i].MinDmgLeft)))
			end
			
			if NEW_CALC_PETS[i].MaxDmgLeft > 0
			then
				player:setAttackDamageMaxLeft((math.floor(player:getAttackDamageMaxLeft() + NEW_CALC_PETS[i].MaxDmgLeft)))
			end
			
			if NEW_CALC_PETS[i].MinDmgRight > 0
			then
				player:setAttackDamageMinRight((math.floor(player:getAttackDamageMinRight() + NEW_CALC_PETS[i].MinDmgRight)))
			end
			
			if NEW_CALC_PETS[i].MaxDmgRight > 0
			then
				player:setAttackDamageMaxRight((math.floor(player:getAttackDamageMaxRight() + NEW_CALC_PETS[i].MaxDmgRight)))
			end
			
			if NEW_CALC_PETS[i].MagicMinDmg > 0
			then
				player:setMagicDamageMin((math.floor(player:getMagicDamageMin() + NEW_CALC_PETS[i].MagicMinDmg)))
			end
			
			if NEW_CALC_PETS[i].MagicMaxDmg > 0
			then
				player:setMagicDamageMax((math.floor(player:getMagicDamageMax() + NEW_CALC_PETS[i].MagicMaxDmg)))
			end
			
			if NEW_CALC_PETS[i].AttackSpeed > 0
			then
				player:setAttackSpeed((math.floor(player:getAttackSpeed() + NEW_CALC_PETS[i].AttackSpeed)))
			end
			
			if NEW_CALC_PETS[i].MagicSpeed > 0
			then
				player:setMagicSpeed((math.floor(player:getMagicSpeed() + NEW_CALC_PETS[i].MagicSpeed)))
			end
		end
	end
end

GameServerFunctions.CharacterSet(SetNewsCalcPet)