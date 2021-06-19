--[[
Configs element add streng
]]--

ELEMENT_ATTRIBUTES_SWITCH = 0
ELEMENT_ATTRIBUTES_INFO = {
	{ItemIndex = GET_ITEM(13, 200), Defense = 200, DefensePvP = 200, BlockSucess = 50, BlockSucessPvP = 30, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0},
}

ElementAttributes = {}

function ElementAttributes.ApplyDefenseSet(aIndex)
	if ELEMENT_ATTRIBUTES_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local pInv = Inventory.new(aIndex)
	
	for slot = 236, 239 do
		if pInv:isItem(slot) ~= 0
		then
			for i = 1, #ELEMENT_ATTRIBUTES_INFO do
				local element = ELEMENT_ATTRIBUTES_INFO[i]
				
				if element.ItemIndex == pInv:getIndex(slot)
				then
					if element.Defense > 0
					then
						player:setDefense((math.floor(player:getDefense() + element.Defense)))
					end
					
					if element.DefensePvP > 0
					then
						player:setDefensePvP((math.floor(player:getDefensePvP() + element.DefensePvP)))
					end
					
					if element.BlockSucess > 0
					then
						player:setSuccessBlock(math.floor(player:getSuccessBlock() + element.BlockSucess))
					end
					
					if element.BlockSucessPvP > 0
					then
						player:setSuccessBlockPvP(math.floor(player:getSuccessBlockPvP() + element.BlockSucessPvP))
					end
					
					if element.AddLife > 0
					then
						player:setAddLife((math.floor(player:getAddLife() + element.AddLife)))
					end
					
					if element.AddMana > 0
					then
						player:setAddMana((math.floor(player:getAddMana() + element.AddMana)))
					end
					
					if element.MinDmgLeft > 0
					then
						player:setAttackDamageMinLeft((math.floor(player:getAttackDamageMinLeft() + element.MinDmgLeft)))
					end
					
					if element.MaxDmgLeft > 0
					then
						player:setAttackDamageMaxLeft((math.floor(player:getAttackDamageMaxLeft() + element.MaxDmgLeft)))
					end
					
					if element.MinDmgRight > 0
					then
						player:setAttackDamageMinRight((math.floor(player:getAttackDamageMinRight() + element.MinDmgRight)))
					end
					
					if element.MaxDmgRight > 0
					then
						player:setAttackDamageMaxRight((math.floor(player:getAttackDamageMaxRight() + element.MaxDmgRight)))
					end
					
					if element.MagicMinDmg > 0
					then
						player:setMagicDamageMin((math.floor(player:getMagicDamageMin() + element.MagicMinDmg)))
					end
					
					if element.MagicMaxDmg > 0
					then
						player:setMagicDamageMax((math.floor(player:getMagicDamageMax() + element.MagicMaxDmg)))
					end
					
					if element.AttackSpeed > 0
					then
						player:setAttackSpeed((math.floor(player:getAttackSpeed() + element.AttackSpeed)))
					end
					
					if element.MagicSpeed > 0
					then
						player:setMagicSpeed((math.floor(player:getMagicSpeed() + element.MagicSpeed)))
					end
				end
			end
		end
	end
	
	pInv = nil
	player = nil
end

GameServerFunctions.CharacterSet(ElementAttributes.ApplyDefenseSet)

return ElementAttributes