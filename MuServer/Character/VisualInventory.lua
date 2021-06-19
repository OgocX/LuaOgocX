--[[
    Configs Visual Inventory
]]

VISUAL_ITEM_SWITCH = 0 -- active or desative
VISUAL_ITEM_ADD_STRENGHT = 0 -- add attributes on item

VISUAL_ITEM_STRENGHT = {}

VISUAL_ITEM_STRENGHT[GET_ITEM(13,200)] = {
    Defense = 200, DefensePvP = 200, BlockSucess = 50, BlockSucessPvP = 30, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0
}

VISUAL_ITEM_STRENGHT[GET_ITEM(7,100)] = {
    Defense = 200, DefensePvP = 200, BlockSucess = 50, BlockSucessPvP = 30, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0
}

VISUAL_ITEM_STRENGHT[GET_ITEM(8,100)] = {
    Defense = 200, DefensePvP = 200, BlockSucess = 50, BlockSucessPvP = 30, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0
}

VISUAL_ITEM_STRENGHT[GET_ITEM(9,100)] = {
    Defense = 200, DefensePvP = 200, BlockSucess = 50, BlockSucessPvP = 30, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0
}

VISUAL_ITEM_STRENGHT[GET_ITEM(10,100)] = {
    Defense = 200, DefensePvP = 200, BlockSucess = 50, BlockSucessPvP = 30, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0
}

VISUAL_ITEM_STRENGHT[GET_ITEM(11,100)] = {
    Defense = 200, DefensePvP = 200, BlockSucess = 50, BlockSucessPvP = 30, AddLife = 0, AddMana = 0, MinDmgLeft = 100, MaxDmgLeft = 150, MinDmgRight = 100, MaxDmgRight = 150, MagicMinDmg = 100, MagicMaxDmg = 150, AttackSpeed = 0, MagicSpeed = 0
}

VisualInventory = {}

function VisualInventory.ApplyAttributes(aIndex)
    if VISUAL_ITEM_ADD_STRENGHT == 0
    then
        return
    end

    local player = User.new(aIndex)
	local pInv = Inventory.new(aIndex)

    for slot = 240, 248 do
		if pInv:isItem(slot) ~= 0
		then
			local item = VISUAL_ITEM_STRENGHT[pInv:getIndex(slot)]

            if item == nil
            then
                goto continue
            end
            
            if item.Defense > 0
            then
                player:setDefense((math.floor(player:getDefense() + item.Defense)))
            end
            
            if item.DefensePvP > 0
            then
                player:setDefensePvP((math.floor(player:getDefensePvP() + item.DefensePvP)))
            end
            
            if item.BlockSucess > 0
            then
                player:setSuccessBlock(math.floor(player:getSuccessBlock() + item.BlockSucess))
            end
            
            if item.BlockSucessPvP > 0
            then
                player:setSuccessBlockPvP(math.floor(player:getSuccessBlockPvP() + item.BlockSucessPvP))
            end
            
            if item.AddLife > 0
            then
                player:setAddLife((math.floor(player:getAddLife() + item.AddLife)))
            end
            
            if item.AddMana > 0
            then
                player:setAddMana((math.floor(player:getAddMana() + item.AddMana)))
            end
            
            if item.MinDmgLeft > 0
            then
                player:setAttackDamageMinLeft((math.floor(player:getAttackDamageMinLeft() + item.MinDmgLeft)))
            end
            
            if item.MaxDmgLeft > 0
            then
                player:setAttackDamageMaxLeft((math.floor(player:getAttackDamageMaxLeft() + item.MaxDmgLeft)))
            end
            
            if item.MinDmgRight > 0
            then
                player:setAttackDamageMinRight((math.floor(player:getAttackDamageMinRight() + item.MinDmgRight)))
            end
            
            if item.MaxDmgRight > 0
            then
                player:setAttackDamageMaxRight((math.floor(player:getAttackDamageMaxRight() + item.MaxDmgRight)))
            end
            
            if item.MagicMinDmg > 0
            then
                player:setMagicDamageMin((math.floor(player:getMagicDamageMin() + item.MagicMinDmg)))
            end
            
            if item.MagicMaxDmg > 0
            then
                player:setMagicDamageMax((math.floor(player:getMagicDamageMax() + item.MagicMaxDmg)))
            end
            
            if item.AttackSpeed > 0
            then
                player:setAttackSpeed((math.floor(player:getAttackSpeed() + item.AttackSpeed)))
            end
            
            if item.MagicSpeed > 0
            then
                player:setMagicSpeed((math.floor(player:getMagicSpeed() + item.MagicSpeed)))
            end

            ::continue::
		end
	end

    pInv = nil
	player = nil
end

setVisualInventory(VISUAL_ITEM_SWITCH)
GameServerFunctions.CharacterSet(VisualInventory.ApplyAttributes)

return VisualInventory