ClearInventory = { }

function ClearInventory.Command(aIndex, Arguments)
	if CLEAR_INVENTORY_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][8]), aIndex, 1)
		return
	end
	
	if player:getLevel() < CLEAR_INVENTORY_LEVEL
	then
		SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][1], CLEAR_INVENTORY_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < CLEAR_INVENTORY_MONEY
	then
		SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][2], CLEAR_INVENTORY_MONEY), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID()) < CLEAR_INVENTORY_VIP
	then
		SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][3]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < CLEAR_INVENTORY_RESET
	then
		SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][4], CLEAR_INVENTORY_RESET), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < CLEAR_INVENTORY_MRESET
	then
		SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][5], CLEAR_INVENTORY_MRESET), aIndex, 1)
		return
	end
	
	local pInv = Inventory.new(aIndex)
	local notEmpty = 0
	
	for i = 12, 75 do
		if pInv:isItem(i) == 1
		then
			notEmpty = notEmpty + 1
		end
	end
	
	if notEmpty == 0
	then
		SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][6]), aIndex, 1)
		return
	end
	
	for i = 12, 75 do
		if pInv:isItem(i) == 1
		then
			InventoryDeleteItem(aIndex, i)
			SendInventoryDeleteItem(aIndex, i)
		end
	end
	
	local setmoney = money - POST_MONEY
	
	player:setMoney(setmoney)
	
	MoneySend(aIndex)
	
	SendMessage(string.format(CLEAR_INVENTORY_MESSAGES[Language][7]), aIndex, 1)
end

Commands.Register(CLEAR_INVENTORY_COMMAND, ClearInventory.Command)

return ClearInventory