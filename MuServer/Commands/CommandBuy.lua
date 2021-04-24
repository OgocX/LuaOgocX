--[[Command Buy: By OgocX]]--

CommandBuy = {}

function CommandBuy.BuyItem(aIndex, Arguments)
	if BUY_COMMAND_SWITCH == 0
	then
		return
	end

	local player = User.new(aIndex)
	local Language = player:getLanguage()
	local pInv = Inventory.new(aIndex)

	for i = 12, MAX_INVENTORY_RANGE do
		if pInv:isItem(i) ~= 0
		then
			SendMessage(string.format(COMMAND_BUY_MESSAGES[Language][1]), aIndex, 1)
			return
		end
	end
	
	local Name = string.lower(command:getString(Arguments, 1, 0))
	
	for i in ipairs(BUY_COMMAND_CONFIG) do
		if Name == string.lower(BUY_COMMAND_CONFIG[i].String)
		then
			local AmountType = BUY_COMMAND_CONFIG[i].AmountType
			
			if DataBase.GetValue(BUY_COMMAND_AMOUNT_TABLE[AmountType], BUY_COMMAND_AMOUNT_COLUMN[AmountType], BUY_COMMAND_AMOUNT_WHERE[AmountType], player:getAccountID()) < BUY_COMMAND_CONFIG[i].Amount
			then
				SendMessage(string.format(COMMAND_BUY_MESSAGES[Language][2], BUY_COMMAND_CONFIG[i].Amount, BUY_COMMAND_AMOUNT_NAME[AmountType]), aIndex, 1)
				return
			end
			
			for n in ipairs(BUY_COMMAND_ITENS) do
				if BUY_COMMAND_CONFIG[n].Identification == BUY_COMMAND_ITENS[i].Identification
				then
					local exc = 0
					
					if BUY_COMMAND_ITENS[n].Exc_1 ~= 0
					then
						exc = exc + 1
					end
					if BUY_COMMAND_ITENS[n].Exc_2 ~= 0
					then
						exc = exc + 2
					end
					if BUY_COMMAND_ITENS[n].Exc_3 ~= 0
					then
						exc = exc + 4
					end
					if BUY_COMMAND_ITENS[n].Exc_4 ~= 0
					then
						exc = exc + 8
					end
					if BUY_COMMAND_ITENS[n].Exc_5 ~= 0
					then
						exc = exc + 16
					end
					if BUY_COMMAND_ITENS[n].Exc_6 ~= 0
					then
						exc = exc + 32
					end
					
					local Section = BUY_COMMAND_ITENS[n].Section
					local Index = BUY_COMMAND_ITENS[n].Index
					local Level = BUY_COMMAND_ITENS[n].Level
					local Luck = BUY_COMMAND_ITENS[n].Luck
					local Skill = BUY_COMMAND_ITENS[n].Skill
					local Opt = BUY_COMMAND_ITENS[n].Opt
				
					for b = 1, BUY_COMMAND_CONFIG[i].ItemCount do
						if BUY_COMMAND_ITENS[n].IsSet == 1
						then
							for s = 7, 11 do
								ItemSerialCreate(aIndex, 236, 0, 0, GET_ITEM(s, Index), Level, 255, Luck, Skill, Opt, exc)
							end
						else
							ItemSerialCreate(aIndex, 236, 0, 0, GET_ITEM(Section, Index), Level, 255, Luck, Skill, Opt, exc)
						end
					end
				end
			end
			
			DataBase.SetDecreaseValue(BUY_COMMAND_AMOUNT_TABLE[AmountType], BUY_COMMAND_AMOUNT_COLUMN[AmountType], BUY_COMMAND_CONFIG[i].Amount, BUY_COMMAND_AMOUNT_WHERE[AmountType], player:getAccountID())
			
			SendMessage(string.format(COMMAND_BUY_MESSAGES[Language][3], BUY_COMMAND_CONFIG[i].Name), aIndex, 1)
			return
		end
	end
	
	SendMessage(string.format(COMMAND_BUY_MESSAGES[Language][4]), aIndex, 1)
	
	
end

Commands.Register(BUY_COMMAND, CommandBuy.BuyItem)

return CommandBuy